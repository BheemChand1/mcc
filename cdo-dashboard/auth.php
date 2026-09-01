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

$railwayName = strtoupper($stationDetails['zone_name'] ?? 'SOUTH CENTRAL RAILWAY');
$divisionName = strtoupper($stationDetails['division_name'] ?? 'LMG');
$stationName = ucfirst($stationDetails['station_name'] ?? 'Lumding');
$contractorName = $stationDetails['contractor_name'] ?? 'Kingson Services';

$userRole = strtoupper($_SESSION['role'] ?? 'CDO');
$isViewer = ($userRole === 'VIEWER');
?>
