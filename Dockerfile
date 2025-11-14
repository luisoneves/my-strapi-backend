FROM node:20-alpine

# Instala dependências necessárias
RUN apk add --no-cache build-base gcc autoconf automake zlib-dev libpng-dev vips-dev git

WORKDIR /app

# Copia arquivos de dependências
COPY package.json package-lock.json ./

# Instala dependências
RUN npm ci --only=production

# Copia o código da aplicação
COPY . .

# Constrói o Strapi
RUN npm run build

# Expõe a porta
EXPOSE 1337

# Script de inicialização
COPY start.sh ./
RUN chmod +x start.sh

CMD ["./start.sh"]
