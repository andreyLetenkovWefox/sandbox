FROM python:3.9-slim-buster

ENV PYTHONFAULTHANDLER=1 \
    PYTHONUNBUFFERED=1 \
    PYTHONHASHSEED=random \
    PIP_NO_CACHE_DIR=off \
    PIP_DISABLE_PIP_VERSION_CHECK=on \
    PIP_DEFAULT_TIMEOUT=100 \
    POETRY_VERSION=1.1.8 \
    POETRY_HOME="/opt/poetry" \
    PYTHONWARNINGS=ignore \
    WORKSPACE_DIR="/test-workspace"

RUN pip install "poetry==$POETRY_VERSION"

WORKDIR $WORKSPACE_DIR
COPY $TESTS_DIR/poetry.lock $TESTS_DIR/pyproject.toml /

RUN poetry config virtualenvs.create false && \
    poetry install --no-dev --no-interaction --no-ansi

COPY $TESTS_DIR/. .

ENTRYPOINT ["/bin/bash", "-c"]
