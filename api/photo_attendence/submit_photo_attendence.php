<?php
/**
 * Fast & Robust API to submit Photo Attendance (IN / OUT)
 * Endpoint: /api/photo_attendence/submit_photo_attendence.php
 * Method: POST
 * 
 * FormData parameters:
 *   - station_id: Integer/String
 *   - employee_id: String (required)
 *   - employee_name: String
 *   - attendance: 'in' or 'out' (required)
 *   - process_name: String (e.g. 'Normal Cleaning')
 *   - latitude: Float/String
 *   - longitude: Float/String
 *   - address: String
 *   - photo: File (multipart/form-data)
 */

// Buffer all output to ensure no stray HTML or warnings can precede JSON
ob_start();

// Disable HTML error display for pure JSON responses
ini_set('display_errors', '0');
error_reporting(0);

// CORS Headers
header("Access-Control-Allow-Origin: *");
header("Content-Type: application/json; charset=UTF-8");
header("Access-Control-Allow-Methods: GET, POST, OPTIONS");
header("Access-Control-Allow-Headers: Content-Type, Access-Control-Allow-Headers, Authorization, X-Requested-With");

// Helper to safely send JSON and terminate
function sendJsonResponse($statusCode, $payload) {
    if (ob_get_length()) {
        ob_clean();
    }
    http_response_code($statusCode);
    echo json_encode($payload);
    exit();
}

// Handle preflight OPTIONS request
if (isset($_SERVER['REQUEST_METHOD']) && $_SERVER['REQUEST_METHOD'] === 'OPTIONS') {
    sendJsonResponse(200, ["status" => "success", "message" => "OK"]);
}

if (($_SERVER['REQUEST_METHOD'] ?? '') !== 'POST') {
    sendJsonResponse(405, [
        "status" => "error",
        "status_code" => 405,
        "message" => "POST method required."
    ]);
}

try {
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

    $stationId    = isset($data['station_id']) && intval($data['station_id']) > 0 ? intval($data['station_id']) : 1;
    $employeeId   = isset($data['employee_id']) ? trim($data['employee_id']) : '';
    $employeeName = isset($data['employee_name']) ? trim($data['employee_name']) : '';
    $attendance   = isset($data['attendance']) ? strtolower(trim($data['attendance'])) : 'in';
    $processName  = isset($data['process_name']) && !empty(trim($data['process_name'])) ? trim($data['process_name']) : 'Normal Cleaning';
    $latitude     = isset($data['latitude']) && $data['latitude'] !== '' ? floatval($data['latitude']) : null;
    $longitude    = isset($data['longitude']) && $data['longitude'] !== '' ? floatval($data['longitude']) : null;
    $address      = isset($data['address']) ? trim($data['address']) : '';

    // Validation
    if (empty($employeeId)) {
        sendJsonResponse(400, [
            "status" => "error",
            "status_code" => 400,
            "message" => "employee_id is required."
        ]);
    }

    if ($attendance !== 'in' && $attendance !== 'out') {
        $attendance = 'in';
    }

    // Ensure upload directory exists
    $uploadDir = realpath(__DIR__ . '/../../') . DIRECTORY_SEPARATOR . 'attendence_photo' . DIRECTORY_SEPARATOR;
    if (!is_dir($uploadDir)) {
        @mkdir($uploadDir, 0777, true);
    }

    // Helper function to compress and save image as WebP
    if (!function_exists('compressToWebp')) {
        function compressToWebp($sourcePath, $destinationPath, $quality = 75, $maxWidth = 1280, $isRawData = false) {
            if (!function_exists('imagewebp') || !function_exists('imagecreatefromstring')) {
                return false;
            }

            try {
                $imgData = $isRawData ? $sourcePath : @file_get_contents($sourcePath);
                if (empty($imgData)) {
                    return false;
                }

                $srcImg = @imagecreatefromstring($imgData);
                if (!$srcImg) {
                    return false;
                }

                $width = imagesx($srcImg);
                $height = imagesy($srcImg);

                // Auto-downscale large camera photos while preserving aspect ratio
                if ($maxWidth > 0 && $width > $maxWidth) {
                    $newWidth = $maxWidth;
                    $newHeight = (int)round(($height / $width) * $maxWidth);

                    $dstImg = imagecreatetruecolor($newWidth, $newHeight);

                    // Preserve transparency if PNG / WebP
                    imagealphablending($dstImg, false);
                    imagesavealpha($dstImg, true);

                    imagecopyresampled($dstImg, $srcImg, 0, 0, 0, 0, $newWidth, $newHeight, $width, $height);
                    imagedestroy($srcImg);
                    $srcImg = $dstImg;
                } else {
                    imagealphablending($srcImg, false);
                    imagesavealpha($srcImg, true);
                }

                // Compress and write WebP
                $saved = imagewebp($srcImg, $destinationPath, $quality);
                imagedestroy($srcImg);

                return $saved && file_exists($destinationPath) && filesize($destinationPath) > 0;
            } catch (Throwable $e) {
                return false;
            }
        }
    }

    // Handle Photo Upload with WebP Compression
    $photoDbPath = null;
    $cleanEmpId = preg_replace('/[^a-zA-Z0-9_-]/', '', $employeeId);
    $uniqueWebpName = $attendance . '_' . $cleanEmpId . '_' . date('Ymd_His') . '_' . bin2hex(random_bytes(4)) . '.webp';
    $targetPath = $uploadDir . $uniqueWebpName;

    if (isset($_FILES['photo']) && $_FILES['photo']['error'] === UPLOAD_ERR_OK) {
        $tmpName = $_FILES['photo']['tmp_name'];

        // Attempt WebP compression
        $compressed = compressToWebp($tmpName, $targetPath, 75, 1280, false);

        if ($compressed) {
            $photoDbPath = 'attendence_photo/' . $uniqueWebpName;
        } else {
            // Fallback: move raw file if compression fails
            $origName = $_FILES['photo']['name'];
            $ext = strtolower(pathinfo($origName, PATHINFO_EXTENSION)) ?: 'webp';
            $fallbackName = $attendance . '_' . $cleanEmpId . '_' . date('Ymd_His') . '_' . bin2hex(random_bytes(4)) . '.' . $ext;
            $fallbackPath = $uploadDir . $fallbackName;
            if (@move_uploaded_file($tmpName, $fallbackPath)) {
                $photoDbPath = 'attendence_photo/' . $fallbackName;
            }
        }
    } elseif (!empty($data['photo']) && is_string($data['photo'])) {
        // Handle base64 encoded photo if passed via JSON or string
        $photoData = $data['photo'];
        if (preg_match('/^data:image\/(\w+);base64,/', $photoData, $matches)) {
            $photoData = substr($photoData, strpos($photoData, ',') + 1);
        }
        $decodedData = base64_decode($photoData);
        if ($decodedData !== false) {
            // Attempt WebP compression on raw binary data
            $compressed = compressToWebp($decodedData, $targetPath, 75, 1280, true);

            if ($compressed) {
                $photoDbPath = 'attendence_photo/' . $uniqueWebpName;
            } else {
                // Fallback: save raw data
                if (@file_put_contents($targetPath, $decodedData)) {
                    $photoDbPath = 'attendence_photo/' . $uniqueWebpName;
                }
            }
        }
    }

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

    sendJsonResponse(200, [
        "status"        => "success",
        "status_code"   => 200,
        "message"       => "Punch " . strtoupper($attendance) . " recorded successfully.",
        "attendance"    => $attendance,
        "attendance_id" => $attendanceId,
        "photo"         => $photoDbPath
    ]);

} catch (Throwable $e) {
    sendJsonResponse(500, [
        "status"      => "error",
        "status_code" => 500,
        "message"     => "Server error: " . $e->getMessage()
    ]);
}
