<?php
/**
 * Auditor Dashboard - Session & Authentication Bootstrap
 * Scoped specifically for logged-in auditors.
 */
require_once __DIR__ . '/../connection.php';

if (session_status() === PHP_SESSION_NONE) {
    session_start();
}

if (!isset($_SESSION['user_id'])) {
    header("Location: ../index.php");
    exit();
}

$auditorId = intval($_SESSION['user_id']);
$stationId = intval($_SESSION['station_id'] ?? 1);
$userRole = strtoupper($_SESSION['role'] ?? 'AUDITOR');
$auditorName = $_SESSION['user_name'] ?? ($_SESSION['username'] ?? 'Auditor');
$auditorUsername = $_SESSION['username'] ?? '';

// Fetch station, division, zone (railway) and contractor details dynamically
$stationStmt = $pdo->prepare("
    SELECT 
        s.station_name, 
        s.contractor_name,
        d.division_name, 
        z.zone_name 
    FROM mcc_stations s
    LEFT JOIN mcc_divisions d ON s.division_id = d.division_id
    LEFT JOIN mcc_zones z ON d.zone_id = z.zone_id
    WHERE s.station_id = :station_id
");
$stationStmt->execute(['station_id' => $stationId]);
$stationDetails = $stationStmt->fetch();

$railwayName = strtoupper($stationDetails['zone_name'] ?? 'SOUTH WESTERN RAILWAY');
$divisionName = strtoupper($stationDetails['division_name'] ?? 'MYSORE');
$stationName = ucfirst($stationDetails['station_name'] ?? 'Mysore');
$contractorName = $stationDetails['contractor_name'] ?? 'Kingson Services';

/**
 * Helper to fetch digital signatures map by user_id
 */
function getAuditorSignatureMap($pdo) {
    static $map = null;
    if ($map !== null) {
        return $map;
    }
    $map = [];
    try {
        $stmt = $pdo->query("SELECT user_id, digital_signature FROM mcc_users WHERE digital_signature IS NOT NULL AND digital_signature != ''");
        while ($row = $stmt->fetch(PDO::FETCH_ASSOC)) {
            $map[intval($row['user_id'])] = $row['digital_signature'];
        }
    } catch (Exception $e) {}
    return $map;
}

function resolveAuditorSignature($pdo, $auditBy = null, $fallbackName = '') {
    if (empty($pdo)) {
        return null;
    }
    if (!empty($auditBy) && is_numeric($auditBy) && intval($auditBy) > 0) {
        $map = getAuditorSignatureMap($pdo);
        $uid = intval($auditBy);
        if (isset($map[$uid])) {
            return $map[$uid];
        }
    }
    return null;
}

/**
 * Helper to fetch station CDO's digital signature
 */
function getStationCdoSignature($pdo, $stationId) {
    static $cdoSigMap = [];
    if (isset($cdoSigMap[$stationId])) {
        return $cdoSigMap[$stationId];
    }
    $sig = null;
    try {
        $stmt = $pdo->prepare("
            SELECT digital_signature 
            FROM mcc_users 
            WHERE station_id = :station_id AND role = 'CDO' AND digital_signature IS NOT NULL AND digital_signature != ''
            ORDER BY user_id ASC
            LIMIT 1
        ");
        $stmt->execute(['station_id' => $stationId]);
        $sig = $stmt->fetchColumn() ?: null;
    } catch (Exception $e) {}
    $cdoSigMap[$stationId] = $sig;
    return $sig;
}

$cdoSignature = getStationCdoSignature($pdo, $stationId);
?>
