# Apache static file benchmark
docker run -dit --name benchmarks-apache -v "$PWD"/apache:/usr/local/apache2/htdocs/ -p 80:80 httpd:2.4
ab -c 200 -n 200000 -k -r http://localhost/
docker rm -f benchmarks-apache
