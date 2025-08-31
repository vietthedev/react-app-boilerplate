FROM node:lts-alpine@sha256:d2166de198f26e17e5a442f537754dd616ab069c47cc57b889310a717e0abbf9 AS base

FROM base AS deps

RUN apk add --no-cache libc6-compat

WORKDIR /app

COPY package.json .
COPY package-lock.json .

RUN npm pkg delete scripts.prepare
RUN npm ci

FROM base AS builder

WORKDIR /app

COPY --from=deps /app/node_modules ./node_modules
COPY . .

RUN npm run build

FROM nginx:alpine-slim@sha256:94f1c83ea210e0568f87884517b4fe9a39c74b7677e0ad3de72700cfa3da7268 AS runner

WORKDIR /app

RUN rm -rf /usr/share/nginx/html/*

COPY --from=builder /app/dist /usr/share/nginx/html
COPY --from=builder /app/.nginx/nginx.conf /etc/nginx/conf.d/default.conf

CMD ["nginx", "-g", "daemon off;"]
