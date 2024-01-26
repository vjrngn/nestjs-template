export type DatabaseConfig = {
  type: "postgres" | "mysql";
  url: string;
}

export type AppConfig = {
  port: number;
  db: DatabaseConfig;
}

export default (): AppConfig => {
  return {
    port: Number(process.env.APP_PORT),
    db: {
      type: "postgres",
      url: process.env.DB_URL
    }
  }
}