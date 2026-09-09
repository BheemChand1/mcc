<?php
/**
 * Live Database Seed Script for Inventory Module
 * Seeds all 35 reference chemicals & materials into the live MySQL database via connection.php
 */
declare(strict_types=1);

$connectionFile = dirname(__DIR__, 2) . '/connection.php';
if (!file_exists($connectionFile)) {
    die("Error: connection.php not found at project root.\n");
}

require_once $connectionFile;

if (!isset($pdo) || !($pdo instanceof PDO)) {
    die("Error: connection.php did not return a valid PDO instance.\n");
}

$materials = require __DIR__ . '/materials.php';
$stationId = 1;

// 1. Create tables if not present
$queries = [
    "CREATE TABLE IF NOT EXISTS inventory_materials (
        id INT AUTO_INCREMENT PRIMARY KEY,
        station_id INT NOT NULL,
        catalog_number INT NULL,
        name VARCHAR(255) NOT NULL,
        category ENUM('Chemical', 'Equipment', 'Consumable') NOT NULL,
        unit ENUM('L', 'mL', 'kg', 'g', 'pcs', 'rolls', 'sets') NOT NULL,
        opening_qty BIGINT NOT NULL DEFAULT 0,
        opening_date DATE NULL,
        minimum_qty BIGINT NOT NULL DEFAULT 0,
        version INT NOT NULL DEFAULT 1,
        created_at VARCHAR(50) NOT NULL,
        updated_at VARCHAR(50) NOT NULL,
        UNIQUE KEY uq_station_name (station_id, name)
    ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;",

    "CREATE TABLE IF NOT EXISTS inventory_entries (
        id INT AUTO_INCREMENT PRIMARY KEY,
        material_id INT NOT NULL,
        entry_date DATE NOT NULL,
        used_qty BIGINT NOT NULL DEFAULT 0,
        received_qty BIGINT NOT NULL DEFAULT 0,
        supervisor VARCHAR(255) NOT NULL,
        je_sse VARCHAR(255) NOT NULL DEFAULT '',
        notes TEXT,
        created_by VARCHAR(255) NOT NULL,
        updated_by VARCHAR(255) NOT NULL,
        created_at VARCHAR(50) NOT NULL,
        updated_at VARCHAR(50) NOT NULL,
        UNIQUE KEY uq_material_date (material_id, entry_date),
        CONSTRAINT fk_live_material FOREIGN KEY (material_id) REFERENCES inventory_materials(id) ON DELETE RESTRICT
    ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;",

    "CREATE TABLE IF NOT EXISTS inventory_audit (
        id INT AUTO_INCREMENT PRIMARY KEY,
        station_id INT NOT NULL,
        material_id INT NOT NULL,
        action VARCHAR(50) NOT NULL,
        actor VARCHAR(255) NOT NULL,
        before_json LONGTEXT NULL,
        after_json LONGTEXT NOT NULL,
        created_at VARCHAR(50) NOT NULL,
        CONSTRAINT fk_live_audit_material FOREIGN KEY (material_id) REFERENCES inventory_materials(id) ON DELETE CASCADE
    ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;",

    "CREATE TABLE IF NOT EXISTS inventory_seeded_stations (
        station_id INT PRIMARY KEY,
        seeded_at VARCHAR(50) NOT NULL
    ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;"
];

foreach ($queries as $q) {
    $pdo->exec($q);
}

// 2. Insert all 35 items
$stmt = $pdo->prepare("INSERT IGNORE INTO inventory_materials (station_id, catalog_number, name, category, unit, created_at, updated_at) VALUES (?, ?, ?, ?, ?, ?, ?)");
$inserted = 0;
$now = date('Y-m-d H:i:s');

foreach ($materials as $index => $item) {
    $stmt->execute([$stationId, $index + 1, $item[0], $item[1], $item[2], $now, $now]);
    if ($stmt->rowCount() > 0) {
        $inserted++;
    }
}

$pdo->prepare("INSERT IGNORE INTO inventory_seeded_stations (station_id, seeded_at) VALUES (?, ?)")->execute([$stationId, $now]);

echo "Success: Seeded {$inserted} materials into the live MySQL database for station {$stationId}.\n";
