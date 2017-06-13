.PHONY: help install benchmark apache apache-php nginx nginx-fpm-uds nginx-fpm-uds-symfony nginx-swoole-uds-symfony nginx-swoole-uds litespeed litespeed-php litespeed-swoole litespeed-symfony litespeed-symfony-swoole node swoole caddy
.DEFAULT_GOAL := help

CONCURENCY=10
REQUESTS=1000
SLEEP=sleep 5
RESULTS=results/2017-06-13-1

define bench
  ab -c $(CONCURENCY) -n $(REQUESTS) http://localhost$(2)/ > $(RESULTS)/$(1)
endef

help: ## Output usage documentation
	@echo "Usage: make COMMAND [-a=\"command args\"]\n\nCommands:"
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-20s\033[0m %s\n", $$1, $$2}'

install: ## Install applications and dependencies required for running benchmarks
	cd apps/symfony; \
	composer install --no-ansi --no-dev --no-interaction --no-progress --no-scripts --optimize-autoloader --prefer-dist
	cd apps/laravel; \
	composer install --no-ansi --no-dev --no-interaction --no-progress --no-scripts --optimize-autoloader --prefer-dist

benchmark: ## Run all benchmarks
	mkdir -p $(RESULTS)
	make apache
	make apache-php
	make nginx
	make nginx-php-uds
	make nginx-php
	make nginx-symfony-uds
	make nginx-symfony
	make nginx-symfony-swoole-uds
	make nginx-symfony-swoole
	make nginx-swoole-uds
	make nginx-swoole
	make litespeed
	make litespeed-php
	make litespeed-swoole
	make litespeed-symfony
	make litespeed-symfony-swoole
	make swoole
	make node

apache: ## Apache HTML Benchmark
	docker-compose -f stacks/apache/docker-compose.yml -f stacks/apache/docker-compose.html.yml up -d --force-recreate --build
	$(SLEEP)
	$(call bench,apache-html.txt)

apache-php: ## Apache PHP Benchmark
	docker-compose -f stacks/apache-php/docker-compose.yml -f stacks/apache-php/docker-compose.php.yml up -d --force-recreate --build
	$(SLEEP)
	$(call bench,apache-php.txt)

nginx: ## Nginx HTML Benchmark
	docker-compose -f stacks/nginx/docker-compose.yml -f stacks/nginx/docker-compose.html.yml up -d --force-recreate --build
	$(SLEEP)
	$(call bench,nginx-html.txt,:8081)

nginx-php-uds: ## Nginx PHP FPM Unix Domain Socket Benchmark
	docker-compose -f stacks/nginx/docker-compose.yml -f stacks/nginx/docker-compose.php-uds.yml up -d --force-recreate --build
	$(SLEEP)
	$(call bench,nginx-php-uds.txt,:8082)

nginx-php: ## Nginx PHP FPM TCP Socket Benchmark
	docker-compose -f stacks/nginx/docker-compose.yml -f stacks/nginx/docker-compose.php.yml up -d --force-recreate --build
	$(SLEEP)
	$(call bench,nginx-php.txt,:8083)

nginx-symfony-uds: ## Nginx Symfony FPM Unix Domain Socket Benchmark
	docker-compose -f stacks/nginx/docker-compose.yml -f stacks/nginx/docker-compose.symfony-uds.yml up -d --force-recreate --build
	$(SLEEP)
	$(call bench,nginx-symfony-uds.txt,:8084)

nginx-symfony: ## Nginx Symfony FPM TCP IP Socket Benchmark
	docker-compose -f stacks/nginx/docker-compose.yml -f stacks/nginx/docker-compose.symfony.yml up -d --force-recreate --build
	$(SLEEP)
	$(call bench,nginx-symfony.txt,:8085)

nginx-symfony-swoole-uds: ## Nginx with Symfony and Swoole Unix Domain Socket Benchmark
	#docker-compose -f stacks/nginx/docker-compose.yml -f stacks/nginx/docker-compose.symfony-swoole-uds.yml up -d --force-recreate --build
	#$(SLEEP)
	#$(call bench,nginx-symfony-swoole-uds.txt,:8086)

nginx-symfony-swoole: ## Nginx with Swoole TCP IP Socket and Symfony Benchmark
	docker-compose -f stacks/nginx/docker-compose.yml -f stacks/nginx/docker-compose.symfony-swoole.yml up -d --force-recreate --build
	$(SLEEP)
	$(call bench,nginx-symfony-swoole.txt,:8086)

nginx-swoole-uds: ## Nginx with Swoole Unix Domain Socket benchmark
	docker-compose -f stacks/nginx/docker-compose.yml -f stacks/nginx/docker-compose.swoole-uds.yml up -d --force-recreate --build
	$(SLEEP)
	docker exec benchmarks-app chown www-data:www-data /run/php/swoole.sock
	$(call bench,nginx-swoole-uds.txt,:8087)

nginx-swoole: ## Nginx with Swoole TCP IP socket benchmark
	docker-compose -f stacks/nginx/docker-compose.yml -f stacks/nginx/docker-compose.swoole.yml up -d --force-recreate --build
	$(SLEEP)
	$(call bench,nginx-swoole.txt,:8088)

litespeed: ## OpenLiteSpeed HTML benchmark
	docker-compose -f stacks/litespeed/docker-compose.yml -f stacks/litespeed/docker-compose.html.yml up -d --force-recreate --build
	$(SLEEP)
	$(call bench,litespeed-html.txt,:8081)

litespeed-php: ## OpenLiteSpeed PHP benchmark
	docker-compose -f stacks/litespeed/docker-compose.yml -f stacks/litespeed/docker-compose.php.yml up -d --force-recreate --build
	$(SLEEP)
	$(call bench,litespeed-php.txt,:8082)

litespeed-swoole: ## OpenLiteSpeed Swoole benchmark
	docker-compose -f stacks/litespeed/docker-compose.yml -f stacks/litespeed/docker-compose.swoole.yml up -d --force-recreate --build
	$(SLEEP)
	$(call bench,litespeed-swoole.txt,:8083)

litespeed-symfony: ## OpenLiteSpeed Symfony benchmark
	docker-compose -f stacks/litespeed/docker-compose.yml -f stacks/litespeed/docker-compose.symfony.yml up -d --force-recreate --build
	$(SLEEP)
	$(call bench,litespeed-symfony.txt,:8084/app.php)

litespeed-symfony-swoole: ## OpenLiteSpeed Swoole benchmark with Symfony
	docker-compose -f stacks/litespeed/docker-compose.yml -f stacks/litespeed/docker-compose.symfony-swoole.yml up -d --force-recreate --build
	$(SLEEP)
	$(call bench,litespeed-symfony-swoole.txt,:8085)

swoole: ## Raw Swoole HTTP server benchmark
	docker-compose -f stacks/swoole/docker-compose.yml -f stacks/swoole/docker-compose.swoole.yml up -d --force-recreate --build
	$(SLEEP)
	$(call bench,swoole.txt)

node:
	docker-compose -f stacks/node/docker-compose.yml -f stacks/node/docker-compose.express.yml run --rm app npm install
	docker-compose -f stacks/node/docker-compose.yml -f stacks/node/docker-compose.express.yml up -d --force-recreate --build
	$(SLEEP)
	$(call bench,node.txt)
