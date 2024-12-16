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
    && docker-php-ext-install pdo_mysql mbstring exif pcntl bcmath gd

# Install Composer
RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" \
    && php composer-setup.php --version=2.5.8 --install-dir=/usr/local/bin --filename=composer \
    && php -r "unlink('composer-setup.php');"

# Set working directory
WORKDIR /var/www/html

# Copy project files
COPY . .

# Set permissions
RUN chmod -R 775 /var/www/html/storage /var/www/html/bootstrap/cache \
    && chown -R www-data:www-data /var/www/html

# Install Laravel dependencies
ENV COMPOSER_MEMORY_LIMIT=-1
RUN composer install --no-interaction --prefer-dist --optimize-autoloader --ignore-platform-req=ext-zip

# Generate application key
RUN php artisan key:generate

# Expose port 9000
EXPOSE 9000

# Start PHP-FPM
CMD ["php-fpm"]
