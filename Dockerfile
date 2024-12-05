# Etapa de construcción (builder)
FROM ruby:3.2.4-alpine AS builder

RUN apk update && apk add --no-cache tzdata git \
    build-base \
    libpq-dev \
    make \
    nodejs \
    postgresql-client \
    libc6-compat

WORKDIR /tmp
COPY Gemfile Gemfile.lock ./
RUN gem install bundler:2.4.13
RUN bundle config set frozen false
RUN bundle install --jobs=8 --without development test

# Etapa de ejecución
FROM ruby:3.2.4-alpine

RUN apk update && apk add --no-cache tzdata git\
    libpq-dev \
    nodejs \
    postgresql-client \
    make \
    libc6-compat

COPY docker-entry.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/docker-entry.sh

COPY --from=builder /usr/local/bundle /usr/local/bundle
COPY . /var/www/api-quequeo/current/

WORKDIR /var/www/api-quequeo/current

EXPOSE 3000

ENTRYPOINT ["/usr/local/bin/docker-entry.sh"]

CMD ["./bin/rails", "server", "-b", "0.0.0.0"]
