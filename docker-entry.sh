#!/bin/sh

RAILS_ROOT="/var/www/api-quequeo/current"

# Wait for Postgres to be ready
# until PGPASSWORD="${POSTGRES_PASSWORD}" pg_isready -h "${POSTGRES_HOST}" -p "${POSTGRES_PORT}" -U "${POSTGRES_USER}"; do
#   echo "Waiting for Postgres..."
#   sleep 2
# done

# Check if the database exists
# DB_EXISTS=$(PGPASSWORD=$POSTGRES_PASSWORD psql -h $POSTGRES_HOST -U $POSTGRES_USER -tc "SELECT 1 FROM pg_database WHERE datname = '$POSTGRES_DB';" | xargs)
# if [ "$DB_EXISTS" != "1" ]; then
#   echo "Database does not exist. Creating..."
#   bundle exec rails db:create
#   bundle exec rails db:migrate
# else
#   echo "Database already exists."
# fi

exec "$@"