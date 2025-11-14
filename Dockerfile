# Use a imagem oficial do Node.js v20
FROM node:20-alpine AS base
# Instale dependências de sistema para 'sharp' e outras compilações
RUN apk update && apk add --no-cache libc6-compat build-base gcc autoconf automake zlib-dev libpng-dev vips-dev git
WORKDIR /app
COPY package.json package-lock.json ./
RUN npm ci --omit=dev

# Build Stage - Constrói o painel de admin
FROM base AS build
WORKDIR /app
COPY . .
RUN npm run build

# Production Stage - A imagem final e enxuta
FROM base AS production
WORKDIR /app
COPY --from=build /app/dist ./dist
COPY --from=build /app/node_modules ./node_modules
COPY package.json .

# Copia o script de inicialização
COPY start.sh ./

EXPOSE 1337
# Usa o script de inicialização
CMD ["./start.sh"]
