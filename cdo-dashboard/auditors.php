<?php
require_once 'auth.php';

$pageTitle = 'MCC | Auditor Management';

$message = '';
$messageType = '';

// Handle POST actions (Add Auditor / Toggle Status / Delete)
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $action = $_POST['action'] ?? '';

    if ($action === 'add_auditor' || $action === 'edit_auditor') {
        $userId   = intval($_POST['user_id'] ?? 0);
        $fullName = trim($_POST['full_name'] ?? '');
        $username = trim($_POST['username'] ?? '');
        $email    = trim($_POST['email'] ?? '');
        $password = $_POST['password'] ?? '';
        $role     = 'AUDITOR';

        if (empty($fullName) || empty($username) || empty($email)) {
            $message = 'Full name, username, and email are required.';
            $messageType = 'danger';
        } elseif ($action === 'add_auditor' && empty($password)) {
            $message = 'Password is required for creating a new auditor account.';
            $messageType = 'danger';
        } else {
            try {
                // Check duplicate username
                $chkUname = $pdo->prepare("SELECT COUNT(*) FROM mcc_users WHERE username = :username" . ($action === 'edit_auditor' ? " AND user_id != :id" : ""));
                $unameParams = ['username' => $username];
                if ($action === 'edit_auditor') $unameParams['id'] = $userId;
                $chkUname->execute($unameParams);

                // Check duplicate email
                $chkEmail = $pdo->prepare("SELECT COUNT(*) FROM mcc_users WHERE email = :email" . ($action === 'edit_auditor' ? " AND user_id != :id" : ""));
                $emailParams = ['email' => $email];
                if ($action === 'edit_auditor') $emailParams['id'] = $userId;
                $chkEmail->execute($emailParams);

                if ($chkUname->fetchColumn() > 0) {
                    $message = "Username '$username' is already registered. Please choose another.";
                    $messageType = 'danger';
                } elseif ($chkEmail->fetchColumn() > 0) {
                    $message = "Email address '$email' is already in use.";
                    $messageType = 'danger';
                } else {
                    if ($action === 'add_auditor') {
                        $hash = password_hash($password, PASSWORD_BCRYPT);
                        $ins = $pdo->prepare("
                            INSERT INTO mcc_users (user_name, full_name, username, email, password_hash, role, station_id, status)
                            VALUES (:user_name, :full_name, :username, :email, :password_hash, :role, :station_id, 'Active')
                        ");
                        $ins->execute([
                            'user_name'      => $fullName,
                            'full_name'      => $fullName,
                            'username'       => $username,
                            'email'          => $email,
                            'password_hash'  => $hash,
                            'role'           => $role,
                            'station_id'     => $stationId
                        ]);
                        $message = "Auditor account for '$fullName' created successfully!";
                        $messageType = 'success';
                    } else {
                        if (!empty($password)) {
                            $hash = password_hash($password, PASSWORD_BCRYPT);
                            $upd = $pdo->prepare("
                                UPDATE mcc_users 
                                SET user_name = :user_name, full_name = :full_name, username = :username, email = :email, password_hash = :password_hash
                                WHERE user_id = :id AND station_id = :station_id AND role = 'AUDITOR'
                            ");
                            $upd->execute([
                                'user_name'      => $fullName,
                                'full_name'      => $fullName,
                                'username'       => $username,
                                'email'          => $email,
                                'password_hash'  => $hash,
                                'id'             => $userId,
                                'station_id'     => $stationId
                            ]);
                        } else {
                            $upd = $pdo->prepare("
                                UPDATE mcc_users 
                                SET user_name = :user_name, full_name = :full_name, username = :username, email = :email
                                WHERE user_id = :id AND station_id = :station_id AND role = 'AUDITOR'
                            ");
                            $upd->execute([
                                'user_name'  => $fullName,
                                'full_name'  => $fullName,
                                'username'   => $username,
                                'email'      => $email,
                                'id'         => $userId,
                                'station_id' => $stationId
                            ]);
                        }
                        $message = "Auditor details for '$fullName' updated successfully!";
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
        try {
            $upd = $pdo->prepare("UPDATE mcc_users SET status = :status WHERE user_id = :id AND station_id = :station_id AND role = 'AUDITOR'");
            $upd->execute(['status' => $newStatus, 'id' => $userId, 'station_id' => $stationId]);
            $message = "Auditor status updated to '$newStatus'.";
            $messageType = 'success';
        } catch (Exception $e) {
            $message = 'Error updating status: ' . $e->getMessage();
            $messageType = 'danger';
        }
    } elseif ($action === 'delete_auditor') {
        $userId = intval($_POST['user_id'] ?? 0);
        try {
            $del = $pdo->prepare("DELETE FROM mcc_users WHERE user_id = :id AND station_id = :station_id AND role = 'AUDITOR'");
            $del->execute(['id' => $userId, 'station_id' => $stationId]);
            $message = "Auditor account removed successfully.";
            $messageType = 'success';
        } catch (Exception $e) {
            $message = 'Error deleting auditor: ' . $e->getMessage();
            $messageType = 'danger';
        }
    }
}

// Fetch all auditors assigned to this station
$stmt = $pdo->prepare("
    SELECT user_id, user_name, username, email, role, status, created_at
    FROM mcc_users
    WHERE station_id = :station_id AND role = 'AUDITOR'
    ORDER BY user_id DESC
");
$stmt->execute(['station_id' => $stationId]);
$auditors = $stmt->fetchAll(PDO::FETCH_ASSOC);

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
        background: linear-gradient(135deg, #07203a 0%, #0c3b6d 100%);
        color: white;
        border: none;
        padding: 8px 18px;
        border-radius: 6px;
        font-weight: 600;
        font-size: 0.88rem;
        display: inline-flex;
        align-items: center;
        gap: 6px;
        transition: all 0.2s;
    }
    .btn-create-auditor:hover {
        background: linear-gradient(135deg, #07182c 0%, #07203a 100%);
        color: white;
        transform: translateY(-1px);
        box-shadow: 0 4px 10px rgba(7, 32, 58, 0.2);
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
                    <h3 class="mb-1 font-weight-bold" style="font-size: 1.35rem;"><i class="bi bi-person-badge me-2"></i> Auditor Management</h3>
                    <p class="mb-0 text-white-50" style="font-size: 0.85rem;">Manage mobile application auditors and login credentials for <?= htmlspecialchars($stationName) ?> Station</p>
                </div>
                <button type="button" class="btn btn-light fw-bold text-dark btn-sm px-3 shadow-sm" data-bs-toggle="modal" data-bs-target="#auditorModal" onclick="openAddModal()">
                    <i class="bi bi-person-plus-fill me-1 text-primary"></i> Add New Auditor
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
                        <i class="bi bi-people-fill text-primary me-2"></i> Registered Auditors (<?= count($auditors) ?>)
                    </h5>
                </div>
                <div class="table-responsive">
                    <table class="table auditor-table mb-0">
                        <thead>
                            <tr>
                                <th style="width: 60px; text-align: center;">#</th>
                                <th>Auditor Name</th>
                                <th>Username / Login ID</th>
                                <th>Email Address</th>
                                <th style="text-align: center;">Status</th>
                                <th style="text-align: center;">Created At</th>
                                <th style="width: 140px; text-align: center;">Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <?php if (empty($auditors)): ?>
                                <tr>
                                    <td colspan="7" class="text-center py-4 text-muted">
                                        <i class="bi bi-person-x fs-3 d-block mb-2 text-secondary"></i>
                                        No auditor accounts registered for this station yet. Click "Add New Auditor" above to create one.
                                    </td>
                                </tr>
                            <?php else: ?>
                                <?php foreach ($auditors as $idx => $a): ?>
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

                                                <form method="POST" class="d-inline" onsubmit="return confirm('Toggle status for this auditor?');">
                                                    <input type="hidden" name="action" value="toggle_status">
                                                    <input type="hidden" name="user_id" value="<?= $a['user_id'] ?>">
                                                    <input type="hidden" name="current_status" value="<?= $a['status'] ?>">
                                                    <button type="submit" class="btn btn-sm <?= ($a['status'] === 'Active') ? 'btn-outline-warning' : 'btn-outline-success' ?>" title="<?= ($a['status'] === 'Active') ? 'Deactivate' : 'Activate' ?>">
                                                        <i class="bi <?= ($a['status'] === 'Active') ? 'bi-pause-fill' : 'bi-play-fill' ?>"></i>
                                                    </button>
                                                </form>

                                                <form method="POST" class="d-inline" onsubmit="return confirm('Are you sure you want to permanently delete this auditor?');">
                                                    <input type="hidden" name="action" value="delete_auditor">
                                                    <input type="hidden" name="user_id" value="<?= $a['user_id'] ?>">
                                                    <button type="submit" class="btn btn-sm btn-outline-danger" title="Delete">
                                                        <i class="bi bi-trash3"></i>
                                                    </button>
                                                </form>
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

<!-- Add / Edit Auditor Modal -->
<div class="modal fade" id="auditorModal" tabindex="-1" aria-labelledby="auditorModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content border-0 shadow-lg" style="border-radius: 12px;">
            <form method="POST" id="auditorForm">
                <input type="hidden" name="action" id="formAction" value="add_auditor">
                <input type="hidden" name="user_id" id="userId" value="0">

                <div class="modal-header text-white" style="background: linear-gradient(135deg, #07203a 0%, #0c3b6d 100%); border-radius: 12px 12px 0 0;">
                    <h5 class="modal-title font-weight-bold" id="auditorModalLabel"><i class="bi bi-person-plus-fill me-2"></i> Add New Auditor</h5>
                    <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body p-4">
                    <div class="mb-3">
                        <label class="form-label font-weight-bold text-secondary small text-uppercase">Full Name <span class="text-danger">*</span></label>
                        <input type="text" class="form-control" name="full_name" id="fullName" placeholder="e.g. Prabhunath Sharma" required>
                    </div>

                    <div class="mb-3">
                        <label class="form-label font-weight-bold text-secondary small text-uppercase">Username / Login ID <span class="text-danger">*</span></label>
                        <input type="text" class="form-control" name="username" id="username" placeholder="e.g. prabhunath" required>
                        <small class="text-muted">This username will be used to log in on the mobile app.</small>
                    </div>

                    <div class="mb-3">
                        <label class="form-label font-weight-bold text-secondary small text-uppercase">Email Address <span class="text-danger">*</span></label>
                        <input type="email" class="form-control" name="email" id="email" placeholder="e.g. auditor@mcc.in" required>
                    </div>

                    <div class="mb-3">
                        <label class="form-label font-weight-bold text-secondary small text-uppercase" id="pwdLabel">Password <span class="text-danger">*</span></label>
                        <input type="password" class="form-control" name="password" id="password" placeholder="Enter secure password">
                        <small class="text-muted" id="pwdHelp">Must be at least 6 characters.</small>
                    </div>
                </div>
                <div class="modal-footer bg-light" style="border-radius: 0 0 12px 12px;">
                    <button type="button" class="btn btn-secondary px-3" data-bs-dismiss="modal">Cancel</button>
                    <button type="submit" class="btn-create-auditor px-4" id="submitBtn">
                        <i class="bi bi-check-circle me-1"></i> Save Auditor
                    </button>
                </div>
            </form>
        </div>
    </div>
</div>

<script>
function openAddModal() {
    document.getElementById('formAction').value = 'add_auditor';
    document.getElementById('userId').value = '0';
    document.getElementById('auditorModalLabel').innerHTML = '<i class="bi bi-person-plus-fill me-2"></i> Add New Auditor';
    document.getElementById('fullName').value = '';
    document.getElementById('username').value = '';
    document.getElementById('email').value = '';
    document.getElementById('password').value = '';
    document.getElementById('password').required = true;
    document.getElementById('pwdLabel').innerHTML = 'Password <span class="text-danger">*</span>';
    document.getElementById('pwdHelp').innerText = 'Must be at least 6 characters.';
    document.getElementById('submitBtn').innerHTML = '<i class="bi bi-check-circle me-1"></i> Create Auditor';
}

function openEditModal(auditor) {
    document.getElementById('formAction').value = 'edit_auditor';
    document.getElementById('userId').value = auditor.user_id;
    document.getElementById('auditorModalLabel').innerHTML = '<i class="bi bi-pencil-square me-2"></i> Edit Auditor Details';
    document.getElementById('fullName').value = auditor.user_name;
    document.getElementById('username').value = auditor.username;
    document.getElementById('email').value = auditor.email;
    document.getElementById('password').value = '';
    document.getElementById('password').required = false;
    document.getElementById('pwdLabel').innerHTML = 'Password (Leave blank to keep unchanged)';
    document.getElementById('pwdHelp').innerText = 'Leave empty if you do not want to reset password.';
    document.getElementById('submitBtn').innerHTML = '<i class="bi bi-check-circle me-1"></i> Update Auditor';
    
    var modal = new bootstrap.Modal(document.getElementById('auditorModal'));
    modal.show();
}
</script>

<?php include 'footer.php'; ?>
