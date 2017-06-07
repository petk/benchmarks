FROM petk/php:nginx

RUN install-php-ext swoole \
    && download-composer

RUN sed -ri 's/^www-data:x:82:82:/www-data:x:1000:50:/' /etc/passwd

COPY . /
