<?php
require_once __DIR__ . '/../../../connection.php';
global $pdo;

echo "--- mcc_intensive_scorecard_2_report sample rows ---\n";
$stmt1 = $pdo->query("SELECT DISTINCT station_id, train_no, report_date, sub_parameter_id, score_value FROM mcc_intensive_scorecard_2_report LIMIT 10");
print_r($stmt1->fetchAll(PDO::FETCH_ASSOC));

echo "--- mcc_intensive_pantry_report sample rows ---\n";
$stmt2 = $pdo->query("SELECT DISTINCT station_id, train_no, report_date, sub_parameter_id, score_value FROM mcc_intensive_pantry_report LIMIT 10");
print_r($stmt2->fetchAll(PDO::FETCH_ASSOC));
