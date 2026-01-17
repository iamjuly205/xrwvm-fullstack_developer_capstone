#!/bin/sh

set -e

# Build React frontend
echo "Building React frontend..."
cd frontend

echo "Installing dependencies..."
npm install --legacy-peer-deps 2>&1 || { echo "npm install failed"; exit 1; }

echo "Building React app..."
npm run build 2>&1 || { echo "npm run build failed"; exit 1; }

if [ ! -f "build/index.html" ]; then
    echo "ERROR: React build did not create build/index.html"
    ls -la build/
    exit 1
fi

echo "React build completed successfully"
cd ..

# Make migrations and migrate the database.
echo "Making migrations and migrating the database. "
python manage.py makemigrations --noinput
python manage.py migrate --noinput
python manage.py collectstatic --noinput

echo "Setup completed successfully"
exec "$@"