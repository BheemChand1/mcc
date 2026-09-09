-- Inventory Module Database Schema & Reference Materials Seed for MySQL / phpMyAdmin

CREATE TABLE IF NOT EXISTS `inventory_materials` (
    `id` INT AUTO_INCREMENT PRIMARY KEY,
    `station_id` INT NOT NULL,
    `catalog_number` INT NULL,
    `name` VARCHAR(255) NOT NULL,
    `category` ENUM('Chemical', 'Equipment', 'Consumable') NOT NULL,
    `unit` ENUM('L', 'mL', 'kg', 'g', 'pcs', 'rolls', 'sets') NOT NULL,
    `opening_qty` BIGINT NOT NULL DEFAULT 0,
    `opening_date` DATE NULL,
    `minimum_qty` BIGINT NOT NULL DEFAULT 0,
    `version` INT NOT NULL DEFAULT 1,
    `created_at` VARCHAR(50) NOT NULL,
    `updated_at` VARCHAR(50) NOT NULL,
    UNIQUE KEY `uq_station_name` (`station_id`, `name`),
    KEY `idx_materials_station` (`station_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `inventory_entries` (
    `id` INT AUTO_INCREMENT PRIMARY KEY,
    `material_id` INT NOT NULL,
    `entry_date` DATE NOT NULL,
    `used_qty` BIGINT NOT NULL DEFAULT 0,
    `received_qty` BIGINT NOT NULL DEFAULT 0,
    `supervisor` VARCHAR(255) NOT NULL,
    `je_sse` VARCHAR(255) NOT NULL DEFAULT '',
    `notes` TEXT NULL,
    `created_by` VARCHAR(255) NOT NULL,
    `updated_by` VARCHAR(255) NOT NULL,
    `created_at` VARCHAR(50) NOT NULL,
    `updated_at` VARCHAR(50) NOT NULL,
    UNIQUE KEY `uq_material_date` (`material_id`, `entry_date`),
    KEY `idx_entries_date` (`entry_date`),
    CONSTRAINT `fk_inv_entries_material` FOREIGN KEY (`material_id`) REFERENCES `inventory_materials` (`id`) ON DELETE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `inventory_audit` (
    `id` INT AUTO_INCREMENT PRIMARY KEY,
    `station_id` INT NOT NULL,
    `material_id` INT NOT NULL,
    `action` VARCHAR(50) NOT NULL,
    `actor` VARCHAR(255) NOT NULL,
    `entry_date` DATE NULL,
    `used_qty` BIGINT NOT NULL DEFAULT 0,
    `received_qty` BIGINT NOT NULL DEFAULT 0,
    `opening_qty` BIGINT NOT NULL DEFAULT 0,
    `closing_qty` BIGINT NOT NULL DEFAULT 0,
    `supervisor` VARCHAR(255) NULL,
    `je_sse` VARCHAR(255) NULL,
    `notes` TEXT NULL,
    `details` TEXT NULL,
    `created_at` VARCHAR(50) NOT NULL,
    KEY `idx_audit_material` (`material_id`, `id`),
    CONSTRAINT `fk_inv_audit_material` FOREIGN KEY (`material_id`) REFERENCES `inventory_materials` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `inventory_seeded_stations` (
    `station_id` INT PRIMARY KEY,
    `seeded_at` VARCHAR(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- -----------------------------------------------------------------------------
-- Seed Data: All 35 Reference Chemicals, Consumables & Equipment (Station ID 1)
-- -----------------------------------------------------------------------------

INSERT IGNORE INTO `inventory_materials` (`station_id`, `catalog_number`, `name`, `category`, `unit`, `opening_qty`, `opening_date`, `minimum_qty`, `version`, `created_at`, `updated_at`) VALUES
(1, 1, 'Heavy Duty Exterior Washing Liquid', 'Chemical', 'L', 0, NULL, 0, 1, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(1, 2, 'Ceramic & Stainless Steel Toilet Fittings Cleaning Agent', 'Chemical', 'L', 0, NULL, 0, 1, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(1, 3, 'Glass Cleaning Agent', 'Chemical', 'L', 0, NULL, 0, 1, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(1, 4, 'PVC Floor Cleaning Agent', 'Chemical', 'L', 0, NULL, 0, 1, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(1, 5, 'Air Freshener', 'Chemical', 'L', 0, NULL, 0, 1, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(1, 6, 'Liquid Hand Soap (Hand Wash)', 'Chemical', 'L', 0, NULL, 0, 1, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(1, 7, 'Cleaning Agent for Removing Old Sticker, Glue Marks etc.', 'Chemical', 'L', 0, NULL, 0, 1, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(1, 8, 'Stainless Steel Polish', 'Chemical', 'L', 0, NULL, 0, 1, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(1, 9, 'Banister Brush', 'Equipment', 'pcs', 0, NULL, 0, 1, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(1, 10, 'Bucket (15 L + 5 L)', 'Equipment', 'sets', 0, NULL, 0, 1, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(1, 11, 'Foot Broom Head with Bristles', 'Equipment', 'pcs', 0, NULL, 0, 1, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(1, 12, 'Polypropylene Bristle Brush', 'Equipment', 'pcs', 0, NULL, 0, 1, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(1, 13, 'Suitable Broom', 'Equipment', 'pcs', 0, NULL, 0, 1, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(1, 14, 'Disposable Bag (29 × 39)', 'Consumable', 'pcs', 0, NULL, 0, 1, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(1, 15, 'Floor Mopper', 'Equipment', 'pcs', 0, NULL, 0, 1, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(1, 16, 'Mopper Cloth', 'Consumable', 'pcs', 0, NULL, 0, 1, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(1, 17, 'Microfiber Cloth', 'Consumable', 'pcs', 0, NULL, 0, 1, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(1, 18, 'Fiber Hand Held Brush (Round Type)', 'Equipment', 'pcs', 0, NULL, 0, 1, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(1, 19, 'Floor Squeezer', 'Equipment', 'pcs', 0, NULL, 0, 1, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(1, 20, 'Window Squeezer', 'Equipment', 'pcs', 0, NULL, 0, 1, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(1, 21, 'Bottle with Spray Gun', 'Equipment', 'pcs', 0, NULL, 0, 1, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(1, 22, 'Super Absorbent Floor Mopper', 'Equipment', 'pcs', 0, NULL, 0, 1, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(1, 23, 'Squeeze Brush', 'Equipment', 'pcs', 0, NULL, 0, 1, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(1, 24, 'Toilet Commode Brush', 'Equipment', 'pcs', 0, NULL, 0, 1, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(1, 25, 'Carpet Brush', 'Equipment', 'pcs', 0, NULL, 0, 1, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(1, 26, 'Upholstery Cleaning Brush', 'Equipment', 'pcs', 0, NULL, 0, 1, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(1, 27, 'Sponge Duster (Yellow)', 'Consumable', 'pcs', 0, NULL, 0, 1, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(1, 28, 'Disposable Bag for Dustbin (19 × 21)', 'Consumable', 'pcs', 0, NULL, 0, 1, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(1, 29, 'Disinfectants', 'Chemical', 'L', 0, NULL, 0, 1, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(1, 30, 'Mosquito Repellent Spray', 'Chemical', 'pcs', 0, NULL, 0, 1, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(1, 31, 'Tissue Paper for Western AC Coach Toilet', 'Consumable', 'rolls', 0, NULL, 0, 1, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(1, 32, 'Deodorant Stick/Cake for Each Toilet in AC Coaches', 'Consumable', 'pcs', 0, NULL, 0, 1, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(1, 33, 'Painted Surface Cleaning Agent', 'Chemical', 'L', 0, NULL, 0, 1, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(1, 34, 'Laminated Plastic Sheet & Berth Rexine Cleaner', 'Chemical', 'L', 0, NULL, 0, 1, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(1, 35, 'Window Glass Squeezer', 'Equipment', 'pcs', 0, NULL, 0, 1, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

INSERT IGNORE INTO `inventory_seeded_stations` (`station_id`, `seeded_at`) VALUES (1, CURRENT_TIMESTAMP);
