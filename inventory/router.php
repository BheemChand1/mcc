<?php
declare(strict_types=1);

// For PHP's local server: php -S 127.0.0.1:8081 -t inventory inventory/router.php
$path = rawurldecode(parse_url($_SERVER['REQUEST_URI'], PHP_URL_PATH) ?: '/');
if (preg_match('#^/assets/[a-zA-Z0-9_-]+\.(css|js|svg)$#D', $path) && is_file(__DIR__ . $path)) {
    return false;
}
if ($path === '/api.php') {
    require __DIR__ . '/api.php';
    return true;
}
if (in_array($path, ['/', '/index.php'], true)) {
    require __DIR__ . '/index.php';
    return true;
}
http_response_code(404);
echo 'Not found';
