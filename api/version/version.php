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

try {
    // Fetch latest app version record
    $stmt = $pdo->prepare("
        SELECT id, version, created_at, updated_at 
        FROM app_version 
        ORDER BY id DESC 
        LIMIT 1
    ");
    $stmt->execute();
    $row = $stmt->fetch(PDO::FETCH_ASSOC);

    if ($row) {
        http_response_code(200);
        echo json_encode([
            "status"     => "success",
            "version"    => $row['version'],
            "data"       => [
                "id"         => intval($row['id']),
                "version"    => $row['version'],
                "created_at" => $row['created_at'],
                "updated_at" => $row['updated_at']
            ]
        ], JSON_UNESCAPED_SLASHES | JSON_PRETTY_PRINT);
    } else {
        http_response_code(404);
        echo json_encode([
            "status"  => "error",
            "message" => "App version not found."
        ]);
    }
} catch (Exception $e) {
    http_response_code(500);
    echo json_encode([
        "status"  => "error",
        "message" => "Database error: " . $e->getMessage()
    ]);
}
