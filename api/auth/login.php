<?php
header("Access-Control-Allow-Origin: *");
header("Content-Type: application/json; charset=UTF-8");
header("Access-Control-Allow-Methods: POST");
header("Access-Control-Max-Age: 3600");
header("Access-Control-Allow-Headers: Content-Type, Access-Control-Allow-Headers, Authorization, X-Requested-With");

require_once '../../connection.php';
global $pdo;

// Get posted data
$data = json_decode(file_get_contents("php://input"), true);

// Fallback to $_POST if JSON body is empty
if (empty($data)) {
    $data = $_POST;
}

$username = trim($data['username'] ?? '');
$password = $data['password'] ?? '';

if (empty($username) || empty($password)) {
    http_response_code(400);
    echo json_encode([
        "status" => "error",
        "message" => "Username and password are required."
    ]);
    exit();
}

try {
    // 1. Fetch user by username
    $stmt = $pdo->prepare("
        SELECT u.*, s.station_name 
        FROM mcc_users u
        LEFT JOIN mcc_stations s ON u.station_id = s.station_id
        WHERE u.username = :username 
        LIMIT 1
    ");
    $stmt->execute(['username' => $username]);
    $user = $stmt->fetch(PDO::FETCH_ASSOC);

    if (!$user) {
        http_response_code(401);
        echo json_encode([
            "status" => "error",
            "message" => "Invalid username or password."
        ]);
        exit();
    }

    if ($user['status'] !== 'Active') {
        http_response_code(403);
        echo json_encode([
            "status" => "error",
            "message" => "Your account is inactive. Please contact support."
        ]);
        exit();
    }

    if (strtoupper($user['role'] ?? '') !== 'AUDITOR') {
        http_response_code(403);
        echo json_encode([
            "status" => "error",
            "message" => "Access denied. Only users with AUDITOR role can log in."
        ]);
        exit();
    }

    // 2. Verify password (checks bcrypt hash)
    if (!password_verify($password, $user['password_hash'])) {
        http_response_code(401);
        echo json_encode([
            "status" => "error",
            "message" => "Invalid username or password."
        ]);
        exit();
    }

    // Login successful
    http_response_code(200);
    echo json_encode([
        "status" => "success",
        "message" => "Login successful.",
        "user_id" => intval($user['user_id']),
        "username" => $user['username'],
        "user_name" => $user['user_name'], // full name
        "email" => $user['email'],
        "role" => $user['role'],
        "station_id" => intval($user['station_id']),
        "station_name" => $user['station_name'] ?: "Not Assigned"
    ]);

} catch (Exception $e) {
    http_response_code(500);
    echo json_encode([
        "status" => "error",
        "message" => "Database error: " . $e->getMessage()
    ]);
}
