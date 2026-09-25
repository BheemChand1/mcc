-- ==========================================================
-- Unified Chemical Architecture Schema
-- ==========================================================

-- 1. Chemical Types Table (Cleaning Categories)
CREATE TABLE IF NOT EXISTS `mcc_chemical_types` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type_name` varchar(100) NOT NULL,
  `type_code` varchar(50) NOT NULL UNIQUE,
  `status` enum('Active','Inactive') NOT NULL DEFAULT 'Active',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Seed default chemical types
INSERT IGNORE INTO `mcc_chemical_types` (`id`, `type_name`, `type_code`, `status`) VALUES
(1, 'Normal Cleaning', 'normal', 'Active'),
(2, 'Intensive Cleaning', 'intensive', 'Active'),
(3, 'Pantry Car Cleaning', 'pantry', 'Active'),
(4, 'PRT Cleaning', 'prt', 'Active'),
(5, 'Vande Bharat Cleaning', 'vb', 'Active'),
(6, 'Direct Cleaning', 'dc', 'Active');

-- 2. Chemical Units Catalog (Multi-Unit & Conversion Architecture)
CREATE TABLE IF NOT EXISTS `mcc_chemical_units` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `unit_name` varchar(50) NOT NULL,
  `unit_symbol` varchar(20) NOT NULL,
  `unit_type` enum('volume','weight','count') NOT NULL,
  `is_base_unit` tinyint(1) DEFAULT 0,
  `conversion_to_base` decimal(12,4) NOT NULL DEFAULT 1.0000,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Seed default units
INSERT IGNORE INTO `mcc_chemical_units` (`id`, `unit_name`, `unit_symbol`, `unit_type`, `is_base_unit`, `conversion_to_base`) VALUES
(1, 'Millilitre', 'ml', 'volume', 1, 1.0000),
(2, 'Litre', 'L', 'volume', 0, 1000.0000),
(3, '5 Litre Can', '5L Can', 'volume', 0, 5000.0000),
(4, '20 Litre Drum', '20L Drum', 'volume', 0, 20000.0000),
(5, 'Gram', 'g', 'weight', 1, 1.0000),
(6, 'Kilogram', 'kg', 'weight', 0, 1000.0000),
(7, 'Piece / Bottle', 'pcs', 'count', 1, 1.0000);

-- 3. Master Chemical Parameter Catalog per Station
CREATE TABLE IF NOT EXISTS `mcc_chemical_param` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `station_id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `base_unit_id` int(11) DEFAULT 1,
  `unit_type` enum('volume','weight','count') NOT NULL DEFAULT 'volume',
  `status` enum('Active','Inactive') NOT NULL DEFAULT 'Active',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_station` (`station_id`),
  KEY `idx_station_name` (`station_id`, `name`),
  KEY `idx_base_unit` (`base_unit_id`),
  CONSTRAINT `fk_param_base_unit` FOREIGN KEY (`base_unit_id`) REFERENCES `mcc_chemical_units` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- 3. Chemical Parameter to Type Mapping Table
CREATE TABLE IF NOT EXISTS `mcc_chemical_param_type_map` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `station_id` int(11) NOT NULL,
  `parameter_id` int(11) NOT NULL,
  `chemical_type_id` int(11) NOT NULL,
  `status` enum('Active','Inactive') NOT NULL DEFAULT 'Active',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uniq_param_type_station` (`station_id`, `parameter_id`, `chemical_type_id`),
  KEY `idx_station_type` (`station_id`, `chemical_type_id`),
  KEY `idx_param` (`parameter_id`),
  KEY `idx_type` (`chemical_type_id`),
  CONSTRAINT `fk_map_chem_param` FOREIGN KEY (`parameter_id`) REFERENCES `mcc_chemical_param` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_map_chem_type` FOREIGN KEY (`chemical_type_id`) REFERENCES `mcc_chemical_types` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- 4. Chemical Targets Table
CREATE TABLE IF NOT EXISTS `mcc_chemical_target` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `station_id` int(11) NOT NULL,
  `chemical_type_id` int(11) NOT NULL,
  `parameter_id` int(11) NOT NULL,
  `qty(ml)` decimal(10,2) DEFAULT NULL,
  `penalty` decimal(10,2) DEFAULT NULL,
  `penalty_qty(ml)` decimal(10,2) DEFAULT NULL,
  `effective_from` date NOT NULL DEFAULT curdate(),
  `effective_to` date DEFAULT NULL,
  `target_month` date DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_tgt_station_type` (`station_id`, `chemical_type_id`),
  KEY `idx_tgt_param` (`parameter_id`),
  KEY `idx_tgt_effective` (`effective_from`, `effective_to`),
  CONSTRAINT `fk_tgt_chem_param` FOREIGN KEY (`parameter_id`) REFERENCES `mcc_chemical_param` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_tgt_chem_type` FOREIGN KEY (`chemical_type_id`) REFERENCES `mcc_chemical_types` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- 5. Unified Chemical Reports Table
CREATE TABLE IF NOT EXISTS `mcc_chemical_report` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `station_id` int(11) NOT NULL,
  `chemical_type_id` int(11) NOT NULL,
  `parameter_id` int(11) NOT NULL,
  `train_no` varchar(50) DEFAULT NULL,
  `coach_no` varchar(20) DEFAULT NULL,
  `shift_id` int(11) DEFAULT NULL,
  `qty_used` decimal(10,2) DEFAULT NULL,
  `auditor_name` varchar(255) DEFAULT NULL,
  `audit_by` int(11) DEFAULT NULL,
  `token_id` varchar(100) NOT NULL,
  `report_date` date NOT NULL,
  `isApproved` tinyint(1) NOT NULL DEFAULT 0,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_rep_station_type_date` (`station_id`, `chemical_type_id`, `report_date`),
  KEY `idx_rep_token` (`token_id`),
  KEY `idx_rep_param` (`parameter_id`),
  KEY `idx_rep_train` (`train_no`),
  CONSTRAINT `fk_rep_chem_param` FOREIGN KEY (`parameter_id`) REFERENCES `mcc_chemical_param` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_rep_chem_type` FOREIGN KEY (`chemical_type_id`) REFERENCES `mcc_chemical_types` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
