FROM php:7.1-cli

MAINTAINER Peter Kokot

RUN pecl install swoole \
    && echo 'extension=swoole.so' >> /usr/local/etc/php/php.ini
