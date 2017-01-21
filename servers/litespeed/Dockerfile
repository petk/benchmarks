FROM phpearth/php:litespeed

MAINTAINER Peter Kokot <peterkokot@gmail.com>

COPY ./servers/litespeed-php/usr/local/lsws/conf/httpd_config.conf /usr/local/lsws/conf/httpd_config.conf
COPY ./servers/litespeed-php/usr/local/lsws/conf/vhosts /usr/local/lsws/conf/vhosts

RUN chown lsadm:lsadm /usr/local/lsws/conf/httpd_config.conf \
    && chown -R lsadm:lsadm /usr/local/lsws/conf
