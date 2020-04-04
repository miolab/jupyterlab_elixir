FROM elixir:1.9-slim
# FROM python:3.8-slim

ENV PYTHON_VERSION 3.8
ENV PYTHONUNBUFFERED=1

WORKDIR /app

COPY pyproject.toml ./

RUN apt-get update -y && \
  # apt-get upgrade -y && \
  apt-get install -y \
  sudo \
  git
# python3 \
# python3-pip \
# libzmq3-dev

RUN sudo apt-get install -y python3

RUN apt-get install -y python3-pip
RUN apt-get install -y libzmq3-dev
RUN apt-get install -y libsqlite3-dev

RUN sudo pip3 install poetry

RUN mix local.hex --force
RUN mix local.rebar --force

RUN poetry config virtualenvs.create false \
  && poetry install

RUN sudo git clone https://github.com/pprzetacznik/IElixir.git

RUN cd IElixir && \
  mix deps.get && \
  mix test && \
  MIX_ENV=prod mix compile

RUN ./install_script.sh
