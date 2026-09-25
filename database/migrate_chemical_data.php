<?php
/**
 * Data Migration Script for Unified Chemical Module
 * Migrates data from 6 individual chemical modules to the unified tables:
 * - mcc_chemical_param (deduplicated master chemicals per station)
 * - mcc_chemical_param_type_map (mapping chemical to cleaning types)
 * - mcc_chemical_target (historical & active targets per type)
 * - mcc_chemical_report (all audit consumption records per type)
 */

require_once __DIR__ . '/../connection.php';

$modules = [
    [
        'type_id' => 1,
        'code' => 'normal',
        'param_table' => 'mcc_normal_chemical_param',
        'target_table' => 'mcc_normal_chemical_target',
        'report_table' => 'mcc_normal_chemical_report',
        'has_shift' => false
    ],
    [
        'type_id' => 2,
        'code' => 'intensive',
        'param_table' => 'mcc_intensive_chemical_param',
        'target_table' => 'mcc_intensive_chemical_target',
        'report_table' => 'mcc_intensive_chemical_report',
        'has_shift' => false
    ],
    [
        'type_id' => 3,
        'code' => 'pantry',
        'param_table' => 'mcc_intensive_pantry_chemical_param',
        'target_table' => 'mcc_intensive_pantry_chemical_target',
        'report_table' => 'mcc_intensive_pantry_chemical_report',
        'has_shift' => false
    ],
    [
        'type_id' => 4,
        'code' => 'prt',
        'param_table' => 'mcc_prt_chemical_param',
        'target_table' => 'mcc_prt_chemical_target',
        'report_table' => 'mcc_prt_chemical_report',
        'has_shift' => false
    ],
    [
        'type_id' => 5,
        'code' => 'vb',
        'param_table' => 'mcc_vb_chemical_param',
        'target_table' => 'mcc_vb_chemical_target',
        'report_table' => 'mcc_vb_chemical_report',
        'has_shift' => false
    ],
    [
        'type_id' => 6,
        'code' => 'dc',
        'param_table' => 'dc_mcc_chemical_param',
        'target_table' => 'dc_mcc_chemical_target',
        'report_table' => 'dc_mcc_chemical_report',
        'has_shift' => true
    ]
];

echo "Starting Unified Chemical Data Migration...\n";

try {
    // Disable foreign key checks during migration for smooth population
    $pdo->exec("SET FOREIGN_KEY_CHECKS = 0;");
    
    // Clear unified tables before fresh migration
    $pdo->exec("TRUNCATE TABLE mcc_chemical_report;");
    $pdo->exec("TRUNCATE TABLE mcc_chemical_target;");
    $pdo->exec("TRUNCATE TABLE mcc_chemical_param_type_map;");
    $pdo->exec("TRUNCATE TABLE mcc_chemical_param;");

    $totalParamsMigrated = 0;
    $totalMapsMigrated = 0;
    $totalTargetsMigrated = 0;
    $totalReportsMigrated = 0;

    foreach ($modules as $mod) {
        $typeId = $mod['type_id'];
        $typeCode = $mod['code'];
        echo "\nProcessing Module: {$typeCode} (Type ID: {$typeId})...\n";

        // 1. Process Parameters
        $oldParamMap = []; // old_id => new_master_id
        $oldParamsStmt = $pdo->query("SELECT * FROM `{$mod['param_table']}`");
        $oldParams = $oldParamsStmt->fetchAll(PDO::FETCH_ASSOC);

        foreach ($oldParams as $op) {
            $stationId = (int)$op['station_id'];
            $name = trim($op['name']);
            $units = trim($op['units'] ?? 'ml');

            // Find or create master param for this station
            $findStmt = $pdo->prepare("SELECT id FROM mcc_chemical_param WHERE station_id = ? AND LOWER(TRIM(name)) = LOWER(?) LIMIT 1");
            $findStmt->execute([$stationId, $name]);
            $existing = $findStmt->fetch(PDO::FETCH_ASSOC);

            if ($existing) {
                $masterParamId = (int)$existing['id'];
            } else {
                $insertParamStmt = $pdo->prepare("INSERT INTO mcc_chemical_param (station_id, name, units, status, created_at) VALUES (?, ?, ?, 'Active', ?)");
                $insertParamStmt->execute([$stationId, $name, $units, $op['created_at'] ?? date('Y-m-d H:i:s')]);
                $masterParamId = (int)$pdo->lastInsertId();
                $totalParamsMigrated++;
            }

            $oldParamMap[$op['id']] = $masterParamId;

            // Map param to this chemical type
            $insertMapStmt = $pdo->prepare("
                INSERT INTO mcc_chemical_param_type_map (station_id, parameter_id, chemical_type_id, status)
                VALUES (?, ?, ?, 'Active')
                ON DUPLICATE KEY UPDATE status = 'Active'
            ");
            $insertMapStmt->execute([$stationId, $masterParamId, $typeId]);
            $totalMapsMigrated++;
        }

        echo " - Parameters processed: " . count($oldParams) . " (Unique Master created/linked)\n";

        // 2. Process Targets
        $oldTargetStmt = $pdo->query("SELECT * FROM `{$mod['target_table']}`");
        $oldTargets = $oldTargetStmt->fetchAll(PDO::FETCH_ASSOC);

        $insertTargetStmt = $pdo->prepare("
            INSERT INTO mcc_chemical_target 
            (station_id, chemical_type_id, parameter_id, `qty(ml)`, penalty, `penalty_qty(ml)`, effective_from, effective_to, target_month, created_at, updated_at)
            VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
        ");

        foreach ($oldTargets as $ot) {
            $oldParamId = $ot['parameter_id'];
            $masterParamId = $oldParamMap[$oldParamId] ?? null;

            if (!$masterParamId) {
                echo " [WARN] Missing master param for target ID: {$ot['id']}, old_param: {$oldParamId}\n";
                continue;
            }

            $stationId = (int)$ot['station_id'];
            $qty = $ot['qty(ml)'] ?? null;
            $penalty = $ot['penalty'] ?? null;
            $penaltyQty = $ot['penalty_qty(ml)'] ?? null;
            $effectiveFrom = !empty($ot['effective_from']) ? $ot['effective_from'] : date('Y-m-d');
            $effectiveTo = !empty($ot['effective_to']) ? $ot['effective_to'] : null;
            $targetMonth = !empty($ot['target_month']) ? $ot['target_month'] : null;
            $createdAt = $ot['created_at'] ?? date('Y-m-d H:i:s');
            $updatedAt = $ot['updated_at'] ?? date('Y-m-d H:i:s');

            $insertTargetStmt->execute([
                $stationId, $typeId, $masterParamId, $qty, $penalty, $penaltyQty, 
                $effectiveFrom, $effectiveTo, $targetMonth, $createdAt, $updatedAt
            ]);
            $totalTargetsMigrated++;
        }
        echo " - Targets migrated: " . count($oldTargets) . "\n";

        // 3. Process Reports
        $oldRepStmt = $pdo->query("SELECT * FROM `{$mod['report_table']}`");
        $oldReports = $oldRepStmt->fetchAll(PDO::FETCH_ASSOC);

        $insertRepStmt = $pdo->prepare("
            INSERT INTO mcc_chemical_report
            (station_id, chemical_type_id, parameter_id, train_no, coach_no, shift_id, qty_used, auditor_name, audit_by, token_id, report_date, isApproved, created_at, updated_at)
            VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
        ");

        foreach ($oldReports as $rep) {
            $oldParamId = $rep['parameter_id'];
            $masterParamId = $oldParamMap[$oldParamId] ?? null;

            if (!$masterParamId) {
                echo " [WARN] Missing master param for report ID: {$rep['id']}, old_param: {$oldParamId}\n";
                continue;
            }

            $stationId = (int)$rep['station_id'];
            $trainNo = $rep['train_no'] ?? null;
            $coachNo = $rep['coach_no'] ?? null;
            $shiftId = $rep['shift_id'] ?? null;
            $qtyUsed = $rep['qty_used'] ?? 0;
            $auditorName = $rep['auditor_name'] ?? null;
            $auditBy = $rep['audit_by'] ?? null;
            $tokenId = $rep['token_id'] ?? '';
            $reportDate = $rep['report_date'] ?? date('Y-m-d');
            $isApproved = (int)($rep['isApproved'] ?? 0);
            $createdAt = $rep['created_at'] ?? date('Y-m-d H:i:s');
            $updatedAt = $rep['updated_at'] ?? date('Y-m-d H:i:s');

            $insertRepStmt->execute([
                $stationId, $typeId, $masterParamId, $trainNo, $coachNo, $shiftId,
                $qtyUsed, $auditorName, $auditBy, $tokenId, $reportDate, $isApproved,
                $createdAt, $updatedAt
            ]);
            $totalReportsMigrated++;
        }
        echo " - Reports migrated: " . count($oldReports) . "\n";
    }

    $pdo->exec("SET FOREIGN_KEY_CHECKS = 1;");

    echo "\n============================================\n";
    echo "Migration Complete Successfully!\n";
    echo "Total Master Parameters Created: {$totalParamsMigrated}\n";
    echo "Total Type Mappings Created: {$totalMapsMigrated}\n";
    echo "Total Targets Migrated: {$totalTargetsMigrated}\n";
    echo "Total Reports Migrated: {$totalReportsMigrated}\n";
    echo "============================================\n";

} catch (Exception $e) {
    echo "\n[ERROR] Migration failed: " . $e->getMessage() . "\n";
    exit(1);
}
