import mysql from "mysql2/promise";
import { DATABASE_URL } from "../constant/app.constant";

// Create the connection pool. The pool-specific settings are the defaults
const pool = mysql.createPool({
  uri: DATABASE_URL,

  waitForConnections: true,
  connectionLimit: 10,
  maxIdle: 10,
  idleTimeout: 60000,
  queueLimit: 0,
  enableKeepAlive: true,
  keepAliveInitialDelay: 0,
});

export default pool;
