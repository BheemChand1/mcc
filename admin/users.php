<?php
/**
 * MCC - Admin Panel User Management
 * Lists system users and handles creation, status toggles, and secure profile updates.
 */
if (session_status() === PHP_SESSION_NONE) {
    session_name('MCC_ADMIN_SESS');
    session_start();
}
$pageTitle = 'MCC Admin | Manage Users';
require_once '../connection.php';

$message = $_SESSION['flash_message'] ?? '';
$messageType = $_SESSION['flash_message_type'] ?? '';
unset($_SESSION['flash_message'], $_SESSION['flash_message_type']);

// Handle POST actions
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    // 1. Add User / Edit User Action
    if (isset($_POST['action']) && ($_POST['action'] === 'add_user' || $_POST['action'] === 'edit_user')) {
        $action = $_POST['action'];
        $user_id = intval($_POST['user_id'] ?? 0);
        $user_name = trim($_POST['user_name'] ?? '');
        $username = trim($_POST['username'] ?? '');
        $email = trim($_POST['email'] ?? '');
        $password = $_POST['password'] ?? '';
        $role = $_POST['role'] ?? 'AUDITOR';
        $station_id = intval($_POST['station_id'] ?? 0);
        
        $hasError = false;
        
        if ($action === 'add_user') {
            if (empty($user_name) || empty($username) || empty($email) || empty($password) || $station_id <= 0) {
                $_SESSION['flash_message'] = 'All fields, including depot station and password, are required.';
                $_SESSION['flash_message_type'] = 'danger';
                $hasError = true;
            }
        } else { // edit_user
            if (empty($user_name) || empty($username) || empty($email) || $station_id <= 0) {
                $_SESSION['flash_message'] = 'All fields, except password, are required.';
                $_SESSION['flash_message_type'] = 'danger';
                $hasError = true;
            }
        }
        
        if (!$hasError) {
            try {
                // Check duplicate username (excluding self when editing)
                $uname_sql = "SELECT COUNT(*) FROM mcc_users WHERE username = :uname" . ($action === 'edit_user' ? " AND user_id != :id" : "");
                $chk_uname = $pdo->prepare($uname_sql);
                $uname_params = ['uname' => $username];
                if ($action === 'edit_user') {
                    $uname_params['id'] = $user_id;
                }
                $chk_uname->execute($uname_params);
                
                // Check duplicate email
                $email_sql = "SELECT COUNT(*) FROM mcc_users WHERE email = :email" . ($action === 'edit_user' ? " AND user_id != :id" : "");
                $chk_email = $pdo->prepare($email_sql);
                $email_params = ['email' => $email];
                if ($action === 'edit_user') {
                    $email_params['id'] = $user_id;
                }
                $chk_email->execute($email_params);
                
                // Check duplicate display name
                $dname_sql = "SELECT COUNT(*) FROM mcc_users WHERE user_name = :dname" . ($action === 'edit_user' ? " AND user_id != :id" : "");
                $chk_dname = $pdo->prepare($dname_sql);
                $dname_params = ['dname' => $user_name];
                if ($action === 'edit_user') {
                    $dname_params['id'] = $user_id;
                }
                $chk_dname->execute($dname_params);
                
                if ($chk_uname->fetchColumn() > 0) {
                    $_SESSION['flash_message'] = "Login username '$username' already taken.";
                    $_SESSION['flash_message_type'] = 'warning';
                } elseif ($chk_email->fetchColumn() > 0) {
                    $_SESSION['flash_message'] = "Email address '$email' is already registered.";
                    $_SESSION['flash_message_type'] = 'warning';
                } elseif ($chk_dname->fetchColumn() > 0) {
                    $_SESSION['flash_message'] = "Display name '$user_name' already exists.";
                    $_SESSION['flash_message_type'] = 'warning';
                } else {
                    if ($action === 'add_user') {
                        // Hash the password securely using bcrypt
                        $password_hash = password_hash($password, PASSWORD_BCRYPT);
                        
                        $ins = $pdo->prepare("
                            INSERT INTO mcc_users (user_name, username, email, password_hash, role, station_id, status) 
                            VALUES (:user_name, :username, :email, :password_hash, :role, :station_id, 'Active')
                        ");
                        $ins->execute([
                            'user_name' => $user_name,
                            'username' => $username,
                            'email' => $email,
                            'password_hash' => $password_hash,
                            'role' => $role,
                            'station_id' => $station_id
                        ]);
                        
                        $_SESSION['flash_message'] = "User account for '$user_name' successfully created.";
                    } else { // edit_user
                        if (!empty($password)) {
                            $password_hash = password_hash($password, PASSWORD_BCRYPT);
                            $upd = $pdo->prepare("
                                UPDATE mcc_users 
                                SET user_name = :user_name, username = :username, email = :email, password_hash = :password_hash, role = :role, station_id = :station_id 
                                WHERE user_id = :id
                            ");
                            $upd->execute([
                                'user_name' => $user_name,
                                'username' => $username,
                                'email' => $email,
                                'password_hash' => $password_hash,
                                'role' => $role,
                                'station_id' => $station_id,
                                'id' => $user_id
                            ]);
                        } else {
                            $upd = $pdo->prepare("
                                UPDATE mcc_users 
                                SET user_name = :user_name, username = :username, email = :email, role = :role, station_id = :station_id 
                                WHERE user_id = :id
                            ");
                            $upd->execute([
                                'user_name' => $user_name,
                                'username' => $username,
                                'email' => $email,
                                'role' => $role,
                                'station_id' => $station_id,
                                'id' => $user_id
                            ]);
                        }
                        $_SESSION['flash_message'] = "User account '$user_name' successfully updated.";
                    }
                    $_SESSION['flash_message_type'] = 'success';
                }
            } catch (PDOException $e) {
                $_SESSION['flash_message'] = 'Error processing user account: ' . $e->getMessage();
                $_SESSION['flash_message_type'] = 'danger';
            }
        }
        header("Location: users.php" . ($action === 'edit_user' ? "?action=edit&edit_id=" . $user_id : ""));
        exit();
    }
    
    // 2. Toggle Status Action
    if (isset($_POST['action']) && $_POST['action'] === 'toggle_status') {
        $user_id = intval($_POST['user_id'] ?? 0);
        $current_status = $_POST['current_status'] ?? 'Active';
        
        // Prevent disabling yourself!
        if ($user_id === intval($_SESSION['user_id'])) {
            $_SESSION['flash_message'] = 'Security warning: You cannot deactivate your own administrative account.';
            $_SESSION['flash_message_type'] = 'danger';
        } else {
            $new_status = ($current_status === 'Active') ? 'Inactive' : 'Active';
            try {
                $upd = $pdo->prepare("UPDATE mcc_users SET status = :status WHERE user_id = :id");
                $upd->execute(['status' => $new_status, 'id' => $user_id]);
                $_SESSION['flash_message'] = "User status updated to $new_status.";
                $_SESSION['flash_message_type'] = 'success';
            } catch (PDOException $e) {
                $_SESSION['flash_message'] = 'Error updating status: ' . $e->getMessage();
                $_SESSION['flash_message_type'] = 'danger';
            }
        }
        header("Location: users.php");
        exit();
    }
}

// Handle GET edit loader
$edit_user_data = null;
if (isset($_GET['action']) && $_GET['action'] === 'edit' && isset($_GET['edit_id'])) {
    $edit_id = intval($_GET['edit_id']);
    try {
        $stmt = $pdo->prepare("SELECT * FROM mcc_users WHERE user_id = :id");
        $stmt->execute(['id' => $edit_id]);
        $edit_user_data = $stmt->fetch();
    } catch (PDOException $e) {
        // Fail silently
    }
}

// Fetch active stations for select dropdown
$activeStations = [];
try {
    $activeStations = $pdo->query("SELECT station_id, station_name FROM mcc_stations WHERE status = 'Active' ORDER BY station_name ASC")->fetchAll();
} catch (PDOException $e) {
    // Graceful error capture
}

// Fetch all users with station info
$users = [];
try {
    $stmt = $pdo->query("
        SELECT u.*, s.station_name 
        FROM mcc_users u 
        LEFT JOIN mcc_stations s ON u.station_id = s.station_id 
        ORDER BY u.role ASC, u.user_name ASC
    ");
    $users = $stmt->fetchAll();
} catch (PDOException $e) {
    $dbError = $e->getMessage();
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
            <i class="bi bi-person-fill-gear text-indigo me-2" style="font-size: 1.6rem;"></i>
            User Access Management
          </h3>
        </div>
        <div class="col-md-6 text-md-end mt-2 mt-md-0">
          <span class="badge bg-indigo-subtle text-indigo p-2 px-3 border border-indigo-subtle rounded-pill">
            System Users: <?php echo count($users); ?>
          </span>
        </div>
      </div>
    </div>
  </div>

  <!-- Content Body -->
  <div class="app-content">
    <div class="container-fluid">
      
      <?php if (!empty($message)): ?>
        <div class="alert alert-<?php echo $messageType; ?> alert-dismissible fade show rounded-3 shadow-sm mb-4" role="alert">
          <i class="bi <?php echo ($messageType === 'success') ? 'bi-check-circle-fill' : 'bi-exclamation-triangle-fill'; ?> me-2"></i>
          <?php echo htmlspecialchars($message); ?>
          <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
        </div>
      <?php endif; ?>

      <div class="row g-4">
        
        <!-- Left Side: Users List Table -->
        <div class="col-lg-8">
          <div class="card shadow-sm border-0 h-100">
            <div class="card-header bg-white py-3">
              <h5 class="mb-0 font-weight-bold text-dark d-flex align-items-center">
                <i class="bi bi-list-stars text-indigo me-2"></i> Registered Accounts
              </h5>
            </div>
            <div class="card-body p-0">
              <div class="table-responsive">
                <table class="table table-hover table-striped mb-0">
                  <thead>
                    <tr>
                      <th class="ps-3" style="width: 80px;">User ID</th>
                      <th>Full Name</th>
                      <th>Username</th>
                      <th>Email</th>
                      <th>Role</th>
                      <th>Assigned Station</th>
                      <th>Status</th>
                      <th class="text-center" style="width: 180px;">Actions</th>
                    </tr>
                  </thead>
                  <tbody>
                    <?php if (empty($users)): ?>
                      <tr>
                        <td colspan="8" class="text-center py-5 text-muted small">No accounts found in the database.</td>
                      </tr>
                    <?php else: ?>
                      <?php foreach ($users as $u): ?>
                        <tr>
                          <td class="ps-3"><strong>USR-<?php echo $u['user_id']; ?></strong></td>
                          <td><strong><?php echo htmlspecialchars($u['user_name']); ?></strong></td>
                          <td><code><?php echo htmlspecialchars($u['username']); ?></code></td>
                          <td><span class="text-muted" style="font-size: 0.85rem;"><?php echo htmlspecialchars($u['email']); ?></span></td>
                          <td>
                            <span class="badge rounded-pill <?php echo ($u['role'] === 'ADMIN' || $u['role'] === 'DM') ? 'bg-danger-subtle text-danger border border-danger-subtle' : 'bg-primary-subtle text-primary border border-primary-subtle'; ?>" style="font-size: 0.76rem;">
                              <?php echo htmlspecialchars($u['role'] ? $u['role'] : 'AUDITOR'); ?>
                            </span>
                          </td>
                          <td><?php echo htmlspecialchars($u['station_name'] ? $u['station_name'] : 'System Base'); ?></td>
                          <td>
                            <span class="badge rounded-pill <?php echo $u['status'] === 'Active' ? 'bg-success-subtle text-success border border-success-subtle' : 'bg-danger-subtle text-danger border border-danger-subtle'; ?>" style="font-size: 0.78rem;">
                              <?php echo htmlspecialchars($u['status']); ?>
                            </span>
                          </td>
                          <td class="text-center">
                            <?php if ($u['user_id'] === intval($_SESSION['user_id'])): ?>
                              <span class="text-muted small font-weight-bold">Self Account</span>
                            <?php else: ?>
                              <div class="d-inline-flex gap-1">
                                <a href="users.php?action=edit&edit_id=<?php echo $u['user_id']; ?>" class="btn btn-sm btn-outline-secondary rounded-pill px-2.5 font-weight-bold" style="text-decoration: none; font-size: 0.78rem;">
                                  Edit
                                </a>
                                <?php if ($u['status'] === 'Active'): ?>
                                  <a href="impersonate.php?user_id=<?php echo $u['user_id']; ?>" target="_blank" class="btn btn-sm btn-outline-success rounded-pill px-2.5 font-weight-bold" style="text-decoration: none; font-size: 0.78rem;">
                                    Login
                                  </a>
                                <?php endif; ?>
                                <form action="users.php" method="POST" class="m-0">
                                  <input type="hidden" name="action" value="toggle_status">
                                  <input type="hidden" name="user_id" value="<?php echo $u['user_id']; ?>">
                                  <input type="hidden" name="current_status" value="<?php echo $u['status']; ?>">
                                  <button type="submit" class="btn btn-sm <?php echo $u['status'] === 'Active' ? 'btn-outline-danger' : 'btn-outline-success'; ?> rounded-pill px-2.5 font-weight-bold" style="font-size: 0.78rem;">
                                    Status
                                  </button>
                                </form>
                              </div>
                            <?php endif; ?>
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

        <!-- Right Side: Register / Edit User Form -->
        <div class="col-lg-4">
          <div class="card shadow-sm border-0">
            <div class="card-header bg-white py-3">
              <h5 class="mb-0 font-weight-bold text-dark d-flex align-items-center">
                <i class="bi <?php echo $edit_user_data ? 'bi-pencil-square text-warning' : 'bi-person-plus-fill text-indigo'; ?> me-2"></i>
                <?php echo $edit_user_data ? 'Update Account' : 'Register Account'; ?>
              </h5>
            </div>
            <div class="card-body">
              <?php if (empty($activeStations)): ?>
                <div class="alert alert-warning text-center small rounded-3 p-3 mb-0" role="alert">
                  <i class="bi bi-exclamation-triangle-fill fs-5 d-block mb-2"></i>
                  No active Stations found! You must create an <strong>Active Station</strong> first before adding a User.
                  <a href="stations.php" class="btn btn-sm btn-warning w-100 mt-3 font-weight-bold rounded-pill">Create Station</a>
                </div>
              <?php else: ?>
                <form action="users.php" method="POST" autocomplete="off">
                  <input type="hidden" name="action" value="<?php echo $edit_user_data ? 'edit_user' : 'add_user'; ?>">
                  <?php if ($edit_user_data): ?>
                    <input type="hidden" name="user_id" value="<?php echo $edit_user_data['user_id']; ?>">
                  <?php endif; ?>
                  
                  <div class="mb-3">
                    <label for="user_name" class="form-label font-weight-bold text-secondary mb-1" style="font-size: 0.8rem; text-transform: uppercase;">Full Name (Display Name)</label>
                    <input type="text" class="form-control rounded-3" id="user_name" name="user_name" placeholder="e.g. John Doe" required value="<?php echo $edit_user_data ? htmlspecialchars($edit_user_data['user_name']) : ''; ?>">
                  </div>

                  <div class="mb-3">
                    <label for="username" class="form-label font-weight-bold text-secondary mb-1" style="font-size: 0.8rem; text-transform: uppercase;">Login Username</label>
                    <input type="text" class="form-control rounded-3" id="username" name="username" placeholder="e.g. john_cdo" required value="<?php echo $edit_user_data ? htmlspecialchars($edit_user_data['username']) : ''; ?>">
                  </div>

                  <div class="mb-3">
                    <label for="email" class="form-label font-weight-bold text-secondary mb-1" style="font-size: 0.8rem; text-transform: uppercase;">Email Address</label>
                    <input type="email" class="form-control rounded-3" id="email" name="email" placeholder="e.g. john@rail.com" required value="<?php echo $edit_user_data ? htmlspecialchars($edit_user_data['email']) : ''; ?>">
                  </div>

                  <div class="mb-3">
                    <label for="password" class="form-label font-weight-bold text-secondary mb-1" style="font-size: 0.8rem; text-transform: uppercase;">Access Password</label>
                    <input type="password" class="form-control rounded-3" id="password" name="password" placeholder="<?php echo $edit_user_data ? 'Leave blank to preserve current' : 'Min. 6 characters'; ?>" <?php echo $edit_user_data ? '' : 'required'; ?>>
                  </div>

                  <div class="mb-3">
                    <label for="role" class="form-label font-weight-bold text-secondary mb-1" style="font-size: 0.8rem; text-transform: uppercase;">System Role</label>
                    <select class="form-select rounded-3" id="role" name="role" required>
                      <option value="AUDITOR" <?php echo ($edit_user_data && $edit_user_data['role'] === 'AUDITOR') ? 'selected' : ''; ?>>AUDITOR (Default)</option>
                      <option value="CDO" <?php echo ($edit_user_data && $edit_user_data['role'] === 'CDO') ? 'selected' : ''; ?>>CDO (Coach Depot Officer)</option>
                      <option value="DM" <?php echo ($edit_user_data && $edit_user_data['role'] === 'DM') ? 'selected' : ''; ?>>DM (Depot Manager)</option>
                      <option value="DO" <?php echo ($edit_user_data && $edit_user_data['role'] === 'DO') ? 'selected' : ''; ?>>DO (Depot Officer)</option>
                      <option value="ADMIN" <?php echo ($edit_user_data && $edit_user_data['role'] === 'ADMIN') ? 'selected' : ''; ?>>ADMIN (System Administrator)</option>
                    </select>
                  </div>

                  <div class="mb-3">
                    <label for="station_id" class="form-label font-weight-bold text-secondary mb-1" style="font-size: 0.8rem; text-transform: uppercase;">Assigned Depot Station</label>
                    <select class="form-select rounded-3" id="station_id" name="station_id" required>
                      <option value="">-- Select Active Station --</option>
                      <?php foreach ($activeStations as $stn): ?>
                        <option value="<?php echo $stn['station_id']; ?>" <?php echo ($edit_user_data && $edit_user_data['station_id'] == $stn['station_id']) ? 'selected' : ''; ?>><?php echo htmlspecialchars($stn['station_name']); ?></option>
                      <?php endforeach; ?>
                    </select>
                  </div>

                  <div class="row g-2">
                    <div class="<?php echo $edit_user_data ? 'col-8' : 'col-12'; ?>">
                      <button type="submit" class="btn <?php echo $edit_user_data ? 'btn-warning' : 'btn-indigo'; ?> w-100 p-2.5 rounded-3 font-weight-bold shadow-sm">
                        <?php echo $edit_user_data ? 'Update Account' : 'Register Account'; ?> &nbsp;<i class="bi <?php echo $edit_user_data ? 'bi-check-circle' : 'bi-person-plus-fill'; ?>"></i>
                      </button>
                    </div>
                    <?php if ($edit_user_data): ?>
                      <div class="col-4">
                        <a href="users.php" class="btn btn-outline-secondary w-100 p-2.5 rounded-3 font-weight-bold">Cancel</a>
                      </div>
                    <?php endif; ?>
                  </div>
                </form>
              <?php endif; ?>
            </div>
          </div>
        </div>

      </div>
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
</style>

<?php include 'footer.php'; ?>
