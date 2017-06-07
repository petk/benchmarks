.PHONY: help nginx litespeed litespeed-php nginx-fpm-uds
.DEFAULT_GOAL := help

CONCURENCY=10
REQUESTS=10000
SLEEP=sleep 5
RESULTS=results/2017-05
BENCH=ab -c $(CONCURENCY) -n $(REQUESTS) -k http://localhost/

help: ## Output usage documentation
	@echo "Usage: make COMMAND [-a=\"command args\"]\n\nCommands:"
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-20s\033[0m %s\n", $$1, $$2}'

nginx: ## Nginx HTML Benchmark
	docker-compose -f stacks/nginx/docker-compose.yml -f stacks/nginx/docker-compose.html.yml up -d --force-recreate --build
	$(SLEEP)
	$(BENCH) > $(RESULTS)/nginx-html.txt

litespeed: ## OpenLiteSpeed HTML Benchmark
	docker-compose -f stacks/litespeed/docker-compose.yml -f stacks/litespeed/docker-compose.html.yml up -d --force-recreate --build
	$(SLEEP)
	$(BENCH) > $(RESULTS)/litespeed-html.txt

litespeed-php: ## OpenLiteSpeed PHP Benchmark
	docker-compose -f stacks/litespeed-php/docker-compose.yml -f stacks/litespeed-php/docker-compose.php.yml up -d --force-recreate --build
	$(SLEEP)
	$(BENCH) > $(RESULTS)/litespeed-php.txt

litespeed-symfony: ## OpenLiteSpeed Symfony Benchmark
	docker-compose -f stacks/litespeed-php/docker-compose.yml -f stacks/litespeed-php/docker-compose.symfony.yml up -d --force-recreate --build
	$(SLEEP)
	$(BENCH) > $(RESULTS)/litespeed-symfony.txt

nginx-fpm-uds: ## Nginx PHP FPM Unix Domain Socket Benchmark
	docker-compose -f stacks/nginx-fpm-uds/docker-compose.yml -f stacks/nginx-fpm-uds/docker-compose.php.yml up -d --force-recreate --build
	$(SLEEP)
	$(BENCH) > $(RESULTS)/nginx-fpm-uds.txt

nginx-fpm-uds-symfony: ## Nginx Symfony FPM Unix Domain Socket Benchmark
	docker-compose -f stacks/nginx-fpm-uds/docker-compose.yml -f stacks/nginx-fpm-uds/docker-compose.symfony.yml up -d --force-recreate --build
	$(SLEEP)
	$(BENCH) > $(RESULTS)/nginx-fpm-uds-symfony.txt

nginx-swoole-uds-symfony: ## Nginx with Symfony and Swoole Unix Domain Socket Benchmark
	docker-compose -f stacks/nginx-swoole-uds/docker-compose.yml -f stacks/nginx-swoole-uds/docker-compose.symfony.yml up -d --force-recreate --build
	$(SLEEP)
	$(BENCH) > $(RESULTS)/nginx-swoole-uds-symfony.txt

nginx-swoole-uds: ## Nginx with Swoole Unix Domain Socket Benchmark
	docker-compose -f stacks/nginx-swoole-uds/docker-compose.yml -f stacks/nginx-swoole-uds/docker-compose.swoole.yml up -d --force-recreate --build
	$(SLEEP)
	$(BENCH) > $(RESULTS)/nginx-swoole-uds.txt

litespeed-swoole: ## OpenLiteSpeed Swoole Benchmark
	docker-compose -f stacks/litespeed-swoole/docker-compose.yml -f stacks/litespeed-swoole/docker-compose.swoole.yml up -d --force-recreate --build

litespeed-swoole-symfony: ## OpenLiteSpeed Swoole Benchmark with Symfony
	docker-compose -f stacks/litespeed-swoole/docker-compose.yml -f stacks/litespeed-swoole/docker-compose.symfony.yml up -d --force-recreate --build
