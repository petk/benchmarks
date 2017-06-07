FROM petk/php:nginx

RUN install-php-ext swoole \
    && download-composer

COPY etc /etc
