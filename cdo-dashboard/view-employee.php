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

// Delete Employee Action
if (isset($_GET['action']) && $_GET['action'] === 'delete' && isset($_GET['id'])) {
    $id = intval($_GET['id']);
    
    // Get photo filename to delete from disk
    $photoStmt = $pdo->prepare("SELECT employee_photo FROM mcc_employee WHERE id = ?");
    $photoStmt->execute([$id]);
    $emp = $photoStmt->fetch();
    if ($emp && !empty($emp['employee_photo'])) {
        $photoPath = __DIR__ . '/uploads/' . $emp['employee_photo'];
        if (file_exists($photoPath)) {
            @unlink($photoPath);
        }
    }
    
    $deleteStmt = $pdo->prepare("DELETE FROM mcc_employee WHERE id = ?");
    $deleteStmt->execute([$id]);
    header("Location: view-employee.php");
    exit;
}

// Search Filter Logic
$search = $_GET['search'] ?? '';
if (!empty($search)) {
    $searchWild = "%$search%";
    $stmt = $pdo->prepare("
        SELECT * FROM mcc_employee 
        WHERE employee_id LIKE :search 
           OR full_name LIKE :search 
           OR designation LIKE :search 
           OR mobile_number LIKE :search 
           OR aadhar_number LIKE :search
        ORDER BY id DESC
    ");
    $stmt->execute(['search' => $searchWild]);
} else {
    $stmt = $pdo->query("SELECT * FROM mcc_employee ORDER BY id DESC");
}
$employees = $stmt->fetchAll();

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
        background: #343a40;
        padding: 10px 15px;
        text-align: center;
        font-size: 0.75rem;
        font-weight: 600;
        text-transform: uppercase;
        color: #fff;
        border: 1px solid #454d55;
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
                <a href="add-employee.php" class="btn btn-sm btn-primary px-3 fw-bold"
                    style="background: #1987C6; border: none; border-radius: 8px;">
                    <i class="bi bi-plus-lg me-1"></i>Add New
                </a>
            </div>

            <div class="table-responsive">
                <table class="employee-table">
                    <thead>
                        <tr style="text-align:center; vertical-align:middle;">
                            <th>#</th>
                            <th>Photo</th>
                            <th>Name</th>
                            <th>Action</th>
                            <th>Employee ID</th>
                            <th>Designation</th>
                            <th>Rakshak_ID</th>
                            <th>FATHER_NAME</th>
                            <th>MOBILE_NO</th>
                            <th>ADHAR_NO</th>
                            <th>DOB</th>
                            <th>AGE</th>
                            <th>ADDRESS</th>
                            <th>PVC</th>
                            <th>PVC_Ok_Applied</th>
                            <th>PVC_Issue_Month</th>
                            <th>MEDICAL</th>
                            <th>MEDICAL_ISSUE_MONTH</th>
                            <th>PAN_CARD</th>
                            <th>AC_NAME</th>
                            <th>AC_NO</th>
                            <th>IFSC_CODE</th>
                            <th>EDU</th>
                            <th>REMARK</th>
                            <th>STATUS</th>
                            <th>Issue_Date</th>
                            <th>Valid_Upto_date</th>
                            <th>notification</th>
                        </tr>
                    </thead>
                    <tbody id="employeeTableBody">
                        <?php if (empty($employees)): ?>
                            <!-- Empty row handled below by emptyState div -->
                        <?php else: ?>
                            <?php foreach ($employees as $index => $emp): 
                                $photoSrc = !empty($emp['employee_photo']) ? 'uploads/' . $emp['employee_photo'] : 'assets/img/avatar.png';
                            ?>
                            <tr>
                                <td><?= $index + 1 ?></td>
                                <td><img src="<?= htmlspecialchars($photoSrc) ?>" class="emp-photo" alt="Photo"></td>
                                <td style="font-weight: 700; color: #1987C6;"><?= htmlspecialchars($emp['full_name']) ?></td>
                                <td>
                                    <div class="btn-action-group">
                                        <button class="btn-icon" title="Edit" onclick="window.location.href='add-employee.php?id=<?= $emp['id'] ?>'"><i class="bi bi-pencil-square"></i></button>
                                        <button class="btn-icon" title="Generate ID Card" onclick="window.open('generate-idcard.php?id=<?= $emp['id'] ?>', '_blank')"><i class="bi bi-person-badge-fill"></i></button>
                                        <button class="btn-icon delete" title="Delete" onclick="deleteEmployee(<?= $emp['id'] ?>)"><i class="bi bi-trash3"></i></button>
                                    </div>
                                </td>
                                <td><?= htmlspecialchars($emp['employee_id']) ?></td>
                                <td><?= htmlspecialchars($emp['designation']) ?></td>
                                <td><?= htmlspecialchars($emp['rakshak_id'] ?: '-') ?></td>
                                <td><?= htmlspecialchars($emp['father_name'] ?: '-') ?></td>
                                <td><?= htmlspecialchars($emp['mobile_number'] ?: '-') ?></td>
                                <td><?= htmlspecialchars($emp['aadhar_number'] ?: '-') ?></td>
                                <td><?= htmlspecialchars($emp['dob'] ?: '-') ?></td>
                                <td><?= htmlspecialchars($emp['age'] ?: '-') ?></td>
                                <td><?= htmlspecialchars($emp['address'] ?: '-') ?></td>
                                <td><?= htmlspecialchars($emp['pvc'] ?: '-') ?></td>
                                <td><?= htmlspecialchars($emp['pvc_ok_applied'] ?: '-') ?></td>
                                <td><?= htmlspecialchars($emp['pvc_issue_month'] ?: '-') ?></td>
                                <td><?= htmlspecialchars($emp['medical'] ?: '-') ?></td>
                                <td><?= htmlspecialchars($emp['medical_issue_month'] ?: '-') ?></td>
                                <td><?= htmlspecialchars($emp['pan_card'] ?: '-') ?></td>
                                <td><?= htmlspecialchars($emp['account_name'] ?: '-') ?></td>
                                <td><?= htmlspecialchars($emp['account_number'] ?: '-') ?></td>
                                <td><?= htmlspecialchars($emp['ifsc_code'] ?: '-') ?></td>
                                <td><?= htmlspecialchars($emp['education'] ?: '-') ?></td>
                                <td><?= htmlspecialchars($emp['remarks'] ?: '-') ?></td>
                                <td><?= htmlspecialchars($emp['status'] ?: '-') ?></td>
                                <td><?= htmlspecialchars($emp['issue_date'] ?: '-') ?></td>
                                <td><?= htmlspecialchars($emp['valid_upto_date'] ?: '-') ?></td>
                                <td><?= htmlspecialchars($emp['notification'] ?: '-') ?></td>
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

<?php include 'footer.php'; ?>