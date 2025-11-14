# Install PHP dependencies
RUN composer install --no-interaction || composer install --ignore-platform-reqs

# Debug: list vendor folder
RUN ls -la /app/vendor
