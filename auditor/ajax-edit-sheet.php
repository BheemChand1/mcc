<?php
/**
 * Auditor Sheet Edit AJAX Backend
 * Allows logged-in auditors to fetch sheet data for editing and save changes.
 */
require_once __DIR__ . '/auth.php';
global $pdo;

header('Content-Type: application/json');

if ($_SERVER['REQUEST_METHOD'] !== 'POST') {
    echo json_encode(['success' => false, 'message' => 'Invalid request method.']);
    exit;
}

$action = trim($_POST['action'] ?? '');
$table = trim($_POST['table'] ?? '');
$tokenId = trim($_POST['token_id'] ?? '');

$allowedTables = [
    'mcc_chemical_report',
    'dc_mcc_chemical_report',
    'dc_mcc_machine_report',
    'dc_mcc_report',
    'mcc_cleanliness_report',
    'mcc_intensive_chemical_report',
    'mcc_intensive_machine_report',
    'mcc_intensive_pantry_chemical_report',
    'mcc_intensive_pantry_machine_report',
    'mcc_intensive_pantry_report',
    'mcc_intensive_scorecard_2_report',
    'mcc_intensive_scorecard_report',
    'mcc_manpower_log',
    'mcc_normal_chemical_report',
    'mcc_normal_machine_report',
    'mcc_normal_scorecard_report',
    'mcc_photo_report',
    'mcc_prt_chemical_report',
    'mcc_prt_machine_report',
    'mcc_prt_scorecard_report',
    'mcc_surprise_pit_office_report',
    'mcc_surprise_pf_trains_report',
    'mcc_vb_chemical_report',
    'mcc_vb_machine_report',
    'mcc_vb_scorecard_report'
];

if (!in_array($table, $allowedTables)) {
    echo json_encode(['success' => false, 'message' => 'Invalid report table.']);
    exit;
}

if ($action === 'fetch_sheet') {
    if (empty($tokenId)) {
        echo json_encode(['success' => false, 'message' => 'Token ID is required.']);
        exit;
    }

    try {
        // Fetch rows for this token and ensure it was audited by the current auditor
        $stmt = $pdo->prepare("SELECT * FROM {$table} WHERE token_id = :token_id AND station_id = :station_id AND audit_by = :auditor_id");
        $stmt->execute([
            'token_id' => $tokenId,
            'station_id' => $stationId,
            'auditor_id' => $auditorId
        ]);
        $rows = $stmt->fetchAll(PDO::FETCH_ASSOC);

        if (empty($rows)) {
            // Check if sheet exists but under another auditor
            $chkStmt = $pdo->prepare("SELECT COUNT(*) FROM {$table} WHERE token_id = :token_id AND station_id = :station_id");
            $chkStmt->execute(['token_id' => $tokenId, 'station_id' => $stationId]);
            if ($chkStmt->fetchColumn() > 0) {
                echo json_encode(['success' => false, 'message' => 'Unauthorized: This sheet was filled by another auditor.']);
            } else {
                echo json_encode(['success' => false, 'message' => 'Sheet record not found.']);
            }
            exit;
        }

        $trainNo = $rows[0]['train_no'] ?? 'N/A';
        $reportDate = $rows[0]['report_date'] ?? 'N/A';
        $isApproved = intval($rows[0]['isApproved'] ?? 0);

        // Helper maps for parameter names
        $paramMap = [];
        if (strpos($table, 'chemical') !== false) {
            try {
                $pStmt = $pdo->query("SELECT id, name FROM mcc_chemical_param");
                while ($pRow = $pStmt->fetch(PDO::FETCH_ASSOC)) {
                    $paramMap[$pRow['id']] = $pRow['name'];
                }
            } catch (Exception $e) {}
        } elseif (strpos($table, 'machine') !== false) {
            $mTable = str_replace('_report', '_param', $table);
            try {
                $mStmt = $pdo->query("SELECT id, name FROM {$mTable}");
                while ($mRow = $mStmt->fetch(PDO::FETCH_ASSOC)) {
                    $paramMap[$mRow['id']] = $mRow['name'];
                }
            } catch (Exception $e) {}
        } elseif ($table === 'dc_mcc_report') {
            try {
                $dStmt = $pdo->query("SELECT id, parameter_name FROM dc_mcc_param");
                while ($dRow = $dStmt->fetch(PDO::FETCH_ASSOC)) {
                    $paramMap[$dRow['id']] = $dRow['parameter_name'];
                }
            } catch (Exception $e) {}
        } else {
            // Scorecard sub-parameters
            $subTable = str_replace('_report', '_sub_param', $table);
            try {
                $sStmt = $pdo->query("SELECT id, sub_parameter_name FROM {$subTable}");
                while ($sRow = $sStmt->fetch(PDO::FETCH_ASSOC)) {
                    $paramMap[$sRow['id']] = $sRow['sub_parameter_name'];
                }
            } catch (Exception $e) {}
        }

        ob_start();
        ?>
        <form id="auditorSheetEditForm">
          <input type="hidden" name="table" value="<?= htmlspecialchars($table) ?>">
          <input type="hidden" name="token_id" value="<?= htmlspecialchars($tokenId) ?>">

          <div class="row g-2 mb-3 p-3 rounded" style="background: rgba(6, 26, 44, 0.8); border: 1px solid #14416b;">
            <div class="col-sm-4">
              <span class="text-info small fw-semibold">Token ID:</span>
              <div class="fw-bold text-white"><?= htmlspecialchars($tokenId) ?></div>
            </div>
            <div class="col-sm-4">
              <span class="text-info small fw-semibold">Train / Rake:</span>
              <div class="fw-bold text-white"><?= htmlspecialchars($trainNo) ?></div>
            </div>
            <div class="col-sm-4">
              <span class="text-info small fw-semibold">Report Date:</span>
              <div class="fw-bold text-white"><?= htmlspecialchars(date('d-m-Y', strtotime($reportDate))) ?></div>
            </div>
          </div>

          <?php if ($isApproved == 1): ?>
            <div class="alert alert-warning py-2 mb-3 small d-flex align-items-center gap-2" style="background: rgba(245, 158, 11, 0.15); border-color: rgba(245, 158, 11, 0.4); color: #fbbf24;">
              <i class="bi bi-exclamation-triangle-fill fs-5"></i>
              <div><strong>Notice:</strong> This sheet is approved by CDO. Any edits made will update the official audit record.</div>
            </div>
          <?php endif; ?>

          <div class="table-responsive" style="max-height: 420px; border: 1px solid #14416b; border-radius: 8px;">
            <table class="table align-middle mb-0" style="font-size: 13px; background: #071f35; color: #f1f5f9;">
              <thead class="sticky-top" style="background: #06192d !important; color: #38bdf8; border-bottom: 2px solid #14416b;">
                <tr>
                  <th class="ps-3 py-2" style="width: 50px;">#</th>
                  <th class="py-2">Item / Parameter Description</th>
                  <th class="py-2" style="width: 140px;">Score / Value</th>
                  <?php if (isset($rows[0]['used_status'])): ?>
                  <th class="py-2" style="width: 100px;">Status (Y/N)</th>
                  <?php endif; ?>
                  <?php if (isset($rows[0]['remarks']) || isset($rows[0]['remark'])): ?>
                  <th class="py-2">Remarks</th>
                  <?php endif; ?>
                </tr>
              </thead>
              <tbody>
                <?php foreach ($rows as $idx => $r): 
                  $rowId = $r['id'] ?? ($idx + 1);
                  $scoreVal = $r['score_value'] ?? ($r['qty_used'] ?? ($r['hours_used'] ?? ($r['rating'] ?? ($r['cleaning_score'] ?? ''))));
                  $coachNo = $r['coach_no'] ?? '';
                  $paramId = $r['sub_parameter_id'] ?? ($r['parameter_id'] ?? ($r['item_id'] ?? ''));
                  $pName = $paramMap[$paramId] ?? '';
                  
                  $label = '';
                  if ($coachNo && $pName) {
                      $label = "<strong>Coach $coachNo</strong> &bull; " . htmlspecialchars($pName);
                  } elseif ($pName) {
                      $label = htmlspecialchars($pName);
                  } elseif ($coachNo) {
                      $label = "<strong>Coach $coachNo</strong> (Param #$paramId)";
                  } else {
                      $label = "Item #" . ($idx + 1);
                  }
                ?>
                <tr style="border-bottom: 1px solid #0e3355; background: <?= ($idx % 2 === 0) ? '#081d33' : '#06182a' ?>;">
                  <td class="ps-3 text-info fw-semibold"><?= $idx + 1 ?></td>
                  <td>
                    <span class="text-white"><?= $label ?></span>
                  </td>
                  <td>
                    <input type="text" class="form-control form-control-sm text-white fw-bold" 
                           style="background: #05182a; border: 1px solid #1a5180; color: #fff;" 
                           name="scores[<?= htmlspecialchars($r['id'] ?? $idx) ?>]" 
                           value="<?= htmlspecialchars((string)$scoreVal) ?>">
                  </td>
                  <?php if (isset($rows[0]['used_status'])): ?>
                  <td>
                    <select class="form-select form-select-sm text-white" 
                            style="background: #05182a; border: 1px solid #1a5180; color: #fff;"
                            name="used_status[<?= htmlspecialchars($r['id'] ?? $idx) ?>]">
                      <option value="Y" <?= (strtoupper($r['used_status'] ?? '') === 'Y') ? 'selected' : '' ?>>Y</option>
                      <option value="N" <?= (strtoupper($r['used_status'] ?? '') === 'N') ? 'selected' : '' ?>>N</option>
                    </select>
                  </td>
                  <?php endif; ?>
                  <?php if (isset($rows[0]['remarks']) || isset($rows[0]['remark'])): 
                    $rem = $r['remarks'] ?? ($r['remark'] ?? '');
                  ?>
                  <td>
                    <input type="text" class="form-control form-control-sm text-white" 
                           style="background: #05182a; border: 1px solid #1a5180; color: #fff;" 
                           name="remarks[<?= htmlspecialchars($r['id'] ?? $idx) ?>]" 
                           value="<?= htmlspecialchars((string)$rem) ?>" placeholder="Optional remark">
                  </td>
                  <?php endif; ?>
                </tr>
                <?php endforeach; ?>
              </tbody>
            </table>
          </div>
        </form>
        <?php
        $html = ob_get_clean();

        echo json_encode([
            'success' => true,
            'html' => $html
        ]);
        exit;
    } catch (PDOException $e) {
        echo json_encode(['success' => false, 'message' => 'Database error: ' . $e->getMessage()]);
        exit;
    }
} elseif ($action === 'save_sheet') {
    if (empty($tokenId)) {
        echo json_encode(['success' => false, 'message' => 'Token ID is required.']);
        exit;
    }

    $scores = $_POST['scores'] ?? [];
    $remarks = $_POST['remarks'] ?? [];
    $usedStatuses = $_POST['used_status'] ?? [];

    if (empty($scores) && empty($remarks) && empty($usedStatuses)) {
        echo json_encode(['success' => false, 'message' => 'No edits submitted.']);
        exit;
    }

    try {
        $pdo->beginTransaction();

        // Determine the score column name for this table
        $scoreCol = 'score_value';
        if (strpos($table, 'chemical') !== false) {
            $scoreCol = 'qty_used';
        } elseif (strpos($table, 'machine') !== false) {
            $scoreCol = 'hours_used';
        } elseif ($table === 'dc_mcc_report') {
            $scoreCol = 'rating';
        } elseif ($table === 'mcc_cleanliness_report') {
            $scoreCol = 'cleaning_score';
        }

        // Check if rows belong to current auditor and station
        $idStmt = $pdo->prepare("SELECT * FROM {$table} WHERE token_id = :token_id AND station_id = :station_id AND audit_by = :auditor_id");
        $idStmt->execute([
            'token_id' => $tokenId,
            'station_id' => $stationId,
            'auditor_id' => $auditorId
        ]);
        $rows = $idStmt->fetchAll(PDO::FETCH_ASSOC);

        if (empty($rows)) {
            $pdo->rollBack();
            echo json_encode(['success' => false, 'message' => 'Unauthorized: Cannot modify this sheet.']);
            exit;
        }

        foreach ($rows as $idx => $r) {
            $rKey = $r['id'] ?? $idx;
            if (isset($scores[$rKey]) || isset($usedStatuses[$rKey]) || isset($remarks[$rKey])) {
                $newScore = isset($scores[$rKey]) ? trim($scores[$rKey]) : ($r[$scoreCol] ?? '');
                $newRemark = isset($remarks[$rKey]) ? trim($remarks[$rKey]) : null;
                $newStatus = isset($usedStatuses[$rKey]) ? trim($usedStatuses[$rKey]) : null;

                if (isset($r['id'])) {
                    $setClauses = ["{$scoreCol} = :score"];
                    $params = ['score' => $newScore, 'id' => $r['id'], 'station_id' => $stationId];

                    if ($newRemark !== null) {
                        $remCol = isset($r['remarks']) ? 'remarks' : (isset($r['remark']) ? 'remark' : null);
                        if ($remCol) {
                            $setClauses[] = "{$remCol} = :remark";
                            $params['remark'] = $newRemark;
                        }
                    }

                    if ($newStatus !== null && isset($r['used_status'])) {
                        $setClauses[] = "used_status = :status";
                        $params['status'] = $newStatus;
                    }

                    $updSql = "UPDATE {$table} SET " . implode(', ', $setClauses) . " WHERE id = :id AND station_id = :station_id";
                    $upd = $pdo->prepare($updSql);
                    $upd->execute($params);
                }
            }
        }

        $pdo->commit();
        echo json_encode(['success' => true, 'message' => 'Sheet scores updated successfully!']);
        exit;
    } catch (PDOException $e) {
        if ($pdo->inTransaction()) {
            $pdo->rollBack();
        }
        echo json_encode(['success' => false, 'message' => 'Save failed: ' . $e->getMessage()]);
        exit;
    }
}

echo json_encode(['success' => false, 'message' => 'Unknown action.']);
