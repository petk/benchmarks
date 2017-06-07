FROM petk/php:litespeed-slim

RUN install-php-ext swoole

COPY usr/local/etc /usr/local/etc
COPY usr/local/lsws/conf/httpd_config.conf /usr/local/lsws/conf/httpd_config.conf
COPY usr/local/lsws/conf/vhosts /usr/local/lsws/conf/vhosts
COPY etc /etc

RUN chown lsadm:lsadm /usr/local/lsws/conf/httpd_config.conf \
    && chown -R lsadm:lsadm /usr/local/lsws/conf
