<?php
declare(strict_types=1);
if (PHP_SAPI !== 'cli') {
    http_response_code(404);
    exit;
}
require dirname(__DIR__) . '/src/Database.php';
require dirname(__DIR__) . '/src/InventoryService.php';
date_default_timezone_set('Asia/Kolkata');
$stationId = (int) ($argv[1] ?? 1);
$service = new \Inventory\InventoryService(\Inventory\Database::connect(), $stationId, 'Database setup');
$service->seed();
echo 'Inventory database ready. ' . count($service->materials()) . " materials for station $stationId.\n";
