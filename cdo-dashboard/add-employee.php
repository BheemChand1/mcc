<?php
require_once 'auth.php';

// Fetch active designations station-wise
$desStmt = $pdo->prepare("
    SELECT designation_name 
    FROM mcc_designation 
    WHERE (station_id = :station_id OR station_id = 0) AND status = 'Active' 
    ORDER BY designation_name ASC
");
$desStmt->execute(['station_id' => $stationId]);
$designationOptions = $desStmt->fetchAll(PDO::FETCH_COLUMN);
if (empty($designationOptions)) {
    $designationOptions = ['Supervisor', 'Unskilled'];
}

// Fetch active custom fields for this specific station
$cfStmt = $pdo->prepare("
    SELECT * FROM mcc_employee_custom_fields 
    WHERE station_id = :station_id AND status = 'Active' 
    ORDER BY sort_order ASC, id ASC
");
$cfStmt->execute(['station_id' => $stationId]);
$customFields = $cfStmt->fetchAll(PDO::FETCH_ASSOC);

// Ensure uploads directory exists
$uploadDir = __DIR__ . '/uploads';
if (!is_dir($uploadDir)) {
    mkdir($uploadDir, 0777, true);
}

// Edit Mode Logic
$isEdit = false;
$employee = null;
$savedCustomData = [];

if (isset($_GET['id'])) {
    $stmt = $pdo->prepare("SELECT * FROM mcc_employee WHERE id = ?");
    $stmt->execute([$_GET['id']]);
    $employee = $stmt->fetch(PDO::FETCH_ASSOC);
    if ($employee) {
        $isEdit = true;
        if (!empty($employee['custom_data'])) {
            $savedCustomData = json_decode($employee['custom_data'], true);
            if (!is_array($savedCustomData)) {
                $savedCustomData = [];
            }
        }
    }
}

// Helper to get field value (supporting custom_data, direct table columns, or empty default)
function getFieldVal($key, $employee, $savedCustomData) {
    if (isset($savedCustomData[$key])) {
        return htmlspecialchars((string)$savedCustomData[$key]);
    }
    if (isset($employee[$key])) {
        return htmlspecialchars((string)$employee[$key]);
    }
    return '';
}

// POST Action Handling (AJAX Form submission)
if ($_SERVER['REQUEST_METHOD'] === 'POST' && isset($_POST['action']) && $_POST['action'] === 'save_employee') {
    header('Content-Type: application/json');
    try {
        $empId = trim($_POST['employee_id'] ?? '');
        $fullName = trim($_POST['full_name'] ?? '');
        $designation = trim($_POST['designation'] ?? '');
        $id = isset($_POST['id']) ? intval($_POST['id']) : 0;
        
        if (empty($empId) || empty($fullName) || empty($designation)) {
            echo json_encode(['success' => false, 'message' => 'Employee ID, Full Name, and Designation are required fields.']);
            exit;
        }

        // Check if employee ID is already taken by someone else
        $dupCheck = $pdo->prepare("SELECT id FROM mcc_employee WHERE employee_id = ? AND id != ?");
        $dupCheck->execute([$empId, $id]);
        if ($dupCheck->rowCount() > 0) {
            echo json_encode(['success' => false, 'message' => 'Employee ID already exists.']);
            exit;
        }

        // Photo Upload Handling
        $photoFileName = $isEdit && $employee ? $employee['employee_photo'] : null;
        if (isset($_FILES['employee_photo']) && $_FILES['employee_photo']['error'] === UPLOAD_ERR_OK) {
            $fileTmpPath = $_FILES['employee_photo']['tmp_name'];
            $origFileName = $_FILES['employee_photo']['name'];
            $fileExtension = strtolower(pathinfo($origFileName, PATHINFO_EXTENSION));
            
            $allowedExtensions = ['jpg', 'jpeg', 'png', 'gif', 'webp'];
            if (!in_array($fileExtension, $allowedExtensions)) {
                echo json_encode(['success' => false, 'message' => 'Only JPG, JPEG, PNG, GIF, and WEBP photos are allowed.']);
                exit;
            }

            $newFileName = uniqid('emp_', true) . '.' . $fileExtension;
            $destPath = $uploadDir . '/' . $newFileName;
            
            if (move_uploaded_file($fileTmpPath, $destPath)) {
                if ($isEdit && !empty($employee['employee_photo'])) {
                    $oldPhotoPath = $uploadDir . '/' . $employee['employee_photo'];
                    if (file_exists($oldPhotoPath)) {
                        @unlink($oldPhotoPath);
                    }
                }
                $photoFileName = $newFileName;
            } else {
                echo json_encode(['success' => false, 'message' => 'Failed to save the uploaded image.']);
                exit;
            }
        }

        // Retrieve existing columns in mcc_employee to sync matching direct columns
        $existingCols = [];
        try {
            $colStmt = $pdo->query("SHOW COLUMNS FROM mcc_employee");
            while ($c = $colStmt->fetch(PDO::FETCH_ASSOC)) {
                $existingCols[] = $c['Field'];
            }
        } catch (Exception $e) {}

        // Collect Custom Dynamic Fields
        $submittedCustomData = [];
        $columnDirectUpdates = [];

        foreach ($customFields as $cf) {
            $k = $cf['field_key'];
            $val = '';

            if ($cf['field_type'] === 'file') {
                if (isset($_FILES['custom_' . $k]) && $_FILES['custom_' . $k]['error'] === UPLOAD_ERR_OK) {
                    $ext = strtolower(pathinfo($_FILES['custom_' . $k]['name'], PATHINFO_EXTENSION));
                    $newFile = uniqid('cf_' . $k . '_', true) . '.' . $ext;
                    if (move_uploaded_file($_FILES['custom_' . $k]['tmp_name'], $uploadDir . '/' . $newFile)) {
                        $val = $newFile;
                    }
                } elseif ($isEdit && isset($savedCustomData[$k])) {
                    $val = $savedCustomData[$k];
                }
            } else {
                $val = trim($_POST['custom_' . $k] ?? ($_POST[$k] ?? ''));
            }

            // Check required validation
            if (!empty($cf['is_required']) && ($val === '' || $val === null)) {
                echo json_encode(['success' => false, 'message' => "Field '{$cf['field_label']}' is required."]);
                exit;
            }

            $submittedCustomData[$k] = $val;

            // If column exists directly in mcc_employee, sync it for backwards compatibility
            if (in_array($k, $existingCols)) {
                $columnDirectUpdates[$k] = ($val === '' ? null : $val);
            }
        }

        if ($isEdit) {
            // Merge with existing custom data
            $prevCustom = !empty($employee['custom_data']) ? json_decode($employee['custom_data'], true) : [];
            if (!is_array($prevCustom)) $prevCustom = [];
            $finalCustom = array_merge($prevCustom, $submittedCustomData);

            $updateFields = [
                "`employee_id` = :employee_id",
                "`full_name` = :full_name",
                "`designation` = :designation",
                "`employee_photo` = :employee_photo",
                "`custom_data` = :custom_data"
            ];
            $params = [
                'employee_id' => $empId,
                'full_name' => $fullName,
                'designation' => $designation,
                'employee_photo' => $photoFileName,
                'custom_data' => json_encode($finalCustom, JSON_UNESCAPED_UNICODE),
                'id' => $id
            ];

            foreach ($columnDirectUpdates as $colName => $colVal) {
                $updateFields[] = "`{$colName}` = :{$colName}";
                $params[$colName] = $colVal;
            }

            $updateSql = "UPDATE mcc_employee SET " . implode(', ', $updateFields) . " WHERE id = :id";
            $stmt = $pdo->prepare($updateSql);
            $stmt->execute($params);

            echo json_encode(['success' => true, 'message' => 'Employee details updated successfully!']);
            exit;
        } else {
            // Insert
            $insertCols = ['station_id', 'employee_id', 'full_name', 'designation', 'employee_photo', 'custom_data'];
            $insertPlaceholders = [':station_id', ':employee_id', ':full_name', ':designation', ':employee_photo', ':custom_data'];
            $params = [
                'station_id' => $stationId,
                'employee_id' => $empId,
                'full_name' => $fullName,
                'designation' => $designation,
                'employee_photo' => $photoFileName,
                'custom_data' => json_encode($submittedCustomData, JSON_UNESCAPED_UNICODE)
            ];

            foreach ($columnDirectUpdates as $colName => $colVal) {
                $insertCols[] = "`{$colName}`";
                $insertPlaceholders[] = ":{$colName}";
                $params[$colName] = $colVal;
            }

            $insertSql = "INSERT INTO mcc_employee (" . implode(', ', $insertCols) . ") VALUES (" . implode(', ', $insertPlaceholders) . ")";
            $stmt = $pdo->prepare($insertSql);
            $stmt->execute($params);

            echo json_encode(['success' => true, 'message' => 'Employee created successfully!']);
            exit;
        }
    } catch (Exception $e) {
        echo json_encode(['success' => false, 'message' => 'Database error: ' . $e->getMessage()]);
        exit;
    }
}

$pageTitle = $isEdit ? 'MCC | Edit Employee' : 'MCC | Add Employee';

$extraStyles = '
  :root {
    --primary-color: #07203a;
    --primary-dark: #07182c;
    --primary-blue: #0c3b6d;
    --accent-blue: #1987C6;
    --success-green: #198754;
    --cancel-gray: #6c757d;
    --section-bg: #ffffff;
    --input-border: #d1d5db;
    --label-color: #4b5563;
  }

  body, .app-main {
    font-family: "Inter", -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, sans-serif !important;
    background-color: #f4f6f9;
    min-height: 100vh;
  }

  .header-card {
    background: linear-gradient(135deg, #07203a 0%, #0c3b6d 100%);
    color: white;
    padding: 16px 25px;
    border-radius: 10px;
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-bottom: 20px;
    box-shadow: 0 4px 14px rgba(7, 32, 58, 0.18);
  }

  .header-left {
    display: flex;
    align-items: center;
    gap: 18px;
  }

  .header-title {
    font-size: 1.35rem;
    font-weight: 700;
    margin: 0;
    letter-spacing: -0.2px;
  }

  .btn-back {
    background: rgba(255, 255, 255, 0.15);
    color: #ffffff;
    border: 1px solid rgba(255, 255, 255, 0.25);
    padding: 6px 14px;
    border-radius: 6px;
    font-size: 0.85rem;
    font-weight: 600;
    display: flex;
    align-items: center;
    gap: 6px;
    text-decoration: none;
    transition: all 0.2s ease-in-out;
  }

  .btn-back:hover {
    background: #ffffff;
    color: #07203a;
    transform: translateX(-2px);
    box-shadow: 0 2px 6px rgba(0,0,0,0.15);
  }

  .btn-import-header {
    background: #10b981;
    color: white;
    border: none;
    padding: 7px 16px;
    border-radius: 6px;
    font-size: 0.85rem;
    font-weight: 600;
    display: flex;
    align-items: center;
    gap: 6px;
    cursor: pointer;
    transition: all 0.2s;
  }

  .btn-import-header:hover {
    background: #059669;
    color: white;
    transform: translateY(-1px);
    box-shadow: 0 4px 10px rgba(16, 185, 129, 0.3);
  }

  .form-container {
    width: 100%;
    padding: 10px 15px;
    margin: 0;
  }

  .form-section {
    background: var(--section-bg);
    border-radius: 10px;
    padding: 20px 24px;
    margin-bottom: 20px;
    box-shadow: 0 2px 8px rgba(0,0,0,0.04);
    border: 1px solid #e5e7eb;
    width: 100%;
  }

  .section-header {
    display: flex;
    align-items: center;
    justify-content: space-between;
    margin-bottom: 18px;
    padding-bottom: 12px;
    border-bottom: 1px solid #f0f2f5;
  }

  .section-header-title {
    display: flex;
    align-items: center;
    gap: 10px;
  }

  .section-icon {
    font-size: 1.25rem;
    color: #0c3b6d;
  }

  .section-title {
    font-size: 1rem;
    font-weight: 700;
    color: #07203a;
    margin: 0;
    text-transform: uppercase;
    letter-spacing: 0.4px;
  }

  .field-grid-3 {
    display: grid;
    grid-template-columns: repeat(3, 1fr);
    gap: 16px;
  }

  .field-grid-2 {
    display: grid;
    grid-template-columns: repeat(2, 1fr);
    gap: 16px;
  }

  .form-group {
    margin-bottom: 8px;
  }

  .form-label {
    display: block;
    font-size: 0.78rem;
    font-weight: 600;
    color: #4b5563;
    margin-bottom: 6px;
    text-transform: uppercase;
    letter-spacing: 0.2px;
  }

  .form-label .required {
    color: #dc3545;
    margin-left: 2px;
  }

  .form-control, .form-select {
    width: 100%;
    padding: 8px 12px;
    border: 1px solid var(--input-border);
    border-radius: 6px;
    font-size: 0.88rem;
    color: #1f2937;
    background-color: #fff;
    transition: all 0.2s ease-in-out;
  }

  .form-control:focus, .form-select:focus {
    border-color: #0c3b6d;
    box-shadow: 0 0 0 3px rgba(12, 59, 109, 0.12);
    outline: none;
  }

  .photo-upload-box {
    border: 1.5px dashed #cbd5e1;
    border-radius: 8px;
    padding: 12px;
    background-color: #f8fafc;
    transition: all 0.2s;
  }

  .photo-upload-box:hover {
    border-color: #0c3b6d;
    background-color: #f0f4f8;
  }

  .footer-actions {
    display: flex;
    justify-content: flex-end;
    gap: 12px;
    margin-top: 15px;
    padding-bottom: 40px;
  }

  .btn-action {
    padding: 10px 24px;
    border-radius: 6px;
    font-weight: 600;
    font-size: 0.9rem;
    display: flex;
    align-items: center;
    gap: 8px;
    border: none;
    cursor: pointer;
    transition: all 0.2s ease-in-out;
  }

  .btn-cancel {
    background-color: var(--cancel-gray);
    color: white;
  }

  .btn-cancel:hover {
    background-color: #495057;
  }

  .btn-create {
    background: linear-gradient(135deg, #07203a 0%, #0c3b6d 100%);
    color: white;
  }

  .btn-create:hover {
    background: linear-gradient(135deg, #07182c 0%, #07203a 100%);
    box-shadow: 0 4px 10px rgba(7, 32, 58, 0.25);
  }

  @media (max-width: 992px) {
    .field-grid-3 {
      grid-template-columns: repeat(2, 1fr);
    }
  }

  @media (max-width: 576px) {
    .field-grid-3, .field-grid-2 {
      grid-template-columns: 1fr;
    }
  }
';

$extraScripts = '
  // Employee Form Submit
  document.getElementById("employeeForm").addEventListener("submit", function(e) {
    e.preventDefault();
    const formData = new FormData(this);
    formData.append("action", "save_employee");
    
    const submitBtn = this.querySelector(\'button[type="submit"]\');
    const originalBtnHTML = submitBtn.innerHTML;
    submitBtn.disabled = true;
    submitBtn.innerHTML = \'<span class="spinner-border spinner-border-sm me-2" role="status" aria-hidden="true"></span>Saving...\';
    
    fetch(window.location.href, {
      method: "POST",
      body: formData
    })
    .then(response => response.json())
    .then(data => {
      if (data.success) {
        alert(data.message);
        window.location.href = "view-employee.php";
      } else {
        alert(data.message);
        submitBtn.disabled = false;
        submitBtn.innerHTML = originalBtnHTML;
      }
    })
    .catch(error => {
      console.error("Error:", error);
      alert("An error occurred while saving the employee.");
      submitBtn.disabled = false;
      submitBtn.innerHTML = originalBtnHTML;
    });
  });

  // Excel Import Submit
  document.getElementById("excelImportForm")?.addEventListener("submit", function(e) {
    e.preventDefault();
    const formData = new FormData(this);
    formData.append("action", "import_excel");

    const submitBtn = document.getElementById("importSubmitBtn");
    const originalBtnHTML = submitBtn.innerHTML;
    submitBtn.disabled = true;
    submitBtn.innerHTML = \'<span class="spinner-border spinner-border-sm me-2"></span>Importing...\';

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
        alertBox.innerHTML = \'<i class="bi bi-check-circle-fill me-2"></i>\' + data.message;
        setTimeout(() => {
          window.location.href = "view-employee.php";
        }, 1500);
      } else {
        alertBox.className = "alert alert-danger";
        alertBox.innerHTML = \'<i class="bi bi-exclamation-triangle-fill me-2"></i>\' + data.message;
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
';

include 'header.php';
include 'sidebar.php';
?>

<main class="app-main">
  <div class="form-container">

    <!-- Header Card -->
    <div class="header-card">
      <div class="header-left">
        <a href="view-employee.php" class="btn-back">
          <i class="bi bi-arrow-left"></i> Back to Directory
        </a>
        <h1 class="header-title"><?= $isEdit ? 'Edit Employee Details' : 'Create New Employee' ?></h1>
        <span class="badge bg-light text-dark px-2 py-1 rounded-pill small" style="font-size: 0.8rem;">
          <i class="bi bi-geo-alt-fill text-primary"></i> <?= htmlspecialchars($stationName) ?>
        </span>
      </div>
      <div>
        <button type="button" class="btn-import-header" data-bs-toggle="modal" data-bs-target="#excelImportModal">
          <i class="bi bi-file-earmark-excel"></i> Import from Excel
        </button>
      </div>
    </div>

    <form id="employeeForm" enctype="multipart/form-data">
      <input type="hidden" name="id" value="<?= $isEdit ? $employee['id'] : '' ?>">

      <!-- 1. Mandatory Core Default Information -->
      <div class="form-section">
        <div class="section-header">
          <div class="section-header-title">
            <i class="bi bi-person-badge-fill section-icon"></i>
            <div>
              <h2 class="section-title">Core Information (Permanent Default Inputs)</h2>
              <span class="text-muted small">Standard mandatory identification for all employees</span>
            </div>
          </div>
          <span class="badge bg-primary-subtle text-primary border border-primary-subtle rounded-pill px-3 py-1">
            Default Inputs
          </span>
        </div>

        <div class="field-grid-3">
          <div class="form-group">
            <label class="form-label">Employee ID <span class="required">*</span></label>
            <input type="text" name="employee_id" class="form-control" placeholder="e.g. EMP1001" required value="<?= getFieldVal('employee_id', $employee, $savedCustomData) ?>">
          </div>

          <div class="form-group">
            <label class="form-label">Full Name <span class="required">*</span></label>
            <input type="text" name="full_name" class="form-control" placeholder="Employee Full Name" required value="<?= getFieldVal('full_name', $employee, $savedCustomData) ?>">
          </div>

          <div class="form-group">
            <label class="form-label">Designation <span class="required">*</span></label>
            <select name="designation" class="form-select" required>
              <option value="">-- Select Designation --</option>
              <?php 
              $currentDes = $employee['designation'] ?? '';
              foreach ($designationOptions as $dOpt): 
              ?>
                <option value="<?= htmlspecialchars($dOpt) ?>" <?= ($currentDes === $dOpt) ? 'selected' : '' ?>>
                  <?= htmlspecialchars($dOpt) ?>
                </option>
              <?php endforeach; ?>
            </select>
          </div>
        </div>

        <!-- Photo Upload -->
        <div class="form-group mt-3">
          <label class="form-label">Employee Photo</label>
          <div class="photo-upload-box d-flex align-items-center gap-3">
            <?php if ($isEdit && !empty($employee['employee_photo'])): ?>
              <div>
                <img src="uploads/<?= htmlspecialchars($employee['employee_photo']) ?>" style="width: 70px; height: 70px; object-fit: cover; border-radius: 6px; border: 1px solid #cbd5e1;" alt="Current Photo">
              </div>
            <?php endif; ?>
            <div class="flex-grow-1">
              <input type="file" name="employee_photo" class="form-control" accept="image/*">
              <span class="text-muted small mt-1 d-block">Supported formats: JPG, PNG, WEBP. Max recommended size: 2MB.</span>
            </div>
          </div>
        </div>
      </div>

      <!-- 2. Location-Specific Custom Inputs -->
      <div class="form-section">
        <div class="section-header">
          <div class="section-header-title">
            <i class="bi bi-ui-checks-grid section-icon text-indigo"></i>
            <div>
              <h2 class="section-title">Additional Information (Configured for <?= htmlspecialchars($stationName) ?>)</h2>
              <span class="text-muted small">Location-wise dynamic inputs configured in Admin Panel</span>
            </div>
          </div>
          <span class="badge bg-indigo-subtle text-indigo border border-indigo-subtle rounded-pill px-3 py-1">
            <?= count($customFields) ?> Custom Inputs Configured
          </span>
        </div>

        <?php if (empty($customFields)): ?>
          <div class="text-center py-4 bg-light rounded-3 border">
            <i class="bi bi-info-circle text-muted fs-3 mb-2 d-block"></i>
            <h6 class="text-secondary fw-bold mb-1">Only Standard Default Inputs Active for <?= htmlspecialchars($stationName) ?></h6>
            <p class="text-muted small mb-0">
              No extra custom inputs have been configured for this location yet.<br>
              Administrators can add or remove location-specific inputs (like Mobile, Aadhar, Address, PVC, etc.) anytime from the <strong>Admin Panel &gt; Employee Custom Fields</strong>.
            </p>
          </div>
        <?php else: ?>
          <div class="field-grid-3">
            <?php foreach ($customFields as $cf): 
              $fieldKey = $cf['field_key'];
              $inputName = 'custom_' . $fieldKey;
              $val = getFieldVal($fieldKey, $employee, $savedCustomData);
              $isRequired = !empty($cf['is_required']);
              $placeholder = htmlspecialchars($cf['placeholder'] ?? '');
            ?>
              <div class="form-group <?= ($cf['field_type'] === 'textarea') ? 'grid-span-full' : '' ?>">
                <label class="form-label">
                  <?= htmlspecialchars($cf['field_label']) ?>
                  <?php if ($isRequired): ?><span class="required">*</span><?php endif; ?>
                </label>

                <?php if ($cf['field_type'] === 'text'): ?>
                  <input type="text" name="<?= $inputName ?>" class="form-control" placeholder="<?= $placeholder ?>" value="<?= $val ?>" <?= $isRequired ? 'required' : '' ?>>

                <?php elseif ($cf['field_type'] === 'number'): ?>
                  <input type="number" name="<?= $inputName ?>" class="form-control" placeholder="<?= $placeholder ?>" value="<?= $val ?>" <?= $isRequired ? 'required' : '' ?>>

                <?php elseif ($cf['field_type'] === 'date'): ?>
                  <input type="date" name="<?= $inputName ?>" class="form-control" value="<?= $val ?>" <?= $isRequired ? 'required' : '' ?>>

                <?php elseif ($cf['field_type'] === 'select'): 
                  $options = array_map('trim', explode(',', $cf['field_options'] ?? ''));
                ?>
                  <select name="<?= $inputName ?>" class="form-select" <?= $isRequired ? 'required' : '' ?>>
                    <option value="">-- Select <?= htmlspecialchars($cf['field_label']) ?> --</option>
                    <?php foreach ($options as $opt): ?>
                      <option value="<?= htmlspecialchars($opt) ?>" <?= ($val === $opt) ? 'selected' : '' ?>>
                        <?= htmlspecialchars($opt) ?>
                      </option>
                    <?php endforeach; ?>
                  </select>

                <?php elseif ($cf['field_type'] === 'textarea'): ?>
                  <textarea name="<?= $inputName ?>" class="form-control" rows="2" placeholder="<?= $placeholder ?>" <?= $isRequired ? 'required' : '' ?>><?= $val ?></textarea>

                <?php elseif ($cf['field_type'] === 'file'): ?>
                  <?php if (!empty($val)): ?>
                    <div class="mb-1 small">
                      <a href="uploads/<?= htmlspecialchars($val) ?>" target="_blank" class="text-primary text-decoration-none">
                        <i class="bi bi-file-earmark-check"></i> View uploaded file
                      </a>
                    </div>
                  <?php endif; ?>
                  <input type="file" name="<?= $inputName ?>" class="form-control" <?= ($isRequired && empty($val)) ? 'required' : '' ?>>

                <?php endif; ?>
              </div>
            <?php endforeach; ?>
          </div>
        <?php endif; ?>
      </div>

      <!-- Action Buttons -->
      <div class="footer-actions">
        <button type="button" class="btn-action btn-cancel" onclick="window.location.href='view-employee.php'">
          <i class="bi bi-x-lg"></i> Cancel
        </button>
        <button type="submit" class="btn-action btn-create">
          <i class="bi bi-save"></i> <?= $isEdit ? 'Update Employee' : 'Save Employee' ?>
        </button>
      </div>
    </form>

  </div>
</main>

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
                <span class="text-muted small">Generated specifically for <?= htmlspecialchars($stationName) ?> with active custom columns</span>
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

<?php include 'footer.php'; ?>