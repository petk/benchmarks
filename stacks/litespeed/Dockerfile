FROM phpearth/php:litespeed

MAINTAINER Peter Kokot

COPY usr/local/lsws/conf/httpd_config.conf /usr/local/lsws/conf/httpd_config.conf
COPY usr/local/lsws/conf/vhosts /usr/local/lsws/conf/vhosts

RUN chown lsadm:lsadm /usr/local/lsws/conf/httpd_config.conf \
    && chown -R lsadm:lsadm /usr/local/lsws/conf
