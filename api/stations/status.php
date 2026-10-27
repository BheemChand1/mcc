<?php
/**
 * Station Mobile Backend Status API
 * 
 * Endpoint: /api/stations/status.php
 * Methods: GET, POST
 * 
 * Parameters (query string, form POST, or JSON body):
 *   - station_id (optional): Integer ID of the station to check
 *   - user_id (optional): Integer ID of user to check associated station status
 * 
 * Response:
 *   If station_id or user_id provided:
 *     Returns single station status with `active_backend_mobile` (0 or 1)
 *   If no parameter provided:
 *     Returns array of all stations with their `active_backend_mobile` (0 or 1)
 */

header("Access-Control-Allow-Origin: *");
header("Content-Type: application/json; charset=UTF-8");
header("Access-Control-Allow-Methods: GET, POST, OPTIONS");
header("Access-Control-Max-Age: 3600");
header("Access-Control-Allow-Headers: Content-Type, Access-Control-Allow-Headers, Authorization, X-Requested-With");

if (($_SERVER['REQUEST_METHOD'] ?? 'GET') === 'OPTIONS') {
    http_response_code(200);
    exit();
}

require_once __DIR__ . '/../../connection.php';
global $pdo;

// Parse input from JSON body, POST, or GET
$rawInput = file_get_contents("php://input");
$input = json_decode($rawInput, true);
if (!is_array($input)) {
    $input = [];
}
$data = array_merge($_GET, $_POST, $input);

$stationId = isset($data['station_id']) ? intval($data['station_id']) : null;
$userId    = isset($data['user_id']) ? intval($data['user_id']) : null;

try {
    // If user_id is passed instead of station_id, resolve station_id from user
    if ((!$stationId || $stationId <= 0) && $userId && $userId > 0) {
        $userStmt = $pdo->prepare("SELECT station_id FROM mcc_users WHERE user_id = :uid LIMIT 1");
        $userStmt->execute([':uid' => $userId]);
        $userStation = $userStmt->fetch(PDO::FETCH_ASSOC);
        if ($userStation && !empty($userStation['station_id'])) {
            $stationId = intval($userStation['station_id']);
        }
    }

    if ($stationId && $stationId > 0) {
        // Fetch specific station
        $stmt = $pdo->prepare("
            SELECT 
                s.station_id,
                s.station_name,
                s.division_id,
                d.division_name,
                z.zone_name,
                s.status AS station_status,
                COALESCE(s.active_backend_mobile, 1) AS active_backend_mobile,
                s.updated_at
            FROM mcc_stations s
            LEFT JOIN mcc_divisions d ON s.division_id = d.division_id
            LEFT JOIN mcc_zones z ON d.zone_id = z.zone_id
            WHERE s.station_id = :station_id
            LIMIT 1
        ");
        $stmt->execute([':station_id' => $stationId]);
        $station = $stmt->fetch(PDO::FETCH_ASSOC);

        if (!$station) {
            http_response_code(404);
            echo json_encode([
                "status"  => "error",
                "message" => "Station not found for station_id: " . $stationId
            ], JSON_UNESCAPED_SLASHES | JSON_PRETTY_PRINT);
            exit();
        }

        $activeBackendMobile = intval($station['active_backend_mobile']);

        http_response_code(200);
        echo json_encode([
            "status"                => "success",
            "station_id"            => intval($station['station_id']),
            "station_name"          => $station['station_name'],
            "division_name"         => $station['division_name'],
            "zone_name"             => $station['zone_name'],
            "active_backend_mobile" => $activeBackendMobile, // 1 = Yes (Active), 0 = No (Inactive)
            "is_active"             => ($activeBackendMobile === 1),
            "message"               => ($activeBackendMobile === 1) 
                                        ? "Station backend mobile is active." 
                                        : "Station backend mobile is inactive."
        ], JSON_UNESCAPED_SLASHES | JSON_PRETTY_PRINT);
        exit();
    }

    // Otherwise, fetch all stations
    $stmt = $pdo->query("
        SELECT 
            s.station_id,
            s.station_name,
            s.division_id,
            d.division_name,
            z.zone_name,
            s.status AS station_status,
            COALESCE(s.active_backend_mobile, 1) AS active_backend_mobile,
            s.updated_at
        FROM mcc_stations s
        LEFT JOIN mcc_divisions d ON s.division_id = d.division_id
        LEFT JOIN mcc_zones z ON d.zone_id = z.zone_id
        ORDER BY s.station_name ASC
    ");
    $stations = $stmt->fetchAll(PDO::FETCH_ASSOC);

    $formattedStations = array_map(function($stn) {
        $activeBackendMobile = intval($stn['active_backend_mobile']);
        return [
            "station_id"            => intval($stn['station_id']),
            "station_name"          => $stn['station_name'],
            "division_name"         => $stn['division_name'],
            "zone_name"             => $stn['zone_name'],
            "station_status"        => $stn['station_status'],
            "active_backend_mobile" => $activeBackendMobile, // 1 = Yes, 0 = No
            "is_active"             => ($activeBackendMobile === 1)
        ];
    }, $stations);

    http_response_code(200);
    echo json_encode([
        "status"   => "success",
        "count"    => count($formattedStations),
        "stations" => $formattedStations
    ], JSON_UNESCAPED_SLASHES | JSON_PRETTY_PRINT);

} catch (Exception $e) {
    http_response_code(500);
    echo json_encode([
        "status"  => "error",
        "message" => "Database error: " . $e->getMessage()
    ], JSON_UNESCAPED_SLASHES | JSON_PRETTY_PRINT);
}
