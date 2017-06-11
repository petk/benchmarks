FROM phpearth/php:litespeed

RUN install-php-ext swoole

COPY . /

RUN chown lsadm:lsadm /usr/local/lsws/conf/httpd_config.conf \
    && chown -R lsadm:lsadm /usr/local/lsws/conf
