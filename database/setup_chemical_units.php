<?php
require_once __DIR__ . '/../connection.php';

try {
    // 1. Create mcc_chemical_units table
    $pdo->exec("
    CREATE TABLE IF NOT EXISTS `mcc_chemical_units` (
      `id` INT AUTO_INCREMENT PRIMARY KEY,
      `unit_name` VARCHAR(50) NOT NULL,
      `unit_symbol` VARCHAR(20) NOT NULL,
      `unit_type` ENUM('volume', 'weight', 'count') NOT NULL,
      `is_base_unit` TINYINT(1) DEFAULT 0,
      `conversion_to_base` DECIMAL(12, 4) NOT NULL DEFAULT 1.0000,
      `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP
    ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
    ");

    // 2. Insert standard units if not already present
    $check = $pdo->query("SELECT COUNT(*) FROM `mcc_chemical_units`")->fetchColumn();
    if ($check == 0) {
        $pdo->exec("
        INSERT INTO `mcc_chemical_units` (`id`, `unit_name`, `unit_symbol`, `unit_type`, `is_base_unit`, `conversion_to_base`) VALUES
        (1, 'Millilitre', 'ml', 'volume', 1, 1.0000),
        (2, 'Litre', 'L', 'volume', 0, 1000.0000),
        (3, '5 Litre Can', '5L Can', 'volume', 0, 5000.0000),
        (4, '20 Litre Drum', '20L Drum', 'volume', 0, 20000.0000),
        (5, 'Gram', 'g', 'weight', 1, 1.0000),
        (6, 'Kilogram', 'kg', 'weight', 0, 1000.0000),
        (7, 'Piece / Bottle', 'pcs', 'count', 1, 1.0000);
        ");
    }

    // 3. Add base_unit_id and unit_type to mcc_chemical_param if not exists
    $cols = $pdo->query("SHOW COLUMNS FROM `mcc_chemical_param` LIKE 'base_unit_id'")->fetchAll();
    if (empty($cols)) {
        $pdo->exec("
            ALTER TABLE `mcc_chemical_param` 
            ADD COLUMN `base_unit_id` INT DEFAULT 1 AFTER `units`,
            ADD COLUMN `unit_type` ENUM('volume', 'weight', 'count') DEFAULT 'volume' AFTER `base_unit_id`,
            ADD CONSTRAINT `fk_param_base_unit` FOREIGN KEY (`base_unit_id`) REFERENCES `mcc_chemical_units` (`id`) ON DELETE SET NULL;
        ");
    }

    // 4. Update unit_type and base_unit_id based on current 'units' text in mcc_chemical_param
    $pdo->exec("
        UPDATE `mcc_chemical_param`
        SET `base_unit_id` = 1, `unit_type` = 'volume'
        WHERE `units` LIKE '%ml%' OR `units` LIKE '%l%' OR `units` IS NULL OR `units` = '';
    ");
    $pdo->exec("
        UPDATE `mcc_chemical_param`
        SET `base_unit_id` = 5, `unit_type` = 'weight'
        WHERE `units` LIKE '%g%' AND `units` NOT LIKE '%ml%' AND `units` NOT LIKE '%coach%';
    ");
    $pdo->exec("
        UPDATE `mcc_chemical_param`
        SET `base_unit_id` = 7, `unit_type` = 'count'
        WHERE `units` LIKE '%pc%' OR `units` LIKE '%bot%' OR `units` LIKE '%no%';
    ");

    echo "Chemical units table and parameter mapping setup successfully!\n";

    // Print unit list
    $units = $pdo->query("SELECT * FROM `mcc_chemical_units`")->fetchAll(PDO::FETCH_ASSOC);
    print_r($units);

} catch (Exception $e) {
    echo "Error: " . $e->getMessage() . "\n";
}
