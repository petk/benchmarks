# PHP FPM Optimizations

How PHP FPM behaves on different server hardware can be configured in the `www.conf`
file.

* `pm.max_children` = (1024*x) / 30

  Total Max Processes = (Total Ram - (Used Ram + Buffer)) / (Memory per PHP process)

  Where `x` is amount of RAM in GB

## See Also

* [Servers For Hackers](https://serversforhackers.com/video/php-fpm-process-management)
