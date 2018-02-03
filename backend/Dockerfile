FROM ruby:2.5

RUN curl -sL https://deb.nodesource.com/setup_7.x | bash -

RUN apt-get update && \
  apt-get install -y \
  build-essential \
  libpq-dev \
  nodejs \
  vim


RUN mkdir -p /app
WORKDIR /app

RUN npm i -g yarn phantomjs

RUN gem install bundler
COPY Gemfile  ./
RUN bundle install --jobs 20 --retry 5