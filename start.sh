#!/bin/sh
set -e

# Função para verificar a conexão com o banco
check_db() {
  node -e "
    const { Client } = require('pg');
    const client = new Client({ connectionString: process.env.DATABASE_URL, ssl: { rejectUnauthorized: false } });
    console.log('Tentando conectar ao banco de dados...');
    client.connect()
      .then(() => {
        console.log('✅ Conexão com o banco de dados bem-sucedida!');
        client.end();
        process.exit(0);
      })
      .catch(err => {
        console.error('❌ Falha na conexão:', err.message);
        process.exit(1);
      });
  "
}

# Loop de tentativas
until check_db; do
  echo "🕒 Banco de dados ainda não está pronto. Tentando novamente em 5 segundos..."
  sleep 5
done

echo "🚀 Iniciando Strapi..."
exec npm run start
