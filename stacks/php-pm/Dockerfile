FROM phpearth/php:7.1-cgi

RUN apk add --no-cache composer git php7.1-pcntl \
    && mkdir -p /opt \
    && cd /opt \
    && git clone https://github.com/php-pm/php-pm.git \
    && cd php-pm \
    && composer install \
    && ln -s `pwd`/bin/ppm /usr/local/bin/ppm

#COPY etc /etc
