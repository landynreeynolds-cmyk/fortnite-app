# Use PHP 8.2 CLI image
FROM php:8.2-cli

WORKDIR /app

# Copy repo files
COPY . /app

# Install system packages and PHP extensions required for php-proxy-app
RUN apt-get update && apt-get install -y git unzip curl libzip-dev libonig-dev libxml2-dev \
    && docker-php-ext-install mbstring zip xml curl

# Install Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Install PHP dependencies (creates vendor folder)
RUN composer install --no-interaction || composer install --ignore-platform-reqs

# Expose PHP server port
EXPOSE 10000

# Start PHP built-in server
CMD ["php", "-S", "0.0.0.0:10000", "-t", "."]
