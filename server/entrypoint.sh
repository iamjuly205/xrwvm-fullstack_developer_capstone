#!/bin/sh

# Build React frontend
echo "Building React frontend..."
cd frontend
npm install
npm run build
cd ..

# Make migrations and migrate the database.
echo "Making migrations and migrating the database. "
python manage.py makemigrations --noinput
python manage.py migrate --noinput
python manage.py collectstatic --noinput
exec "$@"