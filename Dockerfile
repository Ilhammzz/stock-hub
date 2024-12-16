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

# Install a specific version of Composer compatible with PHP 8.1
RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" \
    && php composer-setup.php --version=2.5.8 --install-dir=/usr/local/bin --filename=composer \
    && php -r "unlink('composer-setup.php');"

# Set working directory
WORKDIR /var/www/html

# Copy project files
COPY . .

# Ensure correct permissions
RUN chmod -R 775 /var/www/html \
    && chown -R www-data:www-data /var/www/html

# Copy and configure environment file
COPY .env.example .env

# Install Laravel dependencies
ENV COMPOSER_MEMORY_LIMIT=-1
RUN composer install --no-interaction --prefer-dist --optimize-autoloader

# Generate application key
RUN php artisan key:generate

# Expose port 80
EXPOSE 80

# Start PHP-FPM
CMD ["php-fpm"]
