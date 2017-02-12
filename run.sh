#!/bin/bash

# Benchmarking helper script

# Output usage documentation and help
function usage () {
cat <<END
Custom helper commands for managing the benchmarks
Usage: run.sh COMMAND APP [arg...]
Commands:
    init              Install applications
    apache            Run Apache static file benchmark
    apache-php        Run Apache with PHP-CGI benchmark
    nginx             Run Nginx static file benchmark
    nginx-fpm         Run Nginx with PHP-FPM (TCP/IP Socket) benchmark
    nginx-fpm-uds     Run Nginx with PHP-FPM (Unix Domain Socket) benchmark
    litespeed         Run OpenLiteSpeed static file benchmark
    litespeed-php     Run OpenLiteSpeed with LSAPI benchmark
    litespeed-swoole  Run OpenLiteSpeed with Swoole (TCP/IP) benchmark
    swoole            Run Swoole benchmark
    nginx-swoole      Run Nginx with Swoole (TCP/IP) benchmark
    nginx-swoole-uds  Run Nginx with Swoole (Unix Domain Socket) benchmark
    node              Run Node.js and Express benchmark Hello world benchmark
    data              Create JSON data file for GH pages chart
Applications:
    html              Static HTML file
    php               Hello world PHP application
    symfony           Symfony application
    laravel           Laravel application
    swoole            Hello world PHP Swoole application
    express           Node.js Express application
END
}

# Parse YAML configuration files
function parse_yaml {
    local prefix=$2
    local s='[[:space:]]*' w='[a-zA-Z0-9_]*' fs=$(echo @|tr @ '\034')
    sed -ne "s|^\($s\):|\1|" \
        -e "s|^\($s\)\($w\)$s:$s[\"']\(.*\)[\"']$s\$|\1$fs\2$fs\3|p" \
        -e "s|^\($s\)\($w\)$s:$s\(.*\)$s\$|\1$fs\2$fs\3|p"  $1 |
    awk -F$fs '{
        indent = length($1)/2;
        vname[indent] = $2;
        for (i in vname) {if (i > indent) {delete vname[i]}}
        if (length($3) > 0) {
            vn=""; for (i=0; i<indent; i++) {vn=(vn)(vname[i])("_")}
            printf("%s%s%s=\"%s\"\n", "'$prefix'",vn, $2, $3);
        }
    }'
}

# Set configuration values
eval $(parse_yaml config.yml)

# Generic benchmark
# Arguments
#   $1 - setup name
#   $2 - application name
function run() {
    sum=0
    for ((i=1; i<=$benchmarks; i++)); do
        docker-compose -f stacks/$1/docker-compose.yml -f stacks/$1/docker-compose.$2.yml up -d --force-recreate
        echo "Benchmarking..."
        sleep $sleep

        ab -c $concurency -n $requests -k http://localhost/ > results/$1_$2_$i.txt
        rqs=$(grep -o -P '(?<=Requests per second:    ).*(?= \[)' results/$1_$2_$i.txt)

        docker-compose -f stacks/$1/docker-compose.yml -f stacks/$1/docker-compose.$2.yml down
        sum=$(echo "$sum + $rqs" | bc)
    done
    average=$(echo "$sum / $benchmarks" | bc)
    echo $1"_"$2":"$average >> $data
}

# If arguments are passed, for example ./run.sh nginx
if [ $# -gt 0 ];then

    stacks=("apache" "apache-php" "nginx" "nginx-fpm" "nginx-swoole" "litespeed" "litespeed-php" "litespeed-swoole" "swoole" "php-pm" "node" "nginx-swoole-uds" "nginx-fpm-uds")

    if [ "$1" == "init" ]; then
        # Pull Docker images
        for i in "${stacks[@]}"
        do
            docker-compose -f stacks/$i/docker-compose.yml pull
        done

        # Install Express node.js
        docker-compose -f stacks/node/docker-compose.yml run --rm app npm install

        # Install Symfony
        cd apps/symfony
        composer install
        composer dump-autoload --optimize

        # Install Laravel
        cd ../laravel
        composer install
        composer dump-autoload --optimize

    elif [[ "${stacks[@]}" =~ "$1" ]]; then
        run $1 $2

    elif [ "$1" == "data" ]; then
        cp results/template.json docs/assets/js/results.json
        while read -r line
        do
            IFS=':' read key rqs <<< "$line"
            key="__"$key"__"
            sed -i "s/$key/$rqs/g" docs/assets/js/results.json
        done < "results/data.txt"
    else
        usage
    fi
else
    usage
fi
