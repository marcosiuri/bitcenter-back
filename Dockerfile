FROM php:8.3-apache

# Install system dependencies
RUN apt-get update && apt-get install -y \
    libpng-dev \
    libonig-dev \
    libxml2-dev \
    libzip-dev \
    zip \
    curl \
    unzip \
    git \
    libpq-dev \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# Install PHP extensions
RUN docker-php-ext-install pdo pdo_mysql pdo_pgsql mbstring exif pcntl bcmath gd zip

# Enable Apache mod_rewrite
RUN a2enmod rewrite
RUN a2enmod headers

# Install Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Set working directory
WORKDIR /var/www/html

# Copy existing application directory contents
COPY . .

# Install composer dependencies
RUN composer install --no-interaction

# Set permissions for storage
RUN chmod -R a+wr ./storage
RUN chmod -R a+wr ./bootstrap/cache
RUN chown root:root -R ./storage ./bootstrap/cache


# Copy vhost file into container
COPY ./.docker/vhost.conf /etc/apache2/sites-available/000-default.conf


CMD ["apache2-foreground"]
