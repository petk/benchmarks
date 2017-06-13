#!/bin/bash

# Benchmarking helper script

# Output usage documentation and help
function usage () {
cat <<END
Custom helper commands for managing the benchmarks
Usage: run.sh COMMAND APP [arg...]
Commands:
    init              Install applications
    data              Create JSON data file for GH pages chart
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

        # Instal Magento 2
        cd ../magento2
        git clone git://github.com/magento/magento2 .
        git checkout tags/2.1.4
        composer install --ignore-platform-reqs

    elif [[ "${stacks[@]}" =~ "$1" ]]; then
        if [ "$1" == "nginx-fpm" ]; then
            # Get number of processors
            processors=$(grep ^processor /proc/cpuinfo | wc -l)
        fi
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
