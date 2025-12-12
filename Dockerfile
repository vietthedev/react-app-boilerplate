FROM node:lts-alpine@sha256:7e0bd0460b26eb3854ea5b99b887a6a14d665d14cae694b78ae2936d14b2befb AS base

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

FROM nginx:alpine-slim@sha256:a5459dbb9ed17c9f1eff5448a5dfb22ea3eb386a356e26fc16871dc426ac5383 AS runner

WORKDIR /app

RUN rm -rf /usr/share/nginx/html/*

COPY --from=builder /app/dist /usr/share/nginx/html
COPY --from=builder /app/.nginx/nginx.conf /etc/nginx/conf.d/default.conf

CMD ["nginx", "-g", "daemon off;"]
