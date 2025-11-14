# Use a imagem oficial do Node.js v20
FROM node:20-alpine AS base
# Instale dependências de sistema para 'sharp' e outras compilações
RUN apk add --no-cache libc6-compat build-base gcc autoconf automake zlib-dev libpng-dev vips-dev
WORKDIR /app
COPY package.json package-lock.json ./
RUN npm ci --omit=dev

# Build Stage - Constrói o painel de admin
FROM base AS build
WORKDIR /app
COPY . .
# Use as secrets de build do seu provedor de hospedagem para as APP_KEYS etc.
RUN npm run build

# Production Stage - A imagem final e enxuta
FROM base AS production
WORKDIR /app
COPY --from=build /app/dist ./dist
COPY --from=build /app/node_modules ./node_modules
# A linha abaixo pode ser necessária se seu package.json não estiver na imagem
COPY package.json .

EXPOSE 1337
CMD ["npm", "run", "start"]
