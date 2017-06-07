# Nginx Performance

Nginx is one of the most popular web servers that can serve large traffic
websites.

To adjust performance behavior of Nginx there are some configuration settings
to check and understand:

* `worker_processes`

  http://nginx.org/en/docs/ngx_core_module.html#worker_processes

  Setting this to auto inside the Docker container
