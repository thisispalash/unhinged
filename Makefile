start:
	poetry run python manage.py runserver 0.0.0.0:8000

migrate:
	poetry run python manage.py migrate

makemigrations:
	poetry run python manage.py makemigrations

shell:
	poetry run python manage.py shell

gunicorn:
	poetry run gunicorn --bind 0.0.0.0:8000 config.wsgi:unhinged_lander

docker-migrate:
	docker compose exec unhinged_lander make migrate

docker-makemigrations:
	docker compose exec unhinged_lander make makemigrations

docker-shell:
	docker compose exec unhinged_lander make shell


docker-db-setup:
	docker compose run --rm unhinged_lander make makemigrations
	docker compose run --rm unhinged_lander make migrate
