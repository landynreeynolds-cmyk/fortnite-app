# Use PHP 8.2 with Apache
FROM php:8.2-apache

# Enable Apache rewrite module
RUN a2enmod rewrite

# Set working directory
WORKDIR /var/www/html

# Copy app files
COPY . /var/www/html

# Install system dependencies needed for PHP extensions
RUN apt-get update && apt-get install -y \
    git \
    unzip \
    curl \
    libzip-dev \
    libxml2-dev \
    zlib1g-dev \
    libonig-dev \
    pkg-config \
    && docker-php-ext-install mbstring zip xml \
    && rm -rf /var/lib/apt/lists/*

# Install Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Install PHP dependencies
RUN composer install --no-interaction || composer install --ignore-platform-reqs

# Expose Apache port
EXPOSE 80

# Start Apache in foreground
CMD ["apache2-foreground"]
