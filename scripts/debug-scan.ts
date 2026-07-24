import pool from "../src/config/database";

async function main() {
  try {
    const [resvRows] = await pool.execute("SELECT id, project_id, token, fields_json, mode, status FROM reservations ORDER BY id DESC LIMIT 20");
    console.log("=== LATEST 20 RESERVATIONS ===");
    console.log(JSON.stringify(resvRows, null, 2));

    const [visitorRows] = await pool.execute("SELECT id, project_id, phone, consent_at FROM visitors ORDER BY id DESC LIMIT 20");
    console.log("=== LATEST 20 VISITORS ===");
    console.log(JSON.stringify(visitorRows, null, 2));

    const [projRows] = await pool.execute("SELECT id, project_name, project_serial FROM projects");
    console.log("=== PROJECTS ===");
    console.log(JSON.stringify(projRows, null, 2));
  } catch (err) {
    console.error("Debug run failed:", err);
  } finally {
    await pool.end();
  }
}

main();
