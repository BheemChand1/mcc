<?php
session_start();
$_SESSION['user_id'] = 2; // CDO user ID
$_SESSION['username'] = 'CDO';
$_SESSION['user_name'] = 'kings';
$_SESSION['role'] = 'CDO';
$_SESSION['station_id'] = 1; // Lumding station

header("Location: cdo-dashboard/man-power-log.php");
exit();
?>
