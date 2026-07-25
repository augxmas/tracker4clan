import { Router } from "express";
import multer from "multer";
import path from "path";
import crypto from "crypto";
import pool from "../config/database";
import { requireHost } from "../middleware/auth";
import sizeOf from "image-size";

const router = Router();

// Multer storage for Resources in Memory
const upload = multer({
  storage: multer.memoryStorage(),
  limits: { fileSize: 50 * 1024 * 1024 }, // 50MB
});

const RESOURCE_ARCHIVE_EXTENSIONS = new Set([
  ".zip", ".rar", ".7z", ".tar", ".gz", ".gzip", ".bz2", ".xz", ".tgz", ".cab", ".iso", ".jar", ".war",
]);
const RESOURCE_TEXT_EXTENSIONS = new Set([
  ".txt", ".text", ".csv", ".tsv", ".js", ".mjs", ".cjs", ".ts", ".tsx", ".jsx",
  ".css", ".scss", ".sass", ".less", ".html", ".htm", ".xml", ".json", ".yaml", ".yml",
  ".md", ".log", ".ini", ".conf", ".config", ".sql", ".sh", ".bat", ".cmd", ".ps1",
  ".py", ".java", ".c", ".cpp", ".h", ".hpp", ".go", ".rs", ".php", ".rb", ".pl",
  ".vue", ".svelte", ".svg",
]);
const RESOURCE_BINARY_EXTENSIONS = new Set([
  ".jpg", ".jpeg", ".png", ".gif", ".webp", ".bmp", ".tif", ".tiff", ".ico",
  ".mp3", ".wav", ".ogg", ".m4a", ".aac", ".flac", ".wma",
  ".mp4", ".webm", ".mov", ".avi", ".mkv", ".mpeg", ".mpg", ".wmv",
  ".pdf", ".doc", ".docx", ".xls", ".xlsx", ".ppt", ".pptx", ".hwp", ".hwpx", ".bin",
]);

function validateResourceFile(file: Express.Multer.File): string | null {
  const ext = path.extname(file.originalname).toLowerCase();
  if (!ext) return "확장자가 없는 파일은 업로드할 수 없습니다.";
  if (RESOURCE_ARCHIVE_EXTENSIONS.has(ext)) return "zip 파일은 업로드할 수 없습니다.";
  if (RESOURCE_TEXT_EXTENSIONS.has(ext) || file.mimetype.toLowerCase().startsWith("text/")) {
    return "txt 계열은 업로드할 수 없습니다.";
  }
  if (!RESOURCE_BINARY_EXTENSIONS.has(ext)) return "바이너리 형식의 파일만 업로드할 수 있습니다.";
  return null;
}

async function ensureOwnership(projectId: number, hostId: number): Promise<boolean> {
  const [rows] = await pool.execute("SELECT id FROM projects WHERE id = ? AND host_id = ?", [projectId, hostId]);
  return Array.isArray(rows) && rows.length > 0;
}

async function ensureResourceOwnership(resourceId: number, hostId: number): Promise<any | null> {
  const [rows] = await pool.execute(
    "SELECT r.* FROM project_resources r JOIN projects p ON p.id = r.project_id WHERE r.id = ? AND p.host_id = ?",
    [resourceId, hostId]
  );
  return (Array.isArray(rows) && rows.length > 0) ? rows[0] : null;
}

// 1. List Resources
router.get("/host/resources", requireHost, async (req, res) => {
  try {
    const hostId = req.session.host!.id;
    const projectName = String(req.query.project_name || "").trim();
    const title = String(req.query.title || "").trim();

    let where = "WHERE p.host_id = ?";
    const params: Array<string | number> = [hostId];

    if (projectName) {
      where += " AND (p.project_name LIKE ? OR p.project_serial LIKE ?)";
      params.push(`%${projectName}%`, `%${projectName}%`);
    }
    if (title) {
      where += " AND r.title LIKE ?";
      params.push(`%${title}%`);
    }

    const [rows] = await pool.execute(
      `SELECT r.id, r.project_id, r.title, r.description, r.file_name, r.file_path, r.file_size, r.created_at, r.width, r.height, p.project_name, p.project_serial
       FROM project_resources r
       JOIN projects p ON p.id = r.project_id
       ${where}
       ORDER BY r.id DESC`,
      params
    );

    res.json({ ok: true, resources: rows });
  } catch (err: any) {
    res.status(500).json({ ok: false, error: "db_error", message: err.message });
  }
});

// 2. Upload/Register Resource
router.post("/host/projects/:id/resources", requireHost, upload.single("file"), async (req: any, res) => {
  try {
    const host = req.session.host!;
    const pid = Number(req.params.id);

    if (!(await ensureOwnership(pid, host.id))) {
      res.status(404).json({ ok: false, error: "project_not_found" });
      return;
    }

    const file = req.file;
    if (!file) {
      res.status(400).json({ ok: false, error: "file_required", message: "업로드할 파일을 선택해 주세요." });
      return;
    }

    const fileValidationMessage = validateResourceFile(file);
    if (fileValidationMessage) {
      res.status(400).json({ ok: false, error: "invalid_file_type", message: fileValidationMessage });
      return;
    }

    const title = String(req.body.title || "").trim();
    const description = String(req.body.description || "").trim();

    if (!title) {
      res.status(400).json({ ok: false, error: "title_required", message: "자료 제목을 입력해 주세요." });
      return;
    }

    const safe = crypto.randomBytes(8).toString("hex");
    const ext = path.extname(file.originalname).toLowerCase().slice(0, 10);
    const uniqueFileName = `${Date.now()}_${safe}${ext}`;
    const fileUrl = `/uploads/resources/${uniqueFileName}`;

    let decodedOriginalName = file.originalname;
    try {
      decodedOriginalName = Buffer.from(file.originalname, "latin1").toString("utf-8");
    } catch (e) {
      // fallback if conversion fails
    }

    let width: number | null = null;
    let height: number | null = null;
    const imageExtensions = [".png", ".jpg", ".jpeg", ".gif", ".webp", ".svg", ".bmp"];
    if (imageExtensions.includes(ext)) {
      try {
        const dimensions = sizeOf(file.buffer);
        if (dimensions) {
          width = dimensions.width ?? null;
          height = dimensions.height ?? null;
        }
      } catch (e) {
        console.error("Failed to get image dimensions:", e);
      }
    }

    const [r] = await pool.execute(
      `INSERT INTO project_resources (project_id, title, description, file_name, file_path, file_size, width, height, file_data)
       VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)`,
      [pid, title, description, decodedOriginalName, fileUrl, file.size, width, height, file.buffer]
    );

    res.json({ ok: true, id: (r as any).insertId });
  } catch (err: any) {
    res.status(500).json({ ok: false, error: "db_error", message: err.message });
  }
});

// 3. Delete Resource
router.delete("/host/resources/:id", requireHost, async (req, res) => {
  try {
    const hostId = req.session.host!.id;
    const rid = Number(req.params.id);

    const resource = await ensureResourceOwnership(rid, hostId);
    if (!resource) {
      res.status(404).json({ ok: false, error: "resource_not_found" });
      return;
    }

    await pool.execute("DELETE FROM project_resources WHERE id = ?", [rid]);

    res.json({ ok: true });
  } catch (err: any) {
    res.status(500).json({ ok: false, error: "db_error", message: err.message });
  }
});

// 4. Update/Modify Resource (Metadata + optional file replacement)
router.put("/host/resources/:id", requireHost, upload.single("file"), async (req: any, res) => {
  try {
    const hostId = req.session.host!.id;
    const rid = Number(req.params.id);

    const resource = await ensureResourceOwnership(rid, hostId);
    if (!resource) {
      res.status(404).json({ ok: false, error: "resource_not_found" });
      return;
    }

    const title = String(req.body.title || "").trim();
    const description = String(req.body.description || "").trim();

    if (!title) {
      res.status(400).json({ ok: false, error: "title_required", message: "자료 제목을 입력해 주세요." });
      return;
    }

    const file = req.file;
    if (file) {
      const fileValidationMessage = validateResourceFile(file);
      if (fileValidationMessage) {
        res.status(400).json({ ok: false, error: "invalid_file_type", message: fileValidationMessage });
        return;
      }
      const safe = crypto.randomBytes(8).toString("hex");
      const ext = path.extname(file.originalname).toLowerCase().slice(0, 10);
      const uniqueFileName = `${Date.now()}_${safe}${ext}`;
      const fileUrl = `/uploads/resources/${uniqueFileName}`;

      let decodedOriginalName = file.originalname;
      try {
        decodedOriginalName = Buffer.from(file.originalname, "latin1").toString("utf-8");
      } catch (e) {
        // fallback
      }

      let width: number | null = null;
      let height: number | null = null;
      const imageExtensions = [".png", ".jpg", ".jpeg", ".gif", ".webp", ".svg", ".bmp"];
      if (imageExtensions.includes(ext)) {
        try {
          const dimensions = sizeOf(file.buffer);
          if (dimensions) {
            width = dimensions.width ?? null;
            height = dimensions.height ?? null;
          }
        } catch (e) {
          console.error("Failed to get image dimensions:", e);
        }
      }

      await pool.execute(
        `UPDATE project_resources 
         SET title = ?, description = ?, file_name = ?, file_path = ?, file_size = ?, width = ?, height = ?, file_data = ?
         WHERE id = ?`,
        [title, description, decodedOriginalName, fileUrl, file.size, width, height, file.buffer, rid]
      );
    } else {
      await pool.execute(
        `UPDATE project_resources 
         SET title = ?, description = ?
         WHERE id = ?`,
        [title, description, rid]
      );
    }

    res.json({ ok: true });
  } catch (err: any) {
    res.status(500).json({ ok: false, error: "db_error", message: err.message });
  }
});

export default router;
