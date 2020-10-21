FROM python:3.8.6-slim
ENV PYTHONUNBUFFERED=1

COPY pyproject.toml ./

RUN apt-get update -y \
  && apt-get upgrade -y \
  && apt-get install -y \
  build-essential \
  curl \
  git \
  inotify-tools \
  sudo \
  unzip \
  vim \
  wget

# Install: pip & poetry
RUN pip install --upgrade pip
RUN pip install poetry
RUN poetry config virtualenvs.create false \
  && poetry install

# Install: Erlang
RUN wget https://packages.erlang-solutions.com/erlang-solutions_2.0_all.deb
RUN dpkg -i erlang-solutions_2.0_all.deb
RUN apt-get update && apt install -y esl-erlang
RUN rm erlang-solutions_2.0_all.deb

RUN apt-get clean
