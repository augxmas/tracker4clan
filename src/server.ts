import path from "node:path";
import fs from "node:fs";
import express from "express";
import cors from "cors";
import session from "express-session";
import cookieParser from "cookie-parser";
import MySQLStoreFactory from "express-mysql-session";
import dotenv from "dotenv";
import pool from "./config/database";
import hostAuthRouter from "./routes/host-auth";
import hostProjectRouter from "./routes/host-project";
import supervisorRouter from "./routes/supervisor";
import visitorRouter from "./routes/visitor";
import giftRouter from "./routes/gift";
import merchantRouter from "./routes/merchant";
import integrationRouter from "./routes/integration";
import fieldAgentRouter from "./routes/field-agent";
import surveyRouter from "./routes/survey";
import partnerRouter from "./routes/partner";
import voteRouter from "./routes/vote";
import notificationRouter from "./routes/notification";
import noticeRouter from "./routes/notice";
import gridPrefsRouter from "./routes/grid-prefs";
import inquiryRouter from "./routes/inquiry";
import videoRouter from "./routes/video";
import resourceRouter from "./routes/resource";
import prizeRouter from "./routes/prize";
import { getSessionInfo, extendSession, sessionTimeout } from "./middleware/session-timeout";
import { touchActivity } from "./middleware/auth";
import { scheduleProjectEndingNotifications } from "./jobs/project-ending.job";

const originalPort = process.env.PORT;
dotenv.config({ override: true });
if (originalPort) {
  process.env.PORT = originalPort;
}

const app = express();
app.set("trust proxy", 1);
const port = Number(process.env.PORT ?? 3000);
const errorPageDir = path.join(process.cwd(), "public", "errors");

function acceptsHtml(req: express.Request): boolean {
  return !req.path.startsWith("/api/") && req.accepts(["html", "json"]) === "html";
}

function sendErrorPage(
  req: express.Request,
  res: express.Response,
  status: 404 | 500,
  payload: { error: string; message: string },
): void {
  if (!acceptsHtml(req)) {
    res.status(status).json(payload);
    return;
  }

  res.status(status).sendFile(path.join(errorPageDir, `${status}.html`), (err) => {
    if (!err || res.headersSent) return;
    res.status(status).type("text/plain").send(payload.message);
  });
}

const MySQLStore = MySQLStoreFactory(session as any);
const sessionStore = new MySQLStore(
  {
    clearExpired: true,
    checkExpirationInterval: 60 * 1000,
    expiration: 4 * 60 * 1000,
    createDatabaseTable: false,
    schema: {
      tableName: "sessions",
      columnNames: {
        session_id: "session_id",
        expires: "expires",
        data: "data",
      },
    },
  } as any,
  pool as any,
);

sessionStore.on("error", (err) => {
  console.error("[Session Store Error]", err);
});

app.use(cors());
app.use(express.json({ limit: "10mb" }));
app.use(express.urlencoded({ extended: true }));
app.use(cookieParser());

// Support header and query parameter-based sessions (especially useful inside cross-site iframe environments like AI Studio)
app.use((req, res, next) => {
  const headerSessionId = req.headers["x-session-id"] || req.query["_session_id"];
  if (headerSessionId && typeof headerSessionId === "string") {
    const rawCookie = req.headers.cookie || "";
    if (!rawCookie.includes("connect.sid=")) {
      req.headers.cookie = rawCookie
        ? `${rawCookie}; connect.sid=${headerSessionId}`
        : `connect.sid=${headerSessionId}`;
    } else {
      const parts = rawCookie.split(";").map(p => p.trim());
      const filtered = parts.filter(p => !p.startsWith("connect.sid="));
      filtered.push(`connect.sid=${headerSessionId}`);
      req.headers.cookie = filtered.join("; ");
    }
  }
  next();
});

app.use(
  session({
    secret: process.env.SESSION_SECRET ?? "tracker_secret",
    store: sessionStore,
    resave: false,
    saveUninitialized: false,
    rolling: true,
    cookie: {
      httpOnly: true,
      secure: true,
      sameSite: "none",
      maxAge: 4 * 60 * 1000,
    },
  }),
);

// 세션 상태 조회/연장은 유휴 타이머를 리셋하지 않도록 reset 미들웨어보다 먼저 등록한다
app.get("/api/session-info", getSessionInfo);
app.post("/api/session-extend", extendSession);

app.use(sessionTimeout);
app.use(touchActivity);

app.use("/api/host", hostAuthRouter);
app.use("/api/host", hostProjectRouter);
app.use("/api/supervisor", supervisorRouter);
app.use("/api/visitor", visitorRouter);
app.use("/api/gift", giftRouter);
app.use("/api/merchant", merchantRouter);
app.use("/api/integration", integrationRouter);
app.use("/api/field-agent", fieldAgentRouter);   // 공개 등록 + 근태 PWA + admin (sess.host 검사 내부)
app.use("/api/survey", surveyRouter);             // host 설문 설정 + 공개 응답
app.use("/api/partner", partnerRouter);           // 참여기관 폼 설정 + 신청/관리
app.use("/api/vote", voteRouter);                 // 투표/수상 등급 설정
app.use("/api/notification", notificationRouter); // 랜딩 팝업 알림 등록/관리 + 공개 조회
app.use("/api/notice", noticeRouter);             // 공지사항 등록/관리 + 공개 조회
app.use("/api/grid-prefs", gridPrefsRouter);      // 사용자별 그리드 컬럼 설정(표시/순서)
app.use("/api/inquiry", inquiryRouter);           // 문의사항 작성/관리 + 공개 게시판
app.use("/api/video", videoRouter);               // 동영상(YouTube) 등록/관리 + 공개 게시판
app.use("/api/resource", resourceRouter);             // 자료실 등록/관리
app.use("/api", prizeRouter);                         // 경품 등록/관리 (/api/host/...)

// 참가기관 로그인 — 정적 미들웨어보다 먼저 처리 (public/partner/index.html 자동 서빙 차단)
app.get(["/partner", "/partner/"], (_req, res) => {
  res.sendFile(path.join(process.cwd(), "public", "partner", "auth.html"));
});
// public 정적 파일 — 단, partner 디렉토리의 자동 index.html 서빙은 막음
app.use(express.static(path.join(process.cwd(), "public"), { index: false }));

// 자료실 파일 BLOB 서빙 라우터
app.get("/uploads/resources/:filename", async (req, res) => {
  try {
    const filename = req.params.filename;
    const fileUrl = `/uploads/resources/${filename}`;
    
    const [rows] = await pool.execute(
      "SELECT file_name, file_data FROM project_resources WHERE file_path = ? OR file_path LIKE ?",
      [fileUrl, `%/${filename}`]
    );
    
    if (!Array.isArray(rows) || rows.length === 0) {
      res.status(404).send("File not found");
      return;
    }
    
    const resource = rows[0] as any;
    if (!resource.file_data) {
      // Fallback: check on disk if file exists (for legacy uploaded files)
      const diskPath = path.join(process.cwd(), "uploads", "resources", filename);
      if (fs.existsSync(diskPath)) {
        res.sendFile(diskPath);
        return;
      }
      res.status(404).send("File data is empty");
      return;
    }
    
    // Determine content type based on extension
    const ext = path.extname(filename).toLowerCase();
    let contentType = "application/octet-stream";
    if (ext === ".png") contentType = "image/png";
    else if (ext === ".jpg" || ext === ".jpeg") contentType = "image/jpeg";
    else if (ext === ".gif") contentType = "image/gif";
    else if (ext === ".webp") contentType = "image/webp";
    else if (ext === ".svg") contentType = "image/svg+xml";
    else if (ext === ".bmp") contentType = "image/bmp";
    else if (ext === ".pdf") contentType = "application/pdf";
    
    res.setHeader("Content-Type", contentType);
    res.setHeader("Cache-Control", "public, max-age=86400");
    res.send(resource.file_data);
  } catch (err: any) {
    console.error("Error serving resource file from BLOB:", err);
    res.status(500).send("Internal server error");
  }
});

app.use("/uploads", express.static(path.join(process.cwd(), "uploads")));

app.get("/admin", (_req, res) => {
  res.sendFile(path.join(process.cwd(), "public", "admin", "index.html"));
});
// 모바일 관리자 PWA (현장요원 근태, 경품수령, 사전·현장등록 확인 통합)
app.get("/admin/m", (_req, res) => {
  res.sendFile(path.join(process.cwd(), "public", "admin-m", "index.html"));
});
app.get("/admin-m", (_req, res) => res.redirect("/admin/m"));
app.get("/admin/m/manifest.json", (_req, res) => {
  res.type("application/manifest+json").send(JSON.stringify({
    id: "/admin/m",
    name: "모노라마 관리자",
    short_name: "관리자",
    start_url: "/admin/m",
    scope: "/admin/m/",
    display: "standalone",
    orientation: "portrait",
    background_color: "#f8fafc",
    theme_color: "#1d4ed8",
    icons: [
      { src: "/favicon-blue.svg", sizes: "any", type: "image/svg+xml", purpose: "any" },
      { src: "/favicon-blue.svg", sizes: "512x512", type: "image/svg+xml", purpose: "maskable" },
    ],
  }));
});
app.get("/admin/m/sw.js", (_req, res) => {
  res.setHeader("Service-Worker-Allowed", "/admin/m/");
  res.type("application/javascript");
  res.sendFile(path.join(process.cwd(), "public", "admin-m", "service-worker.js"));
});
app.get("/supervisor", (_req, res) => {
  res.sendFile(path.join(process.cwd(), "public", "supervisor", "index.html"));
});
app.get("/merchant", (_req, res) => {
  res.sendFile(path.join(process.cwd(), "public", "merchant", "index.html"));
});
// 서비스워커는 /v/ 스코프를 제어해야 하므로 /v/ 경로에서 제공한다 (param 라우트보다 먼저 등록)
app.get("/v/sw.js", (_req, res) => {
  res.setHeader("Service-Worker-Allowed", "/v/");
  res.type("application/javascript");
  res.sendFile(path.join(process.cwd(), "public", "visitor", "service-worker.js"));
});
// 프로젝트별 SW — 스코프를 /v/{serial}/ 로 분리하여 프로젝트별 독립 PWA 가능
app.get("/v/:projectSerial/sw.js", (_req, res) => {
  res.setHeader("Service-Worker-Allowed", "/v/");
  res.type("application/javascript");
  res.sendFile(path.join(process.cwd(), "public", "visitor", "service-worker.js"));
});
// Tour QR 진입: /v/:serial/:seq, 설치된 PWA 홈: /v/:serial (진행현황만)
app.get("/v/:projectSerial/:locationSeq", (_req, res) => {
  res.sendFile(path.join(process.cwd(), "public", "visitor", "index.html"));
});
app.get("/v/:projectSerial", (_req, res) => {
  res.sendFile(path.join(process.cwd(), "public", "visitor", "index.html"));
});
// 사전등록 / 현장등록 랜딩 페이지 (입장 희망객 view)
app.get("/reserve/:serial", (_req, res) => {
  res.sendFile(path.join(process.cwd(), "public", "reserve", "index.html"));
});
app.get("/entry/:serial", (_req, res) => {
  res.sendFile(path.join(process.cwd(), "public", "reserve", "index.html"));
});

// 사전/현장등록 통합 진입 — 프로젝트 상태에 따라 자동 분기
//   - 프로젝트 시작 전 (status: ready_to_start, 또는 from_date 이전) → /reserve/{serial}
//   - 프로젝트 시작 후 (status: started, 또는 from_date 이후) → /entry/{serial}
app.get("/register/:serial", async (req, res) => {
  const serial = String(req.params.serial || "");
  try {
    const [rows] = await pool.execute(
      "SELECT status, from_date, reservation_use, entry_use FROM projects WHERE project_serial = ?",
      [serial],
    );
    const p = (Array.isArray(rows) ? rows[0] : null) as any;
    if (!p) { res.status(404).send("프로젝트를 찾을 수 없습니다."); return; }
    const now = new Date();
    const fromDate = p.from_date ? new Date(p.from_date) : null;
    // 시작 여부: status='started' 이거나 from_date 가 오늘 이전
    const started = p.status === "started"
      || p.status === "completed"
      || (fromDate && fromDate <= now);
    // 분기 — 사용 옵션 함께 체크
    if (started) {
      if (Number(p.entry_use) === 1) { res.redirect(`/entry/${serial}`); return; }
      if (Number(p.reservation_use) === 1) { res.redirect(`/reserve/${serial}`); return; }
    } else {
      if (Number(p.reservation_use) === 1) { res.redirect(`/reserve/${serial}`); return; }
      if (Number(p.entry_use) === 1) { res.redirect(`/entry/${serial}`); return; }
    }
    // 둘 다 사용 안 함 → visitor 메뉴로
    res.redirect(`/v/${serial}`);
  } catch (e) {
    res.status(500).send("서버 오류");
  }
});
// 현장요원 PWA — 서비스워커 (스코프 /agent-register/{serial}/)
app.get("/agent-register/sw.js", (_req, res) => {
  res.setHeader("Service-Worker-Allowed", "/agent-register/");
  res.type("application/javascript");
  res.sendFile(path.join(process.cwd(), "public", "agent-register", "service-worker.js"));
});
app.get("/agent-register/:serial/sw.js", (_req, res) => {
  res.setHeader("Service-Worker-Allowed", "/agent-register/");
  res.type("application/javascript");
  res.sendFile(path.join(process.cwd(), "public", "agent-register", "service-worker.js"));
});
// 동적 manifest — 프로젝트 이름이 들어감
app.get("/agent-register/:serial/manifest.json", async (req, res) => {
  const serial = String(req.params.serial || "");
  let projectName = "";
  try {
    const [rows] = await pool.execute(
      `SELECT project_name FROM projects WHERE project_serial = ?`, [serial],
    );
    const p = (Array.isArray(rows) ? rows[0] : null) as any;
    if (p?.project_name) projectName = String(p.project_name);
  } catch {/* fallback */}
  // 앱 이름: "현장요원-프로젝트명" / 짧은 이름: "현장요원-(앞 8자)"
  const appName = projectName ? `현장요원-${projectName}` : "현장요원";
  const shortName = projectName
    ? `현장요원-${projectName.length > 8 ? projectName.slice(0, 8) + "…" : projectName}`
    : "현장요원";
  res.type("application/manifest+json").json({
    name: appName,
    short_name: shortName,
    start_url: `/agent-register/${serial}`,
    scope: `/agent-register/${serial}/`,
    display: "standalone",
    orientation: "portrait",
    background_color: "#f0fdf4",
    theme_color: "#15803d",
    icons: [
      { src: "/favicon-green.svg", sizes: "any", type: "image/svg+xml", purpose: "any" },
      { src: "/favicon-green.svg", sizes: "512x512", type: "image/svg+xml", purpose: "maskable" },
    ],
  });
});
// 현장요원 등록 폼
app.get("/agent-register/:serial", (_req, res) => {
  res.sendFile(path.join(process.cwd(), "public", "agent-register", "index.html"));
});
// 현장요원 근태관리 PWA
app.get("/agent-att/:serial", (_req, res) => {
  res.sendFile(path.join(process.cwd(), "public", "agent-att", "index.html"));
});
// 가맹점이 Gift QR을 스캔하면 열리는 사용처리 페이지
app.get("/g/:token", (_req, res) => {
  res.sendFile(path.join(process.cwd(), "public", "gift", "index.html"));
});

// 도입 제안서 PPTX 다운로드 (영업자료 — 인증 없음)
app.get("/proposal/download", (_req, res) => {
  const filePath = path.join(process.cwd(), "docs", "모노라마_트래커_도입제안서.pptx");
  res.download(filePath, "모노라마_트래커_도입제안서.pptx");
});
// 사전등록/현장등록 QR — 스마트 디스패처 (가맹점이면 사용처리, 아니면 visitor PWA 로 리디렉트)
app.get("/r/:serial/:token", (_req, res) => {
  res.sendFile(path.join(process.cwd(), "public", "redeem", "index.html"));
});
// 설문조사 응답 페이지 (공개)
// 참가기관 로그인/대시보드 — serial 없이 접속 시 로그인
//   /partner, /partner/ 둘 다 로그인 페이지로 (trailing slash 호환)
app.get(["/partner", "/partner/"], (_req, res) => {
  res.sendFile(path.join(process.cwd(), "public", "partner", "auth.html"));
});
// 프로젝트별 랜딩 페이지 — public/landing/{serial}/index.html 우선, 없으면 fallback
app.get("/landing/:serial", (req, res) => {
  const serial = String(req.params.serial || "").trim();
  const specific = path.join(process.cwd(), "public", "landing", serial, "index.html");
  const fallback = path.join(process.cwd(), "public", "landing", "index.html");
  if (require("fs").existsSync(specific)) { res.sendFile(specific); return; }
  if (require("fs").existsSync(fallback)) { res.sendFile(fallback); return; }
  sendErrorPage(req, res, 404, { error: "not_found", message: "Landing page not found" });
});
app.get("/vote/:serial", (_req, res) => {
  res.sendFile(path.join(process.cwd(), "public", "vote", "index.html"));
});
app.get("/partner/:serial", (_req, res) => {
  // serial 이 빈 문자열이면 (즉 /partner/ 접속 시) 로그인으로 fallback
  const serial = String(_req.params.serial || "").trim();
  if (!serial) {
    res.sendFile(path.join(process.cwd(), "public", "partner", "auth.html"));
    return;
  }
  res.sendFile(path.join(process.cwd(), "public", "partner", "index.html"));
});
app.get("/survey/:serial", (_req, res) => {
  res.sendFile(path.join(process.cwd(), "public", "survey", "index.html"));
});
// 문의사항 공개 게시판 (홈페이지 메뉴 링크용 URL)
app.get("/inquiry/:serial", (_req, res) => {
  res.sendFile(path.join(process.cwd(), "public", "inquiry", "index.html"));
});
// 동영상 공개 게시판 (프로젝트별 YouTube 리스트 URL)
app.get("/video/:serial", (_req, res) => {
  res.sendFile(path.join(process.cwd(), "public", "video", "index.html"));
});

// 루트 접근 → 대표 랜딩 페이지로 리다이렉트
app.get("/", (_req, res) => {
  res.redirect("/landing/20260623_0001/");
});

app.use((req, res) => {
  sendErrorPage(req, res, 404, { error: "not_found", message: "Not found" });
});

app.use((err: Error, req: express.Request, res: express.Response, _next: express.NextFunction) => {
  console.error("[server error]", err);
  if (res.headersSent) return;
  sendErrorPage(req, res, 500, { error: "internal_server_error", message: err.message });
});

// Ensure functions and procedures exist in the connected database
async function ensureDatabaseObjects(): Promise<void> {
  console.log("[DB] Ensuring functions and procedures exist...");

  // 1. Ensure sessions table exists
  try {
    await pool.query(`
      CREATE TABLE IF NOT EXISTS sessions (
        session_id VARCHAR(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
        expires INT UNSIGNED NOT NULL,
        data MEDIUMTEXT CHARACTER SET utf8mb4 COLLATE utf8mb4_bin,
        PRIMARY KEY (session_id)
      ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin
    `);
    console.log("[DB] sessions table verified/created.");
  } catch (err: any) {
    console.error("[DB] Failed to ensure sessions table:", err.message);
  }

  // 2. Create sp_update_project_statuses
  try {
    await pool.query("DROP PROCEDURE IF EXISTS sp_update_project_statuses");
    await pool.query(`
      CREATE PROCEDURE sp_update_project_statuses(IN p_source VARCHAR(20))
      BEGIN
        DECLARE v_started DATETIME DEFAULT NOW();
        DECLARE v_n1 INT DEFAULT 0;
        DECLARE v_n2 INT DEFAULT 0;
        DECLARE v_n3 INT DEFAULT 0;

        UPDATE projects
        SET status = 'started', started_at = COALESCE(started_at, NOW()), updated_at = NOW()
        WHERE deposit_confirmed_at IS NOT NULL
          AND status IN ('deposit_confirmed', 'ready_to_start')
          AND from_date <= CURDATE();
        SET v_n1 = ROW_COUNT();

        UPDATE projects
        SET status = 'ready_to_start', updated_at = NOW()
        WHERE deposit_confirmed_at IS NOT NULL
          AND status = 'deposit_confirmed'
          AND from_date > CURDATE();
        SET v_n2 = ROW_COUNT();

        UPDATE projects
        SET status = 'completed', updated_at = NOW()
        WHERE status = 'started' AND to_date < CURDATE();
        SET v_n3 = ROW_COUNT();

        INSERT INTO batch_logs (job_key, source, status, result_summary, started_at, finished_at)
        VALUES (
          'sp_update_project_statuses',
          COALESCE(p_source, 'unknown'),
          'ok',
          CONCAT('started:', v_n1, ' / ready_to_start:', v_n2, ' / completed:', v_n3),
          v_started, NOW()
        );
      END
    `);
    console.log("[DB] sp_update_project_statuses procedure verified/created.");
  } catch (err: any) {
    console.error("[DB] Critical: Failed to ensure sp_update_project_statuses:", err.message);
  }
}

// 프로젝트 상태 일일 자동 전이.
// 본 로직은 sql/scheduler.sql 의 sp_update_project_statuses() 에 정의되어 있고
// DB EVENT ev_daily_project_status_update 로 매일 00:05 자동 실행됨.
// Node 측에서는 (1) 서버 부팅 시 즉시 1회, (2) event_scheduler 가 OFF 인 환경 대비
// 매시간 동일 SP 를 호출해 안전망 역할.
async function autoUpdateProjectStatuses(): Promise<void> {
  await pool.query("CALL sp_update_project_statuses('node')");
}

async function initializeApp(): Promise<void> {
  try {
    await ensureDatabaseObjects();
  } catch (err) {
    console.error("Failed to initialize database objects on startup:", err);
  }
  try {
    await autoUpdateProjectStatuses();
  } catch (err) {
    console.error("Failed to auto-update project statuses on startup:", err);
  }
}

initializeApp().catch(console.error);
setInterval(() => autoUpdateProjectStatuses().catch(console.error), 60 * 60 * 1000);

// 프로젝트 종료일 3일 전 ~ 종료일까지 매일 1회 담당자 + 참여 가맹점에게 알림
scheduleProjectEndingNotifications();

app.listen(port, "0.0.0.0", () => {
  console.log(`Server started at http://clan.maumena.co.kr`);
});
