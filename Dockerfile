# Use PHP 8.2 CLI image
FROM php:8.2-cli

# Set working directory
WORKDIR /app

# Copy all files
COPY . /app

# Install system dependencies and PHP extensions
RUN apt-get update && apt-get install -y git unzip curl libzip-dev libonig-dev libxml2-dev \
    && docker-php-ext-install mbstring zip xml curl

# Install Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Install PHP dependencies
RUN composer install --no-interaction || composer install --ignore-platform-reqs

# Expose port 10000
EXPOSE 10000

# Start PHP built-in server
CMD ["php", "-S", "0.0.0.0:10000", "-t", "."]
