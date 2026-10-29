<?php
require_once __DIR__ . '/../connection.php';

try {
    // 1. Create mcc_employee_custom_fields table
    $sqlFields = "CREATE TABLE IF NOT EXISTS `mcc_employee_custom_fields` (
        `id` INT AUTO_INCREMENT PRIMARY KEY,
        `station_id` INT NOT NULL,
        `field_label` VARCHAR(150) NOT NULL,
        `field_key` VARCHAR(100) NOT NULL,
        `field_type` ENUM('text', 'number', 'date', 'select', 'textarea', 'file') DEFAULT 'text',
        `field_options` TEXT NULL COMMENT 'Comma-separated options for select dropdowns',
        `placeholder` VARCHAR(255) NULL,
        `is_required` TINYINT(1) DEFAULT 0,
        `sort_order` INT DEFAULT 0,
        `status` ENUM('Active', 'Inactive') DEFAULT 'Active',
        `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
        `updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
        INDEX (`station_id`),
        INDEX (`status`),
        INDEX (`sort_order`)
    ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;";
    $pdo->exec($sqlFields);
    echo "mcc_employee_custom_fields table verified/created successfully.\n";

    // 2. Add custom_data column to mcc_employee if not exists
    $colCheck = $pdo->query("SHOW COLUMNS FROM `mcc_employee` LIKE 'custom_data'");
    if ($colCheck->rowCount() == 0) {
        $pdo->exec("ALTER TABLE `mcc_employee` ADD COLUMN `custom_data` LONGTEXT NULL AFTER `remarks`");
        echo "Added `custom_data` column to `mcc_employee`.\n";
    } else {
        echo "`custom_data` column already exists in `mcc_employee`.\n";
    }

    // 3. Ensure station_id column exists and is indexed in mcc_employee
    $stColCheck = $pdo->query("SHOW COLUMNS FROM `mcc_employee` LIKE 'station_id'");
    if ($stColCheck->rowCount() == 0) {
        $pdo->exec("ALTER TABLE `mcc_employee` ADD COLUMN `station_id` INT NOT NULL DEFAULT 1 AFTER `id`");
        $pdo->exec("ALTER TABLE `mcc_employee` ADD INDEX (`station_id`)");
        echo "Added `station_id` column to `mcc_employee`.\n";
    } else {
        echo "`station_id` column already exists in `mcc_employee`.\n";
    }

    echo "Migration completed successfully!\n";
} catch (Exception $e) {
    echo "Error: " . $e->getMessage() . "\n";
}
