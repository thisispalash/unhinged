start:
	poetry run python manage.py runserver

migrate:
	poetry run python manage.py migrate

makemigrations:
	poetry run python manage.py makemigrations

shell:
	poetry run python manage.py shell

gunicorn:
	poetry run gunicorn --bind 0.0.0.0:8000 config.wsgi:unhinged_lander