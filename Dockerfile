FROM node:lts-alpine@sha256:bf77dc26e48ea95fca9d1aceb5acfa69d2e546b765ec2abfb502975f1a2d4def AS base

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

FROM nginx:alpine-slim@sha256:cbbb87ca9417ed5cac0fe5dbbc489b18296721afd20c0b88000e3bea1cae3b4b AS runner

WORKDIR /app

RUN rm -rf /usr/share/nginx/html/*

COPY --from=builder /app/dist /usr/share/nginx/html
COPY --from=builder /app/.nginx/nginx.conf /etc/nginx/conf.d/default.conf

CMD ["nginx", "-g", "daemon off;"]
