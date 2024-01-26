require('dotenv').config();
import { join } from "path";
import { DataSource } from "typeorm";

export default new DataSource({
  type: "postgres",
  url: process.env.DB_URL,
  migrations: [join(__dirname, "migrations", "*.{ts,js}")]
})