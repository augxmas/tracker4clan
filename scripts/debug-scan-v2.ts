import pool from "../src/config/database";
import { ensureAllTierGifts } from "../src/services/gift.service";

async function main() {
  const projectId = 7;
  const token = "55aaab75b7945b941a1df8f42dec137659e6d120"; // 김창호
  const locationId = 18; // Let's find project_locations for project 7 first!

  try {
    const [locations] = await pool.execute("SELECT id, location_name, disabled FROM project_locations WHERE project_id = ?", [projectId]);
    console.log("=== PROJECT LOCATIONS ===");
    console.log(locations);

    const targetLoc = (locations as any[]).find(l => !l.disabled);
    if (!targetLoc) {
      console.error("No active locations found for project 7!");
      return;
    }
    const locId = targetLoc.id;
    console.log(`Using active location: ${targetLoc.location_name} (ID: ${locId})`);

    // Now run the scan-visitor steps one by one
    // 1) Find reservation by token and projectId
    const [resvRows] = await pool.execute(
      "SELECT id, fields_json, mode FROM reservations WHERE project_id = ? AND token = ?",
      [projectId, token]
    );
    console.log("1) Find reservation rows:", resvRows);
    const resv = (resvRows as any)[0];

    // 2) Parse fields_json to extract phone & name
    let phoneRaw = "";
    let name = "방문자";
    try {
      const fields = JSON.parse(resv.fields_json || "{}");
      phoneRaw = fields.mobile || fields.phone || "";
      name = fields.name || "방문자";
    } catch (e) {}
    console.log("2) Extracted phoneRaw:", phoneRaw, "name:", name);

    const digits = phoneRaw.replace(/\D/g, "");
    console.log("Digits:", digits);

    const phone = digits;

    // 3) Find or create visitor in visitors table
    console.log("3) Insert into visitors...");
    await pool.execute(
      "INSERT IGNORE INTO visitors (project_id, phone, consent_at) VALUES (?, ?, NOW())",
      [projectId, phone]
    );

    const [visitorRows] = await pool.execute(
      "SELECT id FROM visitors WHERE project_id = ? AND phone = ?",
      [projectId, phone]
    );
    console.log("visitorRows found:", visitorRows);
    const visitorId = Number((visitorRows as any)[0].id);
    console.log("visitorId:", visitorId);

    // Validate locationId exists for this project
    const [locRows] = await pool.execute(
      "SELECT id, location_name FROM project_locations WHERE id = ? AND project_id = ? AND disabled = 0",
      [locId, projectId]
    );
    console.log("locRows:", locRows);
    const loc = (locRows as any)[0];

    // 4) Check if already visited
    const [dupRows] = await pool.execute(
      "SELECT id FROM visitor_visits WHERE visitor_id = ? AND location_id = ?",
      [visitorId, locId]
    );
    const alreadyVisited = Array.isArray(dupRows) && dupRows.length > 0;
    console.log("alreadyVisited:", alreadyVisited);

    if (!alreadyVisited) {
      console.log("Inserting visitor_visit...");
      await pool.execute(
        "INSERT INTO visitor_visits (project_id, visitor_id, location_id) VALUES (?, ?, ?)",
        [projectId, visitorId, locId]
      );
      console.log("visitor_visit inserted!");
    }

    // 5) Recompute gifts
    console.log("Calling ensureAllTierGifts...");
    await ensureAllTierGifts(projectId, visitorId);
    console.log("ensureAllTierGifts completed successfully!");

    // 6) Query progress
    const [totalRows] = await pool.execute(
      "SELECT COUNT(*) AS total FROM project_locations WHERE project_id = ? AND disabled = 0",
      [projectId]
    );
    const [visitedRows] = await pool.execute(
      `SELECT COUNT(DISTINCT vv.location_id) AS visited
       FROM visitor_visits vv
       JOIN project_locations pl ON pl.id = vv.location_id
       WHERE vv.project_id = ? AND vv.visitor_id = ? AND pl.disabled = 0`,
      [projectId, visitorId]
    );

    const total = Number((totalRows as any)[0]?.total || 0);
    const visited = Number((visitedRows as any)[0]?.visited || 0);
    console.log(`Progress: ${visited}/${total}`);

  } catch (err) {
    console.error("Simulation failed with error:", err);
  } finally {
    await pool.end();
  }
}

main();
