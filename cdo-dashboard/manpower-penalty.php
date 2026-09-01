<?php
require_once 'auth.php';

// Target month & year selection (Effective Month)
$selectedMonth = $_GET['month'] ?? date('m');
$selectedYear = $_GET['year'] ?? date('Y');

// Standardize
$selectedMonth = str_pad($selectedMonth, 2, '0', STR_PAD_LEFT);
$selectedYear = intval($selectedYear);

$effectiveMonthDate = $selectedYear . "-" . $selectedMonth . "-01";

// Fetch active manpower types (roles) for this station
$rolesStmt = $pdo->prepare("
    SELECT id, role_name 
    FROM mcc_manpower_types 
    WHERE station_id = :station_id AND status = 'Active' 
    ORDER BY order_no ASC, id ASC
");
$rolesStmt->execute(['station_id' => $stationId]);
$rolesList = $rolesStmt->fetchAll();

$successMsg = '';
$errorMsg = '';

// Handle save post request
if ($_SERVER['REQUEST_METHOD'] === 'POST' && isset($_POST['save_penalty'])) {
    if (!empty($isViewer)) {
        $errorMsg = "Viewers are in read-only mode and cannot save penalty configurations.";
    } else {
        $selectedMonth = $_POST['month'] ?? '';
        $selectedYear = $_POST['year'] ?? '';
        
        if (!empty($selectedMonth) && !empty($selectedYear)) {
            $effectiveMonthDate = $selectedYear . "-" . str_pad($selectedMonth, 2, '0', STR_PAD_LEFT) . "-01";
            
            $absentPenalties = $_POST['absent_penalty'] ?? [];
            $dressPenalties = $_POST['dress_penalty'] ?? [];
            $gearsPenalties = $_POST['gears_penalty'] ?? [];
            
            $pdo->beginTransaction();
            try {
                // Delete existing configurations for this station and effective month
                $deleteStmt = $pdo->prepare("
                    DELETE FROM mcc_manpower_penalties 
                    WHERE station_id = :station_id AND effective_month = :effective_month
                ");
                $deleteStmt->execute([
                    'station_id' => $stationId,
                    'effective_month' => $effectiveMonthDate
                ]);
                
                // Insert updated penalty rates
                $insertStmt = $pdo->prepare("
                    INSERT INTO mcc_manpower_penalties 
                    (station_id, effective_month, manpower_type_id, absent_penalty, dress_penalty, gears_penalty) 
                    VALUES (:station_id, :effective_month, :manpower_type_id, :absent_penalty, :dress_penalty, :gears_penalty)
                ");
                
                foreach ($rolesList as $role) {
                    $tId = $role['id'];
                    $absentPen = floatval($absentPenalties[$tId] ?? 0);
                    $dressPen = floatval($dressPenalties[$tId] ?? 0);
                    $gearsPen = floatval($gearsPenalties[$tId] ?? 0);
                    
                    $insertStmt->execute([
                        'station_id' => $stationId,
                        'effective_month' => $effectiveMonthDate,
                        'manpower_type_id' => $tId,
                        'absent_penalty' => $absentPen,
                        'dress_penalty' => $dressPen,
                        'gears_penalty' => $gearsPen
                    ]);
                }
                
                $pdo->commit();
                $successMsg = "Manpower penalty rates updated successfully for " . date('F, Y', strtotime($effectiveMonthDate)) . "!";
            } catch (Exception $e) {
                if ($pdo->inTransaction()) {
                    $pdo->rollBack();
                }
                $errorMsg = "Error saving penalty rates: " . $e->getMessage();
            }
        }
    }
}

// Fetch effective penalties configurations (most recent month <= selected month)
$existingPenalties = [];
$penStmt = $pdo->prepare("
    SELECT p1.manpower_type_id, p1.absent_penalty, p1.dress_penalty, p1.gears_penalty 
    FROM mcc_manpower_penalties p1
    INNER JOIN (
        SELECT manpower_type_id, MAX(effective_month) AS max_month
        FROM mcc_manpower_penalties
        WHERE station_id = :station_id1 AND effective_month <= :selected_month
        GROUP BY manpower_type_id
    ) p2 ON p1.manpower_type_id = p2.manpower_type_id AND p1.effective_month = p2.max_month
    WHERE p1.station_id = :station_id2
");
$penStmt->execute([
    'station_id1' => $stationId,
    'station_id2' => $stationId,
    'selected_month' => $effectiveMonthDate
]);
$penRows = $penStmt->fetchAll();
foreach ($penRows as $row) {
    $existingPenalties[$row['manpower_type_id']] = [
        'absent' => $row['absent_penalty'],
        'dress' => $row['dress_penalty'],
        'gears' => $row['gears_penalty']
    ];
}

$pageTitle = 'Set Monthly Manpower Penalty | MCC';

$extraStyles = "
.penalty-input {
    width: 130px;
    padding: 6px 12px;
    border: 1px solid #cbd5e1;
    border-radius: 6px;
    text-align: center;
    font-weight: 600;
    outline: none;
    font-size: 14px;
    transition: all 0.2s ease;
    height: 38px;
    background-color: #f8fafc;
}
.penalty-input:focus {
    border-color: #1987C6;
    background-color: #fff;
    box-shadow: 0 0 0 3px rgba(25, 135, 198, 0.15);
}
";

include 'header.php';
include 'sidebar.php';
?>

<style>
@media print {
    .app-header, 
    .app-sidebar, 
    .app-footer, 
    .no-print, 
    .report-filter,
    form.report-filter,
    div.no-print,
    .sidebar-overlay,
    .sidebar-backdrop,
    #sidebar-overlay {
        display: none !important;
        opacity: 0 !important;
        visibility: hidden !important;
        height: 0 !important;
        padding: 0 !important;
        margin: 0 !important;
    }
    
    html,
    body, 
    .bg-body-tertiary,
    .app-wrapper, 
    .app-main, 
    .app-content, 
    .container-fluid, 
    .report-wrap {
        margin: 0 !important;
        padding: 0 !important;
        width: 100% !important;
        max-width: 100% !important;
        background: #ffffff !important;
        background-color: #ffffff !important;
        box-shadow: none !important;
        border: none !important;
        height: auto !important;
    }
    
    .app-main {
        padding-top: 0 !important;
        margin-left: 0 !important;
    }
    
    .report-frame {
        border: none !important;
        box-shadow: none !important;
    }
    
    .table-responsive {
        overflow: visible !important;
        display: block !important;
    }
    
    .report-table thead th {
        background-color: #f1f5f9 !important;
        background: #f1f5f9 !important;
        -webkit-print-color-adjust: exact !important;
        print-color-adjust: exact !important;
    }
}
</style>

<main class="app-main">
    <div class="app-content">
        <div class="container-fluid" style="padding-top: 15px;">
            
            <!-- Filters & Navigation Bar -->
            <form class="report-filter no-print" method="GET" style="display: flex; justify-content: space-between; align-items: center; background: #fff; border: 1px solid #e2e8f0; padding: 12px 20px; border-radius: 8px; margin-bottom: 15px; box-shadow: 0 2px 4px rgba(0,0,0,0.04); flex-wrap: wrap; gap: 15px;">
                <div style="display: flex; align-items: center; gap: 12px;">
                    <label for="month" style="font-weight: 700; margin: 0; font-size: 14px; color: #334155; white-space: nowrap;">Effective Month</label>
                    <select id="month" name="month" style="border: 1px solid #cbd5e1; border-radius: 6px; padding: 6px 12px; font-size: 14px; background-color: #f8fafc; color: #334155; width: 140px; cursor: pointer; height: 38px; outline: none;">
                        <?php
                        for ($m = 1; $m <= 12; $m++) {
                            $mVal = str_pad($m, 2, '0', STR_PAD_LEFT);
                            $mName = date('F', mktime(0, 0, 0, $m, 1));
                            $selected = ($mVal == $selectedMonth) ? 'selected' : '';
                            echo "<option value=\"$mVal\" $selected>$mName</option>";
                        }
                        ?>
                    </select>
                    
                    <select id="year" name="year" style="border: 1px solid #cbd5e1; border-radius: 6px; padding: 6px 12px; font-size: 14px; background-color: #f8fafc; color: #334155; width: 100px; cursor: pointer; height: 38px; outline: none;">
                        <?php
                        $currentYear = intval(date('Y'));
                        for ($y = $currentYear - 3; $y <= $currentYear + 2; $y++) {
                            $selected = ($y == $selectedYear) ? 'selected' : '';
                            echo "<option value=\"$y\" $selected>$y</option>";
                        }
                        ?>
                    </select>
                    <button type="submit" class="btn-go" style="background: #1987C6 !important; color: white !important; font-weight: 700; font-size: 14px; padding: 8px 24px; border-radius: 6px; border: none; cursor: pointer; height: 38px; display: inline-flex; align-items: center;">
                        Show
                    </button>
                </div>
                
                <div style="display: flex; gap: 10px; flex-wrap: wrap;">
                    <a href="man-power-log.php?from_date=<?= urlencode(date('Y-m-d', strtotime($effectiveMonthDate))) ?>&to_date=<?= urlencode(date('Y-m-t', strtotime($effectiveMonthDate))) ?>" class="btn-print" style="background: #4b5563 !important; color: white !important; text-decoration: none; padding: 8px 16px; border-radius: 6px; font-weight: 700; font-size: 14px; display: inline-flex; align-items: center; border: none; height: 38px;">
                        Back to Log
                    </a>
                    <button type="button" class="btn-print" onclick="window.print()" style="background: #15803d !important; color: white !important; padding: 8px 16px; border-radius: 6px; font-weight: 700; font-size: 14px; display: inline-flex; align-items: center; border: none; height: 38px;">
                        Print
                    </button>
                </div>
            </form>

            <?php if (!empty($successMsg)): ?>
                <div class="alert alert-success no-print" style="margin-bottom: 20px; border-radius: 8px; padding: 12px 20px; border: 1px solid #c3e6cb; background-color: #d4edda; color: #155724;">
                    <i class="bi bi-check-circle-fill me-2"></i> <?= htmlspecialchars($successMsg) ?>
                </div>
            <?php endif; ?>
            <?php if (!empty($errorMsg)): ?>
                <div class="alert alert-danger no-print" style="margin-bottom: 20px; border-radius: 8px; padding: 12px 20px; border: 1px solid #f5c6cb; background-color: #f8d7da; color: #721c24;">
                    <i class="bi bi-exclamation-triangle-fill me-2"></i> <?= htmlspecialchars($errorMsg) ?>
                </div>
            <?php endif; ?>

            <!-- Main target configurations sheet -->
            <div class="report-wrap">
                <div class="report-frame">
                    <div class="report-header" style="text-align: center; margin-bottom: 15px;">
                        <h2 style="font-weight: 700; margin-bottom: 5px;">Manpower Penalty Setup</h2>
                        <p style="font-weight: 600; color: #334155; margin-bottom: 5px; font-size: 0.95rem;">
                            Division: <?= htmlspecialchars($divisionName) ?> | Station: <?= htmlspecialchars($stationName) ?> | Effective Month: <?= date('Y-m', strtotime($effectiveMonthDate)) ?>
                        </p>
                        <p style="font-size: 0.95rem; color: #475569; margin-bottom: 15px;">Penalty is configured manpower-type-wise. New effective month starts a new rate period.</p>
                    </div>

                    <?php if (empty($rolesList)): ?>
                        <div class="alert alert-info" style="margin: 20px 0; border-radius: 8px; padding: 12px 20px; border: 1px solid #bee5eb; background-color: #d1ecf1; color: #0c5460; text-align: center;">
                            <i class="bi bi-info-circle-fill me-2"></i> No active manpower types configured for this station.
                        </div>
                    <?php else: ?>
                        <form method="POST" action="">
                            <input type="hidden" name="month" value="<?= htmlspecialchars($selectedMonth); ?>">
                            <input type="hidden" name="year" value="<?= htmlspecialchars($selectedYear); ?>">
                            
                            <div class="table-responsive">
                                <table class="report-table">
                                    <thead>
                                        <tr>
                                            <th>Manpower Type</th>
                                            <th>Absent Penalty</th>
                                            <th>Dress Code Penalty</th>
                                            <th>Gears Penalty</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <?php foreach ($rolesList as $role): 
                                            $roleId = $role['id'];
                                            
                                            // Get saved penalties or default to empty
                                            $absVal = isset($existingPenalties[$roleId]['absent']) ? floatval($existingPenalties[$roleId]['absent']) : '';
                                            $dressVal = isset($existingPenalties[$roleId]['dress']) ? floatval($existingPenalties[$roleId]['dress']) : '';
                                            $gearsVal = isset($existingPenalties[$roleId]['gears']) ? floatval($existingPenalties[$roleId]['gears']) : '';
                                            
                                            // Convert to int if integer for clean display
                                            if ($absVal !== '' && $absVal == intval($absVal)) $absVal = intval($absVal);
                                            if ($dressVal !== '' && $dressVal == intval($dressVal)) $dressVal = intval($dressVal);
                                            if ($gearsVal !== '' && $gearsVal == intval($gearsVal)) $gearsVal = intval($gearsVal);
                                        ?>
                                            <tr>
                                                <td style="font-weight: 500; text-align: center; vertical-align: middle;">
                                                    <?= htmlspecialchars($role['role_name']) ?>
                                                </td>
                                                <td style="text-align: center;">
                                                    <input type="number" min="0" step="1" 
                                                        name="absent_penalty[<?= $roleId ?>]" 
                                                        value="<?= htmlspecialchars($absVal) ?>" 
                                                        class="penalty-input" required placeholder="0">
                                                </td>
                                                <td style="text-align: center;">
                                                    <input type="number" min="0" step="1" 
                                                        name="dress_penalty[<?= $roleId ?>]" 
                                                        value="<?= htmlspecialchars($dressVal) ?>" 
                                                        class="penalty-input" required placeholder="0">
                                                </td>
                                                <td style="text-align: center;">
                                                    <input type="number" min="0" step="1" 
                                                        name="gears_penalty[<?= $roleId ?>]" 
                                                        value="<?= htmlspecialchars($gearsVal) ?>" 
                                                        class="penalty-input" required placeholder="0">
                                                </td>
                                            </tr>
                                        <?php endforeach; ?>
                                    </tbody>
                                </table>
                            </div>

                            <!-- Save Penalty Button -->
                            <div style="text-align: center; margin-top: 25px;" class="no-print">
                                <button type="submit" name="save_penalty" class="btn btn-success" <?= !empty($isViewer) ? 'disabled title="Read-only mode: Viewers cannot save penalty rates"' : '' ?> style="background-color: #1987C6; border: none; font-weight: 700; font-size: 15px; padding: 10px 30px; border-radius: 6px; box-shadow: 0 4px 6px rgba(0,0,0,0.1); cursor: <?= !empty($isViewer) ? 'not-allowed' : 'pointer' ?>; opacity: <?= !empty($isViewer) ? '0.65' : '1' ?>;">
                                    <?= !empty($isViewer) ? '<i class="bi bi-lock-fill me-1"></i> Targets Locked (Read-Only)' : 'Save Penalty' ?>
                                </button>
                            </div>
                        </form>
                    <?php endif; ?>

                </div>
            </div>
        </div>
    </div>
</main>

<?php include 'footer.php'; ?>
