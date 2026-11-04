# syntax=docker/dockerfile:1
# ============================================================
# Dockerfile multi-stage para apps
# Stack utilizada: Pnpm + NestJs + Vitest
#
# Uso:
#   docker build --target dev        -t app:dev        .
#   docker build --target typecheck  -t app:typecheck  .
#   docker build --target test       -t app:test       .
#   docker build --target prod       -t app:prod       .
# ============================================================

# ---------- Base ----------
FROM node:22-bookworm-slim AS base
ENV PNPM_HOME="/pnpm"
ENV PATH="$PNPM_HOME:$PATH"
RUN corepack enable
WORKDIR /app
COPY package.json pnpm-lock.json ./

# ---------- Dependencies (todas, incluindo dev) ----------
FROM base AS deps
RUN pnpm install --frozen-lockfile

# ---------- Development ----------
FROM deps AS dev
COPY . .
EXPOSE 4000
CMD ["pnpm", "dev"]  

# ----------- Typecheck -----------
FROM deps AS typecheck
COPY . .
CMD ["pnpm", "typecheck"]

# ---------- Test ----------
FROM deps AS test
COPY . .
CMD ["pnpm", "test"]

# ---------- Build ----------
FROM deps AS build
COPY . .
RUN pnpm build

# ---------- Production ----------
FROM node:22-bookworm-slim AS prod
WORKDIR /app
ENV NODE_ENV=production PORT=4000
 
COPY --from=deps /app/node_modules ./node_modules
COPY --from=build --chown=app:app /app/dist ./dist
COPY --chown=app:app package.json pnpm-lock.yaml ./
 
USER app
EXPOSE 4000
CMD ["pnpm", "start"]