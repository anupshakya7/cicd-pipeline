#!/bin/bash
set -e

echo "Deployment Started..."

# Turn On Maintenance Mode or return true
# if already is in maintenance mode
(php artisan down) || true

# Pull the latest version of the app
git pull origin master

# Install composer dependencies
composer install --ignore-platform-req=ext-intl --optimize-autoloader --no-dev --no-interaction

# Clearing Cache
php artisan cache:clear
php artisan config:clear

# Recreate cache
php artisan optimize

# Run database migrations
php artisan migrate --force

# Turn Off Maintenance Mode
php artisan up

echo "Deployment Finished!!!"