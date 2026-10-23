<?php
require_once 'c:/xampp/htdocs/mcc/connection.php';

echo "=== CREATING TABLE photo_attendace_proccess ===\n";

$sql = "
CREATE TABLE IF NOT EXISTS `photo_attendace_proccess` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `station_id` int(11) NOT NULL,
  `process_name` varchar(255) NOT NULL,
  `status` varchar(50) NOT NULL DEFAULT 'Active',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_station_id` (`station_id`),
  UNIQUE KEY `uq_station_process` (`station_id`, `process_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
";

$pdo->exec($sql);
echo "[OK] Table `photo_attendace_proccess` created successfully.\n";

// Fetch existing stations
$stations = $pdo->query("SELECT station_id, station_name FROM mcc_stations")->fetchAll(PDO::FETCH_ASSOC);
echo "Found " . count($stations) . " stations:\n";
foreach ($stations as $st) {
    echo "  - Station ID " . $st['station_id'] . ": " . $st['station_name'] . "\n";
}

// Populate sample processes for each station if table is empty
$count = $pdo->query("SELECT COUNT(*) FROM `photo_attendace_proccess`")->fetchColumn();
if ($count == 0) {
    $defaultProcesses = [
        'Normal Cleaning',
        'Pit Cleaning',
        'Intensive Cleaning',
        'Platform Return Cleaning'
    ];

    $insert = $pdo->prepare("
        INSERT IGNORE INTO `photo_attendace_proccess` (station_id, process_name, status)
        VALUES (:station_id, :process_name, 'Active')
    ");

    $stationIds = !empty($stations) ? array_column($stations, 'station_id') : [1];
    foreach ($stationIds as $sId) {
        foreach ($defaultProcesses as $pName) {
            $insert->execute([
                'station_id' => $sId,
                'process_name' => $pName
            ]);
        }
    }
    echo "[OK] Seeded default station-wise processes into `photo_attendace_proccess`.\n";
} else {
    echo "[INFO] `photo_attendace_proccess` already has $count records.\n";
}

// Display table contents
$rows = $pdo->query("SELECT * FROM `photo_attendace_proccess`")->fetchAll(PDO::FETCH_ASSOC);
print_r($rows);
