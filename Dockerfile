FROM python:3.13-slim

WORKDIR /unhinged_lander

# Install Poetry
RUN apt-get update && apt-get install -y curl && \
  curl -sSL https://install.python-poetry.org | python3 - && \
  apt-get clean && rm -rf /var/lib/apt/lists/*

# Poetry path
ENV PATH="/root/.local/bin:$PATH"  

# Copy dependency mgmt for caching optimization
COPY pyproject.toml poetry.lock /unhinged_lander/
RUN poetry update
# note: `update` does `poetry lock` and `poetry install`

# Copy the rest of the project
COPY . /unhinged_lander

CMD ["poetry", "run", "gunicorn", "--bind", "0.0.0.0:8000", "config.wsgi:unhinged_lander"]