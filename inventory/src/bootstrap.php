<?php
declare(strict_types=1);

require_once __DIR__ . '/Database.php';
require_once __DIR__ . '/InventoryService.php';
date_default_timezone_set('Asia/Kolkata');

header('X-Content-Type-Options: nosniff');
header('X-Frame-Options: SAMEORIGIN');
header('Referrer-Policy: same-origin');
header("Content-Security-Policy: default-src 'self'; script-src 'self'; style-src 'self'; img-src 'self' data:; connect-src 'self'; object-src 'none'; base-uri 'self'; frame-ancestors 'self'; form-action 'self'");
header('Cache-Control: no-store');

if (session_status() === PHP_SESSION_NONE) {
    session_start();
}

// Explicit local development only. Hosted access uses the existing MCC login session.
$inventoryLocal = getenv('INVENTORY_LOCAL_DEV') === '1'
    && PHP_SAPI === 'cli-server'
    && in_array($_SERVER['REMOTE_ADDR'] ?? '', ['127.0.0.1', '::1'], true);
// User session set by root index.php / connection.php login
$inventoryUserId = $_SESSION['user_id'] ?? null;
$rawStation = $_SESSION['station_id'] ?? null;
$inventoryStationId = $rawStation !== null && (int) $rawStation > 0 ? (int) $rawStation : 1;

$inventoryAuthenticated = ($inventoryUserId !== null) || $inventoryLocal;
$inventoryCanWrite = $inventoryAuthenticated && strtoupper((string) ($_SESSION['role'] ?? 'LOCAL')) !== 'VIEWER';
$inventoryActor = $inventoryLocal && $inventoryUserId === null ? 'Local operator' : (string) ($_SESSION['user_name'] ?? $_SESSION['username'] ?? 'User') . ' (#' . (string) ($inventoryUserId ?? 1) . ')';
$inventoryStationName = (string) ($_SESSION['station_name'] ?? 'Station ' . $inventoryStationId);

if ($inventoryAuthenticated && !isset($_SESSION['inventory_csrf'])) {
    $_SESSION['inventory_csrf'] = bin2hex(random_bytes(32));
}

function inventoryService(): \Inventory\InventoryService
{
    global $inventoryStationId, $inventoryActor;
    $service = new \Inventory\InventoryService(\Inventory\Database::connect(), $inventoryStationId, $inventoryActor);
    $service->seed();
    return $service;
}
