#!/bin/bash -e

# Wait for Postgres to be ready
until PGPASSWORD="${POSTGRES_PASSWORD}" pg_isready -h "${POSTGRES_HOST}" -p "${POSTGRES_PORT}" -U "${POSTGRES_USER}"; do
  echo "Waiting for Postgres..."
  sleep 2
done

# Verify if the databases exist
echo "Checking DEVELOPMENT database '${POSTGRES_DEV_DB}'..."
DB_DEV=$(PGPASSWORD="${POSTGRES_PASSWORD}" psql -U "${POSTGRES_USER}" -h "${POSTGRES_HOST}" -tc "SELECT 1 FROM pg_database WHERE datname = '${POSTGRES_DEV_DB}'" | tr -d '[:space:]')

# Create the development database if it doesn't exist
if [ "$DB_DEV" != "1" ]; then
  echo "Creating DEVELOPMENT database..."
  RAILS_ENV=development bundle exec rails db:create
  RAILS_ENV=development bundle exec rails db:migrate
else
  echo "The DEVELOPMENT database already exists, skipping creation."
fi

echo "Checking TEST database '${POSTGRES_TEST_DB}'..."
DB_TEST=$(PGPASSWORD="${POSTGRES_PASSWORD}" psql -U "${POSTGRES_USER}" -h "${POSTGRES_HOST}" -tc "SELECT 1 FROM pg_database WHERE datname = '${POSTGRES_TEST_DB}'" | tr -d '[:space:]')

# Create the test database if it doesn't exist
if [ "$DB_TEST" != "1" ]; then
  echo "Creating TEST database..."
  RAILS_ENV=test bundle exec rails db:create
else
  echo "The TEST database already exists, skipping creation."
fi

# Execute the main container command
exec "$@"