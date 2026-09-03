<?php
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

// Support both POST (JSON or urlencoded) and GET
$data = json_decode(file_get_contents("php://input"), true);
if (empty($data)) {
    $data = array_merge($_POST, $_GET);
}

$stationId = isset($data['station_id']) ? intval($data['station_id']) : null;

// Manpower inspection and log parameters
$parameters = [
    [
        "id"             => 1,
        "parameter_id"   => 1,
        "parameter_name" => "Provided by contractor",
        "field_name"     => "provided_qty",
        "input_type"     => "number",
        "description"    => "Total manpower staff provided by the contractor for this shift",
        "is_required"    => true,
        "default_value"  => 0
    ],
    [
        "id"             => 2,
        "parameter_id"   => 2,
        "parameter_name" => "Found without dress code & ID cards",
        "field_name"     => "no_dress_qty",
        "input_type"     => "number",
        "description"    => "Number of staff found without uniform / dress code or valid ID cards",
        "is_required"    => false,
        "default_value"  => 0
    ],
    [
        "id"             => 3,
        "parameter_id"   => 3,
        "parameter_name" => "Found without protective gears",
        "field_name"     => "no_ppe_qty",
        "input_type"     => "number",
        "description"    => "Number of staff found working without mandatory PPE / protective safety gears",
        "is_required"    => false,
        "default_value"  => 0
    ],
    [
        "id"             => 4,
        "parameter_id"   => 4,
        "parameter_name" => "Absent",
        "field_name"     => "absent_qty",
        "input_type"     => "number",
        "description"    => "Number of staff absent from duty",
        "is_required"    => false,
        "default_value"  => 0
    ]
];

http_response_code(200);
echo json_encode([
    "status"     => "success",
    "station_id" => $stationId,
    "count"      => count($parameters),
    "parameters" => $parameters
], JSON_UNESCAPED_SLASHES | JSON_PRETTY_PRINT);
