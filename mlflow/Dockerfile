FROM python:3.10

RUN mkdir -p /mlflow/mlruns

WORKDIR /mlflow

ENV LC_ALL=C.UTF-8
ENV LANG=C.UTF-8

RUN echo "export LC_ALL=$LC_ALL" >> /etc/profile.d/locale.sh
RUN echo "export LANG=$LANG" >> /etc/profile.d/locale.sh

RUN apt-get update && apt-get install -y \
    default-libmysqlclient-dev
RUN apt clean &&  rm -rf /var/cache/apt/archives/* /var/lib/apt/lists/*

RUN pip install -U pip && \
    pip install poetry

COPY ./pyproject.toml ./pyproject.toml
COPY ./poetry.lock ./poetry.lock

RUN poetry install

COPY ./run.sh ./run.sh

CMD ["bash", "./run.sh"]
