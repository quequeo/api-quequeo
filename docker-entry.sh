#!/bin/sh

RAILS_ROOT="/var/www/wellio-fit/current"

# Wait for Postgres to be ready
# until PGPASSWORD="${POSTGRES_PASSWORD}" pg_isready -h "${POSTGRES_HOST}" -p "${POSTGRES_PORT}" -U "${POSTGRES_USER}"; do
#   echo "Waiting for Postgres..."
#   sleep 2
# done

# bundle exec rails db:create
# bundle exec rails db:migrate

exec "$@"