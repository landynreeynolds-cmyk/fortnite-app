# Use PHP 8.2 CLI image
FROM php:8.2-cli

WORKDIR /app
COPY . /app

# Install system dependencies for composer if needed
RUN apt-get update && apt-get install -y git unzip curl

# Expose port 10000
EXPOSE 10000

# Start PHP built-in server
CMD ["php", "-S", "0.0.0.0:10000", "-t", "."]
