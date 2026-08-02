# syntax=docker/dockerfile:1.11
FROM python:3.12-slim AS builder

# Install uv from the official image (pinning the minor version is recommended)
COPY --from=ghcr.io/astral-sh/uv:0.12 /uv /uvx /bin/

ENV UV_COMPILE_BYTECODE=1 \
    UV_LINK_MODE=copy \
    UV_NO_DEV=1

WORKDIR /mlflow

# Install dependencies in a separate layer so that source-code changes do not
# invalidate the dependency cache.
RUN --mount=type=cache,target=/root/.cache/uv \
    --mount=type=bind,source=uv.lock,target=uv.lock \
    --mount=type=bind,source=pyproject.toml,target=pyproject.toml \
    uv sync --locked --no-install-project --no-editable

# Copy the rest of the project files and verify the lockfile.
COPY . /mlflow
RUN --mount=type=cache,target=/root/.cache/uv \
    uv sync --locked --no-install-project --no-editable


FROM python:3.12-slim

WORKDIR /mlflow

ENV PYTHONPATH=/app \
    PATH="/mlflow/.venv/bin:$PATH" \
    LC_ALL=C.UTF-8 \
    LANG=C.UTF-8
RUN echo "export LC_ALL=$LC_ALL" >> /etc/profile.d/locale.sh && \
    echo "export LANG=$LANG" >> /etc/profile.d/locale.sh

COPY --from=builder /mlflow/.venv /mlflow/.venv
RUN mkdir -p ./mlruns

COPY ./run_server.sh ./
