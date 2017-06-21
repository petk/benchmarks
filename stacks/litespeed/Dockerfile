FROM phpearth/php:7.1-litespeed

RUN apk add --no-cache php7.1-swoole

COPY . /

RUN chown -R lsadm:lsadm /usr/local/lsws/conf
