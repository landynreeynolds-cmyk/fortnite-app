# Use PHP 8 CLI image
FROM php:8.2-cli

# Set working directory
WORKDIR /app

# Copy all files into the container
COPY . /app

# Install dependencies (composer)
RUN apt-get update && apt-get install -y unzip git \
    && php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" \
    && php composer-setup.php --install-dir=/usr/local/bin --filename=composer \
    && composer install

# Expose port 10000
EXPOSE 10000

# Start PHP server
CMD ["php", "-S", "0.0.0.0:10000", "-t", "public"]
