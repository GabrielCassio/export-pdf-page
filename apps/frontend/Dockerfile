# syntax=docker/dockerfile:1
# ============================================================
# Dockerfile multi-stage para Frontend e React/NextJS
# Stack utilizada: Pnpm + React + Vitest
#
# Uso:
#   docker build --target dev   -t app:dev   .
#   docker build --target test  -t app:test  .
#   docker build --target e2e   -t app:e2e   .
#   docker build --target prod  -t app:prod  .
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
EXPOSE 3000
CMD ["pnpm", "dev"]

# ---------- Test ----------
FROM deps AS test
COPY . .
CMD ["pnpm", "test"]

# ---------- E2E (Playwright) ----------
FROM deps AS e2e
COPY . .
RUN pnpm playwright install --with-deps chromium
EXPOSE 3000
CMD ["pnpm", "test:e2e"]

# ---------- Build ----------
FROM deps AS build
COPY . .
RUN pnpm build

# ---------- Production ----------
FROM node:22-bookworm-slim AS prod
WORKDIR /app
ENV NODE_ENV=production PORT=3000 HOSTNAME=0.0.0.0 NEXT_TELEMETRY_DISABLED=1
COPY --from=build --chown=app:app /app/public ./public
COPY --from=build --chown=app:app /app/.next/standalone ./
COPY --from=build --chown=app:app /app/.next/static ./.next/static
USER app
EXPOSE 3000
CMD ["pnpm", "exec", "next", "start", "--hostname", "0.0.0.0", "--port", "3000"]