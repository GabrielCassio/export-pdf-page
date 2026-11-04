# Export Cards

O objetivo desse projeto é exportar cards de RPG no formato PDF totalmente estilizado. Isto é, seguindo todas as normas de segurança necessárias,

## Frontend

O frontend em [`apps/frontend`](./apps/frontend) usa Next.js, React, Tailwind CSS e componentes
shadcn/ui. O ambiente de testes combina Vitest para testes de unidade e Playwright para testes
end-to-end.

```bash
cd apps/frontend
pnpm install
pnpm dev
```

Comandos úteis: `pnpm lint`, `pnpm typecheck`, `pnpm test`, `pnpm test:e2e`,
`pnpm format:check` e `pnpm build`.

## Example API

O serviço em [`apps/example`](./apps/example) é uma API NestJS com Fastify e Drizzle ORM para
PostgreSQL. Configure `DATABASE_URL` a partir de
[`apps/example/.env.example`](./apps/example/.env.example) e execute:

```bash
cd apps/backend
pnpm install
pnpm dev
```

Os endpoints iniciais são `GET /health`, `GET /users` e `POST /users`. Pelo Nginx, eles ficam
disponíveis com o prefixo `/api` (por exemplo, `GET http://localhost:8080/api/health`).
