#!/usr/bin/env php
<?php

$http = new swoole_http_server("0.0.0.0", 9501);

$http->addlistener("/run/php/swoole.sock", 0, SWOOLE_UNIX_STREAM);

$http->set([
    'user' => 'www-data',
    'group' => 'www-data'
]);

$http->on('request', function ($request, $response) {
    $response->header("Content-Type", "text/html; charset=utf-8");
    //$response->end("<h1>Hello Swoole. #".rand(1000, 9999)."</h1>");
    $response->end("Hello, world");
});

$http->start();
