<?php
/**
 * Setup Equipment Master and Daily Log Tables
 */
require_once __DIR__ . '/../connection.php';

try {
    // 1. Create mcc_equipment_master
    $pdo->exec("
        CREATE TABLE IF NOT EXISTS `mcc_equipment_master` (
            `id` INT AUTO_INCREMENT PRIMARY KEY,
            `station_id` INT NOT NULL,
            `equipment_name` VARCHAR(255) NOT NULL,
            `category` VARCHAR(100) DEFAULT 'Machinery',
            `required_qty` INT NOT NULL DEFAULT 1,
            `unit` VARCHAR(50) NOT NULL DEFAULT 'Nos',
            `status` ENUM('Active', 'Inactive') NOT NULL DEFAULT 'Active',
            `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
            `updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
            KEY `idx_stn_status` (`station_id`, `status`)
        ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
    ");

    // 2. Create mcc_equipment_daily_log
    $pdo->exec("
        CREATE TABLE IF NOT EXISTS `mcc_equipment_daily_log` (
            `id` INT AUTO_INCREMENT PRIMARY KEY,
            `station_id` INT NOT NULL,
            `equipment_id` INT NOT NULL,
            `log_date` DATE NOT NULL,
            `required_qty` INT NOT NULL DEFAULT 0,
            `given_qty` INT NOT NULL DEFAULT 0,
            `working_qty` INT NOT NULL DEFAULT 0,
            `breakdown_qty` INT NOT NULL DEFAULT 0,
            `remarks` VARCHAR(255) DEFAULT NULL,
            `submitted_by` VARCHAR(100) DEFAULT NULL,
            `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
            `updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
            UNIQUE KEY `uniq_stn_equip_date` (`station_id`, `equipment_id`, `log_date`),
            KEY `idx_stn_date` (`station_id`, `log_date`),
            CONSTRAINT `fk_equip_master_log` FOREIGN KEY (`equipment_id`) REFERENCES `mcc_equipment_master` (`id`) ON DELETE CASCADE
        ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
    ");

    // 3. Seed default equipments if empty
    $checkStmt = $pdo->query("SELECT COUNT(*) FROM mcc_equipment_master");
    $count = $checkStmt->fetchColumn();

    if ($count == 0) {
        // Fetch all stations
        $stationsStmt = $pdo->query("SELECT station_id FROM mcc_stations");
        $stations = $stationsStmt ? $stationsStmt->fetchAll(PDO::FETCH_COLUMN) : [1];

        if (empty($stations)) {
            $stations = [1];
        }

        $defaultEquipments = [
            ['High Pressure Jet Cleaner', 'Machinery', 4, 'Nos'],
            ['Heavy Duty Wet & Dry Vacuum Cleaner', 'Machinery', 4, 'Nos'],
            ['Single Disc Floor Scrubber', 'Machinery', 2, 'Nos'],
            ['Steam Vapor Cleaning Machine', 'Machinery', 2, 'Nos'],
            ['Air Blower / Dryer', 'Machinery', 3, 'Nos'],
            ['Aluminium Extension Ladder (12-24 ft)', 'Tools & Access', 2, 'Nos'],
            ['Janitor Mop Trolley with Dual Bucket', 'Cleaning Tools', 6, 'Sets'],
            ['Microfiber Mops & Squeegees Set', 'Cleaning Tools', 12, 'Sets'],
            ['Safety PPE Kits & Gum Boots', 'Safety & PPE', 15, 'Sets'],
            ['Telescopic Window Cleaning Pole', 'Cleaning Tools', 4, 'Nos']
        ];

        $insertStmt = $pdo->prepare("
            INSERT INTO mcc_equipment_master (station_id, equipment_name, category, required_qty, unit, status)
            VALUES (?, ?, ?, ?, ?, 'Active')
        ");

        foreach ($stations as $stnId) {
            foreach ($defaultEquipments as $eq) {
                $insertStmt->execute([$stnId, $eq[0], $eq[1], $eq[2], $eq[3]]);
            }
        }
    }

    echo "Equipment tables created and seeded successfully.\n";

} catch (Exception $e) {
    echo "Error setting up equipment tables: " . $e->getMessage() . "\n";
    exit(1);
}
