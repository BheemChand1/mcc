<?php
/**
 * Fast & Robust API to submit Photo Attendance (IN / OUT)
 * Endpoint: /api/photo_attendence/submit_photo_attendence.php
 * Method: POST
 * 
 * FormData parameters:
 *   - station_id (required): Integer
 *   - employee_id (required): String
 *   - employee_name: String
 *   - attendance (required): 'in' or 'out'
 *   - process_name: String (e.g. 'Normal Cleaning')
 *   - latitude: Float/String
 *   - longitude: Float/String
 *   - address: String
 *   - photo: File (multipart/form-data)
 */

header("Access-Control-Allow-Origin: *");
header("Content-Type: application/json; charset=UTF-8");
header("Access-Control-Allow-Methods: POST, OPTIONS");
header("Access-Control-Allow-Headers: Content-Type, Access-Control-Allow-Headers, Authorization, X-Requested-With");

// Handle preflight OPTIONS request
if (isset($_SERVER['REQUEST_METHOD']) && $_SERVER['REQUEST_METHOD'] === 'OPTIONS') {
    http_response_code(200);
    exit();
}

if ($_SERVER['REQUEST_METHOD'] !== 'POST') {
    http_response_code(405);
    echo json_encode([
        "status" => "error",
        "status_code" => 405,
        "message" => "POST method required."
    ]);
    exit();
}

require_once __DIR__ . '/../../connection.php';
global $pdo;

// Extract input from $_POST or raw JSON fallback
$data = $_POST;
if (empty($data)) {
    $rawInput = file_get_contents("php://input");
    if (!empty($rawInput)) {
        $json = json_decode($rawInput, true);
        if (is_array($json)) {
            $data = $json;
        }
    }
}

$stationId    = isset($data['station_id']) ? intval($data['station_id']) : 0;
$employeeId   = isset($data['employee_id']) ? trim($data['employee_id']) : '';
$employeeName = isset($data['employee_name']) ? trim($data['employee_name']) : '';
$attendance   = isset($data['attendance']) ? strtolower(trim($data['attendance'])) : '';
$processName  = isset($data['process_name']) && !empty(trim($data['process_name'])) ? trim($data['process_name']) : 'Normal Cleaning';
$latitude     = isset($data['latitude']) && $data['latitude'] !== '' ? floatval($data['latitude']) : null;
$longitude    = isset($data['longitude']) && $data['longitude'] !== '' ? floatval($data['longitude']) : null;
$address      = isset($data['address']) ? trim($data['address']) : '';

// Validation
if ($stationId <= 0 || empty($employeeId) || empty($attendance)) {
    http_response_code(400);
    echo json_encode([
        "status" => "error",
        "status_code" => 400,
        "message" => "station_id, employee_id, and attendance ('in' or 'out') are required."
    ]);
    exit();
}

if ($attendance !== 'in' && $attendance !== 'out') {
    http_response_code(400);
    echo json_encode([
        "status" => "error",
        "status_code" => 400,
        "message" => "attendance must be either 'in' or 'out'."
    ]);
    exit();
}

// Ensure upload directory exists
$uploadDir = realpath(__DIR__ . '/../../') . DIRECTORY_SEPARATOR . 'attendence_photo' . DIRECTORY_SEPARATOR;
if (!is_dir($uploadDir)) {
    mkdir($uploadDir, 0777, true);
}

// Handle Photo Upload
$photoDbPath = null;

if (isset($_FILES['photo']) && $_FILES['photo']['error'] === UPLOAD_ERR_OK) {
    $tmpName = $_FILES['photo']['tmp_name'];
    $origName = $_FILES['photo']['name'];
    $ext = strtolower(pathinfo($origName, PATHINFO_EXTENSION));
    if (empty($ext) || !in_array($ext, ['webp', 'jpg', 'jpeg', 'png'])) {
        $ext = 'webp';
    }

    $cleanEmpId = preg_replace('/[^a-zA-Z0-9_-]/', '', $employeeId);
    $uniqueFileName = $attendance . '_' . $cleanEmpId . '_' . date('Ymd_His') . '_' . bin2hex(random_bytes(4)) . '.' . $ext;
    $targetPath = $uploadDir . $uniqueFileName;

    if (move_uploaded_file($tmpName, $targetPath)) {
        $photoDbPath = 'attendence_photo/' . $uniqueFileName;
    }
} elseif (!empty($data['photo']) && is_string($data['photo'])) {
    // Handle base64 encoded photo if passed via JSON or string
    $photoData = $data['photo'];
    $ext = 'webp';
    if (preg_match('/^data:image\/(\w+);base64,/', $photoData, $matches)) {
        $ext = strtolower($matches[1]);
        $photoData = substr($photoData, strpos($photoData, ',') + 1);
    }
    $decodedData = base64_decode($photoData);
    if ($decodedData !== false) {
        $cleanEmpId = preg_replace('/[^a-zA-Z0-9_-]/', '', $employeeId);
        $uniqueFileName = $attendance . '_' . $cleanEmpId . '_' . date('Ymd_His') . '_' . bin2hex(random_bytes(4)) . '.' . $ext;
        $targetPath = $uploadDir . $uniqueFileName;
        if (file_put_contents($targetPath, $decodedData)) {
            $photoDbPath = 'attendence_photo/' . $uniqueFileName;
        }
    }
}

try {
    $now = date('Y-m-d H:i:s');
    $today = date('Y-m-d');
    $attendanceId = null;

    if ($attendance === 'in') {
        // Punch IN: Insert new record
        $stmt = $pdo->prepare("
            INSERT INTO mcc_photo_attendance (
                station_id,
                employee_id,
                employee_name,
                attendance_date,
                process,
                in_time,
                in_lat,
                in_long,
                in_location,
                in_photo,
                created_at,
                updated_at
            ) VALUES (
                :station_id,
                :employee_id,
                :employee_name,
                :attendance_date,
                :process,
                :in_time,
                :in_lat,
                :in_long,
                :in_location,
                :in_photo,
                :created_at,
                :updated_at
            )
        ");

        $stmt->execute([
            ':station_id'       => $stationId,
            ':employee_id'      => $employeeId,
            ':employee_name'    => $employeeName,
            ':attendance_date'  => $today,
            ':process'          => $processName,
            ':in_time'          => $now,
            ':in_lat'           => $latitude,
            ':in_long'          => $longitude,
            ':in_location'      => $address,
            ':in_photo'         => $photoDbPath,
            ':created_at'       => $now,
            ':updated_at'       => $now
        ]);

        $attendanceId = intval($pdo->lastInsertId());

    } else {
        // Punch OUT: Find latest open punch IN record for this employee
        $findStmt = $pdo->prepare("
            SELECT id FROM mcc_photo_attendance 
            WHERE employee_id = :employee_id AND out_time IS NULL 
            ORDER BY id DESC 
            LIMIT 1
        ");
        $findStmt->execute([':employee_id' => $employeeId]);
        $openRecord = $findStmt->fetch(PDO::FETCH_ASSOC);

        if ($openRecord) {
            // Update existing open record with OUT details
            $attendanceId = intval($openRecord['id']);
            $updateStmt = $pdo->prepare("
                UPDATE mcc_photo_attendance SET 
                    out_time     = :out_time,
                    out_lat      = :out_lat,
                    out_long     = :out_long,
                    out_location = :out_location,
                    out_photo    = :out_photo,
                    updated_at   = :updated_at
                WHERE id = :id
            ");

            $updateStmt->execute([
                ':out_time'     => $now,
                ':out_lat'      => $latitude,
                ':out_long'     => $longitude,
                ':out_location' => $address,
                ':out_photo'    => $photoDbPath,
                ':updated_at'   => $now,
                ':id'           => $attendanceId
            ]);
        } else {
            // No open IN record found; create record with OUT punch directly
            $stmt = $pdo->prepare("
                INSERT INTO mcc_photo_attendance (
                    station_id,
                    employee_id,
                    employee_name,
                    attendance_date,
                    process,
                    out_time,
                    out_lat,
                    out_long,
                    out_location,
                    out_photo,
                    created_at,
                    updated_at
                ) VALUES (
                    :station_id,
                    :employee_id,
                    :employee_name,
                    :attendance_date,
                    :process,
                    :out_time,
                    :out_lat,
                    :out_long,
                    :out_location,
                    :out_photo,
                    :created_at,
                    :updated_at
                )
            ");

            $stmt->execute([
                ':station_id'       => $stationId,
                ':employee_id'      => $employeeId,
                ':employee_name'    => $employeeName,
                ':attendance_date'  => $today,
                ':process'          => $processName,
                ':out_time'         => $now,
                ':out_lat'          => $latitude,
                ':out_long'         => $longitude,
                ':out_location'     => $address,
                ':out_photo'        => $photoDbPath,
                ':created_at'       => $now,
                ':updated_at'       => $now
            ]);

            $attendanceId = intval($pdo->lastInsertId());
        }
    }

    // Success response with status code
    http_response_code(200);
    echo json_encode([
        "status"        => "success",
        "status_code"   => 200,
        "message"       => "Punch " . strtoupper($attendance) . " recorded successfully.",
        "attendance"    => $attendance,
        "attendance_id" => $attendanceId,
        "photo"         => $photoDbPath
    ]);

} catch (PDOException $e) {
    http_response_code(500);
    echo json_encode([
        "status"      => "error",
        "status_code" => 500,
        "message"     => "Database error: " . $e->getMessage()
    ]);
}
