<?php
require_once '../connection.php';

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

// Ensure uploads directory exists
$uploadDir = __DIR__ . '/uploads';
if (!is_dir($uploadDir)) {
    mkdir($uploadDir, 0777, true);
}

// Edit Mode Logic
$isEdit = false;
$employee = null;
if (isset($_GET['id'])) {
    $stmt = $pdo->prepare("SELECT * FROM mcc_employee WHERE id = ?");
    $stmt->execute([$_GET['id']]);
    $employee = $stmt->fetch();
    if ($employee) {
        $isEdit = true;
    }
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

        // Parse optional numeric/date fields
        $age = !empty($_POST['age']) ? intval($_POST['age']) : null;
        $dob = !empty($_POST['dob']) ? $_POST['dob'] : null;
        $police_ver_dt = !empty($_POST['police_ver_dt']) ? $_POST['police_ver_dt'] : null;
        $issue_date = !empty($_POST['issue_date']) ? $_POST['issue_date'] : null;
        $valid_upto_date = !empty($_POST['valid_upto_date']) ? $_POST['valid_upto_date'] : null;

        // Collect string values
        $fatherName = trim($_POST['father_name'] ?? '');
        $motherName = trim($_POST['mother_name'] ?? '');
        $mobileNumber = trim($_POST['mobile_number'] ?? '');
        $aadharNumber = trim($_POST['aadhar_number'] ?? '');
        $address = trim($_POST['address'] ?? '');
        $renId = trim($_POST['ren_id'] ?? '');
        $rakshakId = trim($_POST['rakshak_id'] ?? '');
        $panCard = trim($_POST['pan_card'] ?? '');
        $policeVer = trim($_POST['police_ver'] ?? '');
        $pvc = trim($_POST['pvc'] ?? '');
        $pvcOkApplied = trim($_POST['pvc_ok_applied'] ?? '');
        $pvcIssueMonth = trim($_POST['pvc_issue_month'] ?? '');
        $medical = trim($_POST['medical'] ?? '');
        $medicalIssueMonth = trim($_POST['medical_issue_month'] ?? '');
        $education = trim($_POST['education'] ?? '');
        $documentStatus = trim($_POST['document_status'] ?? '');
        $accountName = trim($_POST['account_name'] ?? '');
        $accountNumber = trim($_POST['account_number'] ?? '');
        $ifscCode = trim($_POST['ifsc_code'] ?? '');
        $status = trim($_POST['status'] ?? '');
        $validUptoMonth = trim($_POST['valid_upto_month'] ?? '');
        $formulaValidUpto = trim($_POST['formula_valid_upto'] ?? '');
        $notification = trim($_POST['notification'] ?? '');
        $documentLink = trim($_POST['document_link'] ?? '');
        $remarks = trim($_POST['remarks'] ?? '');
        $bloodGroup = trim($_POST['blood_group'] ?? '');
        $department = trim($_POST['department'] ?? '');

        // Photo Upload Handling
        $photoFileName = $isEdit && $employee ? $employee['employee_photo'] : null;
        if (isset($_FILES['employee_photo']) && $_FILES['employee_photo']['error'] === UPLOAD_ERR_OK) {
            $fileTmpPath = $_FILES['employee_photo']['tmp_name'];
            $origFileName = $_FILES['employee_photo']['name'];
            $fileExtension = strtolower(pathinfo($origFileName, PATHINFO_EXTENSION));
            
            // Validate file extension
            $allowedExtensions = ['jpg', 'jpeg', 'png', 'gif', 'webp'];
            if (!in_array($fileExtension, $allowedExtensions)) {
                echo json_encode(['success' => false, 'message' => 'Only JPG, JPEG, PNG, GIF, and WEBP photos are allowed.']);
                exit;
            }

            $newFileName = uniqid('emp_', true) . '.' . $fileExtension;
            $destPath = $uploadDir . '/' . $newFileName;
            
            if (move_uploaded_file($fileTmpPath, $destPath)) {
                // If editing, delete old photo to save space
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

        if ($isEdit) {
            // Update
            $updateSql = "UPDATE mcc_employee SET 
                employee_id = :employee_id, full_name = :full_name, designation = :designation, age = :age, 
                employee_photo = :employee_photo, father_name = :father_name, mother_name = :mother_name, 
                mobile_number = :mobile_number, dob = :dob, aadhar_number = :aadhar_number, address = :address, 
                ren_id = :ren_id, rakshak_id = :rakshak_id, pan_card = :pan_card, police_ver = :police_ver, 
                police_ver_dt = :police_ver_dt, pvc = :pvc, pvc_ok_applied = :pvc_ok_applied, 
                pvc_issue_month = :pvc_issue_month, medical = :medical, medical_issue_month = :medical_issue_month, 
                education = :education, document_status = :document_status, account_name = :account_name, 
                account_number = :account_number, ifsc_code = :ifsc_code, status = :status, 
                issue_date = :issue_date, valid_upto_date = :valid_upto_date, valid_upto_month = :valid_upto_month, 
                formula_valid_upto = :formula_valid_upto, notification = :notification, 
                document_link = :document_link, remarks = :remarks, blood_group = :blood_group, department = :department
                WHERE id = :id";
            
            $stmt = $pdo->prepare($updateSql);
            $stmt->execute([
                'employee_id' => $empId, 'full_name' => $fullName, 'designation' => $designation, 'age' => $age,
                'employee_photo' => $photoFileName, 'father_name' => $fatherName, 'mother_name' => $motherName,
                'mobile_number' => $mobileNumber, 'dob' => $dob, 'aadhar_number' => $aadharNumber, 'address' => $address,
                'ren_id' => $renId, 'rakshak_id' => $rakshakId, 'pan_card' => $panCard, 'police_ver' => $policeVer,
                'police_ver_dt' => $police_ver_dt, 'pvc' => $pvc, 'pvc_ok_applied' => $pvcOkApplied,
                'pvc_issue_month' => $pvcIssueMonth, 'medical' => $medical, 'medical_issue_month' => $medicalIssueMonth,
                'education' => $education, 'document_status' => $documentStatus, 'account_name' => $accountName,
                'account_number' => $accountNumber, 'ifsc_code' => $ifscCode, 'status' => $status,
                'issue_date' => $issue_date, 'valid_upto_date' => $valid_upto_date, 'valid_upto_month' => $validUptoMonth,
                'formula_valid_upto' => $formulaValidUpto, 'notification' => $notification,
                'document_link' => $documentLink, 'remarks' => $remarks, 'blood_group' => $bloodGroup, 'department' => $department, 'id' => $id
            ]);
            echo json_encode(['success' => true, 'message' => 'Employee details updated successfully!']);
            exit;
        } else {
            // Insert
            $insertSql = "INSERT INTO mcc_employee (
                employee_id, full_name, designation, age, employee_photo, father_name, mother_name, 
                mobile_number, dob, aadhar_number, address, ren_id, rakshak_id, pan_card, police_ver, 
                police_ver_dt, pvc, pvc_ok_applied, pvc_issue_month, medical, medical_issue_month, 
                education, document_status, account_name, account_number, ifsc_code, status, 
                issue_date, valid_upto_date, valid_upto_month, formula_valid_upto, notification, 
                document_link, remarks, blood_group, department
            ) VALUES (
                :employee_id, :full_name, :designation, :age, :employee_photo, :father_name, :mother_name, 
                :mobile_number, :dob, :aadhar_number, :address, :ren_id, :rakshak_id, :pan_card, :police_ver, 
                :police_ver_dt, :pvc, :pvc_ok_applied, :pvc_issue_month, :medical, :medical_issue_month, 
                :education, :document_status, :account_name, :account_number, :ifsc_code, :status, 
                :issue_date, :valid_upto_date, :valid_upto_month, :formula_valid_upto, :notification, 
                :document_link, :remarks, :blood_group, :department
            )";
            
            $stmt = $pdo->prepare($insertSql);
            $stmt->execute([
                'employee_id' => $empId, 'full_name' => $fullName, 'designation' => $designation, 'age' => $age,
                'employee_photo' => $photoFileName, 'father_name' => $fatherName, 'mother_name' => $motherName,
                'mobile_number' => $mobileNumber, 'dob' => $dob, 'aadhar_number' => $aadharNumber, 'address' => $address,
                'ren_id' => $renId, 'rakshak_id' => $rakshakId, 'pan_card' => $panCard, 'police_ver' => $policeVer,
                'police_ver_dt' => $police_ver_dt, 'pvc' => $pvc, 'pvc_ok_applied' => $pvcOkApplied,
                'pvc_issue_month' => $pvcIssueMonth, 'medical' => $medical, 'medical_issue_month' => $medicalIssueMonth,
                'education' => $education, 'document_status' => $documentStatus, 'account_name' => $accountName,
                'account_number' => $accountNumber, 'ifsc_code' => $ifscCode, 'status' => $status,
                'issue_date' => $issue_date, 'valid_upto_date' => $valid_upto_date, 'valid_upto_month' => $validUptoMonth,
                'formula_valid_upto' => $formulaValidUpto, 'notification' => $notification,
                'document_link' => $documentLink, 'remarks' => $remarks, 'blood_group' => $bloodGroup, 'department' => $department
            ]);
            echo json_encode(['success' => true, 'message' => 'Employee created successfully!']);
            exit;
        }
    } catch (Exception $e) {
        echo json_encode(['success' => false, 'message' => 'Database error: ' . $e->getMessage()]);
        exit;
    }
}

// Helper to get HTML escaped value
function getVal($field, $employee) {
    return htmlspecialchars($employee[$field] ?? '');
}

$pageTitle = $isEdit ? 'MCC | Edit Employee' : 'MCC | Add Employee';

$extraStyles = '
  :root {
    --primary-purple: #6f42c1;
    --dark-purple: #5a32a3;
    --success-green: #198754;
    --cancel-gray: #6c757d;
    --section-bg: #ffffff;
    --input-border: #dee2e6;
    --label-color: #495057;
  }

  .app-main {
    background-color: #f0f2f5;
    min-height: 100vh;
  }

  .header-card {
    background: var(--primary-purple);
    color: white;
    padding: 12px 25px;
    border-radius: 8px;
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-bottom: 25px;
    box-shadow: 0 4px 12px rgba(0,0,0,0.1);
  }

  .header-left {
    display: flex;
    align-items: center;
    gap: 20px;
  }

  .header-title {
    font-size: 1.5rem;
    font-weight: 700;
    margin: 0;
  }

  .header-right {
    font-size: 0.85rem;
    opacity: 0.9;
  }

  .btn-back {
    background: #fff;
    color: #333;
    border: none;
    padding: 5px 15px;
    border-radius: 6px;
    font-size: 0.85rem;
    font-weight: 600;
    display: flex;
    align-items: center;
    gap: 8px;
    text-decoration: none;
    transition: all 0.2s;
  }

  .btn-back:hover {
    background: #f8f9fa;
    transform: translateX(-2px);
  }

  .form-container {
    width: 100%;
    padding: 10px;
    margin: 0;
  }

  .form-main-grid {
    display: grid;
    grid-template-columns: 1fr 1fr;
    gap: 15px;
    align-items: start;
  }

  @media (max-width: 1100px) {
    .form-main-grid {
      grid-template-columns: 1fr;
    }
  }

  .form-section {
    background: var(--section-bg);
    border-radius: 8px;
    padding: 2px 18px;
    margin-bottom: 6px;
    box-shadow: 0 1px 3px rgba(0,0,0,0.05);
    border: 1px solid #eef0f2;
    width: 100%;
  }

  .section-header {
    display: flex;
    align-items: center;
    gap: 8px;
    margin-bottom: 6px;
    padding-bottom: 4px;
    border-bottom: 1px solid #f1f1f1;
  }

  .section-icon {
    font-size: 1.1rem;
    color: var(--primary-purple);
  }

  .section-title {
    font-size: 0.95rem;
    font-weight: 700;
    color: #333;
    margin: 0;
    text-transform: uppercase;
    letter-spacing: 0.5px;
  }

  .field-grid-4 {
    display: grid;
    grid-template-columns: repeat(4, 1fr);
    gap: 12px;
  }

  .field-grid-3 {
    display: grid;
    grid-template-columns: repeat(3, 1fr);
    gap: 12px;
  }

  .form-group {
    margin-bottom: 8px;
  }

  .form-column {
    display: flex;
    flex-direction: column;
    gap: 12px;
  }

  .flex-section {
    flex: 1;
    display: flex;
    flex-direction: column;
    padding-top: 25px !important;
    padding-bottom: 25px !important;
  }

  .flex-section .field-grid-3 {
    flex: 1;
    align-content: space-evenly;
  }

  .form-label {
    display: block;
    font-size: 0.78rem;
    font-weight: 600;
    color: #666;
    margin-bottom: 4px;
    text-transform: uppercase;
  }

  .form-label .required {
    color: #dc3545;
    margin-left: 2px;
  }

  .form-control, .form-select {
    width: 100%;
    padding: 6px 10px;
    border: 1px solid #d1d5db;
    border-radius: 6px;
    font-size: 0.85rem;
    color: #333;
    background-color: #fff;
    transition: all 0.2s;
  }

  .form-control:focus, .form-select:focus {
    border-color: var(--primary-purple);
    box-shadow: 0 0 0 3px rgba(111, 66, 193, 0.1);
    outline: none;
  }

  .form-control::placeholder {
    color: #adb5bd;
  }

  .photo-upload-container {
    border: 1.5px dashed #dee2e6;
    border-radius: 6px;
    padding: 8px;
    background-color: #fafafa;
    transition: all 0.2s;
  }

  .photo-upload-container:hover {
    border-color: var(--primary-purple);
    background-color: #fdfcff;
  }

  .photo-hint {
    font-size: 0.8rem;
    color: #6c757d;
    margin-top: 8px;
  }

  .footer-actions {
    display: flex;
    justify-content: flex-end;
    gap: 15px;
    margin-top: 10px;
    padding-bottom: 40px;
  }

  .btn-action {
    padding: 8px 20px;
    border-radius: 6px;
    font-weight: 600;
    font-size: 0.9rem;
    display: flex;
    align-items: center;
    gap: 8px;
    border: none;
    cursor: pointer;
    transition: all 0.2s;
    box-shadow: 0 2px 4px rgba(0,0,0,0.1);
  }

  .btn-cancel {
    background-color: var(--cancel-gray);
    color: white;
  }

  .btn-cancel:hover {
    background-color: #5a6268;
    transform: translateY(-1px);
    box-shadow: 0 6px 12px rgba(0,0,0,0.15);
  }

  .btn-create {
    background-color: var(--success-green);
    color: white;
  }

  .btn-create:hover {
    background-color: #157347;
    transform: translateY(-1px);
    box-shadow: 0 6px 12px rgba(0,0,0,0.15);
  }

  @media (max-width: 1200px) {
    .field-grid-4 {
      grid-template-columns: repeat(3, 1fr);
    }
  }

  @media (max-width: 992px) {
    .field-grid-4, .field-grid-3 {
      grid-template-columns: repeat(2, 1fr);
    }
  }

  @media (max-width: 576px) {
    .field-grid-4, .field-grid-3 {
      grid-template-columns: 1fr;
    }
    .header-card {
      flex-direction: column;
      align-items: flex-start;
      gap: 10px;
    }
    .header-right {
      display: none;
    }
  }
';

$extraScripts = '
  document.getElementById("employeeForm").addEventListener("submit", function(e) {
    e.preventDefault();
    const formData = new FormData(this);
    formData.append("action", "save_employee");
    
    // Disable submit button to prevent double submit
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
';

include 'header.php';
include 'sidebar.php';
?>

<main class="app-main">
  <div class="form-container">
    <div class="header-card">
      <div class="header-left">
        <a href="view-employee.php" class="btn-back">
          <i class="bi bi-arrow-left"></i> Back
        </a>
        <h1 class="header-title"><?= $isEdit ? 'Edit Employee Details' : 'Create New Employee' ?></h1>
      </div>
    </div>

    <form id="employeeForm" enctype="multipart/form-data">
      <input type="hidden" name="id" value="<?= $isEdit ? $employee['id'] : '' ?>">
      <div class="form-main-grid">
        <!-- Left Column -->
        <div class="form-column">
          <!-- Basic Information -->
          <div class="form-section">
            <div class="section-header">
              <i class="bi bi-person section-icon"></i>
              <h2 class="section-title">Basic Information</h2>
            </div>
            <div class="field-grid-4">
              <div class="form-group" style="grid-column: span 2;">
                <label class="form-label">Employee ID <span class="required">*</span></label>
                <input type="text" name="employee_id" class="form-control" placeholder="ID" required value="<?= getVal('employee_id', $employee) ?>">
              </div>
              <div class="form-group" style="grid-column: span 2;">
                <label class="form-label">Full Name <span class="required">*</span></label>
                <input type="text" name="full_name" class="form-control" placeholder="Name" required value="<?= getVal('full_name', $employee) ?>">
              </div>
              <div class="form-group" style="grid-column: span 2;">
                <label class="form-label">Designation <span class="required">*</span></label>
                <input type="text" name="designation" class="form-control" placeholder="Designation" required value="<?= getVal('designation', $employee) ?>">
              </div>
              <div class="form-group" style="grid-column: span 2;">
                <label class="form-label">Department</label>
                <input type="text" name="department" class="form-control" placeholder="e.g. MECHANICAL (C&W)" value="<?= getVal('department', $employee) ?>">
              </div>
              <div class="form-group" style="grid-column: span 2;">
                <label class="form-label">Age</label>
                <input type="number" name="age" class="form-control" placeholder="Age" value="<?= getVal('age', $employee) ?>">
              </div>
              <div class="form-group" style="grid-column: span 2;">
                <label class="form-label">Blood Group</label>
                <input type="text" name="blood_group" class="form-control" placeholder="e.g. B+, O-" value="<?= getVal('blood_group', $employee) ?>">
              </div>
            </div>
          </div>

          <!-- Photo -->
          <div class="form-section">
            <div class="section-header">
              <i class="bi bi-camera section-icon"></i>
              <h2 class="section-title">Photo</h2>
            </div>
            <div class="form-group">
              <?php if ($isEdit && !empty($employee['employee_photo'])): ?>
                <div style="margin-bottom: 8px;">
                  <img src="uploads/<?= htmlspecialchars($employee['employee_photo']) ?>" style="max-height: 80px; border-radius: 4px; border: 1px solid #ddd;" alt="Current Photo">
                  <div class="small text-muted">Current photo</div>
                </div>
              <?php endif; ?>
              <div class="photo-upload-container">
                <input type="file" name="employee_photo" class="form-control" accept="image/*">
              </div>
            </div>
          </div>

          <!-- Personal Information -->
          <div class="form-section flex-section">
            <div class="section-header">
              <i class="bi bi-person-vcard section-icon"></i>
              <h2 class="section-title">Personal Information</h2>
            </div>
            <div class="field-grid-3">
              <div class="form-group">
                <label class="form-label">Father's Name</label>
                <input type="text" name="father_name" class="form-control" placeholder="Father's Name" value="<?= getVal('father_name', $employee) ?>">
              </div>
              <div class="form-group">
                <label class="form-label">Mother's Name</label>
                <input type="text" name="mother_name" class="form-control" placeholder="Mother's Name" value="<?= getVal('mother_name', $employee) ?>">
              </div>
              <div class="form-group">
                <label class="form-label">Mobile Number</label>
                <input type="tel" name="mobile_number" class="form-control" placeholder="Mobile" value="<?= getVal('mobile_number', $employee) ?>">
              </div>
              <div class="form-group">
                <label class="form-label">Date of Birth</label>
                <input type="date" name="dob" class="form-control" value="<?= getVal('dob', $employee) ?>">
              </div>
              <div class="form-group">
                <label class="form-label">Aadhar Number</label>
                <input type="text" name="aadhar_number" class="form-control" placeholder="Aadhar" value="<?= getVal('aadhar_number', $employee) ?>">
              </div>
              <div class="form-group">
                <label class="form-label">Address</label>
                <input type="text" name="address" class="form-control" placeholder="Address" value="<?= getVal('address', $employee) ?>">
              </div>
            </div>
          </div>

          <!-- ID Information -->
          <div class="form-section flex-section">
            <div class="section-header" style="padding-top: 4px">
              <i class="bi bi-person-badge section-icon"></i>
              <h2 class="section-title">ID Information</h2>
            </div>
            <div class="field-grid-3">
              <div class="form-group">
                <label class="form-label">REN ID</label>
                <input type="text" name="ren_id" class="form-control" placeholder="REN ID" value="<?= getVal('ren_id', $employee) ?>">
              </div>
              <div class="form-group">
                <label class="form-label">Rakshak ID</label>
                <input type="text" name="rakshak_id" class="form-control" placeholder="Rakshak ID" value="<?= getVal('rakshak_id', $employee) ?>">
              </div>
              <div class="form-group">
                <label class="form-label">PAN Card</label>
                <input type="text" name="pan_card" class="form-control" placeholder="PAN Card" value="<?= getVal('pan_card', $employee) ?>">
              </div>
              <div class="form-group">
                <label class="form-label">Police Ver.</label>
                <input type="text" name="police_ver" class="form-control" placeholder="Status" value="<?= getVal('police_ver', $employee) ?>">
              </div>
              <div class="form-group" style="grid-column: span 2;">
                <label class="form-label">Police Ver. Dt</label>
                <input type="date" name="police_ver_dt" class="form-control" value="<?= getVal('police_ver_dt', $employee) ?>">
              </div>
            </div>
          </div>
        </div>

        <!-- Right Column -->
        <div class="form-column">
          <!-- Documents & Medical -->
          <div class="form-section">
            <div class="section-header">
              <i class="bi bi-file-earmark-plus section-icon"></i>
              <h2 class="section-title">Documents & Medical</h2>
            </div>
            <div class="field-grid-3">
              <div class="form-group">
                <label class="form-label">PVC</label>
                <input type="text" name="pvc" class="form-control" placeholder="PVC" value="<?= getVal('pvc', $employee) ?>">
              </div>
              <div class="form-group">
                <label class="form-label">PVC Ok Applied</label>
                <input type="text" name="pvc_ok_applied" class="form-control" placeholder="Applied?" value="<?= getVal('pvc_ok_applied', $employee) ?>">
              </div>
              <div class="form-group">
                <label class="form-label">PVC Issue Month</label>
                <input type="text" name="pvc_issue_month" class="form-control" placeholder="Month" value="<?= getVal('pvc_issue_month', $employee) ?>">
              </div>
              <div class="form-group">
                <label class="form-label">Medical</label>
                <input type="text" name="medical" class="form-control" placeholder="Medical" value="<?= getVal('medical', $employee) ?>">
              </div>
              <div class="form-group">
                <label class="form-label">Medical Issue Month</label>
                <input type="text" name="medical_issue_month" class="form-control" placeholder="Month" value="<?= getVal('medical_issue_month', $employee) ?>">
              </div>
              <div class="form-group">
                <label class="form-label">Education</label>
                <input type="text" name="education" class="form-control" placeholder="Education" value="<?= getVal('education', $employee) ?>">
              </div>
              <div class="form-group" style="grid-column: span 3;">
                <label class="form-label">Document Status</label>
                <input type="text" name="document_status" class="form-control" placeholder="Status" value="<?= getVal('document_status', $employee) ?>">
              </div>
            </div>
          </div>

          <!-- Bank Information -->
          <div class="form-section">
            <div class="section-header">
              <i class="bi bi-bank section-icon"></i>
              <h2 class="section-title">Bank Information</h2>
            </div>
            <div class="field-grid-3">
              <div class="form-group">
                <label class="form-label">Account Name</label>
                <input type="text" name="account_name" class="form-control" placeholder="Name" value="<?= getVal('account_name', $employee) ?>">
              </div>
              <div class="form-group">
                <label class="form-label">Account Number</label>
                <input type="text" name="account_number" class="form-control" placeholder="Number" value="<?= getVal('account_number', $employee) ?>">
              </div>
              <div class="form-group">
                <label class="form-label">IFSC Code</label>
                <input type="text" name="ifsc_code" class="form-control" placeholder="IFSC" value="<?= getVal('ifsc_code', $employee) ?>">
              </div>
            </div>
          </div>

          <!-- Status & Validity -->
          <div class="form-section">
            <div class="section-header">
              <i class="bi bi-check2-square section-icon"></i>
              <h2 class="section-title">Status & Validity</h2>
            </div>
            <div class="field-grid-3">
              <div class="form-group">
                <label class="form-label">Status</label>
                <?php $statusVal = $employee['status'] ?? ''; ?>
                <select name="status" class="form-select">
                  <option value="" <?= $statusVal === '' ? 'selected' : '' ?>>Status</option>
                  <option value="Active" <?= $statusVal === 'Active' ? 'selected' : '' ?>>Active</option>
                  <option value="Inactive" <?= $statusVal === 'Inactive' ? 'selected' : '' ?>>Inactive</option>
                </select>
              </div>
              <div class="form-group">
                <label class="form-label">Issue Date</label>
                <input type="date" name="issue_date" class="form-control" value="<?= getVal('issue_date', $employee) ?>">
              </div>
              <div class="form-group">
                <label class="form-label">Valid Upto</label>
                <input type="date" name="valid_upto_date" class="form-control" value="<?= getVal('valid_upto_date', $employee) ?>">
              </div>
              <div class="form-group">
                <label class="form-label">Valid Month</label>
                <input type="text" name="valid_upto_month" class="form-control" placeholder="Month" value="<?= getVal('valid_upto_month', $employee) ?>">
              </div>
              <div class="form-group">
                <label class="form-label">Formula</label>
                <input type="text" name="formula_valid_upto" class="form-control" placeholder="Formula" value="<?= getVal('formula_valid_upto', $employee) ?>">
              </div>
              <div class="form-group">
                <label class="form-label">Notification</label>
                <input type="text" name="notification" class="form-control" placeholder="Notif" value="<?= getVal('notification', $employee) ?>">
              </div>
              <div class="form-group" style="grid-column: span 3;">
                <label class="form-label">Document Link</label>
                <input type="url" name="document_link" class="form-control" placeholder="https://" value="<?= getVal('document_link', $employee) ?>">
              </div>
            </div>
          </div>

          <!-- Remarks -->
          <div class="form-section">
            <div class="section-header">
              <i class="bi bi-chat-left-text section-icon"></i>
              <h2 class="section-title">Remarks</h2>
            </div>
            <div class="form-group">
              <textarea name="remarks" class="form-control" rows="1" placeholder="Remarks..."><?= getVal('remarks', $employee) ?></textarea>
            </div>
          </div>

          <!-- Actions -->
          <div class="footer-actions">
            <button type="button" class="btn-action btn-cancel" onclick="window.location.href='view-employee.php'">
              <i class="bi bi-x-lg"></i> Cancel
            </button>
            <button type="submit" class="btn-action btn-create">
              <i class="bi bi-save"></i> <?= $isEdit ? 'Update Employee' : 'Save Employee' ?>
            </button>
          </div>
        </div>
      </div>
    </form>
  </div>
</main>

<?php include 'footer.php'; ?>