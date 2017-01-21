#!/bin/bash

# Output usage documentation and help
function usage () {
cat <<END
Custom helper commands for managing the benchmarks
Usage: run.sh COMMAND [arg...]
Commands:'
    apache            Runs Apache static file benchmark
    nginx             Runs Nginx static file benchmark
    apache-php        Runs Apache with PHP-CGI benchmark
    litespeed-php     Runs OpenLiteSpeed with LSAPI benchmark
    litespeed-swoole  Runs OpenLiteSpeed with Swoole (TCP/IP) benchmark
    nginx-php         Runs Nginx with PHP-FPM (TCP/IP Socket) benchmark
    nginx-php-uds     Runs Nginx with PHP-FPM (Unix Domain Socket) benchmark
    swoole            Runs Swoole benchmark
    nginx-swoole      Runs Nginx with Swoole benchmark
    nginx-swoole-uds  Runs Nginx with Swoole benchmark
END
}

# If arguments are passed, for example ./run.sh nginx
if [ $# -gt 0 ];then

    if [ "$1" == "apache" ]; then
        shift 1
        docker-compose -f servers/apache/docker-compose.yml up -d --build --force-recreate
        ab -c 200 -n 200000 -k -r http://localhost/
        docker-compose -f servers/apache/docker-compose.yml down

    elif [ "$1" == "nginx" ]; then
        shift 1
        docker-compose -f servers/nginx/docker-compose.yml up -d --build --force-recreate
        ab -c 200 -n 200000 -k -r http://localhost/
        docker-compose -f servers/nginx/docker-compose.yml down

    elif [ "$1" == "litespeed" ]; then
        shift 1
        docker-compose -f servers/litespeed/docker-compose.yml up -d --build --force-recreate
        ab -c 200 -n 200000 -k -r http://localhost/
        docker-compose -f servers/litespeed/docker-compose.yml down

    elif [ "$1" == "apache-php" ]; then
        shift 1
        docker-compose -f servers/apache-php/docker-compose.yml up -d --build --force-recreate
        ab -c 200 -n 200000 -k -r http://localhost/
        docker-compose -f servers/apache-php/docker-compose.yml down

    elif [ "$1" == "litespeed-php" ]; then
        shift 1
        docker-compose -f servers/litespeed-php/docker-compose.yml up -d --build --force-recreate
        ab -c 200 -n 200000 -k -r http://localhost/
        docker-compose -f servers/litespeed-php/docker-compose.yml down

    elif [ "$1" == "litespeed-swoole" ]; then
        shift 1
        docker-compose -f servers/litespeed-swoole/docker-compose.yml up -d --build --force-recreate
        ab -c 200 -n 200000 -k -r http://localhost/
        docker-compose -f servers/litespeed-swoole/docker-compose.yml down

    elif [ "$1" == "nginx-php" ]; then
        shift 1
        docker-compose -f servers/nginx-php/docker-compose.yml up -d --build --force-recreate
        ab -c 200 -n 200000 -k -r http://localhost/
        docker-compose -f servers/nginx-php/docker-compose.yml down

    elif [ "$1" == "nginx-php-uds" ]; then
        shift 1
        docker-compose -f servers/nginx-php-uds/docker-compose.yml up -d --build --force-recreate
        ab -c 200 -n 200000 -k -r http://localhost/
        docker-compose -f servers/nginx-php-uds/docker-compose.yml down

    elif [ "$1" == "swoole" ]; then
        shift 1
        docker-compose -f servers/swoole/docker-compose.yml up -d --build --force-recreate
        ab -c 200 -n 200000 -k -r http://localhost/
        docker-compose -f servers/swoole/docker-compose.yml down

    elif [ "$1" == "nginx-swoole" ]; then
        shift 1
        docker-compose -f servers/nginx-swoole/docker-compose.yml up -d --build --force-recreate
        ab -c 200 -n 200000 -k -r http://localhost/
        docker-compose -f servers/nginx-swoole/docker-compose.yml down

    elif [ "$1" == "nginx-swoole-uds" ]; then
        shift 1
        docker-compose -f servers/nginx-swoole-uds/docker-compose.yml up -d --build --force-recreate
        ab -c 200 -n 200000 -k -r http://localhost/
        docker-compose -f servers/nginx-swoole-uds/docker-compose.yml down

    else
        usage
    fi
else
    usage
fi
