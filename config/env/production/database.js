module.exports = ({ env }) => ({
  connection: {
    client: 'postgres',
    connection: {
      connectionString: env('DATABASE_URL'),
      ssl: {
        rejectUnauthorized: false,
      },
    },
    // --- ADICIONE ESTA LINHA ---
    driver: 'pg-native',
    // -------------------------
    debug: false,
  },
});
