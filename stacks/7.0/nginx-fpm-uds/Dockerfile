FROM php:7.0-fpm

RUN apt-get update && apt-get -y install curl ca-certificates supervisor --no-install-recommends \
    && echo 'deb http://ftp.debian.org/debian jessie-backports main' >> /etc/apt/sources.list \
    && echo 'deb http://packages.dotdeb.org jessie all' | tee --append /etc/apt/sources.list \
    && echo 'deb-src http://packages.dotdeb.org jessie all' | tee --append /etc/apt/sources.list \
    && echo 'deb http://packages.dotdeb.org jessie-nginx-http2 all' | tee --append /etc/apt/sources.list \
    && echo 'deb-src http://packages.dotdeb.org jessie-nginx-http2 all' | tee --append /etc/apt/sources.list \
    && curl https://www.dotdeb.org/dotdeb.gpg | apt-key add - \
    && apt-get update \
    && apt-get -y install openssl libssl-dev -t jessie-backports --no-install-recommends \
    && apt-get -y install nginx \
    # Additional PHP extensions: soap, mcrypt, gd, pdo_mysql
    && apt-get -y install libxml2-dev libmcrypt-dev libpng-dev libjpeg-dev libfreetype6-dev libicu-dev libxslt-dev --no-install-recommends \
    && docker-php-ext-install soap mcrypt pdo_mysql intl xsl zip \
    && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
    && docker-php-ext-install -j$(nproc) gd \
    && ln -sf /dev/stdout /var/log/nginx/access.log \
    && ln -sf /dev/stderr /var/log/nginx/error.log \
    && mkdir /run/php \
    && php -r "readfile('http://getcomposer.org/installer');" | php -- --install-dir=/usr/bin/ --filename=composer \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

COPY etc /etc
COPY usr /usr

CMD ["/usr/bin/supervisord"]
