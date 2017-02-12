<?php

use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\Debug\Debug;

class SymfonyRequest
{
    public static function createSymfonyRequest($swRequest)
    {
        $_SERVER = isset($swRequest->server) ? array_change_key_case($swRequest->server, CASE_UPPER) : [];
        if (isset($swRequest->header)) {
            $headers = [];
            foreach ($swRequest->header as $k => $v) {
                $k = str_replace('-', '_', $k);
                $headers['http_' . $k] = $v;
            }
            $_SERVER += array_change_key_case($headers, CASE_UPPER);
        }
        $_GET = isset($swRequest->get) ? $swRequest->get : [];
        $_POST = isset($swRequest->post) ? $swRequest->post : [];
        $_COOKIE = isset($swRequest->cookie) ? $swRequest->cookie : [];
        $symfonyRequest = Request::createFromGlobals();
        if (0 === strpos($symfonyRequest->headers->get('Content-Type'), 'application/json')) {
            $data = json_decode($swRequest->rawContent(), true);
            $symfonyRequest->request->replace(is_array($data) ? $data : array());
        }
        return $symfonyRequest;
    }
}

class SymfonyResponse
{
    public static function send($swResponse, $symfonyResponse)
    {
        foreach ($symfonyResponse->headers->getCookies() as $cookie) {
            $swResponse->header('Set-Cookie', $cookie);
        }
        foreach ($symfonyResponse->headers as $name => $values) {
            $name = implode('-', array_map('ucfirst', explode('-', $name)));
            foreach ($values as $value) {
                $swResponse->header($name, $value);
            }
        }
        $swResponse->end($symfonyResponse->getContent());
    }
}

/** @var \Composer\Autoload\ClassLoader $loader */
$loader = require __DIR__.'/../app/autoload.php';
include_once __DIR__.'/../var/bootstrap.php.cache';
//Debug::enable();

$http = new swoole_http_server("0.0.0.0", 9502);
$http->addlistener("/run/php/swoole-symfony.sock", 0, SWOOLE_UNIX_STREAM);

$kernel = new AppKernel('prod', false);
$kernel->loadClassCache();
//$kernel = new AppCache($kernel);

$http->on('request', function ($request, $response) use ($kernel) {
    $symfonyRequest = SymfonyRequest::createSymfonyRequest($request);
    $symfonyResponse = $kernel->handle($symfonyRequest);

    SymfonyResponse::send($response, $symfonyResponse);
    $kernel->terminate($symfonyRequest, $symfonyResponse);
});

$http->start();
