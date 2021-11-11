FROM composer:2 AS composer
FROM php:7.4-fpm-alpine

COPY --from=composer /usr/bin/composer /usr/bin/composer

RUN set -xe \
    && apk add --no-cache \
    $PHPIZE_DEPS \
    ffmpeg \
    libavif-dev \
    libwebp-dev \
    libzip-dev \
    libwebp-tools \
    freetype-dev \
    libpng-dev \
    postgresql-dev \
    libjpeg-turbo-dev \
    gmp-dev \
    && docker-php-ext-configure gd \
    --with-freetype \
    --with-jpeg \
    --with-webp \
    && docker-php-ext-configure zip \
    && docker-php-ext-configure zip \
    && docker-php-ext-configure gmp \
    && docker-php-ext-configure pdo_mysql \
    && docker-php-ext-install -j$(nproc) gd \
    && docker-php-ext-install -j$(nproc) zip \
    && docker-php-ext-install -j$(nproc) exif \
    && docker-php-ext-install -j$(nproc) pdo_mysql \
    && docker-php-ext-install -j$(nproc) pdo_pgsql \
    && docker-php-ext-install -j$(nproc) gmp \
    && pear install pear/PHP_CodeSniffer \
    && pecl install pcov

RUN apk add --no-cache supervisor tzdata
ENV TZ Europe/Moscow

COPY ./configs/www.conf /usr/local/etc/php-fpm.d/www.conf
COPY ./configs/php.ini /usr/local/etc/php/php.ini
COPY ./configs/supervisord.conf /etc/supervisor/conf.d/supervisord.conf

CMD /usr/bin/supervisord -c /etc/supervisor/conf.d/supervisord.conf
