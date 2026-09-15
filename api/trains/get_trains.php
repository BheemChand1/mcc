<?php
/**
 * Fast & Lightweight Trains & Coaches API
 * Endpoint: /api/trains/get_trains.php
 * Method: GET, POST
 * 
 * Parameters:
 *   - station_id (required): Integer
 */

header("Access-Control-Allow-Origin: *");
header("Content-Type: application/json; charset=UTF-8");
header("Access-Control-Allow-Methods: GET, POST, OPTIONS");
header("Access-Control-Allow-Headers: Content-Type, Access-Control-Allow-Headers, Authorization, X-Requested-With");

// Handle preflight OPTIONS request
if (isset($_SERVER['REQUEST_METHOD']) && $_SERVER['REQUEST_METHOD'] === 'OPTIONS') {
    http_response_code(200);
    exit();
}

require_once __DIR__ . '/../../connection.php';
global $pdo;

// Support JSON body, POST and GET data
$rawInput = file_get_contents("php://input");
$inputData = json_decode($rawInput, true);
if (empty($inputData)) {
    $inputData = array_merge($_POST, $_GET);
}

$stationId = isset($inputData['station_id']) ? intval($inputData['station_id']) : null;

if (!$stationId) {
    http_response_code(400);
    echo json_encode([
        "status"  => "error",
        "message" => "station_id parameter is required."
    ]);
    exit();
}

try {
    // 1. Fetch active trains for the station
    $trainStmt = $pdo->prepare("
        SELECT train_id, train_no 
        FROM mcc_trains 
        WHERE station_id = :station_id AND status = 'Active' 
        ORDER BY train_no ASC
    ");
    $trainStmt->execute([':station_id' => $stationId]);
    $trains = $trainStmt->fetchAll(PDO::FETCH_ASSOC);

    if (empty($trains)) {
        echo json_encode([
            "status" => "success",
            "data"   => []
        ]);
        exit();
    }

    // 2. Fetch coaches for all active trains
    $trainIds = array_column($trains, 'train_id');
    $inClause = implode(',', array_fill(0, count($trainIds), '?'));

    $coachStmt = $pdo->prepare("
        SELECT coach_id, train_id, coach_no 
        FROM mcc_coaches 
        WHERE train_id IN ($inClause) AND status = 'Active' 
        ORDER BY display_order ASC, coach_id ASC
    ");
    $coachStmt->execute($trainIds);
    $allCoaches = $coachStmt->fetchAll(PDO::FETCH_ASSOC);

    // Group coaches by train_id
    $coachesByTrain = [];
    foreach ($allCoaches as $coach) {
        $tId = $coach['train_id'];
        if (!isset($coachesByTrain[$tId])) {
            $coachesByTrain[$tId] = [];
        }
        $coachesByTrain[$tId][] = [
            "coach_id" => intval($coach['coach_id']),
            "coach_no" => $coach['coach_no']
        ];
    }

    // 3. Construct response
    $result = [];
    foreach ($trains as $tr) {
        $tId = $tr['train_id'];
        $result[] = [
            "train_id" => intval($tr['train_id']),
            "train_no" => $tr['train_no'],
            "coaches"  => isset($coachesByTrain[$tId]) ? $coachesByTrain[$tId] : []
        ];
    }

    echo json_encode([
        "status" => "success",
        "data"   => $result
    ]);

} catch (Exception $e) {
    http_response_code(500);
    echo json_encode([
        "status"  => "error",
        "message" => $e->getMessage()
    ]);
}
