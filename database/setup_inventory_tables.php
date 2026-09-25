<?php
require_once __DIR__ . '/../connection.php';

$pdo->exec("
CREATE TABLE IF NOT EXISTS `mcc_chemical_stock` (
  `id` INT AUTO_INCREMENT PRIMARY KEY,
  `station_id` INT NOT NULL,
  `parameter_id` INT NOT NULL,
  `stock_quantity` DECIMAL(12,2) NOT NULL DEFAULT 0.00,
  `last_updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  UNIQUE KEY `uniq_stn_param` (`station_id`, `parameter_id`),
  CONSTRAINT `fk_stock_param` FOREIGN KEY (`parameter_id`) REFERENCES `mcc_chemical_param` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
");

$pdo->exec("
CREATE TABLE IF NOT EXISTS `mcc_chemical_stock_log` (
  `id` INT AUTO_INCREMENT PRIMARY KEY,
  `station_id` INT NOT NULL,
  `parameter_id` INT NOT NULL,
  `action_type` ENUM('ADD', 'SET') NOT NULL DEFAULT 'ADD',
  `quantity` DECIMAL(12,2) NOT NULL,
  `remarks` VARCHAR(255) DEFAULT NULL,
  `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  `created_by` VARCHAR(100) DEFAULT NULL,
  KEY `idx_stock_log` (`station_id`, `parameter_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
");

echo "Tables created successfully.\n";
