FROM ruby:3.2.4-slim-bullseye AS builder

RUN apt-get update -qq && \
    apt-get install -y --no-install-recommends \
        build-essential \
        libpq-dev \
        nodejs && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /usr/share/doc /usr/share/man

COPY Gemfile Gemfile.lock ./
RUN gem install bundler:2.4.13

WORKDIR /tmp
ARG BUNDLE_WITHOUT="development test"
RUN bundle config set --global without "${BUNDLE_WITHOUT}"
RUN MAKE="make --jobs 8" bundle install --jobs=8
RUN bundle clean --force

FROM ruby:3.2.4-slim-bullseye

RUN apt-get update -qq && \
    apt-get install -y make --no-install-recommends \
        libpq-dev \
        nodejs \
        postgresql-client

COPY --from=builder /usr/local/bundle /usr/local/bundle

RUN mkdir -p /var/www/wellio-fit/current \
             /var/www/wellio-fit/current/vendor \
             /var/www/wellio-fit/current/tmp \
             tmp/pids

ENV RAILS_ROOT /var/www/wellio-fit/current

COPY . /var/www/wellio-fit/current/

COPY docker-entry.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/docker-entry.sh

WORKDIR "/var/www/wellio-fit/current"

EXPOSE 3000

ENTRYPOINT ["/usr/local/bin/docker-entry.sh"]

CMD ["./bin/rails", "server", "-b", "0.0.0.0"]
