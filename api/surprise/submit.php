<?php
/**
 * Surprise Visit Report Submission API
 * Endpoint: /api/surprise/submit.php
 * Method: POST
 *
 * Supported Payload:
 * {
 *   "auditor_name": "CDO",
 *   "category": "pit_office",
 *   "station_id": 4,
 *   "report_date": "2026-09-12", // optional (defaults to railway operating date/today)
 *   "token_id": "SV-PIT-CDO-001", // optional (auto-generated if omitted)
 *   "sub_parameters": [
 *       {"sub_parameter_id": 1, "value": 5},
 *       {"sub_parameter_id": 2, "value": 5},
 *       {"sub_parameter_id": 3, "value": 5},
 *       {"sub_parameter_id": 4, "value": 5},
 *       {"sub_parameter_id": 5, "value": 5},
 *       {"sub_parameter_id": 6, "value": 5}
 *   ]
 * }
 */

header("Access-Control-Allow-Origin: *");
header("Content-Type: application/json; charset=UTF-8");
header("Access-Control-Allow-Methods: POST, OPTIONS");
header("Access-Control-Max-Age: 3600");
header("Access-Control-Allow-Headers: Content-Type, Access-Control-Allow-Headers, Authorization, X-Requested-With");

// Handle preflight OPTIONS request
if ($_SERVER['REQUEST_METHOD'] === 'OPTIONS') {
    http_response_code(200);
    exit();
}

require_once __DIR__ . '/../../connection.php';
$railwayDateHelper = __DIR__ . '/../datetime_logic/railway_date.php';
if (file_exists($railwayDateHelper)) {
    require_once $railwayDateHelper;
}

global $pdo;

// Parse input (JSON body or POST)
$rawInput = file_get_contents("php://input");
$data = json_decode($rawInput, true);
if (empty($data)) {
    $data = $_POST;
}

// 1. Extract inputs
$stationId    = isset($data['station_id']) ? intval($data['station_id']) : null;
$category     = isset($data['category']) ? trim($data['category']) : null;
$auditorName  = !empty(trim($data['auditor_name'] ?? '')) ? trim($data['auditor_name']) : 'CDO';
$explicitDate = $data['report_date'] ?? ($data['date'] ?? null);

// Determine operating date
if (function_exists('getRailwayOperatingDate')) {
    $reportDate = getRailwayOperatingDate($explicitDate);
} else {
    $reportDate = (!empty($explicitDate) && preg_match('/^\d{4}-\d{2}-\d{2}$/', trim($explicitDate)))
        ? trim($explicitDate)
        : date('Y-m-d');
}

// 2. Validate essential inputs
if ($stationId === null || $stationId <= 0) {
    http_response_code(400);
    echo json_encode([
        "status"  => "error",
        "message" => "station_id parameter is required and must be a valid positive integer."
    ]);
    exit();
}

if (empty($category)) {
    http_response_code(400);
    echo json_encode([
        "status"  => "error",
        "message" => "category parameter is required (e.g., 'pit_office' or 'pf_trains')."
    ]);
    exit();
}

// Normalize category
$category = str_replace('-', '_', strtolower($category));

// 3. Extract sub_parameters / parameters list
$subParams = $data['sub_parameters'] ?? ($data['parameters'] ?? ($data['values'] ?? null));

if (empty($subParams) || !is_array($subParams)) {
    http_response_code(400);
    echo json_encode([
        "status"  => "error",
        "message" => "sub_parameters (or parameters) array is required and must not be empty."
    ]);
    exit();
}

try {
    // 4. Determine or generate unique token_id
    if (!empty($data['token_id'])) {
        $tokenId = trim($data['token_id']);
    } else {
        // Generate token based on category & auditor
        $prefix = ($category === 'pf_trains') ? 'SV-PF' : 'SV-PIT';
        $auditorTag = preg_replace('/[^A-Za-z0-9]/', '', strtoupper($auditorName));
        if (empty($auditorTag)) {
            $auditorTag = 'CDO';
        }
        $tokenPrefix = "{$prefix}-{$auditorTag}";

        // Get count of distinct tokens for this station, category, date
        $cntStmt = $pdo->prepare("
            SELECT COUNT(DISTINCT token_id) 
            FROM mcc_surprise_reports 
            WHERE station_id = :sid AND category = :cat AND report_date = :rdate
        ");
        $cntStmt->execute([
            ':sid'   => $stationId,
            ':cat'   => $category,
            ':rdate' => $reportDate
        ]);
        $seq = (int)$cntStmt->fetchColumn() + 1;
        $tokenId = sprintf("%s-%03d", $tokenPrefix, $seq);

        // Ensure token uniqueness
        $checkStmt = $pdo->prepare("SELECT COUNT(*) FROM mcc_surprise_reports WHERE token_id = ?");
        $checkStmt->execute([$tokenId]);
        while ((int)$checkStmt->fetchColumn() > 0) {
            $seq++;
            $tokenId = sprintf("%s-%03d", $tokenPrefix, $seq);
            $checkStmt->execute([$tokenId]);
        }
    }

    $pdo->beginTransaction();

    // Prepare existence check statement
    $checkRowStmt = $pdo->prepare("
        SELECT id FROM mcc_surprise_reports 
        WHERE token_id = :token_id 
          AND parameter_id = :parameter_id 
          AND station_id = :station_id
        LIMIT 1
    ");

    // Prepare update statement
    $updateStmt = $pdo->prepare("
        UPDATE mcc_surprise_reports 
        SET value = :value,
            auditor_name = :auditor_name,
            report_date = :report_date,
            category = :category,
            updated_at = NOW()
        WHERE id = :id
    ");

    // Prepare insert statement
    $insertStmt = $pdo->prepare("
        INSERT INTO mcc_surprise_reports (
            category,
            station_id,
            token_id,
            report_date,
            auditor_name,
            parameter_id,
            value,
            created_at,
            updated_at
        ) VALUES (
            :category,
            :station_id,
            :token_id,
            :report_date,
            :auditor_name,
            :parameter_id,
            :value,
            NOW(),
            NOW()
        )
    ");

    $processedCount = 0;
    $submittedItems = [];

    foreach ($subParams as $item) {
        $paramId = $item['sub_parameter_id'] ?? ($item['parameter_id'] ?? ($item['id'] ?? null));
        $val     = $item['value'] ?? ($item['score'] ?? ($item['rating_value'] ?? null));

        if ($paramId === null || $val === null) {
            continue;
        }

        $paramId = intval($paramId);
        $val     = intval($val);

        // Check if record exists for this token & parameter
        $checkRowStmt->execute([
            ':token_id'     => $tokenId,
            ':parameter_id' => $paramId,
            ':station_id'   => $stationId
        ]);
        $existingId = $checkRowStmt->fetchColumn();

        if ($existingId) {
            $updateStmt->execute([
                ':value'        => $val,
                ':auditor_name' => $auditorName,
                ':report_date'  => $reportDate,
                ':category'     => $category,
                ':id'           => $existingId
            ]);
        } else {
            $insertStmt->execute([
                ':category'     => $category,
                ':station_id'   => $stationId,
                ':token_id'     => $tokenId,
                ':report_date'  => $reportDate,
                ':auditor_name' => $auditorName,
                ':parameter_id' => $paramId,
                ':value'        => $val
            ]);
        }

        $processedCount++;
        $submittedItems[] = [
            "parameter_id" => $paramId,
            "value"        => $val
        ];
    }

    $pdo->commit();

    http_response_code(200);
    echo json_encode([
        "status"          => "success",
        "message"         => "Surprise audit report submitted successfully.",
        "token_id"        => $tokenId,
        "station_id"      => $stationId,
        "category"        => $category,
        "auditor_name"    => $auditorName,
        "report_date"     => $reportDate,
        "processed_count" => $processedCount,
        "items"           => $submittedItems
    ]);

} catch (Exception $e) {
    if ($pdo->inTransaction()) {
        $pdo->rollBack();
    }

    http_response_code(500);
    echo json_encode([
        "status"  => "error",
        "message" => "Database error during submission: " . $e->getMessage()
    ]);
}
?>
