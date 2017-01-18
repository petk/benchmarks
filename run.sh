#!/bin/bash

# Output documentation and help
function documentation () {
cat <<END
Custom helper commands for managing the benchmarks
Usage: run.sh COMMAND [arg...]
Commands:'
    apache            Runs Apache static file benchmark
    nginx             Runs Nginx static file benchmark
    apache-php        Runs Apache with PHP-CGI benchmark
    nginx-php         Runs Nginx with PHP-FPM (TCP/IP Socket) benchmark
    nginx-php-uds     Runs Nginx with PHP-FPM (Unix Domain Socket) benchmark
    swoole            Runs Swoole benchmark
    nginx-swoole      Runs Nginx with Swoole benchmark
    nginx-swoole-uds  Runs Nginx with Swoole benchmark
END
}

# If arguments are passed, for example ./run.sh nginx
if [ $# -gt 0 ];then

    # Apache Benchmark
    if [ "$1" == "apache" ]; then
        shift 1
        ./servers/apache/run.sh

    elif [ "$1" == "nginx" ]; then
        shift 1
        ./servers/nginx/run.sh

    elif [ "$1" == "apache-php" ]; then
        shift 1
        ./servers/apache-php/run.sh

    elif [ "$1" == "nginx-php" ]; then
        shift 1
        ./servers/nginx-php/run.sh

    elif [ "$1" == "nginx-php-uds" ]; then
        shift 1
        ./servers/nginx-php-uds/run.sh

    elif [ "$1" == "swoole" ]; then
        shift 1
        ./servers/swoole/run.sh

    elif [ "$1" == "nginx-swoole" ]; then
        shift 1
        ./servers/nginx-swoole/run.sh

    elif [ "$1" == "nginx-swoole-uds" ]; then
        shift 1
        ./servers/nginx-swoole-uds/run.sh

    else
        documentation
    fi
else
    documentation
fi
