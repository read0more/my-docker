FROM php:7.4-fpm-alpine
WORKDIR "/application"

# Install bash
RUN apk add --no-cache bash

# Install php extension
ADD https://github.com/mlocati/docker-php-extension-installer/releases/latest/download/install-php-extensions /usr/local/bin/
RUN chmod +x /usr/local/bin/install-php-extensions && sync && install-php-extensions \
    bcmath \
	gd \
	intl \
	pdo_mysql \
	soap \
	sockets \
	xsl \
	zip \
    xdebug \
    opcache \
    APCu 
    
# Install essential build tools
RUN apk add --no-cache \
    git \
    yarn \
    autoconf \
    g++ \
    make \
    openssl-dev

# Optional, force UTC as server time
RUN echo "UTC" > /etc/timezone

# Install composer
ENV COMPOSER_HOME /composer
ENV PATH ./vendor/bin:/composer/vendor/bin:$PATH
ENV COMPOSER_ALLOW_SUPERUSER 1
RUN curl -s https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin/ --filename=composer

# Setup bzip2 extension
RUN apk add --no-cache \
    bzip2-dev \
    && docker-php-ext-install -j$(nproc) bz2 \
    && docker-php-ext-enable bz2 \
    && rm -rf /tmp/*
 
EXPOSE 9000
CMD ["php-fpm"]
