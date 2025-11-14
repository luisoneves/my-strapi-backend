# Use a imagem oficial do Node.js v20
FROM node:20-alpine AS base

# Instale dependências de sistema
RUN apk update && apk add --no-cache libc6-compat build-base gcc autoconf automake zlib-dev libpng-dev vips-dev git

WORKDIR /app
COPY package.json package-lock.json ./
RUN npm ci --omit=dev

# Build Stage
FROM base AS build
WORKDIR /app
COPY . .
RUN npm run build

# Production Stage
FROM base AS production
WORKDIR /app
COPY --from=build /app/dist ./dist
COPY --from=build /app/node_modules ./node_modules
COPY package.json .

# Copia o script de inicialização
COPY start.sh ./

# Use PORT para Railway (em vez de EXPOSE)
ENV PORT 1337

# Usa o script de inicialização
CMD ["./start.sh"]
