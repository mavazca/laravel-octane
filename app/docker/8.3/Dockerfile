FROM php:8.3-fpm

# Arguments
ARG user=code
ARG uid=1000

# Install system dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
    git \
    curl \
    libpng-dev \
    libonig-dev \
    libxml2-dev \
    zip \
    unzip \
    supervisor \
    pkg-config \
    libbrotli-dev \
    libssl-dev \
    libcurl4-openssl-dev \
    libpcre3-dev \
    libz-dev \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Install PHP extensions
RUN docker-php-ext-install pdo_mysql mbstring exif pcntl bcmath gd sockets

# Install Swoole
RUN pecl install swoole && docker-php-ext-enable swoole

# Install Redis
RUN pecl install redis && docker-php-ext-enable redis

# Get latest Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Create system user to run Composer and Artisan Commands
RUN useradd -G www-data,root -u $uid -d /home/$user $user \
    && mkdir -p /home/$user/.composer \
    && chown -R $user:$user /home/$user

# Set working directory
WORKDIR /var/www

# Copy application files
COPY start-container /usr/local/bin/start-container
RUN chmod +x /usr/local/bin/start-container

COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf
COPY php.ini /usr/local/etc/php/conf.d/custom.ini

EXPOSE 8000

ENTRYPOINT ["start-container"]
