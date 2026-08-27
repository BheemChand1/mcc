<?php
require_once '../connection.php';
global $pdo;

try {
    echo "<h2>Live Database Migration - Add train_no to mcc_normal_chemical_report</h2>";
    
    // Check if column already exists first to avoid error
    $check = $pdo->query("DESCRIBE mcc_normal_chemical_report");
    $exists = false;
    while ($r = $check->fetch(PDO::FETCH_ASSOC)) {
        if ($r['Field'] === 'train_no') {
            $exists = true;
            break;
        }
    }
    
    if (!$exists) {
        $pdo->exec("ALTER TABLE mcc_normal_chemical_report ADD COLUMN train_no varchar(50) NOT NULL AFTER token_id");
        echo "<p style='color: green;'><strong>Success:</strong> Column 'train_no' has been added to mcc_normal_chemical_report successfully.</p>";
    } else {
        echo "<p style='color: blue;'><strong>Notice:</strong> Column 'train_no' already exists in mcc_normal_chemical_report.</p>";
    }
    
    // Output current schema
    echo "<h3>Current Table Schema:</h3>";
    echo "<table border='1' cellpadding='5' style='border-collapse: collapse;'>";
    echo "<tr><th>Field</th><th>Type</th><th>Null</th><th>Default</th></tr>";
    $stmt = $pdo->query("DESCRIBE mcc_normal_chemical_report");
    while ($r = $stmt->fetch(PDO::FETCH_ASSOC)) {
        echo "<tr>";
        echo "<td>" . htmlspecialchars($r['Field']) . "</td>";
        echo "<td>" . htmlspecialchars($r['Type']) . "</td>";
        echo "<td>" . htmlspecialchars($r['Null']) . "</td>";
        echo "<td>" . htmlspecialchars($r['Default'] === null ? 'NULL' : $r['Default']) . "</td>";
        echo "</tr>";
    }
    echo "</table>";
    
} catch (Exception $e) {
    echo "<p style='color: red;'><strong>Error:</strong> " . htmlspecialchars($e->getMessage()) . "</p>";
}
