<?php
/**
 * CDO Dashboard - Session & Authentication Bootstrap
 * Centralizes database connection, session handling, and station metadata loading.
 */
require_once __DIR__ . '/../connection.php';

if (session_status() === PHP_SESSION_NONE) {
    session_start();
}

$stationId = $_SESSION['station_id'] ?? 1;

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

$userRole = strtoupper($_SESSION['role'] ?? 'CDO');
$isViewer = ($userRole === 'VIEWER');
$isCDO = ($userRole !== 'VIEWER');
$currentUserId = $_SESSION['user_id'] ?? null;

/**
/**
 * Helper to fetch digital signatures map by user_id and names
 */
function getAuditorSignatureMap($pdo) {
    static $map = null;
    if ($map !== null) {
        return $map;
    }
    $map = [
        'by_id'   => [],
        'by_name' => []
    ];
    try {
        $stmt = $pdo->query("SELECT user_id, user_name, full_name, username, digital_signature FROM mcc_users WHERE digital_signature IS NOT NULL AND digital_signature != ''");
        while ($row = $stmt->fetch(PDO::FETCH_ASSOC)) {
            $sig = $row['digital_signature'];
            $map['by_id'][intval($row['user_id'])] = $sig;
            if (!empty($row['user_name'])) {
                $map['by_name'][strtolower(trim($row['user_name']))] = $sig;
            }
            if (!empty($row['full_name'])) {
                $map['by_name'][strtolower(trim($row['full_name']))] = $sig;
            }
            if (!empty($row['username'])) {
                $map['by_name'][strtolower(trim($row['username']))] = $sig;
            }
        }
    } catch (Exception $e) {}
    return $map;
}

function resolveAuditorSignature($pdo, $auditBy = null, $auditorName = null) {
    if (empty($pdo)) {
        return null;
    }
    $map = getAuditorSignatureMap($pdo);
    if (!empty($auditBy) && is_numeric($auditBy) && intval($auditBy) > 0) {
        $uid = intval($auditBy);
        if (isset($map['by_id'][$uid])) {
            return $map['by_id'][$uid];
        }
    }
    if (!empty($auditorName)) {
        $names = explode(',', (string)$auditorName);
        foreach ($names as $name) {
            $clean = strtolower(trim($name));
            if (!empty($clean) && isset($map['by_name'][$clean])) {
                return $map['by_name'][$clean];
            }
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
