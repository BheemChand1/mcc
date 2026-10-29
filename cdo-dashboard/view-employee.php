<?php
require_once 'auth.php';

// Check if table mcc_employee exists, if not create it
$tableCheck = $pdo->query("SHOW TABLES LIKE 'mcc_employee'");
if ($tableCheck->rowCount() == 0) {
    $sql = "CREATE TABLE `mcc_employee` (
        `id` INT AUTO_INCREMENT PRIMARY KEY,
        `employee_id` VARCHAR(50) NOT NULL UNIQUE,
        `full_name` VARCHAR(255) NOT NULL,
        `designation` VARCHAR(255) NOT NULL,
        `age` INT DEFAULT NULL,
        `employee_photo` VARCHAR(255) DEFAULT NULL,
        `father_name` VARCHAR(255) DEFAULT NULL,
        `mother_name` VARCHAR(255) DEFAULT NULL,
        `mobile_number` VARCHAR(20) DEFAULT NULL,
        `dob` DATE DEFAULT NULL,
        `aadhar_number` VARCHAR(50) DEFAULT NULL,
        `address` TEXT DEFAULT NULL,
        `ren_id` VARCHAR(50) DEFAULT NULL,
        `rakshak_id` VARCHAR(50) DEFAULT NULL,
        `pan_card` VARCHAR(50) DEFAULT NULL,
        `police_ver` VARCHAR(100) DEFAULT NULL,
        `police_ver_dt` DATE DEFAULT NULL,
        `pvc` VARCHAR(100) DEFAULT NULL,
        `pvc_ok_applied` VARCHAR(100) DEFAULT NULL,
        `pvc_issue_month` VARCHAR(50) DEFAULT NULL,
        `medical` VARCHAR(100) DEFAULT NULL,
        `medical_issue_month` VARCHAR(50) DEFAULT NULL,
        `education` VARCHAR(100) DEFAULT NULL,
        `document_status` VARCHAR(100) DEFAULT NULL,
        `account_name` VARCHAR(255) DEFAULT NULL,
        `account_number` VARCHAR(50) DEFAULT NULL,
        `ifsc_code` VARCHAR(50) DEFAULT NULL,
        `status` VARCHAR(50) DEFAULT NULL,
        `issue_date` DATE DEFAULT NULL,
        `valid_upto_date` DATE DEFAULT NULL,
        `valid_upto_month` VARCHAR(50) DEFAULT NULL,
        `formula_valid_upto` VARCHAR(255) DEFAULT NULL,
        `notification` VARCHAR(255) DEFAULT NULL,
        `document_link` VARCHAR(255) DEFAULT NULL,
        `remarks` TEXT DEFAULT NULL,
        `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
        `updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
    ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;";
    $pdo->exec($sql);
}

// Delete Employee Action
if (isset($_GET['action']) && $_GET['action'] === 'delete' && isset($_GET['id'])) {
    $id = intval($_GET['id']);
    
    // Get photo filename to delete from disk
    $photoStmt = $pdo->prepare("SELECT employee_photo FROM mcc_employee WHERE id = ? AND station_id = ?");
    $photoStmt->execute([$id, $stationId]);
    $emp = $photoStmt->fetch();
    if ($emp && !empty($emp['employee_photo'])) {
        $photoPath = __DIR__ . '/uploads/' . $emp['employee_photo'];
        if (file_exists($photoPath)) {
            @unlink($photoPath);
        }
    }
    
    $deleteStmt = $pdo->prepare("DELETE FROM mcc_employee WHERE id = ? AND station_id = ?");
    $deleteStmt->execute([$id, $stationId]);
    header("Location: view-employee.php");
    exit;
}

// Search Filter Logic
$search = $_GET['search'] ?? '';
if (!empty($search)) {
    $searchWild = "%$search%";
    $stmt = $pdo->prepare("
        SELECT * FROM mcc_employee 
        WHERE station_id = :station_id 
          AND (employee_id LIKE :search 
            OR full_name LIKE :search 
            OR designation LIKE :search 
            OR mobile_number LIKE :search 
            OR aadhar_number LIKE :search)
        ORDER BY id DESC
    ");
    $stmt->execute(['station_id' => $stationId, 'search' => $searchWild]);
} else {
    $stmt = $pdo->prepare("SELECT * FROM mcc_employee WHERE station_id = :station_id ORDER BY id DESC");
    $stmt->execute(['station_id' => $stationId]);
}
$employees = $stmt->fetchAll();

// Fetch active custom fields for this specific station
$cfStmt = $pdo->prepare("
    SELECT field_label, field_key, field_type 
    FROM mcc_employee_custom_fields 
    WHERE station_id = :station_id AND status = 'Active' 
    ORDER BY sort_order ASC, id ASC
");
$cfStmt->execute(['station_id' => $stationId]);
$customFields = $cfStmt->fetchAll(PDO::FETCH_ASSOC);

$pageTitle = 'Employee Directory | MCC';
$extraStyles = "
    .content-wrapper { padding: 15px; background: #f0f2f5; min-height: 100vh; }
    
    /* Search Card */
    .search-card {
        background: #fff;
        border: 1px solid #e2e8f0;
        border-radius: 12px;
        padding: 10px;
        margin-bottom: 15px;
        box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.05);
    }
    
    .search-box {
        display: flex;
        gap: 12px;
        width: 100%;
    }
    
    .search-box input {
        flex: 1;
        padding: 10px 16px;
        border: 1px solid #e2e8f0;
        border-radius: 8px;
        font-size: 0.95rem;
    }
    
    .btn-search {
        background: #1987C6;
        color: white;
        border: none;
        padding: 10px 24px;
        border-radius: 8px;
        font-weight: 600;
        cursor: pointer;
    }

    /* Table Card */
    .data-card {
        background: #fff;
        border: 1px solid #e2e8f0;
        border-radius: 12px;
        box-shadow: 0 10px 15px -3px rgba(0, 0, 0, 0.05);
        display: flex;
        flex-direction: column;
    }
    
    .table-header {
        padding: 15px 20px;
        border-bottom: 1px solid #e2e8f0;
        display: flex;
        justify-content: space-between;
        align-items: center;
    }
    
    .table-header h4 { margin: 0; font-weight: 800; color: #1e293b; }
    
    .table-responsive {
        width: 100%;
        overflow-x: auto;
        border-radius: 0 0 12px 12px;
    }

    .employee-table { 
        width: 100%; 
        border-collapse: collapse; 
        white-space: nowrap;
    }

    .employee-table th {
        background: linear-gradient(180deg, #07203a 0%, #07182c 100%) !important;
        padding: 10px 15px;
        text-align: center;
        font-size: 0.75rem;
        font-weight: 600;
        text-transform: uppercase;
        color: #fff;
        border: 1px solid #133357;
    }
    
    .employee-table td {
        padding: 8px 15px;
        font-size: 0.85rem;
        color: #334155;
        border: 1px solid #f1f5f9;
        vertical-align: middle;
    }
    
    .employee-table tr:hover { background: #f8f9fa; }
    
    .emp-photo {
        width: 40px;
        height: 40px;
        border-radius: 4px;
        object-fit: cover;
        border: 1px solid #ddd;
    }

    /* Action Buttons */
    .btn-action-group { display: flex; gap: 5px; }
    .btn-icon {
        width: 30px;
        height: 30px;
        display: flex;
        align-items: center;
        justify-content: center;
        border-radius: 4px;
        border: 1px solid #dee2e6;
        background: #fff;
        color: #64748b;
        cursor: pointer;
        font-size: 0.9rem;
    }
    
    .btn-icon:hover { 
        border-color: #1987C6;
        color: #1987C6;
    }

    .btn-icon.delete:hover {
        border-color: #dc3545;
        color: #dc3545;
    }
";

include 'header.php';
include 'sidebar.php';
?>

<main class="app-main">
    <div class="content-wrapper">
        <!-- Search Section -->
        <div class="search-card">
            <div class="search-box">
                <input type="text" id="searchInput" placeholder="Search employees..." value="<?= htmlspecialchars($search) ?>">
                <button class="btn-search" onclick="searchEmployees()">
                    <i class="bi bi-search me-2"></i>Search
                </button>
            </div>
        </div>

        <!-- Data Table Section -->
        <div class="data-card">
            <div class="table-header">
                <h4><i class="bi bi-people-fill me-2 text-primary"></i>Employee Directory</h4>
                <div class="d-flex gap-2">
                    <button type="button" class="btn btn-sm btn-success px-3 fw-bold" data-bs-toggle="modal" data-bs-target="#excelImportModal" style="border-radius: 8px;">
                        <i class="bi bi-file-earmark-excel me-1"></i>Import Excel
                    </button>
                    <a href="add-employee.php" class="btn btn-sm btn-primary px-3 fw-bold"
                        style="background: #1987C6; border: none; border-radius: 8px;">
                        <i class="bi bi-plus-lg me-1"></i>Add New
                    </a>
                </div>
            </div>

            <div class="table-responsive">
                <table class="employee-table">
                    <thead>
                        <tr style="text-align:center; vertical-align:middle;">
                            <th style="width: 50px;">#</th>
                            <th style="width: 60px;">Photo</th>
                            <th>Employee ID</th>
                            <th>Name</th>
                            <th>Designation</th>
                            <?php foreach ($customFields as $cf): ?>
                                <th><?= htmlspecialchars(strtoupper($cf['field_label'])) ?></th>
                            <?php endforeach; ?>
                            <th style="width: 120px;">Action</th>
                        </tr>
                    </thead>
                    <tbody id="employeeTableBody">
                        <?php if (!empty($employees)): ?>
                            <?php foreach ($employees as $index => $emp): 
                                $photoSrc = !empty($emp['employee_photo']) ? 'uploads/' . $emp['employee_photo'] : 'assets/img/avatar.png';
                                $cData = !empty($emp['custom_data']) ? json_decode($emp['custom_data'], true) : [];
                                if (!is_array($cData)) $cData = [];
                            ?>
                            <tr style="text-align:center; vertical-align:middle;">
                                <td><?= $index + 1 ?></td>
                                <td><img src="<?= htmlspecialchars($photoSrc) ?>" class="emp-photo" alt="Photo" style="width: 40px; height: 40px; border-radius: 50%; object-fit: cover;"></td>
                                <td class="fw-bold"><?= htmlspecialchars($emp['employee_id']) ?></td>
                                <td style="font-weight: 700; color: #1987C6; text-align: left;"><?= htmlspecialchars($emp['full_name']) ?></td>
                                <td><span class="badge bg-secondary-subtle text-secondary px-2 py-1"><?= htmlspecialchars($emp['designation']) ?></span></td>
                                <?php foreach ($customFields as $cf): 
                                    $k = $cf['field_key'];
                                    $val = $cData[$k] ?? ($emp[$k] ?? '');
                                ?>
                                    <td><?= htmlspecialchars($val !== '' && $val !== null ? $val : '-') ?></td>
                                <?php endforeach; ?>
                                <td>
                                    <div class="btn-action-group" style="justify-content: center;">
                                        <button class="btn-icon" title="Edit" onclick="window.location.href='add-employee.php?id=<?= $emp['id'] ?>'"><i class="bi bi-pencil-square"></i></button>
                                        <button class="btn-icon" title="Generate ID Card" onclick="window.open('generate-idcard.php?id=<?= $emp['id'] ?>', '_blank')"><i class="bi bi-person-badge-fill"></i></button>
                                        <button class="btn-icon delete" title="Delete" onclick="deleteEmployee(<?= $emp['id'] ?>)"><i class="bi bi-trash3"></i></button>
                                    </div>
                                </td>
                            </tr>
                            <?php endforeach; ?>
                        <?php endif; ?>
                    </tbody>
                </table>
            </div>

            <?php if (empty($employees)): ?>
                <div id="emptyState" style="padding: 60px; text-align: center;">
                    <i class="bi bi-person-x" style="font-size: 3rem; color: #cbd5e1;"></i>
                    <h5 class="mt-3 text-slate-600">No employees found</h5>
                </div>
            <?php endif; ?>
        </div>
    </div>
</main>

<script>
    function searchEmployees() {
        const searchTerm = document.getElementById("searchInput").value.trim();
        window.location.href = "view-employee.php?search=" + encodeURIComponent(searchTerm);
    }

    function deleteEmployee(id) {
        if (confirm("Are you sure you want to delete this employee?")) {
            window.location.href = "view-employee.php?action=delete&id=" + id;
        }
    }

    document.addEventListener("DOMContentLoaded", function() {
        const searchInput = document.getElementById("searchInput");
        searchInput.addEventListener("keyup", function(event) {
            if (event.key === "Enter") {
                searchEmployees();
            }
        });
    });
</script>

<!-- Modal: Excel Import -->
<div class="modal fade" id="excelImportModal" tabindex="-1" aria-labelledby="excelImportModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered">
    <div class="modal-content border-0 shadow">
      <form id="excelImportForm" enctype="multipart/form-data">
        <div class="modal-header bg-dark text-white">
          <h5 class="modal-title fw-bold" id="excelImportModalLabel">
            <i class="bi bi-file-earmark-excel me-1 text-success"></i> Import Employees from Excel (<?= htmlspecialchars($stationName) ?>)
          </h5>
          <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
        </div>
        <div class="modal-body p-4">
          <div id="importAlertBox" class="alert d-none"></div>

          <!-- Step 1: Download Template -->
          <div class="p-3 bg-light rounded-3 border mb-3">
            <div class="d-flex align-items-center justify-content-between">
              <div>
                <strong class="d-block text-dark small">Step 1: Download Template</strong>
                <span class="text-muted small">Generated with active fields for <?= htmlspecialchars($stationName) ?></span>
              </div>
              <a href="ajax-employee-excel.php?action=download_template" class="btn btn-sm btn-outline-success fw-bold text-nowrap">
                <i class="bi bi-download me-1"></i> Sample Template (.csv)
              </a>
            </div>
          </div>

          <!-- Step 2: Upload File -->
          <div class="mb-3">
            <strong class="d-block text-dark small mb-2">Step 2: Upload Filled File</strong>
            <input type="file" name="excel_file" class="form-control" accept=".xlsx, .csv" required>
            <div class="form-text">Supports Microsoft Excel (.xlsx) and CSV (.csv) files.</div>
          </div>

          <!-- Options -->
          <div class="form-check form-switch mt-3">
            <input class="form-check-input" type="checkbox" name="update_existing" value="1" id="updateExistingCheck" checked>
            <label class="form-check-label small fw-bold text-secondary" for="updateExistingCheck">
              Update existing employee if Employee ID already exists (Otherwise skip duplicate)
            </label>
          </div>
        </div>
        <div class="modal-footer bg-light">
          <button type="button" class="btn btn-secondary rounded-pill px-3" data-bs-dismiss="modal">Close</button>
          <button type="submit" class="btn btn-success rounded-pill px-4" id="importSubmitBtn">
            <i class="bi bi-cloud-arrow-up me-1"></i> Upload & Import
          </button>
        </div>
      </form>
    </div>
  </div>
</div>

<script>
    document.getElementById("excelImportForm")?.addEventListener("submit", function(e) {
      e.preventDefault();
      const formData = new FormData(this);
      formData.append("action", "import_excel");

      const submitBtn = document.getElementById("importSubmitBtn");
      const originalBtnHTML = submitBtn.innerHTML;
      submitBtn.disabled = true;
      submitBtn.innerHTML = '<span class="spinner-border spinner-border-sm me-2"></span>Importing...';

      const alertBox = document.getElementById("importAlertBox");
      alertBox.className = "alert d-none";

      fetch("ajax-employee-excel.php", {
        method: "POST",
        body: formData
      })
      .then(r => r.json())
      .then(data => {
        submitBtn.disabled = false;
        submitBtn.innerHTML = originalBtnHTML;

        alertBox.classList.remove("d-none");
        if (data.success) {
          alertBox.className = "alert alert-success";
          alertBox.innerHTML = '<i class="bi bi-check-circle-fill me-2"></i>' + data.message;
          setTimeout(() => {
            window.location.reload();
          }, 1500);
        } else {
          alertBox.className = "alert alert-danger";
          alertBox.innerHTML = '<i class="bi bi-exclamation-triangle-fill me-2"></i>' + data.message;
        }
      })
      .catch(err => {
        submitBtn.disabled = false;
        submitBtn.innerHTML = originalBtnHTML;
        alertBox.classList.remove("d-none");
        alertBox.className = "alert alert-danger";
        alertBox.innerHTML = "An unexpected error occurred during import.";
      });
    });
</script>

<?php include 'footer.php'; ?>