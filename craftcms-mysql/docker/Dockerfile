FROM php:7.4-apache
RUN a2enmod rewrite headers
RUN apt-get update && apt-get install -y \
        xvfb \
        libfontconfig \
        wkhtmltopdf \
        libxml2-dev \
        libonig-dev \
        libcurl4-openssl-dev \
        libzip-dev \
        pkg-config \
        libfreetype6-dev \
        libjpeg62-turbo-dev \
        libpng-dev \
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install -j$(nproc) gd
COPY config/php.ini "$PHP_INI_DIR/php.ini"
# RUN docker-php-ext-install gd curl ctype iconv json mbstring zip pdo_mysql reflection zip dom spl intl
RUN docker-php-ext-install gd curl ctype iconv json mbstring zip pdo_mysql zip dom
RUN rm -rf /var/www/html
ENV APACHE_DOCUMENT_ROOT /var/www/web/
RUN sed -ri -e 's!/var/www/html!${APACHE_DOCUMENT_ROOT}!g' /etc/apache2/sites-available/*.conf
RUN sed -ri -e 's!/var/www/!${APACHE_DOCUMENT_ROOT}!g' /etc/apache2/apache2.conf /etc/apache2/conf-available/*.conf