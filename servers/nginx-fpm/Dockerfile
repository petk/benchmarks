FROM php:7.1-fpm

MAINTAINER Peter Kokot

RUN apt-get update && apt-get -y install curl ca-certificates supervisor --no-install-recommends \
    && echo 'deb http://ftp.debian.org/debian jessie-backports main' >> /etc/apt/sources.list \
    && echo 'deb http://packages.dotdeb.org jessie all' | tee --append /etc/apt/sources.list \
    && echo 'deb-src http://packages.dotdeb.org jessie all' | tee --append /etc/apt/sources.list \
    && echo 'deb http://packages.dotdeb.org jessie-nginx-http2 all' | tee --append /etc/apt/sources.list \
    && echo 'deb-src http://packages.dotdeb.org jessie-nginx-http2 all' | tee --append /etc/apt/sources.list \
    && curl https://www.dotdeb.org/dotdeb.gpg | apt-key add - \
    && apt-get update \
    && apt-get -y install openssl libssl-dev -t jessie-backports --no-install-recommends \
    && apt-get -y install nginx \
    && ln -sf /dev/stdout /var/log/nginx/access.log \
    && ln -sf /dev/stderr /var/log/nginx/error.log \
    && mkdir /run/php \
    && php -r "readfile('http://getcomposer.org/installer');" | php -- --install-dir=/usr/bin/ --filename=composer

COPY etc /etc
COPY usr /usr

CMD ["/usr/bin/supervisord"]
