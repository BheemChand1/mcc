<?php

header('Content-Type: application/json');

// =====================================================
// SECURITY
// =====================================================

// CHANGE THIS to your own random secret.
// Use the SAME key in your PC's config.json.
$API_KEY = '9412418709';

if ($_SERVER['REQUEST_METHOD'] !== 'POST') {
    http_response_code(405);
    echo json_encode([
        'ok' => false,
        'error' => 'POST required'
    ]);
    exit;
}

$receivedKey = $_SERVER['HTTP_X_API_KEY'] ?? '';

if (!hash_equals($API_KEY, $receivedKey)) {
    http_response_code(401);
    echo json_encode([
        'ok' => false,
        'error' => 'Unauthorized'
    ]);
    exit;
}


// =====================================================
// READ JSON
// =====================================================

$input = json_decode(file_get_contents('php://input'), true);

if (!is_array($input)) {
    http_response_code(400);
    echo json_encode([
        'ok' => false,
        'error' => 'Invalid JSON'
    ]);
    exit;
}


// =====================================================
// ATTENDANCE DATA
// =====================================================

$employeeCode = trim((string)($input['employee_code'] ?? ''));

$employeeName = isset($input['employee_name'])
    ? trim((string)$input['employee_name'])
    : null;
    
$punchTime = trim((string)($input['punch_time'] ?? ''));

$direction = isset($input['direction'])
    ? trim((string)$input['direction'])
    : null;

$deviceId = isset($input['device_id'])
    ? trim((string)$input['device_id'])
    : null;

$serialNumber = isset($input['serial_number'])
    ? trim((string)$input['serial_number'])
    : null;

$verificationMode = isset($input['verification_mode'])
    ? trim((string)$input['verification_mode'])
    : null;

$deviceName = isset($input['device_name'])
    ? trim((string)$input['device_name'])
    : null;


if ($employeeCode === '' || $punchTime === '') {
    http_response_code(400);

    echo json_encode([
        'ok' => false,
        'error' => 'employee_code and punch_time are required'
    ]);

    exit;
}


// =====================================================
// DATABASE
// =====================================================

$dbHost = 'localhost';
$dbName = 'mccbeatleanalyti_db';
$dbUser = 'mccbeatleanalyti_user';
$dbPass = 'Cee;[+&e$a+9rAXe';


try {

    $pdo = new PDO(
        "mysql:host=$dbHost;dbname=$dbName;charset=utf8mb4",
        $dbUser,
        $dbPass,
        [
            PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION,
            PDO::ATTR_DEFAULT_FETCH_MODE => PDO::FETCH_ASSOC
        ]
    );


    // =================================================
    // INSERT ATTENDANCE
    // =================================================

    $sql = "
        INSERT INTO attendance_logs
        (
            employee_code,
            employee_name,
            punch_time,
            direction,
            device_id,
            serial_number,
            verification_mode,
            device_name
        )
        VALUES
        (
            :employee_code,
            :employee_name,
            :punch_time,
            :direction,
            :device_id,
            :serial_number,
            :verification_mode,
            :device_name
        )
        ON DUPLICATE KEY UPDATE id = id
    ";


    $stmt = $pdo->prepare($sql);

    $stmt->execute([
        ':employee_code' => $employeeCode,
        ':employee_name' => $employeeName,
        ':punch_time' => $punchTime,
        ':direction' => $direction,
        ':device_id' => $deviceId,
        ':serial_number' => $serialNumber,
        ':verification_mode' => $verificationMode,
        ':device_name' => $deviceName
    ]);


    echo json_encode([
        'ok' => true
    ]);


} catch (Throwable $e) {

    http_response_code(500);

    echo json_encode([
        'ok' => false,
        'error' => 'Database error'
    ]);
}
?>