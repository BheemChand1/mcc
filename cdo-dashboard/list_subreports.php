<?php
require_once '../connection.php';
global $pdo;

$subreports = $pdo->query("SELECT subreport_id, report_name, report_url, report_id, status FROM mcc_subreports")->fetchAll(PDO::FETCH_ASSOC);
foreach ($subreports as $sr) {
    echo "ID: " . $sr['subreport_id'] . " | Name: " . $sr['report_name'] . " | URL: " . $sr['report_url'] . " | ReportID: " . $sr['report_id'] . " | Status: " . $sr['status'] . "\n";
}
