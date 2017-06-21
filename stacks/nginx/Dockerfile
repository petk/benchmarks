FROM phpearth/php:7.1-nginx

RUN apk add --no-cache php7.1-swoole \
    && sed -ri 's/^www-data:x:82:82:/www-data:x:1000:50:/' /etc/passwd

COPY . /
