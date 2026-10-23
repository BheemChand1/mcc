<?php
require_once __DIR__ . '/../connection.php';

echo "=== STARTING PHOTO ATTENDANCE SETUP ===\n";

// 1. Create table mcc_photo_attendance
$createSql = "
CREATE TABLE IF NOT EXISTS `mcc_photo_attendance` (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `station_id` int(11) NOT NULL DEFAULT 1,
  `employee_id` varchar(50) NOT NULL,
  `attendance_date` date NOT NULL,
  `process` varchar(100) DEFAULT 'Normal Cleaning',
  `in_time` datetime DEFAULT NULL,
  `in_lat` decimal(10, 8) DEFAULT NULL,
  `in_long` decimal(11, 8) DEFAULT NULL,
  `in_location` varchar(255) DEFAULT NULL,
  `in_photo` varchar(255) DEFAULT NULL,
  `out_time` datetime DEFAULT NULL,
  `out_lat` decimal(10, 8) DEFAULT NULL,
  `out_long` decimal(11, 8) DEFAULT NULL,
  `out_location` varchar(255) DEFAULT NULL,
  `out_photo` varchar(255) DEFAULT NULL,
  `remarks` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_emp_date` (`employee_id`, `attendance_date`),
  KEY `idx_station_date` (`station_id`, `attendance_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
";
$pdo->exec($createSql);
echo "[OK] Table mcc_photo_attendance verified or created.\n";

// 2. Register photo_attendance.php in mcc_subreports if not present
$checkSub = $pdo->prepare("SELECT COUNT(*) FROM mcc_subreports WHERE report_url = 'photo_attendance.php' AND report_id = 8");
$checkSub->execute();
if ($checkSub->fetchColumn() == 0) {
    $insertSub = $pdo->prepare("
        INSERT INTO mcc_subreports (report_url, report_name, report_id, status, aap_key)
        VALUES ('photo_attendance.php', 'Photo Attendance', 8, 'Active', 'photo_attendance')
    ");
    $insertSub->execute();
    echo "[OK] Added photo_attendance.php to mcc_subreports.\n";
} else {
    $updSub = $pdo->prepare("UPDATE mcc_subreports SET status = 'Active' WHERE report_url = 'photo_attendance.php' AND report_id = 8");
    $updSub->execute();
    echo "[OK] Updated photo_attendance.php status to Active in mcc_subreports.\n";
}

// 3. Insert realistic sample data for today and recent days if table is empty
$countStmt = $pdo->query("SELECT COUNT(*) FROM mcc_photo_attendance");
if ($countStmt->fetchColumn() == 0) {
    $today = date('Y-m-d');
    $sampleData = [
        [
            'station_id' => 1,
            'employee_id' => 'DEP101',
            'attendance_date' => $today,
            'shift' => 'Shift 1',
            'in_time' => $today . ' 06:05:12',
            'in_lat' => 26.85210400,
            'in_long' => 80.94623100,
            'in_location' => 'Coaching Yard Depot Gate 1',
            'in_photo' => 'uploads/attendance/dep101_in.jpg',
            'out_time' => $today . ' 14:02:45',
            'out_lat' => 26.85221000,
            'out_long' => 80.94635000,
            'out_location' => 'Coaching Yard Depot Gate 1',
            'out_photo' => 'uploads/attendance/dep101_out.jpg',
            'status' => 'Present',
            'remarks' => 'Completed full shift on Coach B4-B7'
        ],
        [
            'station_id' => 1,
            'employee_id' => 'DEP102',
            'attendance_date' => $today,
            'shift' => 'Shift 1',
            'in_time' => $today . ' 05:58:30',
            'in_lat' => 26.85215000,
            'in_long' => 80.94620000,
            'in_location' => 'Depot Admin Bay',
            'in_photo' => 'uploads/attendance/dep102_in.jpg',
            'out_time' => $today . ' 14:10:15',
            'out_lat' => 26.85219000,
            'out_long' => 80.94622000,
            'out_location' => 'Depot Admin Bay',
            'out_photo' => 'uploads/attendance/dep102_out.jpg',
            'status' => 'Present',
            'remarks' => 'Shift supervisor duty'
        ],
        [
            'station_id' => 1,
            'employee_id' => 'DEP103',
            'attendance_date' => $today,
            'shift' => 'Shift 2',
            'in_time' => $today . ' 13:55:40',
            'in_lat' => 26.85198000,
            'in_long' => 80.94640000,
            'in_location' => 'Washing Line 2',
            'in_photo' => 'uploads/attendance/dep103_in.jpg',
            'out_time' => NULL,
            'out_lat' => NULL,
            'out_long' => NULL,
            'out_location' => NULL,
            'out_photo' => NULL,
            'status' => 'Present',
            'remarks' => 'Currently On Duty'
        ],
        [
            'station_id' => 1,
            'employee_id' => 'PRT201',
            'attendance_date' => $today,
            'shift' => 'Shift 1',
            'in_time' => $today . ' 06:12:05',
            'in_lat' => 26.85301000,
            'in_long' => 80.94711000,
            'in_location' => 'Platform No. 1 Return Bay',
            'in_photo' => 'uploads/attendance/prt201_in.jpg',
            'out_time' => $today . ' 13:58:20',
            'out_lat' => 26.85304000,
            'out_long' => 80.94715000,
            'out_location' => 'Platform No. 1 Return Bay',
            'out_photo' => 'uploads/attendance/prt201_out.jpg',
            'status' => 'Present',
            'remarks' => 'PRT turnaround rake'
        ],
        [
            'station_id' => 1,
            'employee_id' => 'PRT202',
            'attendance_date' => $today,
            'shift' => 'Shift 2',
            'in_time' => $today . ' 14:02:18',
            'in_lat' => 26.85310000,
            'in_long' => 80.94720000,
            'in_location' => 'Platform No. 2 Return Bay',
            'in_photo' => 'uploads/attendance/prt202_in.jpg',
            'out_time' => NULL,
            'out_lat' => NULL,
            'out_long' => NULL,
            'out_location' => NULL,
            'out_photo' => NULL,
            'status' => 'Present',
            'remarks' => 'Currently On Duty'
        ]
    ];

    $insertStmt = $pdo->prepare("
        INSERT INTO mcc_photo_attendance 
        (station_id, employee_id, attendance_date, shift, in_time, in_lat, in_long, in_location, in_photo, out_time, out_lat, out_long, out_location, out_photo, status, remarks)
        VALUES 
        (:station_id, :employee_id, :attendance_date, :shift, :in_time, :in_lat, :in_long, :in_location, :in_photo, :out_time, :out_lat, :out_long, :out_location, :out_photo, :status, :remarks)
    ");

    foreach ($sampleData as $item) {
        $insertStmt->execute($item);
    }
    echo "[OK] Inserted " . count($sampleData) . " sample records for " . $today . ".\n";
} else {
    echo "[INFO] mcc_photo_attendance already contains records.\n";
}

echo "=== COMPLETED PHOTO ATTENDANCE SETUP ===\n";
