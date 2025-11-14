# Use PHP 8.2 CLI
FROM php:8.2-cli

WORKDIR /app

# Copy all repo files
COPY . /app

# Install system dependencies and required PHP extensions
RUN apt-get update && apt-get install -y git unzip curl libzip-dev libonig-dev libxml2-dev \
    && docker-php-ext-install mbstring zip xml curl

# Install Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Install PHP dependencies (creates vendor/autoload.php)
RUN composer install --no-interaction || composer install --ignore-platform-reqs

# Expose PHP server port
EXPOSE 10000

# Start PHP built-in server
CMD ["php", "-S", "0.0.0.0:10000", "-t", "."]
