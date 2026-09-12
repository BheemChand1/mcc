<?php
/**
 * Surprise Visit Parameters & Ratings API
 * Endpoint: /api/surprise/parameters.php
 * Method: GET, POST
 * Parameters:
 *   - station_id (required): Integer
 *   - category (optional/required by app): String ('pit_office' | 'pf_trains')
 */

header("Access-Control-Allow-Origin: *");
header("Content-Type: application/json; charset=UTF-8");
header("Access-Control-Allow-Methods: GET, POST, OPTIONS");
header("Access-Control-Max-Age: 3600");
header("Access-Control-Allow-Headers: Content-Type, Access-Control-Allow-Headers, Authorization, X-Requested-With");

// Handle preflight OPTIONS request
if ($_SERVER['REQUEST_METHOD'] === 'OPTIONS') {
    http_response_code(200);
    exit();
}

require_once __DIR__ . '/../../connection.php';
global $pdo;

// Support both JSON body, POST and GET data
$rawInput = file_get_contents("php://input");
$data = json_decode($rawInput, true);
if (empty($data)) {
    $data = array_merge($_POST, $_GET);
}

$stationId = isset($data['station_id']) ? intval($data['station_id']) : null;
$category  = isset($data['category']) ? trim($data['category']) : null;

// Validate station_id
if ($stationId === null || $stationId <= 0) {
    http_response_code(400);
    echo json_encode([
        "status"  => "error",
        "message" => "station_id parameter is required and must be a valid positive integer."
    ]);
    exit();
}

try {
    // 1. Fetch ratings for the station (from mcc_surprise_ratings)
    $ratings = [];
    try {
        $ratingsStmt = $pdo->prepare("
            SELECT rating_value, rating_name 
            FROM mcc_surprise_ratings 
            WHERE station_id = :station_id 
            ORDER BY rating_value DESC
        ");
        $ratingsStmt->execute([':station_id' => $stationId]);
        $dbRatings = $ratingsStmt->fetchAll(PDO::FETCH_ASSOC);

        if (!empty($dbRatings)) {
            foreach ($dbRatings as $r) {
                $ratings[] = [
                    "rating_value" => intval($r['rating_value']),
                    "rating_name"  => $r['rating_name'],
                    "value"        => intval($r['rating_value']),
                    "label"        => $r['rating_value'] . ' - ' . $r['rating_name']
                ];
            }
        }
    } catch (Exception $e) {
        // Table or query fallback
    }

    // Default ratings fallback if table is empty or not seeded
    if (empty($ratings)) {
        $defaultRatings = [
            5 => 'Excellent / No shortage',
            4 => 'Very Good / 1-10% shortage',
            3 => 'Good / Partially available',
            2 => '11-20% shortage',
            1 => 'Average',
            0 => 'Poor / Not available / Shortage > 20%'
        ];
        foreach ($defaultRatings as $val => $name) {
            $ratings[] = [
                "rating_value" => $val,
                "rating_name"  => $name,
                "value"        => $val,
                "label"        => "$val - $name"
            ];
        }
    }

    // 2. Fetch parameters from mcc_surprise_parameters
    $queryParams = [':station_id' => $stationId];
    $sql = "
        SELECT 
            id, 
            id AS parameter_id, 
            category, 
            station_id, 
            item_name, 
            max_marks, 
            parameter_desc, 
            status 
        FROM mcc_surprise_parameters 
        WHERE station_id = :station_id 
          AND status = 'Active'
    ";

    // Normalize category if provided
    if (!empty($category) && $category !== 'all') {
        // Map common variations (e.g. 'pit-office' -> 'pit_office', 'pf-trains' -> 'pf_trains')
        $normalizedCategory = str_replace('-', '_', strtolower($category));
        $sql .= " AND category = :category";
        $queryParams[':category'] = $normalizedCategory;
    }

    $sql .= " ORDER BY id ASC";

    $paramsStmt = $pdo->prepare($sql);
    $paramsStmt->execute($queryParams);
    $paramRows = $paramsStmt->fetchAll(PDO::FETCH_ASSOC);

    // 3. Format parameters and attach ratings to each
    $parameters = [];
    foreach ($paramRows as $row) {
        $row['id']           = intval($row['id']);
        $row['parameter_id'] = intval($row['parameter_id']);
        $row['station_id']   = intval($row['station_id']);
        $row['max_marks']    = intval($row['max_marks']);
        $row['ratings']      = $ratings;
        $parameters[]        = $row;
    }

    http_response_code(200);
    echo json_encode([
        "status"           => "success",
        "station_id"       => $stationId,
        "category"         => $category ?? "all",
        "total_parameters" => count($parameters),
        "ratings"          => $ratings,
        "parameters"       => $parameters
    ]);

} catch (Exception $e) {
    http_response_code(500);
    echo json_encode([
        "status"  => "error",
        "message" => "Database error: " . $e->getMessage()
    ]);
}
?>
