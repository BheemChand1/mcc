<?php
require_once __DIR__ . '/../connection.php';

try {
    // 1. Ensure all rows in mcc_chemical_param have a valid base_unit_id
    $pdo->exec("UPDATE mcc_chemical_param SET base_unit_id = 1 WHERE base_unit_id IS NULL OR base_unit_id = 0");

    // 2. Check if 'units' column exists before dropping
    $cols = $pdo->query("SHOW COLUMNS FROM `mcc_chemical_param` LIKE 'units'")->fetchAll();
    if (!empty($cols)) {
        $pdo->exec("ALTER TABLE `mcc_chemical_param` DROP COLUMN `units`;");
        echo "Column 'units' successfully dropped from mcc_chemical_param.\n";
    } else {
        echo "Column 'units' is already dropped.\n";
    }

    $schema = $pdo->query("DESCRIBE `mcc_chemical_param`")->fetchAll(PDO::FETCH_ASSOC);
    echo "Current mcc_chemical_param structure:\n";
    print_r($schema);

} catch (Exception $e) {
    echo "Error: " . $e->getMessage() . "\n";
}
