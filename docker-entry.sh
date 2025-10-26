#!/bin/sh

# Cargar variables de entorno desde .env si existe
if [ -f .env ]; then
  export $(grep -v '^#' .env | xargs)
fi

RAILS_ROOT="/var/www/api-quequeo/current"

# En Railway, DATABASE_URL está disponible automáticamente
# En desarrollo local, usamos las variables de entorno tradicionales
if [ -z "$DATABASE_URL" ]; then
  # Modo desarrollo local - esperar a que Postgres esté listo
  until pg_isready -h "${POSTGRES_HOST:-db}" -p "${POSTGRES_PORT:-5432}" -U "${POSTGRES_USER:-postgres}"; do
    echo "Waiting for Postgres to be ready..."
    sleep 2
  done
else
  # Modo Railway/producción - esperar un poco para que la DB esté lista
  echo "Using DATABASE_URL, waiting for database to be ready..."
  sleep 5
fi

# Crear y migrar base de datos si es necesario
bundle exec rails db:prepare

exec "$@"