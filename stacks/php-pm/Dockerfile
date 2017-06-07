FROM debian:jessie-slim

RUN apt-get update && apt-get -y install curl wget ca-certificates supervisor apt-transport-https lsb-release git --no-install-recommends \
    && echo 'deb http://ftp.debian.org/debian jessie-backports main' >> /etc/apt/sources.list \
    # dotdeb
    && echo 'deb http://packages.dotdeb.org jessie all' | tee --append /etc/apt/sources.list \
    && echo 'deb-src http://packages.dotdeb.org jessie all' | tee --append /etc/apt/sources.list \
    && echo 'deb http://packages.dotdeb.org jessie-nginx-http2 all' | tee --append /etc/apt/sources.list \
    && echo 'deb-src http://packages.dotdeb.org jessie-nginx-http2 all' | tee --append /etc/apt/sources.list \
    && curl https://www.dotdeb.org/dotdeb.gpg | apt-key add - \
    # deb.sury.org
    && wget -O /etc/apt/trusted.gpg.d/php.gpg https://packages.sury.org/php/apt.gpg \
    && echo "deb https://packages.sury.org/php/ $(lsb_release -sc) main" > /etc/apt/sources.list.d/php.list \
    && apt-get update \
    && apt-get -y install openssl libssl-dev -t jessie-backports --no-install-recommends \
    && apt-get -y install nginx php7.1-cgi php7.1-xml php7.1-zip --no-install-recommends \
    && php -r "readfile('http://getcomposer.org/installer');" | php -- --install-dir=/usr/bin/ --filename=composer \
    && cd /opt \
    && git clone https://github.com/php-pm/php-pm.git \
    && cd php-pm \
    && composer install \
    && ln -s `pwd`/bin/ppm /usr/local/bin/ppm \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

COPY etc /etc

CMD ["/usr/bin/supervisord"]
