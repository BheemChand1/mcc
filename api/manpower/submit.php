<?php
header("Access-Control-Allow-Origin: *");
header("Content-Type: application/json; charset=UTF-8");
header("Access-Control-Allow-Methods: POST, OPTIONS");
header("Access-Control-Max-Age: 3600");
header("Access-Control-Allow-Headers: Content-Type, Access-Control-Allow-Headers, Authorization, X-Requested-With");

if (($_SERVER['REQUEST_METHOD'] ?? 'GET') === 'OPTIONS') {
    http_response_code(200);
    exit();
}

require_once __DIR__ . '/../../connection.php';
global $pdo;

// Read JSON input or POST body
$rawInput = file_get_contents("php://input");
$data = json_decode($rawInput, true);
if (empty($data)) {
    $data = $_POST;
}

if (empty($data)) {
    http_response_code(400);
    echo json_encode([
        "status" => "error",
        "message" => "No submission payload received."
    ]);
    exit();
}

// Normalize single item or batch array of items
$items = [];
if (isset($data['items']) && is_array($data['items'])) {
    $items = $data['items'];
} elseif (isset($data[0]) && is_array($data[0])) {
    $items = $data;
} else {
    $items = [$data];
}

try {
    $insertStmt = $pdo->prepare("
        INSERT INTO mcc_manpower_log (
            station_id,
            category_id,
            report_date,
            shift_id,
            manpower_type_id,
            provided_qty,
            absent_qty,
            no_dress_qty,
            no_ppe_qty,
            auditor_name
        ) VALUES (
            :station_id,
            :category_id,
            :report_date,
            :shift_id,
            :manpower_type_id,
            :provided_qty,
            :absent_qty,
            :no_dress_qty,
            :no_ppe_qty,
            :auditor_name
        )
        ON DUPLICATE KEY UPDATE
            category_id = VALUES(category_id),
            provided_qty = VALUES(provided_qty),
            absent_qty = VALUES(absent_qty),
            no_dress_qty = VALUES(no_dress_qty),
            no_ppe_qty = VALUES(no_ppe_qty),
            auditor_name = VALUES(auditor_name)
    ");

    $shiftCategoryCache = [];
    $processedCount = 0;
    $pdo->beginTransaction();

    foreach ($items as $item) {
        $stationId = isset($item['station_id']) ? intval($item['station_id']) : 0;
        $shiftId   = isset($item['shift_id']) ? intval($item['shift_id']) : 0;
        $typeId    = isset($item['manpower_type_id']) ? intval($item['manpower_type_id']) : 0;

        if ($stationId <= 0 || $shiftId <= 0 || $typeId <= 0) {
            continue;
        }

        // Resolve category_id
        $categoryId = isset($item['category_id']) ? intval($item['category_id']) : 0;
        if ($categoryId <= 0) {
            if (!isset($shiftCategoryCache[$shiftId])) {
                $cStmt = $pdo->prepare("SELECT category_id FROM mcc_manpower_shifts WHERE id = :sid");
                $cStmt->execute(['sid' => $shiftId]);
                $shiftCategoryCache[$shiftId] = intval($cStmt->fetchColumn() ?: 0);
            }
            $categoryId = $shiftCategoryCache[$shiftId];
        }

        $reportDate = isset($item['date']) && !empty($item['date'])
            ? trim($item['date'])
            : (isset($item['report_date']) && !empty($item['report_date']) ? trim($item['report_date']) : date('Y-m-d'));

        // Quantities
        $providedQty = isset($item['provided_qty'])
            ? intval($item['provided_qty'])
            : (isset($item['provided']) ? intval($item['provided']) : (isset($item['target']) ? intval($item['target']) : 0));

        $absentQty = isset($item['absent_qty'])
            ? intval($item['absent_qty'])
            : (isset($item['absent']) ? intval($item['absent']) : 0);

        $noDressQty = isset($item['found_without_dress_and_id_cards'])
            ? intval($item['found_without_dress_and_id_cards'])
            : (isset($item['no_dress_qty']) ? intval($item['no_dress_qty']) : 0);

        $noPpeQty = isset($item['found_without_protective_gears'])
            ? intval($item['found_without_protective_gears'])
            : (isset($item['no_ppe_qty']) ? intval($item['no_ppe_qty']) : 0);

        $auditorName = isset($item['auditor_name']) && !empty($item['auditor_name'])
            ? trim($item['auditor_name'])
            : null;

        $insertStmt->execute([
            'station_id'       => $stationId,
            'category_id'      => $categoryId,
            'report_date'      => $reportDate,
            'shift_id'         => $shiftId,
            'manpower_type_id' => $typeId,
            'provided_qty'     => $providedQty,
            'absent_qty'       => $absentQty,
            'no_dress_qty'     => $noDressQty,
            'no_ppe_qty'       => $noPpeQty,
            'auditor_name'     => $auditorName
        ]);

        $processedCount++;
    }

    $pdo->commit();

    if ($processedCount === 0) {
        http_response_code(400);
        echo json_encode([
            "status" => "error",
            "message" => "No valid manpower log records could be processed. Please check station_id, shift_id, and manpower_type_id."
        ]);
        exit();
    }

    http_response_code(200);
    echo json_encode([
        "status"          => "success",
        "message"         => "Manpower attendance logs submitted successfully.",
        "processed_count" => $processedCount
    ], JSON_UNESCAPED_SLASHES | JSON_PRETTY_PRINT);

} catch (Exception $e) {
    if ($pdo->inTransaction()) {
        $pdo->rollBack();
    }
    http_response_code(500);
    echo json_encode([
        "status"  => "error",
        "message" => "Database error: " . $e->getMessage()
    ]);
}
