# Benchmarks

The following setups provide some performance overview of different technologies
for web developers. Benchmarks are run with help of Docker.

## Included Setups

* [Apache 2.4](https://httpd.apache.org/)
* [Nginx 1.10.3](http://nginx.org/)
* [OpenLiteSpeed 1.4.24](http://open.litespeedtech.com/)
* [Swoole 1.9.5](http://swoole.com/)
* [PHP-PM](https://github.com/php-pm/php-pm)
* [Express](http://expressjs.com/)

## Results

Results are located on a separate rendered [GitHub Page](https://petk.github.io/benchmarks/).

## Installation

To run a particular test you need [Docker](https://docs.docker.com/engine/)
and [Docker Compose](https://docs.docker.com/compose/).

For example, to run Apache test:

```bash
git clone git://github.com/petk/benchmarks
cd benchmarks
# Pull Docker images and install applications
./run.sh init
# Run benchmarking tests
./run.sh apache
```

## Contributing and License

Contributions and improvement suggestions are [most welcome](CONTRIBUTING.md).
This repository is released under the [MIT License](LICENSE).
