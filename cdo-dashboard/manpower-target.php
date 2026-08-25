<?php
require_once 'auth.php';

// Target month & year selection
$selectedMonth = $_GET['month'] ?? date('m');
$selectedYear = $_GET['year'] ?? date('Y');

// Standardize
$selectedMonth = str_pad($selectedMonth, 2, '0', STR_PAD_LEFT);
$selectedYear = intval($selectedYear);

$targetMonthDate = $selectedYear . "-" . $selectedMonth . "-01";

// Fetch active categories, shifts, and mapped roles (sorted by order_no)
$categories = [];
$catStmt = $pdo->prepare("
    SELECT id, category_name 
    FROM mcc_manpower_categories 
    WHERE station_id = :station_id AND status = 'Active' 
    ORDER BY order_no ASC, id ASC
");
$catStmt->execute(['station_id' => $stationId]);
$catList = $catStmt->fetchAll();

// We will also build a lookup map of manpower_type_id => role_name for inserting targets
$roleNamesMap = [];

foreach ($catList as $cat) {
    $categoryId = $cat['id'];
    $shifts = [];
    $shiftStmt = $pdo->prepare("
        SELECT id, shift_name 
        FROM mcc_manpower_shifts 
        WHERE category_id = :category_id AND status = 'Active' 
        ORDER BY order_no ASC, id ASC
    ");
    $shiftStmt->execute(['category_id' => $categoryId]);
    $shiftList = $shiftStmt->fetchAll();

    foreach ($shiftList as $sh) {
        $shiftId = $sh['id'];
        
        // Fetch mapped roles from map table (sorted by role's order_no)
        $typesStmt = $pdo->prepare("
            SELECT map.manpower_type_id, t.role_name, t.order_no
            FROM mcc_manpower_shift_type_map map
            JOIN mcc_manpower_types t ON map.manpower_type_id = t.id
            WHERE map.shift_id = :shift_id AND t.status = 'Active'
            ORDER BY t.order_no ASC, t.id ASC
        ");
        $typesStmt->execute(['shift_id' => $shiftId]);
        $types = $typesStmt->fetchAll();

        if (!empty($types)) {
            $shifts[] = [
                'id' => $sh['id'],
                'shift_name' => $sh['shift_name'],
                'types' => $types
            ];
            
            // Add roles to our role lookup map
            foreach ($types as $type) {
                $roleNamesMap[$type['manpower_type_id']] = $type['role_name'];
            }
        }
    }

    if (!empty($shifts)) {
        $categories[] = [
            'id' => $cat['id'],
            'category_name' => $cat['category_name'],
            'shifts' => $shifts
        ];
    }
}

$successMsg = '';
$errorMsg = '';

// Handle save post request
if ($_SERVER['REQUEST_METHOD'] === 'POST' && isset($_POST['save_target'])) {
    $selectedMonth = $_POST['month'] ?? '';
    $selectedYear = $_POST['year'] ?? '';
    
    if (!empty($selectedMonth) && !empty($selectedYear)) {
        $targetMonthDate = $selectedYear . "-" . str_pad($selectedMonth, 2, '0', STR_PAD_LEFT) . "-01";
        $submittedTargets = $_POST['target_qty'] ?? []; // [shift_id][manpower_type_id] => qty
        
        $pdo->beginTransaction();
        try {
            // Delete existing manpower targets for this station and month
            $deleteStmt = $pdo->prepare("
                DELETE FROM mcc_manpower_targets 
                WHERE station_id = :station_id AND target_date = :target_date
            ");
            $deleteStmt->execute([
                'station_id' => $stationId,
                'target_date' => $targetMonthDate
            ]);
            
            // Insert updated manpower targets
            $insertStmt = $pdo->prepare("
                INSERT INTO mcc_manpower_targets 
                (station_id, target_date, shift_id, manpower_type_id, manpower_type, target_qty) 
                VALUES (:station_id, :target_date, :shift_id, :manpower_type_id, :manpower_type, :target_qty)
            ");
            
            foreach ($submittedTargets as $shId => $typeQtys) {
                foreach ($typeQtys as $tId => $qty) {
                    $qty = intval($qty);
                    $roleName = $roleNamesMap[$tId] ?? 'Staff';
                    
                    $insertStmt->execute([
                        'station_id' => $stationId,
                        'target_date' => $targetMonthDate,
                        'shift_id' => $shId,
                        'manpower_type_id' => $tId,
                        'manpower_type' => $roleName,
                        'target_qty' => $qty
                    ]);
                }
            }
            
            $pdo->commit();
            $successMsg = "Manpower targets for " . date('F, Y', strtotime($targetMonthDate)) . " saved successfully!";
        } catch (Exception $e) {
            $pdo->rollBack();
            $errorMsg = "Error saving manpower targets: " . $e->getMessage();
        }
    }
}

// Fetch existing target norms for the selected month
$targetsMap = [];
$targetsStmt = $pdo->prepare("
    SELECT shift_id, manpower_type_id, target_qty 
    FROM mcc_manpower_targets 
    WHERE station_id = :station_id AND target_date = :target_date
");
$targetsStmt->execute([
    'station_id' => $stationId,
    'target_date' => $targetMonthDate
]);
$targetsRows = $targetsStmt->fetchAll();
foreach ($targetsRows as $row) {
    $targetsMap[$row['shift_id']][$row['manpower_type_id']] = $row['target_qty'];
}

$pageTitle = 'Set Monthly Manpower Target | MCC';

$extraStyles = "
.sub-category {
    background:#f2f2f2 !important;
    font-weight:600;
    text-align:left !important;
}
.sub-category td {
    padding-left:18px !important;
    text-align:left !important;
    font-weight:700;
}
.target-input {
    width: 100px;
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
.target-input:focus {
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
                    <label for="month" style="font-weight: 700; margin: 0; font-size: 14px; color: #334155; white-space: nowrap;">Target Month</label>
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
                    <a href="man-power-log.php?from_date=<?= urlencode(date('Y-m-d', strtotime($targetMonthDate))) ?>&to_date=<?= urlencode(date('Y-m-t', strtotime($targetMonthDate))) ?>" class="btn-print" style="background: #4b5563 !important; color: white !important; text-decoration: none; padding: 8px 16px; border-radius: 6px; font-weight: 700; font-size: 14px; display: inline-flex; align-items: center; border: none; height: 38px;">
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
                        <h2 style="font-weight: 700; margin-bottom: 5px;">Manpower Target</h2>
                        <h3 style="font-size: 1.15rem; font-weight: 600; color: #334155; margin-bottom: 5px;"><?= htmlspecialchars($railwayName) ?></h3>
                        <p style="font-size: 0.95rem; color: #475569; margin-bottom: 15px;">Set monthly manpower norms for cleaning and housekeeping contract at <?= htmlspecialchars($stationName) ?> Railway Station</p>
                    </div>

                    <div class="report-meta-section" style="border-top: 1px solid #cbd5e1; border-bottom: 1px solid #cbd5e1; padding: 10px 0; margin-bottom: 20px; font-weight: 600; text-align: center; font-size: 0.95rem;">
                        <span>Division: <strong style="color: #0f172a;"><?= htmlspecialchars($divisionName) ?></strong></span> &nbsp;&nbsp;|&nbsp;&nbsp;
                        <span>Station: <strong style="color: #0f172a;"><?= htmlspecialchars($stationName) ?></strong></span> &nbsp;&nbsp;|&nbsp;&nbsp;
                        <span>Month: <strong style="color: #0f172a;"><?= date('F Y', strtotime($targetMonthDate)) ?></strong></span>
                    </div>

                    <?php if (empty($categories)): ?>
                        <div class="alert alert-info" style="margin: 20px 0; border-radius: 8px; padding: 12px 20px; border: 1px solid #bee5eb; background-color: #d1ecf1; color: #0c5460; text-align: center;">
                            <i class="bi bi-info-circle-fill me-2"></i> No active manpower categories or shifts configured. Go to <a href="manpower-config.php">Man Power Config</a> to add.
                        </div>
                    <?php else: ?>
                        <form method="POST" action="">
                            <input type="hidden" name="month" value="<?= htmlspecialchars($selectedMonth); ?>">
                            <input type="hidden" name="year" value="<?= htmlspecialchars($selectedYear); ?>">
                            
                            <div class="table-responsive">
                                <table class="report-table">
                                    <thead>
                                        <tr>
                                            <th style="width: 250px;">Shift</th>
                                            <th>Description</th>
                                            <th style="width: 280px;">To be provided as per norms</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <?php foreach ($categories as $cat): ?>
                                            <!-- Category Subheader -->
                                            <tr class="sub-category">
                                                <td colspan="3" style="text-align:center !important; padding-left:0 !important; text-transform: uppercase;">
                                                    <?= htmlspecialchars($cat['category_name']) ?>
                                                </td>
                                            </tr>

                                            <?php foreach ($cat['shifts'] as $shift): 
                                                $typeIndex = 0;
                                                $typesCount = count($shift['types']);
                                            ?>
                                                <?php foreach ($shift['types'] as $type): 
                                                    $shId = $shift['id'];
                                                    $tId = $type['manpower_type_id'];
                                                    $targetVal = $targetsMap[$shId][$tId] ?? '';
                                                ?>
                                                    <tr>
                                                        <?php if ($typeIndex === 0): ?>
                                                            <td rowspan="<?= $typesCount ?>" style="vertical-align: middle; text-align: center; font-weight: 500;"><?= htmlspecialchars($shift['shift_name']) ?></td>
                                                        <?php endif; ?>
                                                        <td><?= htmlspecialchars($type['role_name']) ?></td>
                                                        <td style="text-align: center;">
                                                            <input type="number" min="0" step="1" 
                                                                name="target_qty[<?= $shId ?>][<?= $tId ?>]" 
                                                                value="<?= htmlspecialchars($targetVal) ?>" 
                                                                class="target-input" required placeholder="0">
                                                        </td>
                                                    </tr>
                                                <?php 
                                                    $typeIndex++;
                                                endforeach; ?>
                                            <?php endforeach; ?>
                                        <?php endforeach; ?>
                                    </tbody>
                                </table>
                            </div>

                            <!-- Save Manpower Target Button -->
                            <div style="text-align: center; margin-top: 25px;" class="no-print">
                                <button type="submit" name="save_target" class="btn btn-primary" style="background-color: #1987C6; border: none; font-weight: 700; font-size: 15px; padding: 10px 30px; border-radius: 6px; box-shadow: 0 4px 6px rgba(0,0,0,0.1); cursor: pointer; transition: all 0.2s ease;">
                                    Save Manpower Target
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
