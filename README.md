# Benchmarks

The following setups provide some performance overview of different technologies
for web developers. Benchmarks are run with help of Docker.

## Included Setups

* [Apache](https://httpd.apache.org/)
* [Nginx](http://nginx.org/)
* [OpenLiteSpeed](http://open.litespeedtech.com/)
* [Swoole](http://swoole.com/)
* [PHP-PM](https://github.com/php-pm/php-pm)
* [Express](http://expressjs.com/)

## Results

Results are displayed on [GitHub Page](https://petk.github.io/benchmarks/).

## Installation

To run a particular test you need [Docker](https://docs.docker.com/engine/)
and [Docker Compose](https://docs.docker.com/compose/).

For example, to run Apache test:

```bash
git clone git://github.com/petk/benchmarks
cd benchmarks
# Pull Docker images and install applications
./run.sh init
# Run benchmarking tests, for example Apache stack with static HTML file
./run.sh apache html
```

## Contributing and License

Contributions and improvement suggestions are [most welcome](CONTRIBUTING.md).
This repository is released under the [MIT License](LICENSE).
