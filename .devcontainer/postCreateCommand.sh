#!/bin/bash

# Change ownership of /var/www/html to user and group with ID 1000
chown -R 1000:1000 /var/www/html

# Copy .env.example to .env
cp .env.example .env

# Install composer dependencies
composer install

# Generate the application key
php artisan key:generate

# Create a symbolic link to the storage
php artisan storage:link --force

# Check if DB_CONNECTION is set to sqlite and create the database.sqlite file if true
if [ "$DB_CONNECTION" == "sqlite" ]; then
  touch ./database/database.sqlite
fi

# Run database migrations and seed the database
php artisan migrate --force --seed

# Install npm dependencies
npm install