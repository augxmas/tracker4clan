import mysql from "mysql2/promise";
import dotenv from "dotenv";

dotenv.config({ override: true });

let dbHost = process.env.DB_HOST;
if (process.env.K_SERVICE) {
  // Cloud Run (production environment) should connect to the external DB
  // unless a non-local DB_HOST is explicitly provided.
  if (!dbHost || dbHost === "127.0.0.1" || dbHost === "localhost") {
    dbHost = "3.35.190.76";
  }
} else if (!dbHost) {
  dbHost = "127.0.0.1";
}

const isLocal = dbHost === "127.0.0.1" || dbHost === "localhost";
const defaultDb = "tracker";
const defaultUser = "tracker";
const defaultPassword = "Tr@ck2r";

// 운영환경 배포 시 기존 환경변수(stamptour, traveller, Tr@v21ler)가 주입되어 있을 수 있으므로,
// 해당 구형 값들은 preview 계정인 tracker 계정 정보로 자동 전환되도록 처리합니다.
const dbName = process.env.DB_NAME && process.env.DB_NAME !== "stamptour" ? process.env.DB_NAME : defaultDb;
const dbUser = process.env.DB_USER && process.env.DB_USER !== "traveller" ? process.env.DB_USER : defaultUser;
const dbPassword = process.env.DB_PASSWORD && process.env.DB_PASSWORD !== "Tr@v21ler" ? process.env.DB_PASSWORD : defaultPassword;

const pool = mysql.createPool({
  host: dbHost,
  port: Number(process.env.DB_PORT ?? 3306),
  database: dbName,
  user: dbUser,
  password: dbPassword,
  charset: "utf8mb4",
  timezone: "+09:00",
  waitForConnections: true,
  connectionLimit: 5,
  queueLimit: 0,
  // DB is on a different subnet, so traffic crosses a stateful firewall.
  // Keepalive keeps the NAT/firewall flow alive and surfaces dead sockets
  // early; idle recycling drops pooled connections before the firewall
  // silently reaps them, which otherwise shows up as connect ETIMEDOUT.
  connectTimeout: 20000,
  enableKeepAlive: true,
  keepAliveInitialDelay: 10000,
  idleTimeout: 30000,
  maxIdle: 2,
});

(pool as any).on("error", (err: any) => {
  console.error("[Database Pool Error]", err);
});

// Graceful shutdown to release pool connections immediately on process exit/restart
const handleShutdown = async () => {
  try {
    await pool.end();
    console.log("Database connection pool closed gracefully");
  } catch (err) {
    console.error("Error closing database connection pool:", err);
  }
};
process.on("SIGTERM", handleShutdown);
process.on("SIGINT", handleShutdown);

export default pool;
