.PHONY: up down reset lock-back lock-front

up:
	docker compose up -d --build

down:
	docker compose down

reset:
	docker compose down -v
	docker compose up -d --build

lock-back:
	cd apps/backend && docker run --rm -v $$PWD:/app -w /app nicklpeterson/pnpm-node:24-11-alpine pnpm install --lockfile-only

lock-front:
	cd apps/frontend && docker run --rm -v $PWD:/app -w /app nicklpeterson/pnpm-node:24-11-alpine pnpm install --lockfile-only
