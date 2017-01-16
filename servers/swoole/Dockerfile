FROM php:7.1-cli

MAINTAINER Peter Kokot <peterkokot@gmail.com>

RUN pecl install swoole \
    && echo 'extension=swoole.so' >> /usr/local/etc/php/php.ini

COPY ./apps/swoole-app/ /var/www/html/
