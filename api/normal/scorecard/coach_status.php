<?php
header("Access-Control-Allow-Origin: *");
header("Content-Type: application/json; charset=UTF-8");
header("Access-Control-Allow-Methods: GET, POST");
header("Access-Control-Max-Age: 3600");
header("Access-Control-Allow-Headers: Content-Type, Access-Control-Allow-Headers, Authorization, X-Requested-With");

require_once '../../../connection.php';
global $pdo;

// Support both POST (JSON or urlencoded) and GET
$data = json_decode(file_get_contents("php://input"), true);
if (empty($data)) {
    $data = array_merge($_POST, $_GET);
}

$tokenId = isset($data['token_id']) ? trim($data['token_id']) : null;
$trainNo = isset($data['train_no']) ? trim($data['train_no']) : null;

if (empty($tokenId) || empty($trainNo)) {
    http_response_code(400);
    echo json_encode([
        "status" => "error",
        "message" => "token_id and train_no are both required parameters."
    ]);
    exit();
}

try {
    // Query coach completion counts
    $stmt = $pdo->prepare("
        SELECT coach_no, 
               SUM(CASE WHEN score_value IS NULL OR score_value = '' THEN 1 ELSE 0 END) AS empty_count,
               COUNT(*) AS total_count
        FROM mcc_normal_scorecard_report
        WHERE token_id = :token_id AND train_no = :train_no
        GROUP BY coach_no
        ORDER BY coach_no ASC
    ");
    $stmt->execute([
        'token_id' => $tokenId,
        'train_no' => $trainNo
    ]);
    $rows = $stmt->fetchAll(PDO::FETCH_ASSOC);

    if (empty($rows)) {
        http_response_code(404);
        echo json_encode([
            "status" => "error",
            "message" => "No scorecard records found for the given token_id and train_no."
        ]);
        exit();
    }

    $coachesStatus = [];
    foreach ($rows as $row) {
        $coachesStatus[] = [
            "coach_no" => $row['coach_no'],
            "status" => intval($row['empty_count']) === 0 ? 1 : 0
        ];
    }

    http_response_code(200);
    echo json_encode([
        "status" => "success",
        "meta" => [
            "token_id" => $tokenId,
            "train_no" => $trainNo
        ],
        "coaches" => $coachesStatus
    ]);

} catch (Exception $e) {
    http_response_code(500);
    echo json_encode([
        "status" => "error",
        "message" => "Database error: " . $e->getMessage()
    ]);
}
