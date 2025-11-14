# Use PHP 8.2 with Apache (includes required tools)
FROM php:8.2-apache

# Enable mod_rewrite (needed for routing)
RUN a2enmod rewrite

# Set working directory
WORKDIR /var/www/html

# Copy all files
COPY . /var/www/html

# Install system dependencies for composer
RUN apt-get update && apt-get install -y git unzip curl && rm -rf /var/lib/apt/lists/*

# Install Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Install PHP dependencies
RUN composer install --no-interaction

# Expose default Apache port
EXPOSE 80

# Start Apache in foreground
CMD ["apache2-foreground"]
