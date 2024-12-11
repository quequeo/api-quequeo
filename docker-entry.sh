#!/bin/sh

RAILS_ROOT="/var/www/api-quequeo/current"

# Wait for Postgres to be ready
# until PGPASSWORD="${POSTGRES_PASSWORD}" pg_isready -h "${POSTGRES_HOST}" -p "${POSTGRES_PORT}" -U "${POSTGRES_USER}"; do
#   echo "Waiting for Postgres..."
#   sleep 2
# done

# Check if the database exists
if ! bundle exec rails db:exists RAILS_ENV=production; then
  echo "Database does not exist, creating..."
  bundle exec rails db:create
else
  echo "Database already exists, skipping creation."
fi

bundle exec rails db:migrate

exec "$@"