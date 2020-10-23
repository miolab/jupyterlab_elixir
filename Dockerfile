FROM python:3.8.6-slim

COPY pyproject.toml ./

ENV PYTHONUNBUFFERED=1

ENV ERLANG_PACKAGER_VERSION 2.0
# ENV ELIXIR_VERSION 1.11.1

RUN apt-get update -y \
  && apt-get upgrade -y \
  && apt-get install -y \
  build-essential \
  curl \
  git \
  # gzip \
  inotify-tools \
  sudo \
  # tar \
  vim \
  wget


# Install: pip & poetry
RUN pip install --upgrade pip
RUN pip install poetry
RUN poetry config virtualenvs.create false \
  && poetry install


# Install: Erlang
RUN wget https://packages.erlang-solutions.com/erlang-solutions_${ERLANG_PACKAGER_VERSION}_all.deb
RUN dpkg -i erlang-solutions_${ERLANG_PACKAGER_VERSION}_all.deb
RUN apt-get update \
  && apt install -y esl-erlang
RUN rm erlang-solutions_${ERLANG_PACKAGER_VERSION}_all.deb
RUN which erl


# Install: Elixir
RUN apt-get update && apt-get install elixir
# RUN wget https://github.com/elixir-lang/elixir/archive/v${ELIXIR_VERSION}.tar.gz
# RUN tar xzf v${ELIXIR_VERSION}.tar.gz
# RUN rm v${ELIXIR_VERSION}.tar.gz
# RUN ls /elixir-*/
# ENV PATH $PATH:/elixir-${ELIXIR_VERSION}/bin
# RUN echo $PATH
RUN which elixir

RUN mix local.hex --force
RUN mix local.rebar --force


# Install: IElixir
# RUN git clone https://github.com/pprzetacznik/IElixir.git
# RUN cd IElixir


RUN apt-get clean

CMD ["iex"]
