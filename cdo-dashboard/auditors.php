<?php
require_once 'auth.php';

// Ensure role column in mcc_users table supports VIEWER
try {
    $pdo->exec("ALTER TABLE mcc_users MODIFY COLUMN role VARCHAR(50) NOT NULL DEFAULT 'AUDITOR'");
} catch (Exception $e) {}

// Ensure digital_signature column exists in mcc_users table
try {
    $pdo->exec("ALTER TABLE mcc_users ADD COLUMN digital_signature VARCHAR(255) DEFAULT NULL");
} catch (Exception $e) {}

$uploadSigDir = __DIR__ . '/uploads/signatures';
if (!is_dir($uploadSigDir)) {
    @mkdir($uploadSigDir, 0777, true);
}

$pageTitle = 'MCC | User Management';

$message = '';
$messageType = '';

// Handle POST actions (Add User / Edit User / Toggle Status / Delete)
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $action = $_POST['action'] ?? '';

    if ($action === 'add_auditor' || $action === 'edit_auditor' || $action === 'add_user' || $action === 'edit_user') {
        $userId   = intval($_POST['user_id'] ?? 0);
        $fullName = trim($_POST['full_name'] ?? '');
        $username = trim($_POST['username'] ?? '');
        $email    = trim($_POST['email'] ?? '');
        $password = $_POST['password'] ?? '';
        $role     = strtoupper(trim($_POST['role'] ?? 'AUDITOR'));
        if (!in_array($role, ['AUDITOR', 'VIEWER']) || !empty($isViewer)) {
            $role = 'AUDITOR';
        }

        $manageableRolesClause = !empty($isViewer) ? "role = 'AUDITOR'" : "role IN ('AUDITOR', 'VIEWER')";

        if (empty($fullName) || empty($username) || empty($email)) {
            $message = 'Full name, username, and email are required.';
            $messageType = 'danger';
        } elseif (($action === 'add_auditor' || $action === 'add_user') && empty($password)) {
            $message = 'Password is required for creating a new user account.';
            $messageType = 'danger';
        } else {
            try {
                // Check duplicate username
                $chkUname = $pdo->prepare("SELECT COUNT(*) FROM mcc_users WHERE username = :username" . (($action === 'edit_auditor' || $action === 'edit_user') ? " AND user_id != :id" : ""));
                $unameParams = ['username' => $username];
                if ($action === 'edit_auditor' || $action === 'edit_user') $unameParams['id'] = $userId;
                $chkUname->execute($unameParams);

                // Check duplicate email
                $chkEmail = $pdo->prepare("SELECT COUNT(*) FROM mcc_users WHERE email = :email" . (($action === 'edit_auditor' || $action === 'edit_user') ? " AND user_id != :id" : ""));
                $emailParams = ['email' => $email];
                if ($action === 'edit_auditor' || $action === 'edit_user') $emailParams['id'] = $userId;
                $chkEmail->execute($emailParams);

                if ($chkUname->fetchColumn() > 0) {
                    $message = "Username '$username' is already registered. Please choose another.";
                    $messageType = 'danger';
                } elseif ($chkEmail->fetchColumn() > 0) {
                    $message = "Email address '$email' is already in use.";
                    $messageType = 'danger';
                } else {
                    // Process digital signature if uploaded or drawn
                    $savedSignatureName = null;
                    $removeSignature = !empty($_POST['remove_signature']) && $_POST['remove_signature'] === '1';

                    // 1. Uploaded signature file
                    if (isset($_FILES['signature_file']) && $_FILES['signature_file']['error'] === UPLOAD_ERR_OK) {
                        $fileTmp = $_FILES['signature_file']['tmp_name'];
                        $origName = $_FILES['signature_file']['name'];
                        $ext = strtolower(pathinfo($origName, PATHINFO_EXTENSION));
                        $allowed = ['png', 'jpg', 'jpeg', 'webp', 'svg'];
                        if (in_array($ext, $allowed)) {
                            $savedSignatureName = 'sig_' . time() . '_' . bin2hex(random_bytes(4)) . '.' . $ext;
                            move_uploaded_file($fileTmp, $uploadSigDir . '/' . $savedSignatureName);
                        }
                    }
                    // 2. Drawn signature base64 data
                    elseif (!empty($_POST['signature_data']) && strpos($_POST['signature_data'], 'data:image') === 0) {
                        $dataUri = $_POST['signature_data'];
                        if (preg_match('/^data:image\/(\w+);base64,/', $dataUri)) {
                            $dataBase64 = substr($dataUri, strpos($dataUri, ',') + 1);
                            $decoded = base64_decode($dataBase64);
                            if ($decoded !== false) {
                                $savedSignatureName = 'sig_' . time() . '_' . bin2hex(random_bytes(4)) . '.png';
                                file_put_contents($uploadSigDir . '/' . $savedSignatureName, $decoded);
                            }
                        }
                    }

                    if ($action === 'add_auditor' || $action === 'add_user') {
                        $hash = password_hash($password, PASSWORD_BCRYPT);
                        $ins = $pdo->prepare("
                            INSERT INTO mcc_users (user_name, full_name, username, email, password_hash, role, station_id, status, digital_signature)
                            VALUES (:user_name, :full_name, :username, :email, :password_hash, :role, :station_id, 'Active', :digital_signature)
                        ");
                        $ins->execute([
                            'user_name'         => $fullName,
                            'full_name'         => $fullName,
                            'username'          => $username,
                            'email'             => $email,
                            'password_hash'     => $hash,
                            'role'              => $role,
                            'station_id'        => $stationId,
                            'digital_signature' => $savedSignatureName
                        ]);
                        $message = "User account for '$fullName' ($role) created successfully!";
                        $messageType = 'success';
                    } else {
                        $sigClause = "";
                        $sigParams = [];
                        if ($savedSignatureName !== null) {
                            $sigClause = ", digital_signature = :digital_sig";
                            $sigParams['digital_sig'] = $savedSignatureName;
                        } elseif ($removeSignature) {
                            $sigClause = ", digital_signature = NULL";
                        }

                        if (!empty($password)) {
                            $hash = password_hash($password, PASSWORD_BCRYPT);
                            $upd = $pdo->prepare("
                                UPDATE mcc_users 
                                SET user_name = :user_name, full_name = :full_name, username = :username, email = :email, role = :role, password_hash = :password_hash $sigClause
                                WHERE user_id = :id AND station_id = :station_id AND $manageableRolesClause
                            ");
                            $params = array_merge([
                                'user_name'      => $fullName,
                                'full_name'      => $fullName,
                                'username'       => $username,
                                'email'          => $email,
                                'role'           => $role,
                                'password_hash'  => $hash,
                                'id'             => $userId,
                                'station_id'     => $stationId
                            ], $sigParams);
                            $upd->execute($params);
                        } else {
                            $upd = $pdo->prepare("
                                UPDATE mcc_users 
                                SET user_name = :user_name, full_name = :full_name, username = :username, email = :email, role = :role $sigClause
                                WHERE user_id = :id AND station_id = :station_id AND $manageableRolesClause
                            ");
                            $params = array_merge([
                                'user_name'  => $fullName,
                                'full_name'  => $fullName,
                                'username'   => $username,
                                'email'      => $email,
                                'role'       => $role,
                                'id'         => $userId,
                                'station_id' => $stationId
                            ], $sigParams);
                            $upd->execute($params);
                        }
                        $message = "User details for '$fullName' updated successfully!";
                        $messageType = 'success';
                    }
                }
            } catch (Exception $e) {
                $message = 'Database error: ' . $e->getMessage();
                $messageType = 'danger';
            }
        }
    } elseif ($action === 'toggle_status') {
        $userId = intval($_POST['user_id'] ?? 0);
        $newStatus = ($_POST['current_status'] ?? 'Active') === 'Active' ? 'Inactive' : 'Active';
        $manageableRolesClause = !empty($isViewer) ? "role = 'AUDITOR'" : "role IN ('AUDITOR', 'VIEWER')";
        try {
            $upd = $pdo->prepare("UPDATE mcc_users SET status = :status WHERE user_id = :id AND station_id = :station_id AND $manageableRolesClause");
            $upd->execute(['status' => $newStatus, 'id' => $userId, 'station_id' => $stationId]);
            $message = "User status updated to '$newStatus'.";
            $messageType = 'success';
        } catch (Exception $e) {
            $message = 'Error updating status: ' . $e->getMessage();
            $messageType = 'danger';
        }
    } elseif ($action === 'delete_auditor' || $action === 'delete_user') {
        $userId = intval($_POST['user_id'] ?? 0);
        $manageableRolesClause = !empty($isViewer) ? "role = 'AUDITOR'" : "role IN ('AUDITOR', 'VIEWER')";
        try {
            $del = $pdo->prepare("DELETE FROM mcc_users WHERE user_id = :id AND station_id = :station_id AND $manageableRolesClause");
            $del->execute(['id' => $userId, 'station_id' => $stationId]);
            $message = "User account removed successfully.";
            $messageType = 'success';
        } catch (Exception $e) {
            $message = 'Error deleting user: ' . $e->getMessage();
            $messageType = 'danger';
        }
    }
}

// Fetch users assigned to this station (if logged in as VIEWER, only show AUDITOR accounts)
$viewableRolesClause = !empty($isViewer) ? "role = 'AUDITOR'" : "role IN ('AUDITOR', 'VIEWER')";
$stmt = $pdo->prepare("
    SELECT user_id, user_name, username, email, role, digital_signature, status, created_at
    FROM mcc_users
    WHERE station_id = :station_id AND $viewableRolesClause
    ORDER BY user_id DESC
");
$stmt->execute(['station_id' => $stationId]);
$users = $stmt->fetchAll(PDO::FETCH_ASSOC);

$extraStyles = '
<style>
    .auditor-card {
        background: #ffffff;
        border-radius: 10px;
        border: 1px solid #e2e8f0;
        box-shadow: 0 4px 12px rgba(0,0,0,0.03);
        margin-bottom: 25px;
    }
    .auditor-header-card {
        background: linear-gradient(135deg, #07203a 0%, #0c3b6d 100%);
        color: white;
        padding: 16px 22px;
        border-radius: 8px;
        display: flex;
        justify-content: space-between;
        align-items: center;
        margin-bottom: 20px;
        box-shadow: 0 4px 14px rgba(7, 32, 58, 0.18);
    }
    .auditor-table th {
        background: linear-gradient(180deg, #07203a 0%, #07182c 100%) !important;
        color: white !important;
        font-size: 0.78rem;
        font-weight: 600;
        text-transform: uppercase;
        letter-spacing: 0.3px;
        padding: 10px 14px;
        border: 1px solid #133357;
    }
    .auditor-table td {
        padding: 10px 14px;
        font-size: 0.86rem;
        color: #334155;
        border-bottom: 1px solid #f1f5f9;
        vertical-align: middle;
    }
    .auditor-table tr:hover {
        background: #f8fafc;
    }
    .badge-active {
        background-color: #dcfce7;
        color: #15803d;
        border: 1px solid #bbf7d0;
        padding: 4px 10px;
        border-radius: 20px;
        font-size: 0.75rem;
        font-weight: 600;
    }
    .badge-inactive {
        background-color: #fee2e2;
        color: #b91c1c;
        border: 1px solid #fecaca;
        padding: 4px 10px;
        border-radius: 20px;
        font-size: 0.75rem;
        font-weight: 600;
    }
    .btn-create-auditor {
        background: #ffffff !important;
        color: #07203a !important;
        border: 1px solid #cbd5e1 !important;
        padding: 8px 18px !important;
        border-radius: 6px !important;
        font-weight: 700 !important;
        font-size: 0.88rem !important;
        display: inline-flex !important;
        align-items: center !important;
        gap: 6px !important;
        transition: all 0.2s ease !important;
        box-shadow: 0 2px 6px rgba(0,0,0,0.15) !important;
        cursor: pointer !important;
        text-decoration: none !important;
    }
    .btn-create-auditor,
    .btn-create-auditor span,
    .btn-create-auditor i {
        color: #07203a !important;
    }
    .btn-create-auditor:hover {
        background: #f8fafc !important;
        color: #0c3b6d !important;
        transform: translateY(-1px) !important;
        box-shadow: 0 4px 12px rgba(0, 0, 0, 0.25) !important;
    }
    .btn-create-auditor:hover span,
    .btn-create-auditor:hover i {
        color: #0c3b6d !important;
    }
    .sig-thumb-container {
        display: inline-flex;
        align-items: center;
        justify-content: center;
        background: #ffffff;
        border: 1px solid #cbd5e1;
        border-radius: 6px;
        padding: 2px 8px;
        cursor: pointer;
        transition: all 0.2s ease;
        box-shadow: 0 1px 3px rgba(0,0,0,0.04);
    }
    .sig-thumb-container:hover {
        border-color: #0c3b6d;
        box-shadow: 0 2px 8px rgba(12, 59, 109, 0.18);
        transform: scale(1.05);
    }
    .sig-thumb-img {
        max-height: 34px;
        max-width: 100px;
        object-fit: contain;
    }
    .sig-pad-box {
        border: 2px dashed #cbd5e1;
        border-radius: 8px;
        background: #ffffff;
        position: relative;
        text-align: center;
        user-select: none;
    }
    .sig-pad-box canvas {
        width: 100%;
        height: 140px;
        display: block;
        cursor: crosshair;
        border-radius: 6px;
        touch-action: none;
    }
    .sig-nav-tabs .nav-link {
        font-size: 0.84rem;
        font-weight: 600;
        color: #64748b;
        border: 1px solid transparent;
        border-bottom: 2px solid transparent;
        border-radius: 6px 6px 0 0;
        padding: 6px 14px;
    }
    .sig-nav-tabs .nav-link.active {
        color: #07203a;
        background-color: #f1f5f9;
        border-bottom: 2px solid #07203a;
    }
</style>
';

include 'header.php';
include 'sidebar.php';
?>

<main class="app-main">
    <div class="app-content py-3">
        <div class="container-fluid">
            
            <div class="auditor-header-card">
                <div>
                    <h3 class="mb-1 font-weight-bold" style="font-size: 1.35rem;"><i class="bi bi-people-fill me-2"></i> User Management</h3>
                    <p class="mb-0 text-white-50" style="font-size: 0.85rem;">Manage application user accounts (<?= !empty($isViewer) ? 'Auditors' : 'Auditors & Viewers' ?>) and login credentials for <?= htmlspecialchars($stationName) ?> Station</p>
                </div>
                <button type="button" class="btn btn-create-auditor" data-bs-toggle="modal" data-bs-target="#auditorModal" onclick="openAddModal()">
                    <i class="bi bi-person-plus-fill me-1" style="font-size: 1rem;"></i> <span>Add User</span>
                </button>
            </div>

            <?php if (!empty($message)): ?>
                <div class="alert alert-<?= $messageType ?> alert-dismissible fade show shadow-sm" role="alert">
                    <i class="bi <?= ($messageType === 'success') ? 'bi-check-circle-fill' : 'bi-exclamation-triangle-fill' ?> me-2"></i>
                    <?= htmlspecialchars($message) ?>
                    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                </div>
            <?php endif; ?>

            <div class="auditor-card">
                <div class="card-header bg-white py-3 border-bottom d-flex justify-content-between align-items-center">
                    <h5 class="mb-0 font-weight-bold text-dark" style="font-size: 1rem;">
                        <i class="bi bi-people-fill text-primary me-2"></i> Registered Users (<?= count($users) ?>)
                    </h5>
                </div>
                <div class="table-responsive">
                    <table class="table auditor-table mb-0">
                        <thead>
                            <tr>
                                <th style="width: 50px; text-align: center;">#</th>
                                <th>User Name</th>
                                <th>Username / Login ID</th>
                                <th>Email Address</th>
                                <th style="text-align: center;">Role</th>
                                <th style="text-align: center;">Digital Signature</th>
                                <th style="text-align: center;">Status</th>
                                <th style="text-align: center;">Created At</th>
                                <th style="width: 140px; text-align: center;">Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <?php if (empty($users)): ?>
                                <tr>
                                    <td colspan="9" class="text-center py-4 text-muted">
                                        <i class="bi bi-person-x fs-3 d-block mb-2 text-secondary"></i>
                                        No user accounts registered for this station yet. Click "Add User" above to create one.
                                    </td>
                                </tr>
                            <?php else: ?>
                                <?php foreach ($users as $idx => $a): ?>
                                    <tr>
                                        <td class="text-center font-weight-bold text-muted"><?= $idx + 1 ?></td>
                                        <td>
                                            <strong class="text-dark"><?= htmlspecialchars($a['user_name']) ?></strong>
                                        </td>
                                        <td>
                                            <code><?= htmlspecialchars($a['username']) ?></code>
                                        </td>
                                        <td><?= htmlspecialchars($a['email']) ?></td>
                                        <td class="text-center">
                                            <span class="badge <?= ($a['role'] === 'VIEWER') ? 'bg-info text-dark' : 'bg-primary' ?> px-2 py-1" style="font-size: 0.75rem;">
                                                <?= htmlspecialchars($a['role']) ?>
                                            </span>
                                        </td>
                                        <td class="text-center">
                                            <?php if (!empty($a['digital_signature']) && file_exists(__DIR__ . '/uploads/signatures/' . $a['digital_signature'])): ?>
                                                <div class="sig-thumb-container" onclick="previewSignature('uploads/signatures/<?= htmlspecialchars($a['digital_signature']) ?>', '<?= htmlspecialchars(addslashes($a['user_name'])) ?>')" title="Click to view signature">
                                                    <img src="uploads/signatures/<?= htmlspecialchars($a['digital_signature']) ?>" alt="Signature" class="sig-thumb-img">
                                                </div>
                                            <?php else: ?>
                                                <span class="text-muted small"><i class="bi bi-pen me-1 opacity-50"></i>None</span>
                                            <?php endif; ?>
                                        </td>
                                        <td class="text-center">
                                            <?php if ($a['status'] === 'Active'): ?>
                                                <span class="badge-active"><i class="bi bi-check-circle-fill me-1"></i> Active</span>
                                            <?php else: ?>
                                                <span class="badge-inactive"><i class="bi bi-slash-circle-fill me-1"></i> Inactive</span>
                                            <?php endif; ?>
                                        </td>
                                        <td class="text-center text-muted" style="font-size: 0.8rem;">
                                            <?= htmlspecialchars(date('d M Y, h:i A', strtotime($a['created_at']))) ?>
                                        </td>
                                        <td class="text-center">
                                            <div class="d-inline-flex gap-1">
                                                <button type="button" class="btn btn-sm btn-outline-primary" title="Edit" onclick='openEditModal(<?= json_encode($a) ?>)'>
                                                    <i class="bi bi-pencil-square"></i>
                                                </button>

                                                <form method="POST" class="d-inline" onsubmit="return confirm('Toggle status for this user?');">
                                                    <input type="hidden" name="action" value="toggle_status">
                                                    <input type="hidden" name="user_id" value="<?= $a['user_id'] ?>">
                                                    <input type="hidden" name="current_status" value="<?= $a['status'] ?>">
                                                    <button type="submit" class="btn btn-sm <?= ($a['status'] === 'Active') ? 'btn-outline-warning' : 'btn-outline-success' ?>" title="<?= ($a['status'] === 'Active') ? 'Deactivate' : 'Activate' ?>">
                                                        <i class="bi <?= ($a['status'] === 'Active') ? 'bi-pause-fill' : 'bi-play-fill' ?>"></i>
                                                    </button>
                                                </form>

                                                <!-- Delete button commented out for now
                                                <form method="POST" class="d-inline" onsubmit="return confirm('Are you sure you want to permanently delete this user?');">
                                                    <input type="hidden" name="action" value="delete_user">
                                                    <input type="hidden" name="user_id" value="<?= $a['user_id'] ?>">
                                                    <button type="submit" class="btn btn-sm btn-outline-danger" title="Delete">
                                                        <i class="bi bi-trash3"></i>
                                                    </button>
                                                </form>
                                                -->
                                            </div>
                                        </td>
                                    </tr>
                                <?php endforeach; ?>
                            <?php endif; ?>
                        </tbody>
                    </table>
                </div>
            </div>

        </div>
    </div>
</main>

<!-- Add / Edit User Modal -->
<div class="modal fade" id="auditorModal" tabindex="-1" aria-labelledby="auditorModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered modal-lg">
        <div class="modal-content border-0 shadow-lg" style="border-radius: 12px;">
            <form method="POST" id="auditorForm" enctype="multipart/form-data" onsubmit="return prepareSubmitForm()">
                <input type="hidden" name="action" id="formAction" value="add_user">
                <input type="hidden" name="user_id" id="userId" value="0">
                <input type="hidden" name="signature_data" id="signatureData" value="">
                <input type="hidden" name="remove_signature" id="removeSignatureInput" value="0">

                <div class="modal-header text-white" style="background: linear-gradient(135deg, #07203a 0%, #0c3b6d 100%); border-radius: 12px 12px 0 0;">
                    <h5 class="modal-title font-weight-bold" id="auditorModalLabel"><i class="bi bi-person-plus-fill me-2"></i> Add New User</h5>
                    <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body p-4">
                    <div class="row">
                        <div class="col-md-6 mb-3">
                            <label class="form-label font-weight-bold text-secondary small text-uppercase">Full Name <span class="text-danger">*</span></label>
                            <input type="text" class="form-control" name="full_name" id="fullName" placeholder="e.g. Prabhunath Sharma" required>
                        </div>

                        <div class="col-md-6 mb-3">
                            <label class="form-label font-weight-bold text-secondary small text-uppercase">Username / Login ID <span class="text-danger">*</span></label>
                            <input type="text" class="form-control" name="username" id="username" placeholder="e.g. prabhunath" required>
                            <small class="text-muted">This username will be used to log in.</small>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-md-6 mb-3">
                            <label class="form-label font-weight-bold text-secondary small text-uppercase">Role <span class="text-danger">*</span></label>
                            <select class="form-select" name="role" id="userRoleSelect" required>
                                <option value="AUDITOR">AUDITOR</option>
                                <?php if (empty($isViewer)): ?>
                                <option value="VIEWER">VIEWER</option>
                                <?php endif; ?>
                            </select>
                            <?php if (!empty($isViewer)): ?>
                            <small class="text-muted">Note: Viewers can only create and manage Auditor accounts.</small>
                            <?php endif; ?>
                        </div>

                        <div class="col-md-6 mb-3">
                            <label class="form-label font-weight-bold text-secondary small text-uppercase">Email Address <span class="text-danger">*</span></label>
                            <input type="email" class="form-control" name="email" id="email" placeholder="e.g. user@mcc.in" required>
                        </div>
                    </div>

                    <div class="mb-3">
                        <label class="form-label font-weight-bold text-secondary small text-uppercase" id="pwdLabel">Password <span class="text-danger">*</span></label>
                        <input type="password" class="form-control" name="password" id="password" placeholder="Enter secure password">
                        <small class="text-muted" id="pwdHelp">Must be at least 6 characters.</small>
                    </div>

                    <!-- Digital Signature Section -->
                    <div class="mt-4 pt-3 border-top">
                        <div class="d-flex justify-content-between align-items-center mb-2">
                            <label class="form-label font-weight-bold text-dark small text-uppercase mb-0">
                                <i class="bi bi-pen-fill text-primary me-1"></i> Digital Signature
                            </label>
                            <span class="badge bg-light text-muted border">Optional</span>
                        </div>

                        <!-- Existing signature display (Edit mode) -->
                        <div id="existingSignatureContainer" class="p-3 mb-3 bg-light rounded border d-none">
                            <div class="d-flex justify-content-between align-items-center">
                                <div>
                                    <div class="small fw-bold text-secondary mb-1">Current Signature:</div>
                                    <div class="bg-white p-2 border rounded d-inline-block">
                                        <img id="existingSigImg" src="" alt="Current Signature" style="max-height: 50px; max-width: 200px; object-fit: contain;">
                                    </div>
                                </div>
                                <div>
                                    <button type="button" class="btn btn-sm btn-outline-danger" id="removeSigBtn" onclick="markRemoveSignature()">
                                        <i class="bi bi-trash3 me-1"></i> Remove Signature
                                    </button>
                                </div>
                            </div>
                            <div id="sigRemovedNotice" class="alert alert-warning py-1 px-2 mt-2 mb-0 small d-none">
                                <i class="bi bi-info-circle me-1"></i> Signature will be removed on saving unless you provide a new one below.
                            </div>
                        </div>

                        <!-- Signature Input Tabs -->
                        <ul class="nav sig-nav-tabs mb-3" id="sigTab" role="tablist">
                            <li class="nav-item" role="presentation">
                                <button class="nav-link active" id="draw-tab" data-bs-toggle="tab" data-bs-target="#draw-tab-pane" type="button" role="tab">
                                    <i class="bi bi-brush me-1"></i> Draw On Screen
                                </button>
                            </li>
                            <li class="nav-item" role="presentation">
                                <button class="nav-link" id="upload-tab" data-bs-toggle="tab" data-bs-target="#upload-tab-pane" type="button" role="tab">
                                    <i class="bi bi-upload me-1"></i> Upload Image
                                </button>
                            </li>
                        </ul>

                        <div class="tab-content" id="sigTabContent">
                            <!-- Draw Pad Pane -->
                            <div class="tab-pane fade show active" id="draw-tab-pane" role="tabpanel">
                                <div class="sig-pad-box">
                                    <canvas id="sigCanvas"></canvas>
                                </div>
                                <div class="d-flex justify-content-between align-items-center mt-2">
                                    <small class="text-muted"><i class="bi bi-hand-index-thumb me-1"></i> Sign using mouse, stylus, or fingertip on touch screen</small>
                                    <button type="button" class="btn btn-sm btn-outline-secondary px-3" onclick="clearSignatureCanvas()">
                                        <i class="bi bi-eraser me-1"></i> Clear Pad
                                    </button>
                                </div>
                            </div>

                            <!-- Upload Image Pane -->
                            <div class="tab-pane fade" id="upload-tab-pane" role="tabpanel">
                                <div class="input-group">
                                    <input type="file" class="form-control" name="signature_file" id="signatureFile" accept="image/png,image/jpeg,image/webp,image/svg+xml" onchange="previewUploadedSig(this)">
                                    <button class="btn btn-outline-secondary" type="button" onclick="clearUploadedFile()">Clear</button>
                                </div>
                                <small class="text-muted d-block mt-1">Accepted formats: PNG, JPG, JPEG, WEBP, SVG (Max 2MB). Transparent PNG recommended.</small>
                                <div id="uploadPreviewBox" class="mt-2 text-center p-2 bg-light border rounded d-none">
                                    <img id="uploadPreviewImg" src="" alt="Upload Preview" style="max-height: 60px; max-width: 250px; object-fit: contain;">
                                </div>
                            </div>
                        </div>

                    </div>
                </div>
                <div class="modal-footer bg-light" style="border-radius: 0 0 12px 12px;">
                    <button type="button" class="btn btn-secondary px-3" data-bs-dismiss="modal">Cancel</button>
                    <button type="submit" class="btn-create-auditor px-4" id="submitBtn">
                        <i class="bi bi-check-circle me-1"></i> Save User
                    </button>
                </div>
            </form>
        </div>
    </div>
</div>

<!-- Signature Preview Lightbox Modal -->
<div class="modal fade" id="sigPreviewModal" tabindex="-1" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content border-0 shadow">
            <div class="modal-header py-2 bg-dark text-white">
                <h6 class="modal-title font-weight-bold" id="sigPreviewTitle"><i class="bi bi-pen me-2"></i> Digital Signature</h6>
                <button type="button" class="btn-close btn-close-white btn-sm" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body text-center p-4 bg-white">
                <img id="modalSigImage" src="" alt="Digital Signature" class="img-fluid border p-3 rounded shadow-sm" style="max-height: 220px; background: #fafafa;">
            </div>
        </div>
    </div>
</div>

<script>
let canvas, ctx;
let isDrawing = false;
let hasDrawn = false;

function initCanvas() {
    canvas = document.getElementById('sigCanvas');
    if (!canvas) return;
    ctx = canvas.getContext('2d');

    // Resize canvas to display size
    const rect = canvas.getBoundingClientRect();
    const dpr = window.devicePixelRatio || 1;
    canvas.width = (rect.width || 400) * dpr;
    canvas.height = 140 * dpr;
    ctx.scale(dpr, dpr);
    ctx.lineWidth = 2.2;
    ctx.lineCap = 'round';
    ctx.lineJoin = 'round';
    ctx.strokeStyle = '#07203a';

    // Mouse events
    canvas.onmousedown = function(e) {
        isDrawing = true;
        hasDrawn = true;
        const pos = getPos(e);
        ctx.beginPath();
        ctx.moveTo(pos.x, pos.y);
    };
    canvas.onmousemove = function(e) {
        if (!isDrawing) return;
        const pos = getPos(e);
        ctx.lineTo(pos.x, pos.y);
        ctx.stroke();
    };
    window.addEventListener('mouseup', function() {
        if (isDrawing) {
            isDrawing = false;
        }
    });

    // Touch events for mobile/tablet
    canvas.addEventListener('touchstart', function(e) {
        if (e.target === canvas) e.preventDefault();
        isDrawing = true;
        hasDrawn = true;
        const pos = getTouchPos(e);
        ctx.beginPath();
        ctx.moveTo(pos.x, pos.y);
    }, { passive: false });

    canvas.addEventListener('touchmove', function(e) {
        if (e.target === canvas) e.preventDefault();
        if (!isDrawing) return;
        const pos = getTouchPos(e);
        ctx.lineTo(pos.x, pos.y);
        ctx.stroke();
    }, { passive: false });

    canvas.addEventListener('touchend', function(e) {
        if (isDrawing) {
            isDrawing = false;
        }
    }, { passive: false });
}

function getPos(e) {
    const rect = canvas.getBoundingClientRect();
    return {
        x: e.clientX - rect.left,
        y: e.clientY - rect.top
    };
}

function getTouchPos(e) {
    const rect = canvas.getBoundingClientRect();
    const touch = e.touches[0];
    return {
        x: touch.clientX - rect.left,
        y: touch.clientY - rect.top
    };
}

function clearSignatureCanvas() {
    if (!ctx || !canvas) return;
    const dpr = window.devicePixelRatio || 1;
    ctx.clearRect(0, 0, canvas.width / dpr, canvas.height / dpr);
    hasDrawn = false;
    document.getElementById('signatureData').value = '';
}

function previewUploadedSig(input) {
    const previewBox = document.getElementById('uploadPreviewBox');
    const previewImg = document.getElementById('uploadPreviewImg');
    if (input.files && input.files[0]) {
        const reader = new FileReader();
        reader.onload = function(e) {
            previewImg.src = e.target.result;
            previewBox.classList.remove('d-none');
        };
        reader.readAsDataURL(input.files[0]);
    } else {
        clearUploadedFile();
    }
}

function clearUploadedFile() {
    const input = document.getElementById('signatureFile');
    if (input) input.value = '';
    const previewBox = document.getElementById('uploadPreviewBox');
    if (previewBox) previewBox.classList.add('d-none');
}

function markRemoveSignature() {
    document.getElementById('removeSignatureInput').value = '1';
    document.getElementById('sigRemovedNotice').classList.remove('d-none');
    document.getElementById('removeSigBtn').classList.add('d-none');
}

function prepareSubmitForm() {
    const activeTab = document.querySelector('#sigTab .nav-link.active');
    if (activeTab && activeTab.id === 'draw-tab') {
        if (hasDrawn && canvas) {
            document.getElementById('signatureData').value = canvas.toDataURL('image/png');
        } else {
            document.getElementById('signatureData').value = '';
        }
    } else {
        document.getElementById('signatureData').value = '';
    }
    return true;
}

function previewSignature(src, userName) {
    document.getElementById('modalSigImage').src = src;
    document.getElementById('sigPreviewTitle').innerHTML = '<i class="bi bi-pen me-2"></i> Digital Signature: ' + userName;
    var modal = new bootstrap.Modal(document.getElementById('sigPreviewModal'));
    modal.show();
}

function openAddModal() {
    document.getElementById('formAction').value = 'add_user';
    document.getElementById('userId').value = '0';
    document.getElementById('auditorModalLabel').innerHTML = '<i class="bi bi-person-plus-fill me-2"></i> Add New User';
    document.getElementById('fullName').value = '';
    document.getElementById('username').value = '';
    document.getElementById('userRoleSelect').value = 'AUDITOR';
    document.getElementById('email').value = '';
    document.getElementById('password').value = '';
    document.getElementById('password').required = true;
    document.getElementById('pwdLabel').innerHTML = 'Password <span class="text-danger">*</span>';
    document.getElementById('pwdHelp').innerText = 'Must be at least 6 characters.';
    document.getElementById('submitBtn').innerHTML = '<i class="bi bi-check-circle me-1"></i> Create User';

    // Reset signature fields
    document.getElementById('removeSignatureInput').value = '0';
    document.getElementById('existingSignatureContainer').classList.add('d-none');
    document.getElementById('sigRemovedNotice').classList.add('d-none');
    document.getElementById('removeSigBtn').classList.remove('d-none');
    clearUploadedFile();
    clearSignatureCanvas();

    // Default to draw tab
    const drawTabTrigger = new bootstrap.Tab(document.getElementById('draw-tab'));
    drawTabTrigger.show();

    setTimeout(initCanvas, 200);
}

function openEditModal(user) {
    document.getElementById('formAction').value = 'edit_user';
    document.getElementById('userId').value = user.user_id;
    document.getElementById('auditorModalLabel').innerHTML = '<i class="bi bi-pencil-square me-2"></i> Edit User Details';
    document.getElementById('fullName').value = user.user_name;
    document.getElementById('username').value = user.username;
    document.getElementById('userRoleSelect').value = user.role || 'AUDITOR';
    document.getElementById('email').value = user.email;
    document.getElementById('password').value = '';
    document.getElementById('password').required = false;
    document.getElementById('pwdLabel').innerHTML = 'Password (Leave blank to keep unchanged)';
    document.getElementById('pwdHelp').innerText = 'Leave empty if you do not want to reset password.';
    document.getElementById('submitBtn').innerHTML = '<i class="bi bi-check-circle me-1"></i> Update User';
    
    // Setup existing signature if present
    document.getElementById('removeSignatureInput').value = '0';
    document.getElementById('sigRemovedNotice').classList.add('d-none');
    document.getElementById('removeSigBtn').classList.remove('d-none');
    clearUploadedFile();
    clearSignatureCanvas();

    if (user.digital_signature) {
        document.getElementById('existingSigImg').src = 'uploads/signatures/' + user.digital_signature;
        document.getElementById('existingSignatureContainer').classList.remove('d-none');
    } else {
        document.getElementById('existingSignatureContainer').classList.add('d-none');
    }

    var modal = new bootstrap.Modal(document.getElementById('auditorModal'));
    modal.show();

    setTimeout(initCanvas, 300);
}

document.addEventListener('DOMContentLoaded', function() {
    var auditorModalEl = document.getElementById('auditorModal');
    if (auditorModalEl) {
        auditorModalEl.addEventListener('shown.bs.modal', function() {
            initCanvas();
        });
    }

    var drawTabEl = document.getElementById('draw-tab');
    if (drawTabEl) {
        drawTabEl.addEventListener('shown.bs.tab', function() {
            initCanvas();
        });
    }
});
</script>

<?php include 'footer.php'; ?>
