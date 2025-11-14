module.exports = ({ env }) => ({
  database: {
    connection: {
      client: 'postgres',
      connection: {
        connectionString: env('DATABASE_URL'),
        ssl: {
          rejectUnauthorized: false,
        },
      },
      debug: false,
    },
  }
});
