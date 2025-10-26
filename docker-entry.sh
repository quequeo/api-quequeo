#!/bin/sh

# Cargar variables de entorno desde .env si existe
if [ -f .env ]; then
  export $(grep -v '^#' .env | xargs)
fi

RAILS_ROOT="/var/www/api-quequeo/current"

# Esperar a que Postgres esté listo
until pg_isready -h "${POSTGRES_HOST:-db}" -p "${POSTGRES_PORT:-5432}" -U "${POSTGRES_USER:-postgres}"; do
  echo "Waiting for Postgres to be ready..."
  sleep 2
done

# Crear y migrar base de datos si es necesario
bundle exec rails db:prepare

exec "$@"