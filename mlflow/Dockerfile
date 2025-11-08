FROM python:3.12-slim as builder

WORKDIR /mlflow

RUN apt-get update && apt-get install -y \
    default-libmysqlclient-dev \
    build-essential \
    pkg-config
RUN apt clean &&  rm -rf /var/cache/apt/archives/* /var/lib/apt/lists/*
RUN pip install -U pip && \
    pip install poetry

ENV POETRY_NO_INTERACTION=1 \
    POETRY_VIRTUALENVS_IN_PROJECT=1 \
    POETRY_VIRTUALENVS_CREATE=1 \
    POETRY_CACHE_DIR=/tmp/poetry_cache

COPY ./pyproject.toml ./poetry.lock ./
RUN poetry install --no-root --without dev && rm -rf /tmp/poetry_cache


FROM python:3.12-slim

WORKDIR /mlflow

RUN apt-get update && apt-get install -y \
    default-libmysqlclient-dev

ENV PYTHONPATH=/app \
    PATH="/mlflow/.venv/bin:$PATH" \
    LC_ALL=C.UTF-8 \
    LANG=C.UTF-8
RUN echo "export LC_ALL=$LC_ALL" >> /etc/profile.d/locale.sh
RUN echo "export LANG=$LANG" >> /etc/profile.d/locale.sh

COPY --from=builder /mlflow/.venv /mlflow/.venv
RUN mkdir -p ./mlruns

COPY ./run_server.sh ./run_deployment.sh ./deployment.yaml ./
