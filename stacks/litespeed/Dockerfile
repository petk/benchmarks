FROM phpearth/php:7.1-litespeed

RUN install-php-ext swoole

COPY . /

RUN chown -R lsadm:lsadm /usr/local/lsws/conf
