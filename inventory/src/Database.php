<?php
declare(strict_types=1);

namespace Inventory;

use PDO;
use RuntimeException;

final class Database
{
    private static ?PDO $pdoInstance = null;

    public static function connect(?PDO $customPdo = null): PDO
    {
        if ($customPdo !== null) {
            self::initMysqlTables($customPdo);
            return $customPdo;
        }

        if (self::$pdoInstance !== null) {
            return self::$pdoInstance;
        }

        $connectionFile = dirname(__DIR__, 2) . '/connection.php';
        if (!file_exists($connectionFile)) {
            throw new RuntimeException('connection.php not found at project root.');
        }

        // Include connection.php to get database credentials and connections
        require_once $connectionFile;

        $pdo = $GLOBALS['pdo'] ?? ($pdo ?? null);

        // If $pdo is not directly set in scope, create PDO using the credentials in connection.php
        if (!($pdo instanceof PDO)) {
            if (defined('DB_HOST') && defined('DB_USER') && defined('DB_PASS') && defined('DB_NAME')) {
                $dsn = "mysql:host=" . DB_HOST . ";dbname=" . DB_NAME . ";charset=utf8mb4";
                $options = [
                    PDO::ATTR_ERRMODE            => PDO::ERRMODE_EXCEPTION,
                    PDO::ATTR_DEFAULT_FETCH_MODE => PDO::FETCH_ASSOC,
                    PDO::ATTR_EMULATE_PREPARES   => false,
                ];
                $pdo = new PDO($dsn, DB_USER, DB_PASS, $options);
            }
        }

        if (!($pdo instanceof PDO)) {
            throw new RuntimeException('Could not establish PDO MySQL connection from connection.php.');
        }

        self::initMysqlTables($pdo);
        self::$pdoInstance = $pdo;
        return $pdo;
    }

    private static function initMysqlTables(PDO $pdo): void
    {
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
                UNIQUE KEY uq_station_name (station_id, name),
                KEY idx_materials_station (station_id)
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
                KEY idx_entries_date (entry_date),
                CONSTRAINT fk_inv_material FOREIGN KEY (material_id) REFERENCES inventory_materials(id) ON DELETE RESTRICT
            ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;",

            "CREATE TABLE IF NOT EXISTS inventory_audit (
                id INT AUTO_INCREMENT PRIMARY KEY,
                station_id INT NOT NULL,
                material_id INT NOT NULL,
                action VARCHAR(50) NOT NULL,
                actor VARCHAR(255) NOT NULL,
                entry_date DATE NULL,
                used_qty BIGINT NOT NULL DEFAULT 0,
                received_qty BIGINT NOT NULL DEFAULT 0,
                opening_qty BIGINT NOT NULL DEFAULT 0,
                closing_qty BIGINT NOT NULL DEFAULT 0,
                supervisor VARCHAR(255) NULL,
                je_sse VARCHAR(255) NULL,
                notes TEXT NULL,
                details TEXT NULL,
                created_at VARCHAR(50) NOT NULL,
                KEY idx_audit_material (material_id, id),
                CONSTRAINT fk_inv_audit_material FOREIGN KEY (material_id) REFERENCES inventory_materials(id) ON DELETE CASCADE
            ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;",

            "CREATE TABLE IF NOT EXISTS inventory_seeded_stations (
                station_id INT PRIMARY KEY,
                seeded_at VARCHAR(50) NOT NULL
            ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;"
        ];

        foreach ($queries as $query) {
            $pdo->exec($query);
        }
    }
}
