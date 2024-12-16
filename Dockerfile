# Use the official PHP 8.1 image with FPM
FROM php:8.1-fpm

# Install system dependencies and PHP extensions
RUN apt-get update && apt-get install -y \
    git \
    curl \
    libpng-dev \
    libjpeg62-turbo-dev \
    libfreetype6-dev \
    libonig-dev \
    libxml2-dev \
    zip \
    unzip \
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install pdo_mysql mbstring exif pcntl bcmath gd \
    && apt-get clean

# Install Composer globally
RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" \
    && php composer-setup.php --version=2.5.8 --install-dir=/usr/local/bin --filename=composer \
    && php -r "unlink('composer-setup.php');"

# Set working directory
WORKDIR /var/www/html

# Copy application source code
COPY . .

# Ensure the environment file exists
RUN cp .env.example .env || true

# Set permissions for Laravel directories
RUN chmod -R 775 /var/www/html/storage /var/www/html/bootstrap/cache \
    && chown -R www-data:www-data /var/www/html

# Set Composer memory limit
ENV COMPOSER_MEMORY_LIMIT=-1

# Pre-create storage and cache directories if they don't exist
RUN mkdir -p /var/www/html/storage/framework/{sessions,views,cache} /var/www/html/bootstrap/cache

# Install Laravel dependencies
RUN composer install --no-scripts --no-interaction --prefer-dist --optimize-autoloader || composer install --no-scripts

# Run Laravel scripts after dependencies are installed
RUN php artisan key:generate || true

# Expose PHP-FPM default port
EXPOSE 8081
EXPOSE 80
EXPOSE 8000

# Start PHP-FPM
CMD ["php-fpm"]
