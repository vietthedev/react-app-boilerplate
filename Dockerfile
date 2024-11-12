FROM node:lts-alpine@sha256:f8c7230e119ab657a4adda992f7dad2b2b068029c7710f53d930673a8eb2a1e8 AS base

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

FROM nginx:alpine-slim@sha256:9ebd266ba0ddab1bf6c0f7580bb53f373bf5ac137ec02430169d20c4c139c70b AS runner

WORKDIR /app

RUN rm -rf /usr/share/nginx/html/*

COPY --from=builder /app/dist /usr/share/nginx/html
COPY --from=builder /app/.nginx/nginx.conf /etc/nginx/conf.d/default.conf

CMD ["nginx", "-g", "daemon off;"]
