SHELL := /bin/bash

.PHONY: dev server tailwind build-css prod migrate makemigrations shell collectstatic
.DEFAULT_GOAL := dev

# ---------------- dev ----------------------------------------------------- #
# Runs Tailwind watch + Django dev server in parallel
dev:
	@trap 'kill 0' INT; \
		tailwindcss -i static/css/tw-in.css -o static/css/tw.css --watch & \
		poetry run python manage.py runserver 0.0.0.0:8000

server:
	poetry run python manage.py runserver 0.0.0.0:8000

tailwind:
	tailwindcss -i static/css/tw-in.css -o static/css/tw.css --watch

# ── build ──────────────────────────────────────────────────────────
build-css:
	tailwindcss -i static/css/tw-in.css -o static/css/tw.css --minify

collectstatic:
	poetry run python manage.py collectstatic --noinput

# ── prod ───────────────────────────────────────────────────────────
prod: build-css collectstatic
	poetry run gunicorn --bind 0.0.0.0:8000 config.wsgi:unhinged_lander

# ── django management ─────────────────────────────────────────────
migrate:
	poetry run python manage.py migrate

makemigrations:
	poetry run python manage.py makemigrations

shell:
	poetry run python manage.py shell

# ── docker shortcuts ──────────────────────────────────────────────
docker-migrate:
	docker compose exec unhinged_lander make migrate

docker-makemigrations:
	docker compose exec unhinged_lander make makemigrations

docker-shell:
	docker compose exec unhinged_lander make shell

docker-db-setup:
	docker compose run --rm unhinged_lander make makemigrations
	docker compose run --rm unhinged_lander make migrate
