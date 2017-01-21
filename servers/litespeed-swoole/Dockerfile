FROM phpearth/php:litespeed

ENV BUILD_DEPS \
        autoconf \
        gcc \
        g++ \
        make \
        build-essential

RUN apt-get update && apt-get -y install $BUILD_DEPS --no-install-recommends \
    && pecl install swoole \
    && apt-get purge -y --auto-remove $BUILD_DEPS \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

COPY ./servers/litespeed-swoole/usr/local/etc /usr/local/etc
COPY ./servers/litespeed-swoole/usr/local/lsws/conf/httpd_config.conf /usr/local/lsws/conf/httpd_config.conf
COPY ./servers/litespeed-swoole/usr/local/lsws/conf/vhosts /usr/local/lsws/conf/vhosts
COPY ./servers/litespeed-swoole/etc /etc

RUN chown lsadm:lsadm /usr/local/lsws/conf/httpd_config.conf \
    && chown -R lsadm:lsadm /usr/local/lsws/conf
