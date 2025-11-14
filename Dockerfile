# Use a imagem oficial do Node.js v20
FROM node:20-alpine AS base
# Instale as dependências de sistema
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

# ----> ADICIONE ESTA LINHA PARA COPIAR O SCRIPT <----
COPY start.sh ./

EXPOSE 1337
# ----> MUDE O CMD PARA USAR O SCRIPT <----
CMD ["./start.sh"]
