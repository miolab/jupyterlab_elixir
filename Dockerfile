FROM python:3.8.6-slim

COPY pyproject.toml ./

ENV PYTHONUNBUFFERED=1 \
  ERLANG_PACKAGER_VERSION=2.0

RUN apt-get update -y \
  && apt-get upgrade -y \
  && apt-get install -y \
  build-essential \
  curl \
  git \
  inotify-tools \
  libsqlite3-dev \
  libzmq3-dev \
  sudo \
  vim \
  wget

# Install: pip & poetry
RUN pip install --upgrade pip
RUN pip install poetry
RUN poetry config virtualenvs.create false && \
  poetry install

# Install: Erlang
RUN wget https://packages.erlang-solutions.com/erlang-solutions_${ERLANG_PACKAGER_VERSION}_all.deb
RUN dpkg -i erlang-solutions_${ERLANG_PACKAGER_VERSION}_all.deb
RUN apt-get update && apt-get install -y esl-erlang
RUN rm erlang-solutions_${ERLANG_PACKAGER_VERSION}_all.deb
RUN which erl

# Install: Elixir
RUN apt-get update && apt-get install elixir
RUN which elixir
RUN mix --version && which mix

RUN mix local.hex --force
RUN mix local.rebar --force

RUN apt-get clean

# Install: IElixir
RUN git clone https://github.com/pprzetacznik/IElixir.git
WORKDIR IElixir
RUN pwd && ls
RUN mix deps.get
RUN mix test
RUN MIX_ENV=prod mix compile
RUN ./install_script.sh

CMD ["iex"]
