import { Router } from "express";
import multer from "multer";
import path from "path";
import fs from "fs";
import crypto from "crypto";
import pool from "../config/database";
import { requireHost } from "../middleware/auth";

const router = Router();

const prizeImageDir = path.join(process.cwd(), "uploads", "prize-images");
try {
  fs.mkdirSync(prizeImageDir, { recursive: true });
} catch (e) {
  console.error("Failed to create prize-images directory:", e);
}

const storage = multer.diskStorage({
  destination: (_req, _file, cb) => {
    cb(null, prizeImageDir);
  },
  filename: (_req, file, cb) => {
    const safe = crypto.randomBytes(8).toString("hex");
    const ext = path.extname(file.originalname).toLowerCase() || ".png";
    cb(null, `${Date.now()}_${safe}${ext}`);
  }
});
const upload = multer({ storage });

// Auto-initialize project_prizes table and dependencies
(async () => {
  try {
    await pool.query(`
      CREATE TABLE IF NOT EXISTS project_prizes (
        id BIGINT AUTO_INCREMENT PRIMARY KEY,
        project_id BIGINT NOT NULL,
        ranking INT NOT NULL DEFAULT 1,
        rank_name VARCHAR(100) NOT NULL,
        prize_name VARCHAR(255) NOT NULL,
        winner_count INT NOT NULL DEFAULT 1,
        image_path VARCHAR(255) NULL,
        created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
        updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
        CONSTRAINT fk_prize_project FOREIGN KEY (project_id) REFERENCES projects(id) ON DELETE CASCADE
      ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
    `);
    
    // Add ranking column if it doesn't exist for backward compatibility
    try {
      await pool.query("ALTER TABLE project_prizes ADD COLUMN ranking INT NOT NULL DEFAULT 1 AFTER project_id");
      console.log("Added ranking column to project_prizes.");
    } catch (e) {
      // Column probably already exists, which is fine
    }

    // Add prize_challengers column to projects if it doesn't exist
    try {
      await pool.query("ALTER TABLE projects ADD COLUMN prize_challengers INT NOT NULL DEFAULT 0 AFTER entry_benefit_image_path");
      console.log("Added prize_challengers column to projects.");
    } catch (e) {
      // Column probably already exists
    }

    // Create project_prize_slots table
    await pool.query(`
      CREATE TABLE IF NOT EXISTS project_prize_slots (
        id BIGINT AUTO_INCREMENT PRIMARY KEY,
        project_id BIGINT NOT NULL,
        slot_index INT NOT NULL,
        prize_id BIGINT NULL,
        created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
        UNIQUE KEY uq_proj_slot (project_id, slot_index),
        CONSTRAINT fk_slot_project FOREIGN KEY (project_id) REFERENCES projects(id) ON DELETE CASCADE,
        CONSTRAINT fk_slot_prize FOREIGN KEY (prize_id) REFERENCES project_prizes(id) ON DELETE CASCADE
      ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
    `);

    // Create visitor_prize_challenges table
    await pool.query(`
      CREATE TABLE IF NOT EXISTS visitor_prize_challenges (
        id BIGINT AUTO_INCREMENT PRIMARY KEY,
        project_id BIGINT NOT NULL,
        visitor_id BIGINT NOT NULL,
        slot_index INT NOT NULL,
        prize_id BIGINT NULL,
        challenged_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
        UNIQUE KEY uq_proj_visitor (project_id, visitor_id),
        CONSTRAINT fk_challenge_project FOREIGN KEY (project_id) REFERENCES projects(id) ON DELETE CASCADE,
        CONSTRAINT fk_challenge_visitor FOREIGN KEY (visitor_id) REFERENCES visitors(id) ON DELETE CASCADE,
        CONSTRAINT fk_challenge_prize FOREIGN KEY (prize_id) REFERENCES project_prizes(id) ON DELETE CASCADE
      ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
    `);
    
    console.log("project_prizes, slots, and challenges tables verified/created.");
  } catch (err) {
    console.error("Failed to initialize project_prizes table & dependencies:", err);
  }
})();

// 1. List prizes for a project
router.get("/host/projects/:projectId/prizes", requireHost, async (req, res) => {
  try {
    const projectId = Number(req.params.projectId);
    const hostId = req.session.host!.id;

    // Verify project ownership
    const [projRows] = await pool.execute(
      "SELECT id, prize_challengers FROM projects WHERE id = ? AND host_id = ?",
      [projectId, hostId]
    );
    if (!Array.isArray(projRows) || projRows.length === 0) {
      res.status(404).json({ ok: false, error: "project_not_found", message: "프로젝트를 찾을 수 없습니다." });
      return;
    }

    const [rows] = await pool.execute(
      "SELECT id, project_id, ranking, rank_name, prize_name, winner_count, image_path, created_at FROM project_prizes WHERE project_id = ? ORDER BY ranking ASC, id ASC",
      [projectId]
    );

    res.json({ ok: true, prizes: rows });
  } catch (err: any) {
    res.status(500).json({ ok: false, error: "db_error", message: err.message });
  }
});

// 2. Add a prize to a project
router.post("/host/projects/:projectId/prizes", requireHost, upload.single("file"), async (req: any, res) => {
  try {
    const projectId = Number(req.params.projectId);
    const hostId = req.session.host!.id;

    // Check project ownership
    const [projRows] = await pool.execute("SELECT id FROM projects WHERE id = ? AND host_id = ?", [projectId, hostId]);
    if (!Array.isArray(projRows) || projRows.length === 0) {
      res.status(404).json({ ok: false, error: "project_not_found", message: "프로젝트를 찾을 수 없습니다." });
      return;
    }

    const { ranking, rank_name, prize_name, winner_count, image_path } = req.body;
    let finalImagePath = image_path || null;

    if (req.file) {
      finalImagePath = `/uploads/prize-images/${req.file.filename}`;
    }

    if (!rank_name || !prize_name) {
      res.status(400).json({ ok: false, error: "missing_fields", message: "등수와 상품명을 입력해주세요." });
      return;
    }
    const nextWinnerCount = Math.max(1, Number(winner_count || 1));
    const challengerLimit = Number((projRows as any)[0].prize_challengers || 0);
    const [sumRows] = await pool.execute(
      "SELECT COALESCE(SUM(winner_count), 0) AS total FROM project_prizes WHERE project_id = ?",
      [projectId]
    );
    const projectedPrizeCount = Number((sumRows as any)[0].total || 0) + nextWinnerCount;
    if (challengerLimit > 0 && challengerLimit < projectedPrizeCount) {
      res.status(400).json({
        ok: false,
        error: "insufficient_challengers",
        message: `도전인원(${challengerLimit}명)은 취득 가능한 총 경품 수량(${projectedPrizeCount}개)보다 크거나 같아야 합니다. 도전인원을 먼저 늘려주세요.`,
      });
      return;
    }

    const [insertResult] = await pool.execute(
      `INSERT INTO project_prizes (project_id, ranking, rank_name, prize_name, winner_count, image_path)
       VALUES (?, ?, ?, ?, ?, ?)`,
      [projectId, Number(ranking || 1), rank_name.trim(), prize_name.trim(), nextWinnerCount, finalImagePath]
    );

    res.json({ ok: true, id: (insertResult as any).insertId, image_path: finalImagePath });
  } catch (err: any) {
    res.status(500).json({ ok: false, error: "db_error", message: err.message });
  }
});

// 3. Edit a prize
router.put("/host/prizes/:id", requireHost, upload.single("file"), async (req: any, res) => {
  try {
    const prizeId = Number(req.params.id);
    const hostId = req.session.host!.id;

    // Check prize ownership
    const [rows] = await pool.execute(
      `SELECT r.id, r.project_id, r.winner_count, p.prize_challengers FROM project_prizes r
       JOIN projects p ON p.id = r.project_id 
       WHERE r.id = ? AND p.host_id = ?`,
      [prizeId, hostId]
    );
    if (!Array.isArray(rows) || rows.length === 0) {
      res.status(404).json({ ok: false, error: "prize_not_found", message: "경품을 찾을 수 없거나 권한이 없습니다." });
      return;
    }

    const { ranking, rank_name, prize_name, winner_count, image_path } = req.body;
    let finalImagePath = image_path;

    if (req.file) {
      finalImagePath = `/uploads/prize-images/${req.file.filename}`;
    }

    if (!rank_name || !prize_name) {
      res.status(400).json({ ok: false, error: "missing_fields", message: "등수와 상품명을 입력해주세요." });
      return;
    }
    const ownedPrize = (rows as any)[0];
    const nextWinnerCount = Math.max(1, Number(winner_count || 1));
    const challengerLimit = Number(ownedPrize.prize_challengers || 0);
    const [sumRows] = await pool.execute(
      "SELECT COALESCE(SUM(winner_count), 0) AS total FROM project_prizes WHERE project_id = ?",
      [ownedPrize.project_id]
    );
    const projectedPrizeCount =
      Number((sumRows as any)[0].total || 0) - Number(ownedPrize.winner_count || 0) + nextWinnerCount;
    if (challengerLimit > 0 && challengerLimit < projectedPrizeCount) {
      res.status(400).json({
        ok: false,
        error: "insufficient_challengers",
        message: `도전인원(${challengerLimit}명)은 취득 가능한 총 경품 수량(${projectedPrizeCount}개)보다 크거나 같아야 합니다. 도전인원을 먼저 늘려주세요.`,
      });
      return;
    }

    let updateSql = `UPDATE project_prizes SET ranking = ?, rank_name = ?, prize_name = ?, winner_count = ?`;
    const params = [Number(ranking || 1), rank_name.trim(), prize_name.trim(), nextWinnerCount];

    if (finalImagePath !== undefined) {
      const dbPath = (finalImagePath === "" || finalImagePath === "null") ? null : finalImagePath;
      updateSql += `, image_path = ?`;
      params.push(dbPath);
    }

    updateSql += ` WHERE id = ?`;
    params.push(prizeId);

    await pool.execute(updateSql, params);

    res.json({ ok: true, message: "경품 정보가 수정되었습니다.", image_path: finalImagePath });
  } catch (err: any) {
    res.status(500).json({ ok: false, error: "db_error", message: err.message });
  }
});

// 4. Delete a prize
router.delete("/host/prizes/:id", requireHost, async (req, res) => {
  try {
    const prizeId = Number(req.params.id);
    const hostId = req.session.host!.id;

    // Check prize ownership
    const [rows] = await pool.execute(
      `SELECT r.id FROM project_prizes r 
       JOIN projects p ON p.id = r.project_id 
       WHERE r.id = ? AND p.host_id = ?`,
      [prizeId, hostId]
    );
    if (!Array.isArray(rows) || rows.length === 0) {
      res.status(404).json({ ok: false, error: "prize_not_found", message: "경품을 찾을 수 없거나 권한이 없습니다." });
      return;
    }

    await pool.execute("DELETE FROM project_prizes WHERE id = ?", [prizeId]);

    res.json({ ok: true, message: "경품이 삭제되었습니다." });
  } catch (err: any) {
    res.status(500).json({ ok: false, error: "db_error", message: err.message });
  }
});

// 4.4 Get every prize winner for a project
router.get("/host/projects/:projectId/prize-winners", requireHost, async (req, res) => {
  try {
    res.setHeader("Cache-Control", "no-store");
    const projectId = Number(req.params.projectId);
    const hostId = req.session.host!.id;

    const [projectRows] = await pool.execute(
      "SELECT id FROM projects WHERE id = ? AND host_id = ?",
      [projectId, hostId],
    );
    if (!Array.isArray(projectRows) || projectRows.length === 0) {
      res.status(404).json({ ok: false, error: "project_not_found", message: "프로젝트를 찾을 수 없거나 권한이 없습니다." });
      return;
    }

    const [winnerRows] = await pool.execute(
      `SELECT vpc.id, vpc.visitor_id, vpc.slot_index, vpc.challenged_at, v.phone,
              pp.id AS prize_id, pp.ranking, pp.rank_name, pp.prize_name
         FROM visitor_prize_challenges vpc
         JOIN visitors v ON v.id = vpc.visitor_id
         JOIN project_prizes pp ON pp.id = vpc.prize_id
        WHERE vpc.project_id = ? AND vpc.prize_id IS NOT NULL
        ORDER BY pp.ranking ASC, vpc.challenged_at DESC, vpc.id DESC`,
      [projectId],
    );
    const winners = Array.isArray(winnerRows) ? winnerRows : [];

    const nameMap = new Map<string, string>();
    const emailMap = new Map<string, string>();
    if (winners.length > 0) {
      const [reservationRows] = await pool.execute(
        "SELECT fields_json, email_lower FROM reservations WHERE project_id = ?",
        [projectId],
      );
      (Array.isArray(reservationRows) ? reservationRows : []).forEach((row: any) => {
        try {
          const fields = JSON.parse(row.fields_json || "{}");
          const phone = String(fields.mobile || fields.phone || "").replace(/\D/g, "");
          if (!phone) return;
          if (fields.name) nameMap.set(phone, String(fields.name));
          const email = row.email_lower || fields.email;
          if (email) emailMap.set(phone, String(email));
        } catch {}
      });
    }

    res.json({
      ok: true,
      winners: winners.map((winner: any) => {
        const phoneKey = String(winner.phone || "").replace(/\D/g, "");
        return {
          id: Number(winner.id),
          visitor_id: Number(winner.visitor_id),
          prize_id: Number(winner.prize_id),
          ranking: Number(winner.ranking || 1),
          rank_name: winner.rank_name,
          prize_name: winner.prize_name,
          name: nameMap.get(phoneKey) || "미지정",
          phone: winner.phone,
          email: emailMap.get(phoneKey) || "",
          slot_index: Number(winner.slot_index),
          challenged_at: winner.challenged_at,
        };
      }),
    });
  } catch (err: any) {
    res.status(500).json({ ok: false, error: "db_error", message: err.message });
  }
});

// 4.5 Get winners list for a specific prize
router.get("/host/prizes/:id/winners", requireHost, async (req, res) => {
  try {
    const prizeId = Number(req.params.id);
    const hostId = req.session.host!.id;

    // Check prize and project ownership
    const [prizeRows] = await pool.execute(
      `SELECT r.id, r.project_id, r.prize_name, r.rank_name, r.ranking 
       FROM project_prizes r 
       JOIN projects p ON p.id = r.project_id 
       WHERE r.id = ? AND p.host_id = ?`,
      [prizeId, hostId]
    );
    if (!Array.isArray(prizeRows) || prizeRows.length === 0) {
      res.status(404).json({ ok: false, error: "prize_not_found", message: "경품을 찾을 수 없거나 권한이 없습니다." });
      return;
    }
    const prize = prizeRows[0] as any;
    const projectId = prize.project_id;

    // Retrieve all challenges that won this prize
    const [winnerRows] = await pool.execute(
      `SELECT vpc.id, vpc.visitor_id, vpc.slot_index, vpc.challenged_at, v.phone
       FROM visitor_prize_challenges vpc
       JOIN visitors v ON v.id = vpc.visitor_id
       WHERE vpc.prize_id = ?
       ORDER BY vpc.challenged_at DESC`,
      [prizeId]
    );

    const winners = Array.isArray(winnerRows) ? winnerRows : [];

    // Map names/emails from reservations
    const nameMap = new Map<string, string>();
    const emailMap = new Map<string, string>();
    
    if (winners.length > 0) {
      const [resvRows] = await pool.execute(
        `SELECT fields_json, email_lower FROM reservations WHERE project_id = ?`,
        [projectId],
      );
      (Array.isArray(resvRows) ? resvRows : []).forEach((r: any) => {
        try {
          const f = JSON.parse(r.fields_json || "{}");
          const ph = String(f.mobile || f.phone || "").replace(/\D/g, "");
          if (!ph) return;
          if (f.name) nameMap.set(ph, String(f.name));
          const em = r.email_lower || f.email;
          if (em) emailMap.set(ph, String(em));
        } catch {}
      });
    }

    const data = winners.map((w: any) => {
      const phKey = String(w.phone || "").replace(/\D/g, "");
      return {
        id: w.id,
        visitor_id: w.visitor_id,
        phone: w.phone,
        slot_index: w.slot_index,
        challenged_at: w.challenged_at,
        name: nameMap.get(phKey) || "미지정",
        email: emailMap.get(phKey) || "",
      };
    });

    res.json({
      ok: true,
      prize_name: prize.prize_name,
      rank_name: prize.rank_name,
      winners: data,
    });
  } catch (err: any) {
    res.status(500).json({ ok: false, error: "db_error", message: err.message });
  }
});

function extractVisitorPhone(req: any, projectId: number): string | null {
  const key = `tracker_phone_${projectId}`;
  const fromCookie = req.cookies?.[key];
  return typeof fromCookie === "string" && fromCookie.length > 0 ? fromCookie : null;
}

function toUploadUrl(p?: string | null): string | null {
  if (!p) return null;
  const norm = String(p).replace(/\\/g, "/");
  const idx = norm.lastIndexOf("/uploads/");
  if (idx >= 0) return norm.slice(idx);
  const rel = norm.indexOf("uploads/");
  return rel >= 0 ? `/${norm.slice(rel)}` : norm;
}

// 5. Get prize project stats (현장등록인원, 경품도전가능인원, 경품도전인원 등)
router.get("/host/projects/:projectId/prize-stats", requireHost, async (req, res) => {
  try {
    res.setHeader("Cache-Control", "no-store");
    const projectId = Number(req.params.projectId);
    const hostId = req.session.host!.id;

    // Verify project ownership
    const [projRows] = await pool.execute(
      "SELECT id, prize_challengers FROM projects WHERE id = ? AND host_id = ?",
      [projectId, hostId]
    );
    if (!Array.isArray(projRows) || projRows.length === 0) {
      res.status(404).json({ ok: false, error: "project_not_found", message: "프로젝트를 찾을 수 없거나 권한이 없습니다." });
      return;
    }
    const project = (projRows as any)[0];
    const prizeChallengersLimit = Number(project.prize_challengers || 0);

    // 1) Total active locations
    const [locRows] = await pool.execute(
      "SELECT COUNT(*) AS total_locations FROM project_locations WHERE project_id = ? AND disabled = 0",
      [projectId]
    );
    const totalActiveLocations = Number((locRows as any)[0].total_locations || 0);

    // 2) 현장등록인원
    // visitors 는 Tour 방문 인증만 한 사용자도 포함하므로,
    // 실제 현장등록 신청(reservations.mode='entry')을 기준으로 집계한다.
    const [visitorRows] = await pool.execute(
      `SELECT COUNT(*) AS total_visitors
         FROM reservations
        WHERE project_id = ?
          AND mode = 'entry'
          AND status NOT IN ('cancelled', 'expired')`,
      [projectId]
    );
    const totalVisitors = Number((visitorRows as any)[0].total_visitors || 0);

    // 3) Completed visitors (경품도전가능인원: visited all active locations)
    const [eligibleRows] = await pool.execute(
      `SELECT COUNT(*) AS eligible_count FROM (
         SELECT v.id
           FROM visitors v
           JOIN visitor_visits vv ON vv.visitor_id = v.id
           JOIN project_locations pl ON pl.id = vv.location_id AND pl.disabled = 0
          WHERE v.project_id = ?
          GROUP BY v.id
         HAVING COUNT(DISTINCT vv.location_id) >= ?
       ) AS t`,
      [projectId, totalActiveLocations]
    );
    const eligibleVisitors = Number((eligibleRows as any)[0].eligible_count || 0);

    // 4) Challenged visitors (경품도전인원: actual challenges)
    const [challengedRows] = await pool.execute(
      "SELECT COUNT(*) AS challenged_count FROM visitor_prize_challenges WHERE project_id = ?",
      [projectId]
    );
    const challengedVisitors = Number((challengedRows as any)[0].challenged_count || 0);

    // 5) Has winners
    const [winnerCountRows] = await pool.execute(
      "SELECT COUNT(*) AS win_count FROM visitor_prize_challenges WHERE project_id = ? AND prize_id IS NOT NULL",
      [projectId]
    );
    const hasWinners = Number((winnerCountRows as any)[0].win_count || 0) > 0;

    // 6) Prizes list with claimed counts
    const [prizesRows] = await pool.execute(
      `SELECT pp.id, pp.ranking, pp.rank_name, pp.prize_name, pp.winner_count, pp.image_path,
              (SELECT COUNT(*) FROM visitor_prize_challenges vpc WHERE vpc.prize_id = pp.id) AS claimed_count
         FROM project_prizes pp
        WHERE pp.project_id = ?
        ORDER BY pp.ranking ASC, pp.id ASC`,
      [projectId]
    );
    const prizes = (Array.isArray(prizesRows) ? prizesRows : []).map((p: any) => ({
      id: Number(p.id),
      ranking: Number(p.ranking || 1),
      rank_name: p.rank_name,
      prize_name: p.prize_name,
      winner_count: Number(p.winner_count || 1),
      claimed_count: Number(p.claimed_count || 0),
      image_path: toUploadUrl(p.image_path),
    }));

    res.json({
      ok: true,
      total_visitors: totalVisitors,
      eligible_visitors: eligibleVisitors,
      challenged_visitors: challengedVisitors,
      prize_challengers_limit: prizeChallengersLimit,
      has_winners: hasWinners,
      prizes: prizes,
    });
  } catch (err: any) {
    res.status(500).json({ ok: false, error: "db_error", message: err.message });
  }
});

// 6. Set challenger limit & reshuffle only unclaimed prizes.
// Existing challenge results (winners and non-winners) are never reset.
router.post("/host/projects/:projectId/prize-shuffle", requireHost, async (req, res) => {
  try {
    const projectId = Number(req.params.projectId);
    const hostId = req.session.host!.id;
    const challengers = Number(req.body.challengers || 0);

    if (isNaN(challengers) || challengers <= 0) {
      res.status(400).json({ ok: false, error: "invalid_challengers", message: "올바른 도전인원 값을 입력해주세요 (1명 이상)." });
      return;
    }

    // Verify project ownership
    const [projRows] = await pool.execute(
      "SELECT id FROM projects WHERE id = ? AND host_id = ?",
      [projectId, hostId]
    );
    if (!Array.isArray(projRows) || projRows.length === 0) {
      res.status(404).json({ ok: false, error: "project_not_found", message: "프로젝트를 찾을 수 없거나 권한이 없습니다." });
      return;
    }

    // Get all prizes and calculate total / already claimed / remaining counts.
    const [prizesRows] = await pool.execute(
      `SELECT pp.id, pp.winner_count,
              (SELECT COUNT(*) FROM visitor_prize_challenges vpc
                WHERE vpc.project_id = pp.project_id AND vpc.prize_id = pp.id) AS claimed_count
         FROM project_prizes pp
        WHERE pp.project_id = ?`,
      [projectId]
    );
    const prizes = Array.isArray(prizesRows) ? prizesRows : [];
    let totalPrizesCount = 0;
    const remainingPrizeIds: number[] = [];

    for (const p of prizes) {
      const cnt = Number((p as any).winner_count || 1);
      const claimed = Math.min(cnt, Number((p as any).claimed_count || 0));
      totalPrizesCount += cnt;
      for (let i = claimed; i < cnt; i++) {
        remainingPrizeIds.push(Number((p as any).id));
      }
    }

    if (challengers < totalPrizesCount) {
      res.status(400).json({ ok: false, error: "insufficient_challengers", message: `도전인원(${challengers}명)은 등록된 총 경품 수(${totalPrizesCount}개)보다 크거나 같아야 합니다.` });
      return;
    }

    const [challengeCountRows] = await pool.execute(
      "SELECT COUNT(*) AS challenged_count FROM visitor_prize_challenges WHERE project_id = ?",
      [projectId]
    );
    const challengedCount = Number((challengeCountRows as any)[0].challenged_count || 0);
    const minimumChallengers = challengedCount + remainingPrizeIds.length;
    if (challengers < minimumChallengers) {
      res.status(400).json({
        ok: false,
        error: "insufficient_remaining_slots",
        message: `기존 도전 결과 ${challengedCount}건을 유지하고 남은 경품 ${remainingPrizeIds.length}개를 재배치하려면 도전인원이 최소 ${minimumChallengers}명이어야 합니다.`,
      });
      return;
    }

    // Perform atomic transaction
    const conn = await pool.getConnection();
    try {
      await conn.beginTransaction();

      // Update projects table with the challenger limit
      await conn.execute(
        "UPDATE projects SET prize_challengers = ? WHERE id = ?",
        [challengers, projectId]
      );

      // Preserve every challenged slot/result. Only future (unconfirmed) slots are rebuilt.
      await conn.execute(
        "DELETE FROM project_prize_slots WHERE project_id = ? AND slot_index > ?",
        [projectId, challengedCount]
      );

      // Distribute only remaining prizes among slots that nobody has challenged yet.
      const selectedSlots = new Set<number>();
      while (selectedSlots.size < remainingPrizeIds.length) {
        const rnd = Math.floor(Math.random() * (challengers - challengedCount)) + challengedCount + 1;
        selectedSlots.add(rnd);
      }
      const selectedSlotsArr = Array.from(selectedSlots);

      // Shuffle the remaining prize instances as well.
      for (let i = remainingPrizeIds.length - 1; i > 0; i--) {
        const j = Math.floor(Math.random() * (i + 1));
        const temp = remainingPrizeIds[i];
        remainingPrizeIds[i] = remainingPrizeIds[j];
        remainingPrizeIds[j] = temp;
      }

      // Store slots
      for (let i = 0; i < selectedSlotsArr.length; i++) {
        await conn.execute(
          "INSERT INTO project_prize_slots (project_id, slot_index, prize_id) VALUES (?, ?, ?)",
          [projectId, selectedSlotsArr[i], remainingPrizeIds[i]]
        );
      }

      await conn.commit();
      res.json({
        ok: true,
        message: `기존 도전 결과 ${challengedCount}건을 유지하고, 미확정 경품 ${remainingPrizeIds.length}개를 도전인원 ${challengers}명 범위에 재배치했습니다.`,
      });
    } catch (txErr: any) {
      await conn.rollback();
      throw txErr;
    } finally {
      conn.release();
    }
  } catch (err: any) {
    res.status(500).json({ ok: false, error: "db_error", message: err.message });
  }
});

// 7. GET /visitor/projects/:projectSerial/prize-info
router.get("/visitor/projects/:projectSerial/prize-info", async (req, res) => {
  try {
    const projectSerial = req.params.projectSerial;

    // Fetch project
    const [projRows] = await pool.execute(
      "SELECT id, prize_challengers FROM projects WHERE project_serial = ?",
      [projectSerial]
    );
    if (!Array.isArray(projRows) || projRows.length === 0) {
      res.status(404).json({ ok: false, error: "project_not_found", message: "프로젝트를 찾을 수 없습니다." });
      return;
    }
    const project = (projRows as any)[0];
    const projectId = Number(project.id);
    const prizeChallengersLimit = Number(project.prize_challengers || 0);

    const phone = extractVisitorPhone(req, projectId);
    if (!phone) {
      res.status(200).json({ ok: true, error: "phone_required", message: "휴대폰 번호 인증이 필요합니다." });
      return;
    }

    const [visitorRows] = await pool.execute(
      "SELECT id FROM visitors WHERE project_id = ? AND phone = ?",
      [projectId, phone]
    );
    if (!Array.isArray(visitorRows) || visitorRows.length === 0) {
      res.status(200).json({ ok: true, error: "visitor_not_found", message: "등록되지 않은 방문자입니다." });
      return;
    }
    const visitorId = Number((visitorRows as any)[0].id);

    // Check completion status (all active locations visited)
    const [locRows] = await pool.execute(
      "SELECT COUNT(*) AS total_locations FROM project_locations WHERE project_id = ? AND disabled = 0",
      [projectId]
    );
    const totalActiveLocations = Number((locRows as any)[0].total_locations || 0);

    const [visitedRows] = await pool.execute(
      `SELECT COUNT(DISTINCT vv.location_id) AS visited_locations
         FROM visitor_visits vv
         JOIN project_locations pl ON pl.id = vv.location_id
        WHERE vv.project_id = ? AND vv.visitor_id = ? AND pl.disabled = 0`,
      [projectId, visitorId]
    );
    const visitedLocations = Number((visitedRows as any)[0].visited_locations || 0);

    const isEligible = (totalActiveLocations > 0) && (visitedLocations >= totalActiveLocations);

    // Check challenge history
    const [challengeRows] = await pool.execute(
      "SELECT id, slot_index, prize_id, challenged_at FROM visitor_prize_challenges WHERE project_id = ? AND visitor_id = ?",
      [projectId, visitorId]
    );
    const hasChallenged = Array.isArray(challengeRows) && challengeRows.length > 0;
    let challengeResult = null;

    if (hasChallenged) {
      const ch = (challengeRows as any)[0];
      const prizeId = ch.prize_id;
      let wonPrize = null;
      if (prizeId) {
        const [prizeRows] = await pool.execute(
          "SELECT id, ranking, rank_name, prize_name, image_path FROM project_prizes WHERE id = ?",
          [prizeId]
        );
        if (Array.isArray(prizeRows) && prizeRows.length > 0) {
          const p = (prizeRows as any)[0];
          wonPrize = {
            id: Number(p.id),
            ranking: Number(p.ranking || 1),
            rank_name: p.rank_name,
            prize_name: p.prize_name,
            image_path: toUploadUrl(p.image_path)
          };
        }
      }
      challengeResult = {
        win: prizeId !== null,
        slot_index: Number(ch.slot_index),
        challenged_at: ch.challenged_at,
        prize: wonPrize
      };
    }

    // Get all project prizes list
    const [prizesRows] = await pool.execute(
      `SELECT pp.id, pp.ranking, pp.rank_name, pp.prize_name, pp.winner_count, pp.image_path,
              (SELECT COUNT(*) FROM visitor_prize_challenges vpc WHERE vpc.prize_id = pp.id) AS claimed_count
         FROM project_prizes pp
        WHERE pp.project_id = ?
        ORDER BY pp.ranking ASC, pp.id ASC`,
      [projectId]
    );
    const prizesList = (Array.isArray(prizesRows) ? prizesRows : []).map((p: any) => ({
      id: Number(p.id),
      ranking: Number(p.ranking || 1),
      rank_name: p.rank_name,
      prize_name: p.prize_name,
      winner_count: Number(p.winner_count || 1),
      claimed_count: Number(p.claimed_count || 0),
      image_path: toUploadUrl(p.image_path)
    }));

    res.json({
      ok: true,
      prize_challengers_limit: prizeChallengersLimit,
      eligible: isEligible,
      has_challenged: hasChallenged,
      challenge_result: challengeResult,
      prizes: prizesList
    });
  } catch (err: any) {
    res.status(500).json({ ok: false, error: "db_error", message: err.message });
  }
});

// 8. POST /visitor/projects/:projectSerial/prize-challenge
router.post("/visitor/projects/:projectSerial/prize-challenge", async (req, res) => {
  try {
    const projectSerial = req.params.projectSerial;

    // Fetch project
    const [projRows] = await pool.execute(
      "SELECT id, prize_challengers FROM projects WHERE project_serial = ?",
      [projectSerial]
    );
    if (!Array.isArray(projRows) || projRows.length === 0) {
      res.status(404).json({ ok: false, error: "project_not_found", message: "프로젝트를 찾을 수 없습니다." });
      return;
    }
    const project = (projRows as any)[0];
    const projectId = Number(project.id);
    const prizeChallengersLimit = Number(project.prize_challengers || 0);

    if (prizeChallengersLimit <= 0) {
      res.status(400).json({ ok: false, error: "not_configured", message: "경품 행사가 아직 활성화되지 않았습니다. 관리자에게 문의하세요." });
      return;
    }

    const phone = extractVisitorPhone(req, projectId);
    if (!phone) {
      res.status(400).json({ ok: false, error: "phone_required", message: "휴대폰 번호 인증이 필요합니다." });
      return;
    }

    const [visitorRows] = await pool.execute(
      "SELECT id FROM visitors WHERE project_id = ? AND phone = ?",
      [projectId, phone]
    );
    if (!Array.isArray(visitorRows) || visitorRows.length === 0) {
      res.status(404).json({ ok: false, error: "visitor_not_found", message: "등록되지 않은 방문자입니다." });
      return;
    }
    const visitorId = Number((visitorRows as any)[0].id);

    // Verify stamp tour completion
    const [locRows] = await pool.execute(
      "SELECT COUNT(*) AS total_locations FROM project_locations WHERE project_id = ? AND disabled = 0",
      [projectId]
    );
    const totalActiveLocations = Number((locRows as any)[0].total_locations || 0);

    const [visitedRows] = await pool.execute(
      `SELECT COUNT(DISTINCT vv.location_id) AS visited_locations
         FROM visitor_visits vv
         JOIN project_locations pl ON pl.id = vv.location_id
        WHERE vv.project_id = ? AND vv.visitor_id = ? AND pl.disabled = 0`,
      [projectId, visitorId]
    );
    const visitedLocations = Number((visitedRows as any)[0].visited_locations || 0);

    const isEligible = (totalActiveLocations > 0) && (visitedLocations >= totalActiveLocations);
    if (!isEligible) {
      res.status(400).json({ ok: false, error: "not_eligible", message: "모든 스탬프 투어 미션을 완료해야만 경품에 도전할 수 있습니다!" });
      return;
    }

    // Atomically draw next slot index
    const conn = await pool.getConnection();
    try {
      await conn.beginTransaction();

      // Double check challenge history inside transaction
      const [historyRows] = await conn.execute(
        "SELECT id FROM visitor_prize_challenges WHERE project_id = ? AND visitor_id = ? FOR UPDATE",
        [projectId, visitorId]
      );
      if (Array.isArray(historyRows) && historyRows.length > 0) {
        await conn.rollback();
        res.status(400).json({ ok: false, error: "already_challenged", message: "이미 경품 도전에 참여하셨습니다!" });
        return;
      }

      // Lock challenges count
      const [countRows] = await conn.execute(
        "SELECT COUNT(*) AS current_challenges FROM visitor_prize_challenges WHERE project_id = ? FOR UPDATE",
        [projectId]
      );
      const nextSlotIndex = Number((countRows as any)[0].current_challenges) + 1;

      if (nextSlotIndex > prizeChallengersLimit) {
        await conn.rollback();
        res.status(400).json({ ok: false, error: "limit_exceeded", message: "모든 경품 도전 기회가 마감되었습니다. 참여해 주셔서 감사합니다!" });
        return;
      }

      // Check slot allocation
      const [slotRows] = await conn.execute(
        "SELECT prize_id FROM project_prize_slots WHERE project_id = ? AND slot_index = ?",
        [projectId, nextSlotIndex]
      );
      let wonPrizeId: number | null = null;
      if (Array.isArray(slotRows) && slotRows.length > 0) {
        wonPrizeId = (slotRows as any)[0].prize_id;
      }

      // Record challenge
      await conn.execute(
        "INSERT INTO visitor_prize_challenges (project_id, visitor_id, slot_index, prize_id) VALUES (?, ?, ?, ?)",
        [projectId, visitorId, nextSlotIndex, wonPrizeId]
      );

      await conn.commit();

      let wonPrizeDetails = null;
      if (wonPrizeId) {
        const [prizeRows] = await pool.execute(
          "SELECT id, ranking, rank_name, prize_name, image_path FROM project_prizes WHERE id = ?",
          [wonPrizeId]
        );
        if (Array.isArray(prizeRows) && prizeRows.length > 0) {
          const p = (prizeRows as any)[0];
          wonPrizeDetails = {
            id: Number(p.id),
            ranking: Number(p.ranking || 1),
            rank_name: p.rank_name,
            prize_name: p.prize_name,
            image_path: toUploadUrl(p.image_path)
          };
        }
      }

      res.json({
        ok: true,
        win: wonPrizeId !== null,
        slot_index: nextSlotIndex,
        prize: wonPrizeDetails
      });
    } catch (txErr: any) {
      await conn.rollback();
      throw txErr;
    } finally {
      conn.release();
    }
  } catch (err: any) {
    res.status(500).json({ ok: false, error: "db_error", message: err.message });
  }
});

export default router;
