export default ({ env }: { env: (key: string, defaultValue?: any) => any }) => ({
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
});
