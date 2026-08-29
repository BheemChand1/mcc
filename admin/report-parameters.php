<?php
/**
 * MCC - Admin Panel Report Parameters Management
 * Interface to manage parameters and shifts for scorecards, chemical consumption, machine logs, and surprise visits.
 */
if (session_status() === PHP_SESSION_NONE) {
    session_name('MCC_ADMIN_SESS');
    session_start();
}
$pageTitle = 'MCC Admin | Manage Report Parameters';
require_once '../connection.php';

// List of assignable categories and their metadata
$categories = [
    'normal_scorecard' => [
        'label' => 'Normal Cleaning Scorecard',
        'type' => 'scorecard',
        'parent_table' => 'mcc_normal_scorecard_param',
        'child_table' => 'mcc_normal_scorecard_sub_param',
        'required_report_keys' => ['normal_audit']
    ],
    'normal_chemical' => [
        'label' => 'Normal Chemical Consumption',
        'type' => 'chemical_with_shifts',
        'table' => 'mcc_normal_chemical_param',
        'shift_table' => 'mcc_normal_chemical_shifts',
        'required_report_keys' => ['normal_chem']
    ],
    'normal_machine' => [
        'label' => 'Normal Machine Log',
        'type' => 'machine_with_shifts',
        'table' => 'mcc_normal_machine_param',
        'shift_table' => 'mcc_normal_machine_shifts',
        'required_report_keys' => ['normal_mach']
    ],
    'intensive_scorecard' => [
        'label' => 'Intensive Cleaning Scorecard',
        'type' => 'scorecard',
        'parent_table' => 'mcc_intensive_scorecard_param',
        'child_table' => 'mcc_intensive_scorecard_sub_param',
        'required_report_keys' => ['int_audit']
    ],
    'intensive_scorecard_2' => [
        'label' => 'Intensive Scorecard 2 (Annexure A-2)',
        'type' => 'scorecard',
        'parent_table' => 'mcc_intensive_scorecard_2_param',
        'child_table' => 'mcc_intensive_scorecard_2_sub_param',
        'required_report_keys' => ['int_scorecard_2']
    ],
    'intensive_pantry' => [
        'label' => 'Pantry Car Scorecard',
        'type' => 'scorecard',
        'parent_table' => 'mcc_intensive_pantry_param',
        'child_table' => 'mcc_intensive_pantry_sub_param',
        'required_report_keys' => ['int_pantry']
    ],
    'intensive_chemical' => [
        'label' => 'Intensive Chemical Report',
        'type' => 'chemical_with_shifts',
        'table' => 'mcc_intensive_chemical_param',
        'shift_table' => 'mcc_intensive_chemical_shifts',
        'required_report_keys' => ['int_chem']
    ],
    'intensive_machine' => [
        'label' => 'Intensive Machine Log',
        'type' => 'machine_with_shifts',
        'table' => 'mcc_intensive_machine_param',
        'shift_table' => 'mcc_intensive_machine_shifts',
        'required_report_keys' => ['int_mach']
    ],
    'pldc_scorecard' => [
        'label' => 'PLDC Cleanliness Scorecard',
        'type' => 'flat_scorecard_with_shifts',
        'table' => 'dc_mcc_param',
        'shift_table' => 'dc_mcc_shifts',
        'required_report_keys' => ['pldc_audit']
    ],
    'pldc_chemical' => [
        'label' => 'PLDC Chemical Report',
        'type' => 'chemical_with_shifts',
        'table' => 'dc_mcc_chemical_param',
        'shift_table' => 'dc_mcc_chemical_shifts',
        'required_report_keys' => ['pldc_chem']
    ],
    'pldc_machine' => [
        'label' => 'PLDC Machine Log',
        'type' => 'machine_with_shifts',
        'table' => 'dc_mcc_machine_param',
        'shift_table' => 'dc_mcc_machine_shifts',
        'required_report_keys' => ['pldc_mach']
    ],
    'prt_scorecard' => [
        'label' => 'PRT Cleanliness Scorecard',
        'type' => 'scorecard',
        'parent_table' => 'mcc_prt_scorecard_param',
        'child_table' => 'mcc_prt_scorecard_sub_param',
        'required_report_keys' => ['prt_audit']
    ],
    'prt_chemical' => [
        'label' => 'PRT Chemical Report',
        'type' => 'chemical_with_shifts',
        'table' => 'mcc_prt_chemical_param',
        'required_report_keys' => ['prt_chem']
    ],
    'surprise' => [
        'label' => 'Surprise Inspections',
        'type' => 'surprise',
        'table' => 'mcc_surprise_parameters',
        'required_report_keys' => ['sur_pit', 'sur_pf']
    ],
    'vb_scorecard' => [
        'label' => 'Vande Bharat Score Card',
        'type' => 'scorecard',
        'parent_table' => 'mcc_vb_scorecard_param',
        'child_table' => 'mcc_vb_scorecard_sub_param',
        'required_report_keys' => ['vb_audit']
    ],
    'vb_chemical' => [
        'label' => 'Vande Bharat Chemical Report',
        'type' => 'chemical_with_shifts',
        'table' => 'mcc_vb_chemical_param',
        'shift_table' => 'mcc_vb_chemical_shifts',
        'required_report_keys' => ['vb_chem']
    ],
    'vb_machine' => [
        'label' => 'Vande Bharat Machine Log',
        'type' => 'machine_with_shifts',
        'table' => 'mcc_vb_machine_param',
        'shift_table' => 'mcc_vb_machine_shifts',
        'required_report_keys' => ['vb_mach']
    ],
    'manpower_categories' => [
        'label' => 'Manpower Categories',
        'type' => 'manpower_categories',
        'table' => 'mcc_manpower_categories',
        'required_report_keys' => ['manpower']
    ],
    'manpower_shifts' => [
        'label' => 'Manpower Shifts',
        'type' => 'manpower_shifts',
        'table' => 'mcc_manpower_shifts',
        'required_report_keys' => ['manpower']
    ],
    'manpower_types' => [
        'label' => 'Manpower Roles / Types',
        'type' => 'manpower_types',
        'table' => 'mcc_manpower_types',
        'required_report_keys' => ['manpower']
    ],
    'manpower_shift_type_map' => [
        'label' => 'Manpower Shift-Role Mappings',
        'type' => 'manpower_shift_type_map',
        'table' => 'mcc_manpower_shift_type_map',
        'required_report_keys' => ['manpower']
    ]
];

$message = $_SESSION['flash_message'] ?? '';
$messageType = $_SESSION['flash_message_type'] ?? '';
unset($_SESSION['flash_message'], $_SESSION['flash_message_type']);

// Fetch active stations for the selector
$activeStations = [];
try {
    $activeStations = $pdo->query("SELECT station_id, station_name FROM mcc_stations WHERE status = 'Active' ORDER BY station_name ASC")->fetchAll();
} catch (PDOException $e) {
    // Fail silently
}

// Current selection parameters
$station_id = intval($_GET['station_id'] ?? ($_POST['station_id'] ?? ($activeStations[0]['station_id'] ?? 0)));

// Fetch assigned report keys for this station
$assignedKeys = [];
if ($station_id > 0) {
    try {
        $stmt = $pdo->prepare("SELECT report_key FROM mcc_station_reports WHERE station_id = :station_id");
        $stmt->execute(['station_id' => $station_id]);
        $assignedKeys = $stmt->fetchAll(PDO::FETCH_COLUMN);
    } catch (PDOException $e) {
        // Fail silently
    }
}

// Filter categories
$assignedCategories = [];
foreach ($categories as $key => $cat) {
    $show_cat = false;
    $req_keys = $cat['required_report_keys'] ?? [];
    foreach ($req_keys as $rk) {
        if (in_array($rk, $assignedKeys)) {
            $show_cat = true;
            break;
        }
    }
    if ($show_cat) {
        $assignedCategories[$key] = $cat;
    }
}

$module_type = $_GET['type'] ?? ($_POST['type'] ?? '');
if (!empty($assignedCategories)) {
    if (empty($module_type) || !isset($assignedCategories[$module_type])) {
        $module_type = array_key_first($assignedCategories);
    }
} else {
    $module_type = '';
}

// Handle POST submissions
if ($_SERVER['REQUEST_METHOD'] === 'POST' && isset($_POST['action'])) {
    $action = $_POST['action'];
    $target_station = intval($_POST['station_id'] ?? 0);
    $target_type = $_POST['type'] ?? '';
    
    // Fetch assigned report keys for the target station to validate
    $targetAssignedKeys = [];
    if ($target_station > 0) {
        try {
            $stmt = $pdo->prepare("SELECT report_key FROM mcc_station_reports WHERE station_id = :station_id");
            $stmt->execute(['station_id' => $target_station]);
            $targetAssignedKeys = $stmt->fetchAll(PDO::FETCH_COLUMN);
        } catch (PDOException $e) {
            // Fail silently
        }
    }
    
    // Check if target type is authorized
    $isAuthorized = false;
    if (isset($categories[$target_type])) {
        $req_keys = $categories[$target_type]['required_report_keys'] ?? [];
        foreach ($req_keys as $rk) {
            if (in_array($rk, $targetAssignedKeys)) {
                $isAuthorized = true;
                break;
            }
        }
    }
    
    if ($target_station <= 0) {
        $_SESSION['flash_message'] = "Please select a valid coaching station.";
        $_SESSION['flash_message_type'] = "danger";
    } elseif (!$isAuthorized) {
        $_SESSION['flash_message'] = "Unauthorized parameter module modification attempt.";
        $_SESSION['flash_message_type'] = "danger";
    } else {
        $meta = $categories[$target_type] ?? null;
        if ($meta) {
            try {
                if ($action === 'add_parent' || $action === 'edit_parent') {
                    $name = trim($_POST['parameter_name'] ?? '');
                    $status = $_POST['status'] ?? 'Active';
                    $parent_id = intval($_POST['parent_id'] ?? 0);
                    $table = $meta['parent_table'];
                    
                    if (empty($name)) {
                        throw new Exception("Parameter group name cannot be empty.");
                    }
                    
                    if ($action === 'add_parent') {
                        $stmt = $pdo->prepare("INSERT INTO `$table` (parameter_name, station_id, status) VALUES (:name, :station_id, :status)");
                        $stmt->execute(['name' => $name, 'station_id' => $target_station, 'status' => $status]);
                        $_SESSION['flash_message'] = "Parameter group '$name' added successfully.";
                    } else {
                        $stmt = $pdo->prepare("UPDATE `$table` SET parameter_name = :name, status = :status WHERE id = :id AND station_id = :station_id");
                        $stmt->execute(['name' => $name, 'status' => $status, 'id' => $parent_id, 'station_id' => $target_station]);
                        $_SESSION['flash_message'] = "Parameter group updated successfully.";
                    }
                    $_SESSION['flash_message_type'] = "success";
                }
                elseif ($action === 'add_child' || $action === 'edit_child') {
                    $name = trim($_POST['sub_parameter_name'] ?? '');
                    $parent_id = intval($_POST['parent_id'] ?? 0);
                    $status = $_POST['status'] ?? 'Active';
                    $child_id = intval($_POST['child_id'] ?? 0);
                    $table = $meta['child_table'];
                    
                    if (empty($name) || $parent_id <= 0) {
                        throw new Exception("Sub-parameter name and parent group selection are required.");
                    }
                    
                    if ($action === 'add_child') {
                        $stmt = $pdo->prepare("INSERT INTO `$table` (sub_parameter_name, parameter_id, station_id, status) VALUES (:name, :parent_id, :station_id, :status)");
                        $stmt->execute(['name' => $name, 'parent_id' => $parent_id, 'station_id' => $target_station, 'status' => $status]);
                        $_SESSION['flash_message'] = "Sub-parameter '$name' added successfully.";
                    } else {
                        $stmt = $pdo->prepare("UPDATE `$table` SET sub_parameter_name = :name, parameter_id = :parent_id, status = :status WHERE id = :id AND station_id = :station_id");
                        $stmt->execute(['name' => $name, 'parent_id' => $parent_id, 'status' => $status, 'id' => $child_id, 'station_id' => $target_station]);
                        $_SESSION['flash_message'] = "Sub-parameter updated successfully.";
                    }
                    $_SESSION['flash_message_type'] = "success";
                }
                elseif ($action === 'add_flat_scorecard' || $action === 'edit_flat_scorecard') {
                    $name = trim($_POST['parameter_name'] ?? '');
                    $item_id = intval($_POST['item_id'] ?? 0);
                    $table = $meta['table'];
                    
                    if (empty($name)) {
                        throw new Exception("Parameter name cannot be empty.");
                    }
                    
                    if ($action === 'add_flat_scorecard') {
                        $stmt = $pdo->prepare("INSERT INTO `$table` (parameter_name, station_id) VALUES (:name, :station_id)");
                        $stmt->execute(['name' => $name, 'station_id' => $target_station]);
                        $_SESSION['flash_message'] = "Parameter '$name' added successfully.";
                    } else {
                        $stmt = $pdo->prepare("UPDATE `$table` SET parameter_name = :name WHERE id = :id AND station_id = :station_id");
                        $stmt->execute(['name' => $name, 'id' => $item_id, 'station_id' => $target_station]);
                        $_SESSION['flash_message'] = "Parameter updated successfully.";
                    }
                    $_SESSION['flash_message_type'] = "success";
                }
                elseif ($action === 'add_chemical' || $action === 'edit_chemical') {
                    $name = trim($_POST['name'] ?? '');
                    $units = trim($_POST['units'] ?? '');
                    $item_id = intval($_POST['item_id'] ?? 0);
                    $table = $meta['table'];
                    
                    if (empty($name) || empty($units)) {
                        throw new Exception("Chemical name and measurement unit are required.");
                    }
                    
                    if ($action === 'add_chemical') {
                        $stmt = $pdo->prepare("INSERT INTO `$table` (name, units, station_id) VALUES (:name, :units, :station_id)");
                        $stmt->execute(['name' => $name, 'units' => $units, 'station_id' => $target_station]);
                        $_SESSION['flash_message'] = "Chemical parameter '$name' added successfully.";
                    } else {
                        $stmt = $pdo->prepare("UPDATE `$table` SET name = :name, units = :units WHERE id = :id AND station_id = :station_id");
                        $stmt->execute(['name' => $name, 'units' => $units, 'id' => $item_id, 'station_id' => $target_station]);
                        $_SESSION['flash_message'] = "Chemical parameter updated successfully.";
                    }
                    $_SESSION['flash_message_type'] = "success";
                }
                elseif ($action === 'add_machine' || $action === 'edit_machine') {
                    $no = trim($_POST['machine_no'] ?? '');
                    $name = trim($_POST['machine_name'] ?? '');
                    $item_id = intval($_POST['item_id'] ?? 0);
                    $table = $meta['table'];
                    
                    if (empty($no) || empty($name)) {
                        throw new Exception("Machine reference number and name description are required.");
                    }
                    
                    if ($action === 'add_machine') {
                        $stmt = $pdo->prepare("INSERT INTO `$table` (machine_no, machine_name, station_id) VALUES (:no, :name, :station_id)");
                        $stmt->execute(['no' => $no, 'name' => $name, 'station_id' => $target_station]);
                        $_SESSION['flash_message'] = "Machine parameter '$no' - '$name' added successfully.";
                    } else {
                        $stmt = $pdo->prepare("UPDATE `$table` SET machine_no = :no, machine_name = :name WHERE id = :id AND station_id = :station_id");
                        $stmt->execute(['no' => $no, 'name' => $name, 'id' => $item_id, 'station_id' => $target_station]);
                        $_SESSION['flash_message'] = "Machine parameter updated successfully.";
                    }
                    $_SESSION['flash_message_type'] = "success";
                }
                elseif ($action === 'add_surprise' || $action === 'edit_surprise') {
                    $category = $_POST['category'] ?? 'pit_office';
                    $name = trim($_POST['item_name'] ?? '');
                    $desc = trim($_POST['parameter_desc'] ?? '');
                    $marks = intval($_POST['max_marks'] ?? 5);
                    $status = $_POST['status'] ?? 'Active';
                    $item_id = intval($_POST['item_id'] ?? 0);
                    $table = $meta['table'];
                    
                    if (empty($name) || empty($desc)) {
                        throw new Exception("Surprise check item name and details description are required.");
                    }
                    
                    if ($action === 'add_surprise') {
                        $stmt = $pdo->prepare("INSERT INTO `$table` (category, station_id, item_name, max_marks, parameter_desc, status) VALUES (:category, :station_id, :name, :marks, :desc, :status)");
                        $stmt->execute(['category' => $category, 'station_id' => $target_station, 'name' => $name, 'marks' => $marks, 'desc' => $desc, 'status' => $status]);
                        $_SESSION['flash_message'] = "Surprise Visit parameter '$name' added successfully.";
                    } else {
                        $stmt = $pdo->prepare("UPDATE `$table` SET category = :category, item_name = :name, max_marks = :marks, parameter_desc = :desc, status = :status WHERE id = :id AND station_id = :station_id");
                        $stmt->execute(['category' => $category, 'name' => $name, 'marks' => $marks, 'desc' => $desc, 'status' => $status, 'id' => $item_id, 'station_id' => $target_station]);
                        $_SESSION['flash_message'] = "Surprise Visit parameter updated successfully.";
                    }
                    $_SESSION['flash_message_type'] = "success";
                }
                elseif ($action === 'add_shift' || $action === 'edit_shift') {
                    $shift = trim($_POST['shift'] ?? '');
                    $item_id = intval($_POST['item_id'] ?? 0);
                    $table = $meta['shift_table'];
                    
                    if (empty($shift)) {
                        throw new Exception("Shift name cannot be empty.");
                    }
                    
                    if ($action === 'add_shift') {
                        $stmt = $pdo->prepare("INSERT INTO `$table` (shift, station_id) VALUES (:shift, :station_id)");
                        $stmt->execute(['shift' => $shift, 'station_id' => $target_station]);
                        $_SESSION['flash_message'] = "Shift '$shift' added successfully.";
                    } else {
                        $stmt = $pdo->prepare("UPDATE `$table` SET shift = :shift WHERE id = :id AND station_id = :station_id");
                        $stmt->execute(['shift' => $shift, 'id' => $item_id, 'station_id' => $target_station]);
                        $_SESSION['flash_message'] = "Shift updated successfully.";
                    }
                    $_SESSION['flash_message_type'] = "success";
                }
                elseif ($action === 'add_manpower_category' || $action === 'edit_manpower_category') {
                    $category_name = trim($_POST['category_name'] ?? '');
                    $order_no = intval($_POST['order_no'] ?? 1);
                    $status = $_POST['status'] ?? 'Active';
                    $item_id = intval($_POST['item_id'] ?? 0);
                    
                    if (empty($category_name)) {
                        throw new Exception("Category name cannot be empty.");
                    }
                    
                    if ($action === 'add_manpower_category') {
                        $stmt = $pdo->prepare("INSERT INTO mcc_manpower_categories (category_name, order_no, station_id, status) VALUES (:category_name, :order_no, :station_id, :status)");
                        $stmt->execute(['category_name' => $category_name, 'order_no' => $order_no, 'station_id' => $target_station, 'status' => $status]);
                        $_SESSION['flash_message'] = "Manpower category '$category_name' added successfully.";
                    } else {
                        $stmt = $pdo->prepare("UPDATE mcc_manpower_categories SET category_name = :category_name, order_no = :order_no, status = :status WHERE id = :id AND station_id = :station_id");
                        $stmt->execute(['category_name' => $category_name, 'order_no' => $order_no, 'status' => $status, 'id' => $item_id, 'station_id' => $target_station]);
                        $_SESSION['flash_message'] = "Manpower category updated successfully.";
                    }
                    $_SESSION['flash_message_type'] = "success";
                }
                elseif ($action === 'add_manpower_shift' || $action === 'edit_manpower_shift') {
                    $category_id = intval($_POST['category_id'] ?? 0);
                    $shift_name = trim($_POST['shift_name'] ?? '');
                    $order_no = intval($_POST['order_no'] ?? 1);
                    $status = $_POST['status'] ?? 'Active';
                    $item_id = intval($_POST['item_id'] ?? 0);
                    
                    if ($category_id <= 0 || empty($shift_name)) {
                        throw new Exception("Category selection and Shift name are required.");
                    }
                    
                    // Verify category belongs to station
                    $chk = $pdo->prepare("SELECT COUNT(*) FROM mcc_manpower_categories WHERE id = :category_id AND station_id = :station_id");
                    $chk->execute(['category_id' => $category_id, 'station_id' => $target_station]);
                    if ($chk->fetchColumn() == 0) {
                        throw new Exception("Invalid category selection.");
                    }
                    
                    if ($action === 'add_manpower_shift') {
                        $stmt = $pdo->prepare("INSERT INTO mcc_manpower_shifts (category_id, shift_name, order_no, status) VALUES (:category_id, :shift_name, :order_no, :status)");
                        $stmt->execute(['category_id' => $category_id, 'shift_name' => $shift_name, 'order_no' => $order_no, 'status' => $status]);
                        $_SESSION['flash_message'] = "Manpower shift '$shift_name' added successfully.";
                    } else {
                        $stmt = $pdo->prepare("UPDATE mcc_manpower_shifts SET category_id = :category_id, shift_name = :shift_name, order_no = :order_no, status = :status WHERE id = :id");
                        $stmt->execute(['category_id' => $category_id, 'shift_name' => $shift_name, 'order_no' => $order_no, 'status' => $status, 'id' => $item_id]);
                        $_SESSION['flash_message'] = "Manpower shift updated successfully.";
                    }
                    $_SESSION['flash_message_type'] = "success";
                }
                elseif ($action === 'add_manpower_type' || $action === 'edit_manpower_type') {
                    $role_name = trim($_POST['role_name'] ?? '');
                    $order_no = intval($_POST['order_no'] ?? 1);
                    $status = $_POST['status'] ?? 'Active';
                    $item_id = intval($_POST['item_id'] ?? 0);
                    
                    if (empty($role_name)) {
                        throw new Exception("Role name cannot be empty.");
                    }
                    
                    if ($action === 'add_manpower_type') {
                        $stmt = $pdo->prepare("INSERT INTO mcc_manpower_types (role_name, order_no, station_id, status) VALUES (:role_name, :order_no, :station_id, :status)");
                        $stmt->execute(['role_name' => $role_name, 'order_no' => $order_no, 'station_id' => $target_station, 'status' => $status]);
                        $_SESSION['flash_message'] = "Manpower role '$role_name' added successfully.";
                    } else {
                        $stmt = $pdo->prepare("UPDATE mcc_manpower_types SET role_name = :role_name, order_no = :order_no, status = :status WHERE id = :id AND station_id = :station_id");
                        $stmt->execute(['role_name' => $role_name, 'order_no' => $order_no, 'status' => $status, 'id' => $item_id, 'station_id' => $target_station]);
                        $_SESSION['flash_message'] = "Manpower role updated successfully.";
                    }
                    $_SESSION['flash_message_type'] = "success";
                }
                elseif ($action === 'add_manpower_shift_type_map') {
                    $shift_id = intval($_POST['shift_id'] ?? 0);
                    $manpower_type_id = intval($_POST['manpower_type_id'] ?? 0);
                    
                    if ($shift_id <= 0 || $manpower_type_id <= 0) {
                        throw new Exception("Both Shift and Role/Type selection are required.");
                    }
                    
                    // Verify shift belongs to station categories
                    $chkShift = $pdo->prepare("SELECT COUNT(*) FROM mcc_manpower_shifts s JOIN mcc_manpower_categories c ON s.category_id = c.id WHERE s.id = :shift_id AND c.station_id = :station_id");
                    $chkShift->execute(['shift_id' => $shift_id, 'station_id' => $target_station]);
                    if ($chkShift->fetchColumn() == 0) {
                        throw new Exception("Invalid shift selection.");
                    }
                    
                    // Verify role belongs to station
                    $chkRole = $pdo->prepare("SELECT COUNT(*) FROM mcc_manpower_types WHERE id = :role_id AND station_id = :station_id");
                    $chkRole->execute(['role_id' => $manpower_type_id, 'station_id' => $target_station]);
                    if ($chkRole->fetchColumn() == 0) {
                        throw new Exception("Invalid role selection.");
                    }
                    
                    // Check duplicate
                    $chkDup = $pdo->prepare("SELECT COUNT(*) FROM mcc_manpower_shift_type_map WHERE station_id = :station_id AND shift_id = :shift_id AND manpower_type_id = :type_id");
                    $chkDup->execute(['station_id' => $target_station, 'shift_id' => $shift_id, 'type_id' => $manpower_type_id]);
                    if ($chkDup->fetchColumn() > 0) {
                        throw new Exception("This Shift-Role mapping already exists.");
                    }
                    
                    $stmt = $pdo->prepare("INSERT INTO mcc_manpower_shift_type_map (station_id, shift_id, manpower_type_id) VALUES (:station_id, :shift_id, :type_id)");
                    $stmt->execute(['station_id' => $target_station, 'shift_id' => $shift_id, 'type_id' => $manpower_type_id]);
                    $_SESSION['flash_message'] = "Shift-Role mapping successfully established.";
                    $_SESSION['flash_message_type'] = "success";
                }
            } catch (Exception $e) {
                $_SESSION['flash_message'] = $e->getMessage();
                $_SESSION['flash_message_type'] = "danger";
            }
        }
    }
    
    header("Location: report-parameters.php?station_id=" . $target_station . "&type=" . $target_type);
    exit();
}

// Handle GET status toggles and delete triggers
if (isset($_GET['action']) && in_array($_GET['action'], ['delete_item', 'delete_shift', 'delete_parent', 'delete_child', 'toggle_status', 'toggle_parent_status', 'toggle_child_status'])) {
    $action = $_GET['action'];
    $target_id = intval($_GET['id'] ?? 0);
    $meta = $categories[$module_type] ?? null;
    
    if ($meta && $target_id > 0) {
        try {
            if ($action === 'delete_item' || $action === 'delete_parent' || $action === 'delete_child') {
                $table = ($action === 'delete_parent') ? $meta['parent_table'] : (($action === 'toggle_child') ? $meta['child_table'] : $meta['table']);
                if ($table === 'mcc_manpower_shifts') {
                    $chk = $pdo->prepare("SELECT COUNT(*) FROM mcc_manpower_shifts s JOIN mcc_manpower_categories c ON s.category_id = c.id WHERE s.id = :id AND c.station_id = :station_id");
                    $chk->execute(['id' => $target_id, 'station_id' => $station_id]);
                    if ($chk->fetchColumn() > 0) {
                        $stmt = $pdo->prepare("DELETE FROM mcc_manpower_shifts WHERE id = :id");
                        $stmt->execute(['id' => $target_id]);
                    }
                } else {
                    $stmt = $pdo->prepare("DELETE FROM `$table` WHERE id = :id AND station_id = :station_id");
                    $stmt->execute(['id' => $target_id, 'station_id' => $station_id]);
                }
                $_SESSION['flash_message'] = "Selected parameter successfully removed from system.";
                $_SESSION['flash_message_type'] = "success";
            }
            elseif ($action === 'delete_shift') {
                $table = $meta['shift_table'];
                $stmt = $pdo->prepare("DELETE FROM `$table` WHERE id = :id AND station_id = :station_id");
                $stmt->execute(['id' => $target_id, 'station_id' => $station_id]);
                $_SESSION['flash_message'] = "Selected shift successfully removed from system.";
                $_SESSION['flash_message_type'] = "success";
            }
            elseif ($action === 'toggle_parent_status' || $action === 'toggle_child_status' || $action === 'toggle_status') {
                $table = ($action === 'toggle_parent_status') ? $meta['parent_table'] : (($action === 'toggle_child_status') ? $meta['child_table'] : $meta['table']);
                
                if ($table === 'mcc_manpower_shifts') {
                    $chk = $pdo->prepare("SELECT s.status FROM mcc_manpower_shifts s JOIN mcc_manpower_categories c ON s.category_id = c.id WHERE s.id = :id AND c.station_id = :station_id");
                    $chk->execute(['id' => $target_id, 'station_id' => $station_id]);
                    $curr = $chk->fetchColumn();
                    if ($curr !== false) {
                        $new = ($curr === 'Active') ? 'Inactive' : 'Active';
                        $ustmt = $pdo->prepare("UPDATE mcc_manpower_shifts SET status = :status WHERE id = :id");
                        $ustmt->execute(['status' => $new, 'id' => $target_id]);
                    }
                } else {
                    $sstmt = $pdo->prepare("SELECT status FROM `$table` WHERE id = :id AND station_id = :station_id");
                    $sstmt->execute(['id' => $target_id, 'station_id' => $station_id]);
                    $curr = $sstmt->fetchColumn();
                    $new = ($curr === 'Active') ? 'Inactive' : 'Active';
                    
                    $ustmt = $pdo->prepare("UPDATE `$table` SET status = :status WHERE id = :id AND station_id = :station_id");
                    $ustmt->execute(['status' => $new, 'id' => $target_id, 'station_id' => $station_id]);
                }
                $_SESSION['flash_message'] = "Status toggled to '$new'.";
                $_SESSION['flash_message_type'] = "success";
            }
        } catch (PDOException $e) {
            $_SESSION['flash_message'] = "Database Action Error: " . $e->getMessage();
            $_SESSION['flash_message_type'] = "danger";
        }
        
        header("Location: report-parameters.php?station_id=" . $station_id . "&type=" . $module_type);
        exit();
    }
}

// Load edit form fields data
$edit_parent_data = null;
$edit_child_data = null;
$edit_data = null;
$edit_shift_data = null;

if (!empty($module_type) && isset($_GET['action']) && $_GET['action'] === 'edit' && isset($_GET['edit_id'])) {
    $edit_id = intval($_GET['edit_id']);
    $edit_target = $_GET['target'] ?? 'item';
    $meta = $categories[$module_type] ?? null;
    
    if ($meta && $edit_id > 0) {
        try {
            if ($edit_target === 'parent') {
                $table = $meta['parent_table'];
                $stmt = $pdo->prepare("SELECT * FROM `$table` WHERE id = :id AND station_id = :station_id");
                $stmt->execute(['id' => $edit_id, 'station_id' => $station_id]);
                $edit_parent_data = $stmt->fetch();
            } elseif ($edit_target === 'child') {
                $table = $meta['child_table'];
                $stmt = $pdo->prepare("SELECT * FROM `$table` WHERE id = :id AND station_id = :station_id");
                $stmt->execute(['id' => $edit_id, 'station_id' => $station_id]);
                $edit_child_data = $stmt->fetch();
            } elseif ($edit_target === 'shift') {
                $table = $meta['shift_table'];
                $stmt = $pdo->prepare("SELECT * FROM `$table` WHERE id = :id AND station_id = :station_id");
                $stmt->execute(['id' => $edit_id, 'station_id' => $station_id]);
                $edit_shift_data = $stmt->fetch();
            } else {
                $table = $meta['table'];
                if ($table === 'mcc_manpower_shifts') {
                    $stmt = $pdo->prepare("SELECT s.* FROM mcc_manpower_shifts s JOIN mcc_manpower_categories c ON s.category_id = c.id WHERE s.id = :id AND c.station_id = :station_id");
                    $stmt->execute(['id' => $edit_id, 'station_id' => $station_id]);
                } else {
                    $stmt = $pdo->prepare("SELECT * FROM `$table` WHERE id = :id AND station_id = :station_id");
                    $stmt->execute(['id' => $edit_id, 'station_id' => $station_id]);
                }
                $edit_data = $stmt->fetch();
            }
        } catch (PDOException $e) {
            // Fail silently
        }
    }
}

// Fetch parameter lists based on the selected target category
$parents_list = [];
$grouped_children = [];
$flat_items = [];
$shift_items = [];
$meta = null;

if (!empty($module_type) && isset($categories[$module_type])) {
    $meta = $categories[$module_type];
    try {
        if ($meta['type'] === 'scorecard') {
            $parent_table = $meta['parent_table'];
            $child_table = $meta['child_table'];
            
            $parents = $pdo->prepare("SELECT * FROM `$parent_table` WHERE station_id = :station_id ORDER BY id ASC");
            $parents->execute(['station_id' => $station_id]);
            $parents_list = $parents->fetchAll();
            
            $children = $pdo->prepare("SELECT * FROM `$child_table` WHERE station_id = :station_id ORDER BY parameter_id ASC, id ASC");
            $children->execute(['station_id' => $station_id]);
            $children_list = $children->fetchAll();
            
            foreach ($children_list as $child) {
                $grouped_children[$child['parameter_id']][] = $child;
            }
        } else {
            $table = $meta['table'];
            if ($table === 'mcc_manpower_shifts') {
                $stmt = $pdo->prepare("SELECT s.*, c.category_name FROM mcc_manpower_shifts s JOIN mcc_manpower_categories c ON s.category_id = c.id WHERE c.station_id = :station_id ORDER BY c.order_no ASC, s.order_no ASC");
                $stmt->execute(['station_id' => $station_id]);
                $flat_items = $stmt->fetchAll();
            } elseif ($table === 'mcc_manpower_shift_type_map') {
                $stmt = $pdo->prepare("
                    SELECT map.id, s.shift_name, t.role_name, c.category_name 
                    FROM mcc_manpower_shift_type_map map
                    JOIN mcc_manpower_shifts s ON map.shift_id = s.id
                    JOIN mcc_manpower_categories c ON s.category_id = c.id
                    JOIN mcc_manpower_types t ON map.manpower_type_id = t.id
                    WHERE map.station_id = :station_id 
                    ORDER BY c.order_no ASC, s.order_no ASC, t.order_no ASC
                ");
                $stmt->execute(['station_id' => $station_id]);
                $flat_items = $stmt->fetchAll();
            } else {
                $order = ($meta['type'] === 'surprise') ? 'category ASC, id ASC' : (($table === 'mcc_manpower_categories') ? 'order_no ASC, id ASC' : 'id ASC');
                $stmt = $pdo->prepare("SELECT * FROM `$table` WHERE station_id = :station_id ORDER BY $order");
                $stmt->execute(['station_id' => $station_id]);
                $flat_items = $stmt->fetchAll();
            }
        }
        
        // Fetch shifts if shift_table is defined
        if (isset($meta['shift_table'])) {
            $stable = $meta['shift_table'];
            $sstmt = $pdo->prepare("SELECT * FROM `$stable` WHERE station_id = :station_id ORDER BY id ASC");
            $sstmt->execute(['station_id' => $station_id]);
            $shift_items = $sstmt->fetchAll();
        }
    } catch (PDOException $e) {
        // Fail silently
    }
}

include 'header.php';
include 'sidebar.php';
?>

<main class="app-main">
  <!-- Content Header -->
  <div class="app-content-header py-3 mb-3 border-bottom bg-white shadow-sm">
    <div class="container-fluid">
      <div class="row align-items-center">
        <div class="col-md-6">
          <h3 class="mb-0 font-weight-bold text-dark d-flex align-items-center">
            <i class="bi bi-sliders text-indigo me-2" style="font-size: 1.6rem;"></i>
            Configure Report Parameters
          </h3>
        </div>
        <div class="col-md-6 text-md-end mt-2 mt-md-0">
          <span class="badge bg-indigo-subtle text-indigo p-2 px-3 border border-indigo-subtle rounded-pill">
            System Mappings Configurator
          </span>
        </div>
      </div>
    </div>
  </div>

  <!-- Content Body -->
  <div class="app-content">
    <div class="container-fluid">
      
      <!-- Selection Bar -->
      <div class="card shadow-sm border-0 mb-4 bg-light-subtle">
        <div class="card-body py-3">
          <form method="GET" class="row g-3 align-items-end" id="selector-form">
            <div class="col-md-5">
              <label for="station_id" class="form-label small font-weight-bold text-secondary text-uppercase mb-1" style="letter-spacing: 0.5px;">Select Target Coaching Depot</label>
              <select class="form-select border-indigo-subtle font-weight-bold" id="station_id" name="station_id" onchange="document.getElementById('selector-form').submit();">
                <?php foreach ($activeStations as $stn): ?>
                  <option value="<?php echo $stn['station_id']; ?>" <?php echo ($station_id == $stn['station_id']) ? 'selected' : ''; ?>>
                    <?php echo htmlspecialchars($stn['station_name']); ?>
                  </option>
                <?php endforeach; ?>
              </select>
            </div>
            <div class="col-md-5">
              <label for="type" class="form-label small font-weight-bold text-secondary text-uppercase mb-1" style="letter-spacing: 0.5px;">Select Parameter Module</label>
              <select class="form-select border-indigo-subtle font-weight-bold" id="type" name="type" onchange="document.getElementById('selector-form').submit();" <?php echo empty($assignedCategories) ? 'disabled' : ''; ?>>
                <?php if (empty($assignedCategories)): ?>
                  <option value="">-- No Reports Assigned --</option>
                <?php else: ?>
                  <?php foreach ($assignedCategories as $key => $cat): ?>
                    <option value="<?php echo $key; ?>" <?php echo ($module_type === $key) ? 'selected' : ''; ?>>
                      <?php echo htmlspecialchars($cat['label']); ?>
                    </option>
                  <?php endforeach; ?>
                <?php endif; ?>
              </select>
            </div>
            <div class="col-md-2">
              <button type="submit" class="btn btn-indigo w-100 font-weight-bold py-2"><i class="bi bi-arrow-repeat"></i> Reload</button>
            </div>
          </form>
        </div>
      </div>

      <?php if (!empty($message)): ?>
        <div class="alert alert-<?php echo $messageType; ?> alert-dismissible fade show rounded-3 shadow-sm mb-4" role="alert">
          <i class="bi <?php echo ($messageType === 'success') ? 'bi-check-circle-fill' : 'bi-exclamation-triangle-fill'; ?> me-2"></i>
          <?php echo htmlspecialchars($message); ?>
          <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
        </div>
      <?php endif; ?>

      <?php if (empty($module_type)): ?>
        <div class="card shadow-sm border-0 rounded-3 text-center p-5 mb-4 bg-white">
          <div class="card-body">
            <i class="bi bi-exclamation-triangle text-warning mb-3" style="font-size: 3.5rem;"></i>
            <h4 class="font-weight-bold text-dark">No Assigned Report Profiles</h4>
            <p class="text-secondary mb-4">This Coaching Depot has not been assigned any report profile access rights yet. Please configure its profile options first.</p>
            <a href="assign-reports.php?edit_station=<?php echo $station_id; ?>" class="btn btn-indigo px-4 py-2.5 font-weight-bold" style="text-decoration: none;"><i class="bi bi-file-earmark-check-fill me-1"></i> Assign Reports</a>
          </div>
        </div>
      <?php else: ?>
        <div class="row g-4">
          
          <!-- Left Side: Directory Table -->
          <div class="col-lg-8">
            
            <!-- Parameters Directory Card -->
            <div class="card shadow-sm border-0 mb-4">
              <div class="card-header bg-white py-3">
                <h5 class="mb-0 font-weight-bold text-dark d-flex align-items-center">
                  <i class="bi bi-list-nested text-indigo me-2"></i> Active Parameters Directory
                </h5>
              </div>
              <div class="card-body p-0">
                
                <!-- 1. Scorecard Parent-Child Layout View -->
                <?php if ($meta['type'] === 'scorecard'): ?>
                  <div class="table-responsive">
                    <table class="table table-hover align-middle mb-0">
                      <thead>
                        <tr>
                          <th class="ps-3" style="width: 50%;">Cleaning Parameters Group & Sub-items</th>
                          <th style="width: 25%;">Status</th>
                          <th class="text-center" style="width: 25%;">Actions</th>
                        </tr>
                      </thead>
                      <tbody>
                        <?php if (empty($parents_list)): ?>
                          <tr>
                            <td colspan="3" class="text-center py-5 text-muted small">No parameter groups defined yet for this station.</td>
                          </tr>
                        <?php else: ?>
                          <?php foreach ($parents_list as $parent): ?>
                            <!-- Parent Row -->
                            <tr class="table-indigo-subtle border-top" style="background: rgba(99, 102, 241, 0.04);">
                              <td class="ps-3">
                                <span class="badge bg-indigo me-2">Group</span>
                                <strong class="text-indigo"><?php echo htmlspecialchars($parent['parameter_name']); ?></strong>
                              </td>
                              <td>
                                <span class="badge rounded-pill <?php echo $parent['status'] === 'Active' ? 'bg-success-subtle text-success' : 'bg-danger-subtle text-danger'; ?>">
                                  <?php echo htmlspecialchars($parent['status']); ?>
                                </span>
                              </td>
                              <td class="text-center">
                                <a href="report-parameters.php?station_id=<?php echo $station_id; ?>&type=<?php echo $module_type; ?>&action=edit&edit_id=<?php echo $parent['id']; ?>&target=parent" class="btn btn-xs btn-outline-indigo rounded-pill px-2.5 font-weight-bold me-1 text-uppercase" style="font-size: 0.7rem; text-decoration: none;">Edit</a>
                                
                                <a href="report-parameters.php?station_id=<?php echo $station_id; ?>&type=<?php echo $module_type; ?>&action=toggle_parent_status&id=<?php echo $parent['id']; ?>" class="btn btn-xs <?php echo $parent['status'] === 'Active' ? 'btn-outline-warning' : 'btn-outline-success'; ?> rounded-pill px-2.5 font-weight-bold me-1 text-uppercase" style="font-size: 0.7rem; text-decoration: none;">Status</a>
                                
                                <a href="report-parameters.php?station_id=<?php echo $station_id; ?>&type=<?php echo $module_type; ?>&action=delete_parent&id=<?php echo $parent['id']; ?>" class="btn btn-xs btn-outline-danger rounded-pill px-2.5 font-weight-bold text-uppercase" style="font-size: 0.7rem; text-decoration: none;" onclick="return confirm('WARNING: Deleting this group will delete all subparameters linked to it. Proceed?');">Delete</a>
                              </td>
                            </tr>
                            
                            <!-- Children Sub-Rows -->
                            <?php if (!empty($grouped_children[$parent['id']])): ?>
                              <?php foreach ($grouped_children[$parent['id']] as $child): ?>
                                <tr>
                                  <td class="ps-5 text-secondary small">
                                    <i class="bi bi-arrow-return-right me-2 text-muted"></i>
                                    <?php echo htmlspecialchars($child['sub_parameter_name']); ?>
                                  </td>
                                  <td class="ps-3">
                                    <span class="badge rounded-pill <?php echo $child['status'] === 'Active' ? 'bg-success-subtle text-success' : 'bg-danger-subtle text-danger'; ?>" style="font-size: 0.7rem;">
                                      <?php echo htmlspecialchars($child['status']); ?>
                                    </span>
                                  </td>
                                  <td class="text-center">
                                    <a href="report-parameters.php?station_id=<?php echo $station_id; ?>&type=<?php echo $module_type; ?>&action=edit&edit_id=<?php echo $child['id']; ?>&target=child" class="btn btn-xs btn-outline-secondary rounded-pill px-2.5 font-weight-bold me-1 text-uppercase" style="font-size: 0.67rem; text-decoration: none;">Edit</a>
                                    
                                    <a href="report-parameters.php?station_id=<?php echo $station_id; ?>&type=<?php echo $module_type; ?>&action=toggle_child_status&id=<?php echo $child['id']; ?>" class="btn btn-xs <?php echo $child['status'] === 'Active' ? 'btn-outline-warning' : 'btn-outline-success'; ?> rounded-pill px-2.5 font-weight-bold me-1 text-uppercase" style="font-size: 0.67rem; text-decoration: none;">Status</a>
                                    
                                    <a href="report-parameters.php?station_id=<?php echo $station_id; ?>&type=<?php echo $module_type; ?>&action=delete_child&id=<?php echo $child['id']; ?>" class="btn btn-xs btn-outline-danger rounded-pill px-2.5 font-weight-bold text-uppercase" style="font-size: 0.67rem; text-decoration: none;" onclick="return confirm('Are you sure you want to delete this sub-parameter?');">Delete</a>
                                  </td>
                                </tr>
                              <?php endforeach; ?>
                            <?php else: ?>
                              <tr>
                                <td colspan="3" class="ps-5 text-muted small py-2 italic"><i class="bi bi-info-circle"></i> No sub-parameters created under this group yet.</td>
                              </tr>
                            <?php endif; ?>
                          <?php endforeach; ?>
                        <?php endif; ?>
                      </tbody>
                    </table>
                  </div>
                
                <!-- 2. Flat scorecard view (PLDC Scorecard) -->
                <?php elseif ($meta['type'] === 'flat_scorecard_with_shifts'): ?>
                  <div class="table-responsive">
                    <table class="table table-hover table-striped align-middle mb-0">
                      <thead>
                        <tr>
                          <th class="ps-3" style="width: 150px;">ID</th>
                          <th>Parameter Item Name</th>
                          <th class="text-center" style="width: 180px;">Actions</th>
                        </tr>
                      </thead>
                      <tbody>
                        <?php if (empty($flat_items)): ?>
                          <tr>
                            <td colspan="3" class="text-center py-5 text-muted small">No parameters defined yet.</td>
                          </tr>
                        <?php else: ?>
                          <?php foreach ($flat_items as $item): ?>
                            <tr>
                              <td class="ps-3"><strong>PLDC-<?php echo $item['id']; ?></strong></td>
                              <td><strong><?php echo htmlspecialchars($item['parameter_name']); ?></strong></td>
                              <td class="text-center">
                                <a href="report-parameters.php?station_id=<?php echo $station_id; ?>&type=<?php echo $module_type; ?>&action=edit&edit_id=<?php echo $item['id']; ?>" class="btn btn-sm btn-outline-secondary rounded-pill px-3 font-weight-bold me-1 text-uppercase" style="font-size: 0.72rem; text-decoration: none;">Edit</a>
                                <a href="report-parameters.php?station_id=<?php echo $station_id; ?>&type=<?php echo $module_type; ?>&action=delete_item&id=<?php echo $item['id']; ?>" class="btn btn-sm btn-outline-danger rounded-pill px-3 font-weight-bold text-uppercase" style="font-size: 0.72rem; text-decoration: none;" onclick="return confirm('Are you sure you want to delete this parameter?');">Delete</a>
                              </td>
                            </tr>
                          <?php endforeach; ?>
                        <?php endif; ?>
                      </tbody>
                    </table>
                  </div>

                <!-- 3. Chemical Layout View -->
                <?php elseif ($meta['type'] === 'chemical_with_shifts'): ?>
                  <div class="table-responsive">
                    <table class="table table-hover table-striped align-middle mb-0">
                      <thead>
                        <tr>
                          <th class="ps-3" style="width: 150px;">ID</th>
                          <th>Chemical Compound Name</th>
                          <th>Standard Units</th>
                          <th class="text-center" style="width: 180px;">Actions</th>
                        </tr>
                      </thead>
                      <tbody>
                        <?php if (empty($flat_items)): ?>
                          <tr>
                            <td colspan="4" class="text-center py-5 text-muted small">No chemical compounds configured.</td>
                          </tr>
                        <?php else: ?>
                          <?php foreach ($flat_items as $item): ?>
                            <tr>
                              <td class="ps-3"><strong>CHEM-<?php echo $item['id']; ?></strong></td>
                              <td><strong><?php echo htmlspecialchars($item['name']); ?></strong></td>
                              <td>
                                <span class="badge bg-indigo-subtle text-indigo border border-indigo-subtle py-1 px-2.5">
                                  <?php echo htmlspecialchars($item['units'] ?: 'N/A'); ?>
                                </span>
                              </td>
                              <td class="text-center">
                                <a href="report-parameters.php?station_id=<?php echo $station_id; ?>&type=<?php echo $module_type; ?>&action=edit&edit_id=<?php echo $item['id']; ?>" class="btn btn-sm btn-outline-secondary rounded-pill px-3 font-weight-bold me-1 text-uppercase" style="font-size: 0.72rem; text-decoration: none;">Edit</a>
                                <a href="report-parameters.php?station_id=<?php echo $station_id; ?>&type=<?php echo $module_type; ?>&action=delete_item&id=<?php echo $item['id']; ?>" class="btn btn-sm btn-outline-danger rounded-pill px-3 font-weight-bold text-uppercase" style="font-size: 0.72rem; text-decoration: none;" onclick="return confirm('Are you sure you want to delete this chemical compound?');">Delete</a>
                              </td>
                            </tr>
                          <?php endforeach; ?>
                        <?php endif; ?>
                      </tbody>
                    </table>
                  </div>

                <!-- 4. Machine Layout View -->
                <?php elseif ($meta['type'] === 'machine_with_shifts'): ?>
                  <div class="table-responsive">
                    <table class="table table-hover table-striped align-middle mb-0">
                      <thead>
                        <tr>
                          <th class="ps-3" style="width: 150px;">Machine No</th>
                          <th>Machine Model & Description</th>
                          <th class="text-center" style="width: 180px;">Actions</th>
                        </tr>
                      </thead>
                      <tbody>
                        <?php if (empty($flat_items)): ?>
                          <tr>
                            <td colspan="3" class="text-center py-5 text-muted small">No specialized machines configured.</td>
                          </tr>
                        <?php else: ?>
                          <?php foreach ($flat_items as $item): ?>
                            <tr>
                              <td class="ps-3"><strong><?php echo htmlspecialchars($item['machine_no']); ?></strong></td>
                              <td><strong><?php echo htmlspecialchars($item['machine_name']); ?></strong></td>
                              <td class="text-center">
                                <a href="report-parameters.php?station_id=<?php echo $station_id; ?>&type=<?php echo $module_type; ?>&action=edit&edit_id=<?php echo $item['id']; ?>" class="btn btn-sm btn-outline-secondary rounded-pill px-3 font-weight-bold me-1 text-uppercase" style="font-size: 0.72rem; text-decoration: none;">Edit</a>
                                <a href="report-parameters.php?station_id=<?php echo $station_id; ?>&type=<?php echo $module_type; ?>&action=delete_item&id=<?php echo $item['id']; ?>" class="btn btn-sm btn-outline-danger rounded-pill px-3 font-weight-bold text-uppercase" style="font-size: 0.72rem; text-decoration: none;" onclick="return confirm('Are you sure you want to delete this machine?');">Delete</a>
                              </td>
                            </tr>
                          <?php endforeach; ?>
                        <?php endif; ?>
                      </tbody>
                    </table>
                  </div>

                <!-- 5. Surprise Visit Layout View -->
                <?php elseif ($meta['type'] === 'surprise'): ?>
                  <div class="table-responsive">
                    <table class="table table-hover table-striped align-middle mb-0">
                      <thead>
                        <tr>
                          <th class="ps-3" style="width: 120px;">Category</th>
                          <th>Audit Area / Item Description</th>
                          <th style="width: 100px;">Max Marks</th>
                          <th style="width: 100px;">Status</th>
                          <th class="text-center text-nowrap" style="width: 220px;">Actions</th>
                        </tr>
                      </thead>
                      <tbody>
                        <?php if (empty($flat_items)): ?>
                          <tr>
                            <td colspan="5" class="text-center py-5 text-muted small">No surprise visit check items configured.</td>
                          </tr>
                        <?php else: ?>
                          <?php foreach ($flat_items as $item): ?>
                            <tr>
                              <td class="ps-3">
                                <span class="badge bg-indigo-subtle text-dark text-uppercase" style="font-size: 0.7rem;">
                                  <?php echo ($item['category'] === 'pit_office') ? 'Pit & Office' : 'PF Trains'; ?>
                                </span>
                              </td>
                              <td>
                                <strong><?php echo htmlspecialchars($item['item_name']); ?></strong>
                                <small class="text-muted d-block"><?php echo htmlspecialchars($item['parameter_desc']); ?></small>
                              </td>
                              <td><strong><?php echo intval($item['max_marks']); ?></strong></td>
                              <td>
                                <span class="badge rounded-pill <?php echo $item['status'] === 'Active' ? 'bg-success-subtle text-success' : 'bg-danger-subtle text-danger'; ?>">
                                  <?php echo htmlspecialchars($item['status']); ?>
                                </span>
                              </td>
                              <td class="text-center text-nowrap">
                                <a href="report-parameters.php?station_id=<?php echo $station_id; ?>&type=<?php echo $module_type; ?>&action=edit&edit_id=<?php echo $item['id']; ?>" class="btn btn-xs btn-outline-secondary rounded-pill px-2.5 font-weight-bold me-1 text-uppercase" style="font-size: 0.72rem; text-decoration: none;">Edit</a>
                                
                                <a href="report-parameters.php?station_id=<?php echo $station_id; ?>&type=<?php echo $module_type; ?>&action=toggle_status&id=<?php echo $item['id']; ?>" class="btn btn-xs <?php echo $item['status'] === 'Active' ? 'btn-outline-warning' : 'btn-outline-success'; ?> rounded-pill px-2.5 font-weight-bold me-1 text-uppercase" style="font-size: 0.72rem; text-decoration: none;">Status</a>
                                
                                <a href="report-parameters.php?station_id=<?php echo $station_id; ?>&type=<?php echo $module_type; ?>&action=delete_item&id=<?php echo $item['id']; ?>" class="btn btn-xs btn-outline-danger rounded-pill px-2.5 font-weight-bold text-uppercase" style="font-size: 0.72rem; text-decoration: none;" onclick="return confirm('Are you sure you want to delete this check item?');">Delete</a>
                              </td>
                            </tr>
                          <?php endforeach; ?>
                        <?php endif; ?>
                      </tbody>
                    </table>
                  </div>
                
                <!-- 9. Manpower Categories Layout View -->
                <?php elseif ($meta['type'] === 'manpower_categories'): ?>
                  <div class="table-responsive">
                    <table class="table table-hover table-striped align-middle mb-0">
                      <thead>
                        <tr>
                          <th class="ps-3">Category Name</th>
                          <th>Order No</th>
                          <th>Status</th>
                          <th class="text-center text-nowrap" style="width: 220px;">Actions</th>
                        </tr>
                      </thead>
                      <tbody>
                        <?php if (empty($flat_items)): ?>
                          <tr>
                            <td colspan="4" class="text-center py-5 text-muted small">No manpower categories configured.</td>
                          </tr>
                        <?php else: ?>
                          <?php foreach ($flat_items as $item): ?>
                            <tr>
                              <td class="ps-3"><strong><?php echo htmlspecialchars($item['category_name']); ?></strong></td>
                              <td><?php echo intval($item['order_no']); ?></td>
                              <td>
                                <span class="badge rounded-pill <?php echo $item['status'] === 'Active' ? 'bg-success-subtle text-success' : 'bg-danger-subtle text-danger'; ?>">
                                  <?php echo htmlspecialchars($item['status']); ?>
                                </span>
                              </td>
                              <td class="text-center text-nowrap">
                                <a href="report-parameters.php?station_id=<?php echo $station_id; ?>&type=<?php echo $module_type; ?>&action=edit&edit_id=<?php echo $item['id']; ?>" class="btn btn-xs btn-outline-secondary rounded-pill px-2.5 font-weight-bold me-1 text-uppercase" style="font-size: 0.72rem; text-decoration: none;">Edit</a>
                                
                                <a href="report-parameters.php?station_id=<?php echo $station_id; ?>&type=<?php echo $module_type; ?>&action=toggle_status&id=<?php echo $item['id']; ?>" class="btn btn-xs <?php echo $item['status'] === 'Active' ? 'btn-outline-warning' : 'btn-outline-success'; ?> rounded-pill px-2.5 font-weight-bold me-1 text-uppercase" style="font-size: 0.72rem; text-decoration: none;">Status</a>
                                
                                <a href="report-parameters.php?station_id=<?php echo $station_id; ?>&type=<?php echo $module_type; ?>&action=delete_item&id=<?php echo $item['id']; ?>" class="btn btn-xs btn-outline-danger rounded-pill px-2.5 font-weight-bold text-uppercase" style="font-size: 0.72rem; text-decoration: none;" onclick="return confirm('Are you sure you want to delete this category? Warning: Deleting a category may impact shifts mapped to it.');">Delete</a>
                              </td>
                            </tr>
                          <?php endforeach; ?>
                        <?php endif; ?>
                      </tbody>
                    </table>
                  </div>

                <!-- 6. Manpower Shifts Layout View -->
                <?php elseif ($meta['type'] === 'manpower_shifts'): ?>
                  <div class="table-responsive">
                    <table class="table table-hover table-striped align-middle mb-0">
                      <thead>
                        <tr>
                          <th class="ps-3">Category</th>
                          <th>Shift Name</th>
                          <th>Order No</th>
                          <th>Status</th>
                          <th class="text-center text-nowrap" style="width: 220px;">Actions</th>
                        </tr>
                      </thead>
                      <tbody>
                        <?php if (empty($flat_items)): ?>
                          <tr>
                            <td colspan="5" class="text-center py-5 text-muted small">No manpower shifts configured.</td>
                          </tr>
                        <?php else: ?>
                          <?php foreach ($flat_items as $item): ?>
                            <tr>
                              <td class="ps-3">
                                <span class="badge bg-indigo-subtle text-dark text-uppercase" style="font-size: 0.72rem;">
                                  <?php echo htmlspecialchars($item['category_name']); ?>
                                </span>
                              </td>
                              <td><strong><?php echo htmlspecialchars($item['shift_name']); ?></strong></td>
                              <td><?php echo intval($item['order_no']); ?></td>
                              <td>
                                <span class="badge rounded-pill <?php echo $item['status'] === 'Active' ? 'bg-success-subtle text-success' : 'bg-danger-subtle text-danger'; ?>">
                                  <?php echo htmlspecialchars($item['status']); ?>
                                </span>
                              </td>
                              <td class="text-center text-nowrap">
                                <a href="report-parameters.php?station_id=<?php echo $station_id; ?>&type=<?php echo $module_type; ?>&action=edit&edit_id=<?php echo $item['id']; ?>" class="btn btn-xs btn-outline-secondary rounded-pill px-2.5 font-weight-bold me-1 text-uppercase" style="font-size: 0.72rem; text-decoration: none;">Edit</a>
                                
                                <a href="report-parameters.php?station_id=<?php echo $station_id; ?>&type=<?php echo $module_type; ?>&action=toggle_status&id=<?php echo $item['id']; ?>" class="btn btn-xs <?php echo $item['status'] === 'Active' ? 'btn-outline-warning' : 'btn-outline-success'; ?> rounded-pill px-2.5 font-weight-bold me-1 text-uppercase" style="font-size: 0.72rem; text-decoration: none;">Status</a>
                                
                                <a href="report-parameters.php?station_id=<?php echo $station_id; ?>&type=<?php echo $module_type; ?>&action=delete_item&id=<?php echo $item['id']; ?>" class="btn btn-xs btn-outline-danger rounded-pill px-2.5 font-weight-bold text-uppercase" style="font-size: 0.72rem; text-decoration: none;" onclick="return confirm('Are you sure you want to delete this shift?');">Delete</a>
                              </td>
                            </tr>
                          <?php endforeach; ?>
                        <?php endif; ?>
                      </tbody>
                    </table>
                  </div>

                <!-- 7. Manpower Roles / Types Layout View -->
                <?php elseif ($meta['type'] === 'manpower_types'): ?>
                  <div class="table-responsive">
                    <table class="table table-hover table-striped align-middle mb-0">
                      <thead>
                        <tr>
                          <th class="ps-3">Role / Type Name</th>
                          <th>Order No</th>
                          <th>Status</th>
                          <th class="text-center text-nowrap" style="width: 220px;">Actions</th>
                        </tr>
                      </thead>
                      <tbody>
                        <?php if (empty($flat_items)): ?>
                          <tr>
                            <td colspan="4" class="text-center py-5 text-muted small">No manpower roles configured.</td>
                          </tr>
                        <?php else: ?>
                          <?php foreach ($flat_items as $item): ?>
                            <tr>
                              <td class="ps-3"><strong><?php echo htmlspecialchars($item['role_name']); ?></strong></td>
                              <td><?php echo intval($item['order_no']); ?></td>
                              <td>
                                <span class="badge rounded-pill <?php echo $item['status'] === 'Active' ? 'bg-success-subtle text-success' : 'bg-danger-subtle text-danger'; ?>">
                                  <?php echo htmlspecialchars($item['status']); ?>
                                </span>
                              </td>
                              <td class="text-center text-nowrap">
                                <a href="report-parameters.php?station_id=<?php echo $station_id; ?>&type=<?php echo $module_type; ?>&action=edit&edit_id=<?php echo $item['id']; ?>" class="btn btn-xs btn-outline-secondary rounded-pill px-2.5 font-weight-bold me-1 text-uppercase" style="font-size: 0.72rem; text-decoration: none;">Edit</a>
                                
                                <a href="report-parameters.php?station_id=<?php echo $station_id; ?>&type=<?php echo $module_type; ?>&action=toggle_status&id=<?php echo $item['id']; ?>" class="btn btn-xs <?php echo $item['status'] === 'Active' ? 'btn-outline-warning' : 'btn-outline-success'; ?> rounded-pill px-2.5 font-weight-bold me-1 text-uppercase" style="font-size: 0.72rem; text-decoration: none;">Status</a>
                                
                                <a href="report-parameters.php?station_id=<?php echo $station_id; ?>&type=<?php echo $module_type; ?>&action=delete_item&id=<?php echo $item['id']; ?>" class="btn btn-xs btn-outline-danger rounded-pill px-2.5 font-weight-bold text-uppercase" style="font-size: 0.72rem; text-decoration: none;" onclick="return confirm('Are you sure you want to delete this role?');">Delete</a>
                              </td>
                            </tr>
                          <?php endforeach; ?>
                        <?php endif; ?>
                      </tbody>
                    </table>
                  </div>

                <!-- 8. Manpower Shift-Role Mappings Layout View -->
                <?php elseif ($meta['type'] === 'manpower_shift_type_map'): ?>
                  <div class="table-responsive">
                    <table class="table table-hover table-striped align-middle mb-0">
                      <thead>
                        <tr>
                          <th class="ps-3">Category</th>
                          <th>Shift Name</th>
                          <th>Assigned Role / Type</th>
                          <th class="text-center" style="width: 150px;">Actions</th>
                        </tr>
                      </thead>
                      <tbody>
                        <?php if (empty($flat_items)): ?>
                          <tr>
                            <td colspan="4" class="text-center py-5 text-muted small">No shift-role mappings established yet.</td>
                          </tr>
                        <?php else: ?>
                          <?php foreach ($flat_items as $item): ?>
                            <tr>
                              <td class="ps-3">
                                <span class="badge bg-indigo-subtle text-dark text-uppercase" style="font-size: 0.72rem;">
                                  <?php echo htmlspecialchars($item['category_name']); ?>
                                </span>
                              </td>
                              <td><strong><?php echo htmlspecialchars($item['shift_name']); ?></strong></td>
                              <td><strong><?php echo htmlspecialchars($item['role_name']); ?></strong></td>
                              <td class="text-center">
                                <a href="report-parameters.php?station_id=<?php echo $station_id; ?>&type=<?php echo $module_type; ?>&action=delete_item&id=<?php echo $item['id']; ?>" class="btn btn-xs btn-outline-danger rounded-pill px-3 font-weight-bold text-uppercase" style="font-size: 0.72rem; text-decoration: none;" onclick="return confirm('Are you sure you want to delete this mapping?');">Delete</a>
                              </td>
                            </tr>
                          <?php endforeach; ?>
                        <?php endif; ?>
                      </tbody>
                    </table>
                  </div>
                <?php endif; ?>
                
              </div>
            </div>

            <!-- Shifts Directory Card (If shifts are enabled for this category) -->
            <?php if (isset($meta['shift_table'])): ?>
              <div class="card shadow-sm border-0 mb-4">
                <div class="card-header bg-white py-3">
                  <h5 class="mb-0 font-weight-bold text-dark d-flex align-items-center">
                    <i class="bi bi-clock-history text-indigo me-2"></i> Active Shifts Directory
                  </h5>
                </div>
                <div class="card-body p-0">
                  <div class="table-responsive">
                    <table class="table table-hover table-striped align-middle mb-0">
                      <thead>
                        <tr>
                          <th class="ps-3" style="width: 150px;">ID</th>
                          <th>Shift Name</th>
                          <th class="text-center" style="width: 180px;">Actions</th>
                        </tr>
                      </thead>
                      <tbody>
                        <?php if (empty($shift_items)): ?>
                          <tr>
                            <td colspan="3" class="text-center py-4 text-muted small">No shifts defined yet for this station profile.</td>
                          </tr>
                        <?php else: ?>
                          <?php foreach ($shift_items as $item): ?>
                            <tr>
                              <td class="ps-3"><strong>SHIFT-<?php echo $item['id']; ?></strong></td>
                              <td><strong><?php echo htmlspecialchars($item['shift']); ?></strong></td>
                              <td class="text-center">
                                <a href="report-parameters.php?station_id=<?php echo $station_id; ?>&type=<?php echo $module_type; ?>&action=edit&edit_id=<?php echo $item['id']; ?>&target=shift" class="btn btn-sm btn-outline-secondary rounded-pill px-3 font-weight-bold me-1 text-uppercase" style="font-size: 0.72rem; text-decoration: none;">Edit</a>
                                <a href="report-parameters.php?station_id=<?php echo $station_id; ?>&type=<?php echo $module_type; ?>&action=delete_shift&id=<?php echo $item['id']; ?>" class="btn btn-sm btn-outline-danger rounded-pill px-3 font-weight-bold text-uppercase" style="font-size: 0.72rem; text-decoration: none;" onclick="return confirm('Are you sure you want to delete this shift?');">Delete</a>
                              </td>
                            </tr>
                          <?php endforeach; ?>
                        <?php endif; ?>
                      </tbody>
                    </table>
                  </div>
                </div>
              </div>
            <?php endif; ?>

          </div>
          
          <!-- Right Side: Forms Column -->
          <div class="col-lg-4">
            
            <!-- 1. Scorecard Form (Parent/Group Creation + Sub-item Creation) -->
            <?php if ($meta['type'] === 'scorecard'): ?>
              <!-- A. Parent Parameter Card -->
              <div class="card shadow-sm border-0 mb-4">
                <div class="card-header bg-white py-3">
                  <h5 class="mb-0 font-weight-bold text-dark d-flex align-items-center">
                    <i class="bi <?php echo $edit_parent_data ? 'bi-pencil-square text-warning' : 'bi-plus-circle-fill text-indigo'; ?> me-2"></i>
                    <?php echo $edit_parent_data ? 'Update Group' : 'Create Group'; ?>
                  </h5>
                </div>
                <div class="card-body">
                  <form action="report-parameters.php" method="POST">
                    <input type="hidden" name="action" value="<?php echo $edit_parent_data ? 'edit_parent' : 'add_parent'; ?>">
                    <input type="hidden" name="station_id" value="<?php echo $station_id; ?>">
                    <input type="hidden" name="type" value="<?php echo $module_type; ?>">
                    <?php if ($edit_parent_data): ?>
                      <input type="hidden" name="parent_id" value="<?php echo $edit_parent_data['id']; ?>">
                    <?php endif; ?>
                    
                    <div class="mb-3">
                      <label for="parameter_name" class="form-label font-weight-bold text-secondary" style="font-size: 0.82rem; text-transform: uppercase;">Group Name</label>
                      <input type="text" class="form-control rounded-3" id="parameter_name" name="parameter_name" placeholder="e.g. Coach Interior Cleaning" required value="<?php echo $edit_parent_data ? htmlspecialchars($edit_parent_data['parameter_name']) : ''; ?>">
                    </div>
                    
                    <div class="mb-3">
                      <label for="parent_status" class="form-label font-weight-bold text-secondary" style="font-size: 0.82rem; text-transform: uppercase;">Status</label>
                      <select class="form-select rounded-3" id="parent_status" name="status">
                        <option value="Active" <?php echo ($edit_parent_data && $edit_parent_data['status'] === 'Active') ? 'selected' : ''; ?>>Active</option>
                        <option value="Inactive" <?php echo ($edit_parent_data && $edit_parent_data['status'] === 'Inactive') ? 'selected' : ''; ?>>Inactive</option>
                      </select>
                    </div>
                    
                    <div class="row g-2">
                      <div class="col-8">
                        <button type="submit" class="btn <?php echo $edit_parent_data ? 'btn-warning' : 'btn-indigo'; ?> w-100 p-2.5 rounded-3 font-weight-bold shadow-sm">
                          <?php echo $edit_parent_data ? 'Update Group' : 'Add Group'; ?>
                        </button>
                      </div>
                      <?php if ($edit_parent_data): ?>
                        <div class="col-4">
                          <a href="report-parameters.php?station_id=<?php echo $station_id; ?>&type=<?php echo $module_type; ?>" class="btn btn-outline-secondary w-100 p-2.5 rounded-3 font-weight-bold">Cancel</a>
                        </div>
                      <?php endif; ?>
                    </div>
                  </form>
                </div>
              </div>
              
              <!-- B. Child Parameter Card -->
              <div class="card shadow-sm border-0">
                <div class="card-header bg-white py-3">
                  <h5 class="mb-0 font-weight-bold text-dark d-flex align-items-center">
                    <i class="bi <?php echo $edit_child_data ? 'bi-pencil-square text-warning' : 'bi-plus-circle-fill text-indigo'; ?> me-2"></i>
                    <?php echo $edit_child_data ? 'Update Sub-parameter' : 'Add Sub-parameter'; ?>
                  </h5>
                </div>
                <div class="card-body">
                  <?php if (empty($parents_list)): ?>
                    <div class="alert alert-warning text-center small rounded-3 p-3 mb-0" role="alert">
                      <i class="bi bi-info-circle-fill d-block mb-1"></i>
                      You must create at least one <strong>Group</strong> above before adding sub-parameters.
                    </div>
                  <?php else: ?>
                    <form action="report-parameters.php" method="POST">
                      <input type="hidden" name="action" value="<?php echo $edit_child_data ? 'edit_child' : 'add_child'; ?>">
                      <input type="hidden" name="station_id" value="<?php echo $station_id; ?>">
                      <input type="hidden" name="type" value="<?php echo $module_type; ?>">
                      <?php if ($edit_child_data): ?>
                        <input type="hidden" name="child_id" value="<?php echo $edit_child_data['id']; ?>">
                      <?php endif; ?>
                      
                      <div class="mb-3">
                        <label for="parent_select" class="form-label font-weight-bold text-secondary" style="font-size: 0.82rem; text-transform: uppercase;">Select Parent Group</label>
                        <select class="form-select rounded-3" id="parent_select" name="parent_id" required>
                          <option value="">-- Choose Group --</option>
                          <?php foreach ($parents_list as $parent): ?>
                            <option value="<?php echo $parent['id']; ?>" <?php echo (($edit_child_data && $edit_child_data['parameter_id'] == $parent['id']) || (isset($_GET['parent_id']) && $_GET['parent_id'] == $parent['id'])) ? 'selected' : ''; ?>>
                              <?php echo htmlspecialchars($parent['parameter_name']); ?>
                            </option>
                          <?php endforeach; ?>
                        </select>
                      </div>
                      
                      <div class="mb-3">
                        <label for="sub_parameter_name" class="form-label font-weight-bold text-secondary" style="font-size: 0.82rem; text-transform: uppercase;">Sub-parameter Name</label>
                        <textarea class="form-control rounded-3" id="sub_parameter_name" name="sub_parameter_name" rows="3" placeholder="e.g. Wiping all berths and rexene panels" required><?php echo $edit_child_data ? htmlspecialchars($edit_child_data['sub_parameter_name']) : ''; ?></textarea>
                      </div>
                      
                      <div class="mb-3">
                        <label for="child_status" class="form-label font-weight-bold text-secondary" style="font-size: 0.82rem; text-transform: uppercase;">Status</label>
                        <select class="form-select rounded-3" id="child_status" name="status">
                          <option value="Active" <?php echo ($edit_child_data && $edit_child_data['status'] === 'Active') ? 'selected' : ''; ?>>Active</option>
                          <option value="Inactive" <?php echo ($edit_child_data && $edit_child_data['status'] === 'Inactive') ? 'selected' : ''; ?>>Inactive</option>
                        </select>
                      </div>
                      
                      <div class="row g-2">
                        <div class="col-8">
                          <button type="submit" class="btn <?php echo $edit_child_data ? 'btn-warning' : 'btn-indigo'; ?> w-100 p-2.5 rounded-3 font-weight-bold shadow-sm">
                            <?php echo $edit_child_data ? 'Update Sub-item' : 'Add Sub-item'; ?>
                          </button>
                        </div>
                        <?php if ($edit_child_data): ?>
                          <div class="col-4">
                            <a href="report-parameters.php?station_id=<?php echo $station_id; ?>&type=<?php echo $module_type; ?>" class="btn btn-outline-secondary w-100 p-2.5 rounded-3 font-weight-bold">Cancel</a>
                          </div>
                        <?php endif; ?>
                      </div>
                    </form>
                  <?php endif; ?>
                </div>
              </div>
              
            <!-- 2. Flat Scorecard Form (PLDC Scorecard) -->
            <?php elseif ($meta['type'] === 'flat_scorecard_with_shifts'): ?>
              <div class="card shadow-sm border-0">
                <div class="card-header bg-white py-3">
                  <h5 class="mb-0 font-weight-bold text-dark d-flex align-items-center">
                    <i class="bi <?php echo $edit_data ? 'bi-pencil-square text-warning' : 'bi-plus-circle-fill text-indigo'; ?> me-2"></i>
                    <?php echo $edit_data ? 'Update Parameter' : 'Create Parameter'; ?>
                  </h5>
                </div>
                <div class="card-body">
                  <form action="report-parameters.php" method="POST">
                    <input type="hidden" name="action" value="<?php echo $edit_data ? 'edit_flat_scorecard' : 'add_flat_scorecard'; ?>">
                    <input type="hidden" name="station_id" value="<?php echo $station_id; ?>">
                    <input type="hidden" name="type" value="<?php echo $module_type; ?>">
                    <?php if ($edit_data): ?>
                      <input type="hidden" name="item_id" value="<?php echo $edit_data['id']; ?>">
                    <?php endif; ?>
                    
                    <div class="mb-3">
                      <label for="parameter_name" class="form-label font-weight-bold text-secondary" style="font-size: 0.82rem; text-transform: uppercase;">Parameter Item Name</label>
                      <input type="text" class="form-control rounded-3" id="parameter_name" name="parameter_name" placeholder="e.g. Bleaching Power usage" required value="<?php echo $edit_data ? htmlspecialchars($edit_data['parameter_name']) : ''; ?>">
                    </div>
                    
                    <div class="row g-2">
                      <div class="col-8">
                        <button type="submit" class="btn <?php echo $edit_data ? 'btn-warning' : 'btn-indigo'; ?> w-100 p-2.5 rounded-3 font-weight-bold shadow-sm">
                          <?php echo $edit_data ? 'Update Item' : 'Add Item'; ?>
                        </button>
                      </div>
                      <?php if ($edit_data): ?>
                        <div class="col-4">
                          <a href="report-parameters.php?station_id=<?php echo $station_id; ?>&type=<?php echo $module_type; ?>" class="btn btn-outline-secondary w-100 p-2.5 rounded-3 font-weight-bold">Cancel</a>
                        </div>
                      <?php endif; ?>
                    </div>
                  </form>
                </div>
              </div>

            <!-- 3. Chemical Form -->
            <?php elseif ($meta['type'] === 'chemical_with_shifts'): ?>
              <div class="card shadow-sm border-0">
                <div class="card-header bg-white py-3">
                  <h5 class="mb-0 font-weight-bold text-dark d-flex align-items-center">
                    <i class="bi <?php echo $edit_data ? 'bi-pencil-square text-warning' : 'bi-plus-circle-fill text-indigo'; ?> me-2"></i>
                    <?php echo $edit_data ? 'Update Chemical' : 'Add Chemical'; ?>
                  </h5>
                </div>
                <div class="card-body">
                  <form action="report-parameters.php" method="POST">
                    <input type="hidden" name="action" value="<?php echo $edit_data ? 'edit_chemical' : 'add_chemical'; ?>">
                    <input type="hidden" name="station_id" value="<?php echo $station_id; ?>">
                    <input type="hidden" name="type" value="<?php echo $module_type; ?>">
                    <?php if ($edit_data): ?>
                      <input type="hidden" name="item_id" value="<?php echo $edit_data['id']; ?>">
                    <?php endif; ?>
                    
                    <div class="mb-3">
                      <label for="chem_name" class="form-label font-weight-bold text-secondary" style="font-size: 0.82rem; text-transform: uppercase;">Chemical Name</label>
                      <input type="text" class="form-control rounded-3" id="chem_name" name="name" placeholder="e.g. Glass Cleaning Agent" required value="<?php echo $edit_data ? htmlspecialchars($edit_data['name']) : ''; ?>">
                    </div>
                    
                    <div class="mb-3">
                      <label for="chem_units" class="form-label font-weight-bold text-secondary" style="font-size: 0.82rem; text-transform: uppercase;">Measurement Units</label>
                      <input type="text" class="form-control rounded-3" id="chem_units" name="units" placeholder="e.g. Liters or Nos." required value="<?php echo $edit_data ? htmlspecialchars($edit_data['units']) : ''; ?>">
                    </div>
                    
                    <div class="row g-2">
                      <div class="col-8">
                        <button type="submit" class="btn <?php echo $edit_data ? 'btn-warning' : 'btn-indigo'; ?> w-100 p-2.5 rounded-3 font-weight-bold shadow-sm">
                          <?php echo $edit_data ? 'Update Chemical' : 'Add Chemical'; ?>
                        </button>
                      </div>
                      <?php if ($edit_data): ?>
                        <div class="col-4">
                          <a href="report-parameters.php?station_id=<?php echo $station_id; ?>&type=<?php echo $module_type; ?>" class="btn btn-outline-secondary w-100 p-2.5 rounded-3 font-weight-bold">Cancel</a>
                        </div>
                      <?php endif; ?>
                    </div>
                  </form>
                </div>
              </div>

            <!-- 4. Machine Form -->
            <?php elseif ($meta['type'] === 'machine_with_shifts'): ?>
              <div class="card shadow-sm border-0">
                <div class="card-header bg-white py-3">
                  <h5 class="mb-0 font-weight-bold text-dark d-flex align-items-center">
                    <i class="bi <?php echo $edit_data ? 'bi-pencil-square text-warning' : 'bi-plus-circle-fill text-indigo'; ?> me-2"></i>
                    <?php echo $edit_data ? 'Update Machine' : 'Add Machine'; ?>
                  </h5>
                </div>
                <div class="card-body">
                  <form action="report-parameters.php" method="POST">
                    <input type="hidden" name="action" value="<?php echo $edit_data ? 'edit_machine' : 'add_machine'; ?>">
                    <input type="hidden" name="station_id" value="<?php echo $station_id; ?>">
                    <input type="hidden" name="type" value="<?php echo $module_type; ?>">
                    <?php if ($edit_data): ?>
                      <input type="hidden" name="item_id" value="<?php echo $edit_data['id']; ?>">
                    <?php endif; ?>
                    
                    <div class="mb-3">
                      <label for="mach_no" class="form-label font-weight-bold text-secondary" style="font-size: 0.82rem; text-transform: uppercase;">Machine Reference Code</label>
                      <input type="text" class="form-control rounded-3" id="mach_no" name="machine_no" placeholder="e.g. HHSD 1" required value="<?php echo $edit_data ? htmlspecialchars($edit_data['machine_no']) : ''; ?>">
                    </div>
                    
                    <div class="mb-3">
                      <label for="mach_name" class="form-label font-weight-bold text-secondary" style="font-size: 0.82rem; text-transform: uppercase;">Machine Description</label>
                      <textarea class="form-control rounded-3" id="mach_name" name="machine_name" rows="3" placeholder="e.g. Single disc floor scrubber" required><?php echo $edit_data ? htmlspecialchars($edit_data['machine_name']) : ''; ?></textarea>
                    </div>
                    
                    <div class="row g-2">
                      <div class="col-8">
                        <button type="submit" class="btn <?php echo $edit_data ? 'btn-warning' : 'btn-indigo'; ?> w-100 p-2.5 rounded-3 font-weight-bold shadow-sm">
                          <?php echo $edit_data ? 'Update Machine' : 'Add Machine'; ?>
                        </button>
                      </div>
                      <?php if ($edit_data): ?>
                        <div class="col-4">
                          <a href="report-parameters.php?station_id=<?php echo $station_id; ?>&type=<?php echo $module_type; ?>" class="btn btn-outline-secondary w-100 p-2.5 rounded-3 font-weight-bold">Cancel</a>
                        </div>
                      <?php endif; ?>
                    </div>
                  </form>
                </div>
              </div>

            <!-- 5. Surprise Visit Form -->
            <?php elseif ($meta['type'] === 'surprise'): ?>
              <div class="card shadow-sm border-0">
                <div class="card-header bg-white py-3">
                  <h5 class="mb-0 font-weight-bold text-dark d-flex align-items-center">
                    <i class="bi <?php echo $edit_data ? 'bi-pencil-square text-warning' : 'bi-plus-circle-fill text-indigo'; ?> me-2"></i>
                    <?php echo $edit_data ? 'Update Item' : 'Add Surprise Item'; ?>
                  </h5>
                </div>
                <div class="card-body">
                  <form action="report-parameters.php" method="POST">
                    <input type="hidden" name="action" value="<?php echo $edit_data ? 'edit_surprise' : 'add_surprise'; ?>">
                    <input type="hidden" name="station_id" value="<?php echo $station_id; ?>">
                    <input type="hidden" name="type" value="<?php echo $module_type; ?>">
                    <?php if ($edit_data): ?>
                      <input type="hidden" name="item_id" value="<?php echo $edit_data['id']; ?>">
                    <?php endif; ?>
                    
                    <div class="mb-3">
                      <label for="sur_category" class="form-label font-weight-bold text-secondary" style="font-size: 0.82rem; text-transform: uppercase;">Checklist Category</label>
                      <select class="form-select rounded-3" id="sur_category" name="category">
                        <option value="pit_office" <?php echo ($edit_data && $edit_data['category'] === 'pit_office') ? 'selected' : ''; ?>>Pit & Office Cleaning</option>
                        <option value="pf_trains" <?php echo ($edit_data && $edit_data['category'] === 'pf_trains') ? 'selected' : ''; ?>>PF Return Trains</option>
                      </select>
                    </div>
                    
                    <div class="mb-3">
                      <label for="sur_item" class="form-label font-weight-bold text-secondary" style="font-size: 0.82rem; text-transform: uppercase;">Check Item Name</label>
                      <input type="text" class="form-control rounded-3" id="sur_item" name="item_name" placeholder="e.g. Pathways Sanitation" required value="<?php echo $edit_data ? htmlspecialchars($edit_data['item_name']) : ''; ?>">
                    </div>
                    
                    <div class="mb-3">
                      <label for="sur_marks" class="form-label font-weight-bold text-secondary" style="font-size: 0.82rem; text-transform: uppercase;">Max Marks Available</label>
                      <input type="number" class="form-control rounded-3" id="sur_marks" name="max_marks" min="1" max="100" required value="<?php echo $edit_data ? intval($edit_data['max_marks']) : '5'; ?>">
                    </div>
                    
                    <div class="mb-3">
                      <label for="sur_desc" class="form-label font-weight-bold text-secondary" style="font-size: 0.82rem; text-transform: uppercase;">Evaluation Description Details</label>
                      <textarea class="form-control rounded-3" id="sur_desc" name="parameter_desc" rows="3" placeholder="e.g. Checks pathway cleanliness and waste disposal bin presence" required><?php echo $edit_data ? htmlspecialchars($edit_data['parameter_desc']) : ''; ?></textarea>
                    </div>
                    
                    <div class="mb-3">
                      <label for="sur_status" class="form-label font-weight-bold text-secondary" style="font-size: 0.82rem; text-transform: uppercase;">Status</label>
                      <select class="form-select rounded-3" id="sur_status" name="status">
                        <option value="Active" <?php echo ($edit_data && $edit_data['status'] === 'Active') ? 'selected' : ''; ?>>Active</option>
                        <option value="Inactive" <?php echo ($edit_data && $edit_data['status'] === 'Inactive') ? 'selected' : ''; ?>>Inactive</option>
                      </select>
                    </div>
                    
                    <div class="row g-2">
                      <div class="col-8">
                        <button type="submit" class="btn <?php echo $edit_data ? 'btn-warning' : 'btn-indigo'; ?> w-100 p-2.5 rounded-3 font-weight-bold shadow-sm">
                          <?php echo $edit_data ? 'Update Item' : 'Add Item'; ?>
                        </button>
                      </div>
                      <?php if ($edit_data): ?>
                        <div class="col-4">
                          <a href="report-parameters.php?station_id=<?php echo $station_id; ?>&type=<?php echo $module_type; ?>" class="btn btn-outline-secondary w-100 p-2.5 rounded-3 font-weight-bold">Cancel</a>
                        </div>
                      <?php endif; ?>
                    </div>
                  </form>
                </div>
              </div>

            <!-- 9. Manpower Categories Form -->
            <?php elseif ($meta['type'] === 'manpower_categories'): ?>
              <div class="card shadow-sm border-0">
                <div class="card-header bg-white py-3">
                  <h5 class="mb-0 font-weight-bold text-dark d-flex align-items-center">
                    <i class="bi <?php echo $edit_data ? 'bi-pencil-square text-warning' : 'bi-plus-circle-fill text-indigo'; ?> me-2"></i>
                    <?php echo $edit_data ? 'Update Category' : 'Add Manpower Category'; ?>
                  </h5>
                </div>
                <div class="card-body">
                  <form action="report-parameters.php" method="POST">
                    <input type="hidden" name="action" value="<?php echo $edit_data ? 'edit_manpower_category' : 'add_manpower_category'; ?>">
                    <input type="hidden" name="station_id" value="<?php echo $station_id; ?>">
                    <input type="hidden" name="type" value="<?php echo $module_type; ?>">
                    <?php if ($edit_data): ?>
                      <input type="hidden" name="item_id" value="<?php echo $edit_data['id']; ?>">
                    <?php endif; ?>
                    
                    <div class="mb-3">
                      <label for="category_name" class="form-label font-weight-bold text-secondary" style="font-size: 0.82rem; text-transform: uppercase;">Category Name</label>
                      <input type="text" class="form-control rounded-3" id="category_name" name="category_name" placeholder="e.g. Round House Cleaning" required value="<?php echo $edit_data ? htmlspecialchars($edit_data['category_name']) : ''; ?>">
                    </div>

                    <div class="mb-3">
                      <label for="order_no" class="form-label font-weight-bold text-secondary" style="font-size: 0.82rem; text-transform: uppercase;">Sort Order No</label>
                      <input type="number" class="form-control rounded-3" id="order_no" name="order_no" min="1" required value="<?php echo $edit_data ? intval($edit_data['order_no']) : '1'; ?>">
                    </div>

                    <div class="mb-3">
                      <label for="category_status" class="form-label font-weight-bold text-secondary" style="font-size: 0.82rem; text-transform: uppercase;">Status</label>
                      <select class="form-select rounded-3" id="category_status" name="status">
                        <option value="Active" <?php echo ($edit_data && $edit_data['status'] === 'Active') ? 'selected' : ''; ?>>Active</option>
                        <option value="Inactive" <?php echo ($edit_data && $edit_data['status'] === 'Inactive') ? 'selected' : ''; ?>>Inactive</option>
                      </select>
                    </div>
                    
                    <div class="row g-2">
                      <div class="col-8">
                        <button type="submit" class="btn <?php echo $edit_data ? 'btn-warning' : 'btn-indigo'; ?> w-100 p-2.5 rounded-3 font-weight-bold shadow-sm">
                          <?php echo $edit_data ? 'Update Category' : 'Add Category'; ?>
                        </button>
                      </div>
                      <?php if ($edit_data): ?>
                        <div class="col-4">
                          <a href="report-parameters.php?station_id=<?php echo $station_id; ?>&type=<?php echo $module_type; ?>" class="btn btn-outline-secondary w-100 p-2.5 rounded-3 font-weight-bold">Cancel</a>
                        </div>
                      <?php endif; ?>
                    </div>
                  </form>
                </div>
              </div>

            <!-- 6. Manpower Shifts Form -->
            <?php elseif ($meta['type'] === 'manpower_shifts'): ?>
              <?php
              $cat_list = [];
              try {
                  $cstmt = $pdo->prepare("SELECT id, category_name FROM mcc_manpower_categories WHERE station_id = :station_id AND status = 'Active' ORDER BY order_no ASC, id ASC");
                  $cstmt->execute(['station_id' => $station_id]);
                  $cat_list = $cstmt->fetchAll();
              } catch (Exception $e) {}
              ?>
              <div class="card shadow-sm border-0">
                <div class="card-header bg-white py-3">
                  <h5 class="mb-0 font-weight-bold text-dark d-flex align-items-center">
                    <i class="bi <?php echo $edit_data ? 'bi-pencil-square text-warning' : 'bi-plus-circle-fill text-indigo'; ?> me-2"></i>
                    <?php echo $edit_data ? 'Update Shift' : 'Add Manpower Shift'; ?>
                  </h5>
                </div>
                <div class="card-body">
                  <?php if (empty($cat_list)): ?>
                    <div class="alert alert-warning text-center small rounded-3 p-3 mb-0" role="alert">
                      <i class="bi bi-info-circle-fill d-block mb-1"></i>
                      No active Manpower Categories found for this Depot Station.
                    </div>
                  <?php else: ?>
                    <form action="report-parameters.php" method="POST">
                      <input type="hidden" name="action" value="<?php echo $edit_data ? 'edit_manpower_shift' : 'add_manpower_shift'; ?>">
                      <input type="hidden" name="station_id" value="<?php echo $station_id; ?>">
                      <input type="hidden" name="type" value="<?php echo $module_type; ?>">
                      <?php if ($edit_data): ?>
                        <input type="hidden" name="item_id" value="<?php echo $edit_data['id']; ?>">
                      <?php endif; ?>
                      
                      <div class="mb-3">
                        <label for="category_id" class="form-label font-weight-bold text-secondary" style="font-size: 0.82rem; text-transform: uppercase;">Select Category</label>
                        <select class="form-select rounded-3" id="category_id" name="category_id" required>
                          <option value="">-- Choose Category --</option>
                          <?php foreach ($cat_list as $cat): ?>
                            <option value="<?php echo $cat['id']; ?>" <?php echo ($edit_data && $edit_data['category_id'] == $cat['id']) ? 'selected' : ''; ?>>
                              <?php echo htmlspecialchars($cat['category_name']); ?>
                            </option>
                          <?php endforeach; ?>
                        </select>
                      </div>

                      <div class="mb-3">
                        <label for="shift_name" class="form-label font-weight-bold text-secondary" style="font-size: 0.82rem; text-transform: uppercase;">Shift Name</label>
                        <input type="text" class="form-control rounded-3" id="shift_name" name="shift_name" placeholder="e.g. Shift 1" required value="<?php echo $edit_data ? htmlspecialchars($edit_data['shift_name']) : ''; ?>">
                      </div>

                      <div class="mb-3">
                        <label for="order_no" class="form-label font-weight-bold text-secondary" style="font-size: 0.82rem; text-transform: uppercase;">Sort Order No</label>
                        <input type="number" class="form-control rounded-3" id="order_no" name="order_no" min="1" required value="<?php echo $edit_data ? intval($edit_data['order_no']) : '1'; ?>">
                      </div>

                      <div class="mb-3">
                        <label for="shift_status" class="form-label font-weight-bold text-secondary" style="font-size: 0.82rem; text-transform: uppercase;">Status</label>
                        <select class="form-select rounded-3" id="shift_status" name="status">
                          <option value="Active" <?php echo ($edit_data && $edit_data['status'] === 'Active') ? 'selected' : ''; ?>>Active</option>
                          <option value="Inactive" <?php echo ($edit_data && $edit_data['status'] === 'Inactive') ? 'selected' : ''; ?>>Inactive</option>
                        </select>
                      </div>
                      
                      <div class="row g-2">
                        <div class="col-8">
                          <button type="submit" class="btn <?php echo $edit_data ? 'btn-warning' : 'btn-indigo'; ?> w-100 p-2.5 rounded-3 font-weight-bold shadow-sm">
                            <?php echo $edit_data ? 'Update Shift' : 'Add Shift'; ?>
                          </button>
                        </div>
                        <?php if ($edit_data): ?>
                          <div class="col-4">
                            <a href="report-parameters.php?station_id=<?php echo $station_id; ?>&type=<?php echo $module_type; ?>" class="btn btn-outline-secondary w-100 p-2.5 rounded-3 font-weight-bold">Cancel</a>
                          </div>
                        <?php endif; ?>
                      </div>
                    </form>
                  <?php endif; ?>
                </div>
              </div>

            <!-- 7. Manpower Roles / Types Form -->
            <?php elseif ($meta['type'] === 'manpower_types'): ?>
              <div class="card shadow-sm border-0">
                <div class="card-header bg-white py-3">
                  <h5 class="mb-0 font-weight-bold text-dark d-flex align-items-center">
                    <i class="bi <?php echo $edit_data ? 'bi-pencil-square text-warning' : 'bi-plus-circle-fill text-indigo'; ?> me-2"></i>
                    <?php echo $edit_data ? 'Update Role' : 'Add Manpower Role'; ?>
                  </h5>
                </div>
                <div class="card-body">
                  <form action="report-parameters.php" method="POST">
                    <input type="hidden" name="action" value="<?php echo $edit_data ? 'edit_manpower_type' : 'add_manpower_type'; ?>">
                    <input type="hidden" name="station_id" value="<?php echo $station_id; ?>">
                    <input type="hidden" name="type" value="<?php echo $module_type; ?>">
                    <?php if ($edit_data): ?>
                      <input type="hidden" name="item_id" value="<?php echo $edit_data['id']; ?>">
                    <?php endif; ?>
                    
                    <div class="mb-3">
                      <label for="role_name" class="form-label font-weight-bold text-secondary" style="font-size: 0.82rem; text-transform: uppercase;">Role / Type Name</label>
                      <input type="text" class="form-control rounded-3" id="role_name" name="role_name" placeholder="e.g. Staff or Supervisor" required value="<?php echo $edit_data ? htmlspecialchars($edit_data['role_name']) : ''; ?>">
                    </div>

                    <div class="mb-3">
                      <label for="order_no" class="form-label font-weight-bold text-secondary" style="font-size: 0.82rem; text-transform: uppercase;">Sort Order No</label>
                      <input type="number" class="form-control rounded-3" id="order_no" name="order_no" min="1" required value="<?php echo $edit_data ? intval($edit_data['order_no']) : '1'; ?>">
                    </div>

                    <div class="mb-3">
                      <label for="role_status" class="form-label font-weight-bold text-secondary" style="font-size: 0.82rem; text-transform: uppercase;">Status</label>
                      <select class="form-select rounded-3" id="role_status" name="status">
                        <option value="Active" <?php echo ($edit_data && $edit_data['status'] === 'Active') ? 'selected' : ''; ?>>Active</option>
                        <option value="Inactive" <?php echo ($edit_data && $edit_data['status'] === 'Inactive') ? 'selected' : ''; ?>>Inactive</option>
                      </select>
                    </div>
                    
                    <div class="row g-2">
                      <div class="col-8">
                        <button type="submit" class="btn <?php echo $edit_data ? 'btn-warning' : 'btn-indigo'; ?> w-100 p-2.5 rounded-3 font-weight-bold shadow-sm">
                          <?php echo $edit_data ? 'Update Role' : 'Add Role'; ?>
                        </button>
                      </div>
                      <?php if ($edit_data): ?>
                        <div class="col-4">
                          <a href="report-parameters.php?station_id=<?php echo $station_id; ?>&type=<?php echo $module_type; ?>" class="btn btn-outline-secondary w-100 p-2.5 rounded-3 font-weight-bold">Cancel</a>
                        </div>
                      <?php endif; ?>
                    </div>
                  </form>
                </div>
              </div>

            <!-- 8. Manpower Shift-Role Mappings Form -->
            <?php elseif ($meta['type'] === 'manpower_shift_type_map'): ?>
              <?php
              $sh_list = [];
              try {
                  $shstmt = $pdo->prepare("SELECT s.id, s.shift_name, c.category_name FROM mcc_manpower_shifts s JOIN mcc_manpower_categories c ON s.category_id = c.id WHERE c.station_id = :station_id AND s.status = 'Active' ORDER BY c.order_no ASC, s.order_no ASC");
                  $shstmt->execute(['station_id' => $station_id]);
                  $sh_list = $shstmt->fetchAll();
              } catch (Exception $e) {}

              $ty_list = [];
              try {
                  $tystmt = $pdo->prepare("SELECT id, role_name FROM mcc_manpower_types WHERE station_id = :station_id AND status = 'Active' ORDER BY order_no ASC, id ASC");
                  $tystmt->execute(['station_id' => $station_id]);
                  $ty_list = $tystmt->fetchAll();
              } catch (Exception $e) {}
              ?>
              <div class="card shadow-sm border-0">
                <div class="card-header bg-white py-3">
                  <h5 class="mb-0 font-weight-bold text-dark d-flex align-items-center">
                    <i class="bi bi-plus-circle-fill text-indigo me-2"></i> Create Shift-Role Mapping
                  </h5>
                </div>
                <div class="card-body">
                  <?php if (empty($sh_list) || empty($ty_list)): ?>
                    <div class="alert alert-warning text-center small rounded-3 p-3 mb-0" role="alert">
                      <i class="bi bi-info-circle-fill d-block mb-1"></i>
                      You must configure both active **Shifts** and active **Roles/Types** before mapping them.
                    </div>
                  <?php else: ?>
                    <form action="report-parameters.php" method="POST">
                      <input type="hidden" name="action" value="add_manpower_shift_type_map">
                      <input type="hidden" name="station_id" value="<?php echo $station_id; ?>">
                      <input type="hidden" name="type" value="<?php echo $module_type; ?>">
                      
                      <div class="mb-3">
                        <label for="shift_id" class="form-label font-weight-bold text-secondary" style="font-size: 0.82rem; text-transform: uppercase;">Select Active Shift</label>
                        <select class="form-select rounded-3" id="shift_id" name="shift_id" required>
                          <option value="">-- Choose Shift --</option>
                          <?php foreach ($sh_list as $sh): ?>
                            <option value="<?php echo $sh['id']; ?>">
                              <?php echo htmlspecialchars($sh['category_name'] . ' -> ' . $sh['shift_name']); ?>
                            </option>
                          <?php endforeach; ?>
                        </select>
                      </div>

                      <div class="mb-3">
                        <label for="manpower_type_id" class="form-label font-weight-bold text-secondary" style="font-size: 0.82rem; text-transform: uppercase;">Select Active Role / Type</label>
                        <select class="form-select rounded-3" id="manpower_type_id" name="manpower_type_id" required>
                          <option value="">-- Choose Role --</option>
                          <?php foreach ($ty_list as $ty): ?>
                            <option value="<?php echo $ty['id']; ?>">
                              <?php echo htmlspecialchars($ty['role_name']); ?>
                            </option>
                          <?php endforeach; ?>
                        </select>
                      </div>
                      
                      <button type="submit" class="btn btn-indigo w-100 p-2.5 rounded-3 font-weight-bold shadow-sm">
                        Create Mapping
                      </button>
                    </form>
                  <?php endif; ?>
                </div>
              </div>
            <?php endif; ?>

            <!-- Shifts Form Card (Rendered below parameters form if report model has shifts) -->
            <?php if (isset($meta['shift_table'])): ?>
              <div class="card shadow-sm border-0 mt-4">
                <div class="card-header bg-white py-3">
                  <h5 class="mb-0 font-weight-bold text-dark d-flex align-items-center">
                    <i class="bi <?php echo $edit_shift_data ? 'bi-pencil-square text-warning' : 'bi-plus-circle-fill text-indigo'; ?> me-2"></i>
                    <?php echo $edit_shift_data ? 'Update Shift' : 'Add Shift Option'; ?>
                  </h5>
                </div>
                <div class="card-body">
                  <form action="report-parameters.php" method="POST">
                    <input type="hidden" name="action" value="<?php echo $edit_shift_data ? 'edit_shift' : 'add_shift'; ?>">
                    <input type="hidden" name="station_id" value="<?php echo $station_id; ?>">
                    <input type="hidden" name="type" value="<?php echo $module_type; ?>">
                    <?php if ($edit_shift_data): ?>
                      <input type="hidden" name="item_id" value="<?php echo $edit_shift_data['id']; ?>">
                    <?php endif; ?>
                    
                    <div class="mb-3">
                      <label for="shift_name" class="form-label font-weight-bold text-secondary" style="font-size: 0.82rem; text-transform: uppercase;">Shift Name</label>
                      <input type="text" class="form-control rounded-3" id="shift_name" name="shift" placeholder="e.g. Shift-I (06:00 - 14:00)" required value="<?php echo $edit_shift_data ? htmlspecialchars($edit_shift_data['shift']) : ''; ?>">
                    </div>
                    
                    <div class="row g-2">
                      <div class="col-8">
                        <button type="submit" class="btn <?php echo $edit_shift_data ? 'btn-warning' : 'btn-indigo'; ?> w-100 p-2.5 rounded-3 font-weight-bold shadow-sm">
                          <?php echo $edit_shift_data ? 'Update Shift' : 'Add Shift'; ?>
                        </button>
                      </div>
                      <?php if ($edit_shift_data): ?>
                        <div class="col-4">
                          <a href="report-parameters.php?station_id=<?php echo $station_id; ?>&type=<?php echo $module_type; ?>" class="btn btn-outline-secondary w-100 p-2.5 rounded-3 font-weight-bold">Cancel</a>
                        </div>
                      <?php endif; ?>
                    </div>
                  </form>
                </div>
              </div>
            <?php endif; ?>
            
          </div>
        </div>
      <?php endif; ?>
      
    </div>
  </div>
</main>

<style>
  .btn-indigo {
    background: linear-gradient(135deg, var(--admin-primary) 0%, var(--admin-primary-dark) 100%);
    color: white;
    border: none;
    transition: all 0.3s ease;
  }
  .btn-indigo:hover {
    box-shadow: 0 4px 15px rgba(99, 102, 241, 0.4);
    transform: translateY(-1px);
    color: white;
  }
  .btn-outline-indigo {
    border-color: var(--admin-primary);
    color: var(--admin-primary);
    transition: all 0.3s ease;
  }
  .btn-outline-indigo:hover {
    background-color: var(--admin-primary);
    color: white;
  }
  .table-indigo-subtle {
    border-bottom: 2px solid #e2e8f0;
  }
  .btn-xs {
    padding: 0.25rem 0.6rem;
    font-size: 0.75rem;
    line-height: 1.2;
    border-radius: 999px;
  }
</style>

<?php include 'footer.php'; ?>
