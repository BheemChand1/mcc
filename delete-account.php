<?php
require_once __DIR__ . '/connection.php';
global $pdo;

$message = '';
$messageType = '';

if ($_SERVER['REQUEST_METHOD'] === 'POST' && isset($_POST['action']) && $_POST['action'] === 'request_deletion') {
    $identifier = trim($_POST['identifier'] ?? '');
    $role = trim($_POST['role'] ?? 'user');
    $reason = trim($_POST['reason'] ?? '');
    $confirm = isset($_POST['confirm_check']);

    if (empty($identifier)) {
        $message = 'Please provide your Username, Employee ID, or Email Address.';
        $messageType = 'danger';
    } elseif (!$confirm) {
        $message = 'Please check the confirmation box to acknowledge account deletion.';
        $messageType = 'danger';
    } else {
        try {
            // Check in users or employees table
            $found = false;
            
            // Check mcc_users
            $uStmt = $pdo->prepare("SELECT user_id, username, full_name, email FROM mcc_users WHERE username = :id OR email = :id2");
            $uStmt->execute(['id' => $identifier, 'id2' => $identifier]);
            $userRow = $uStmt->fetch(PDO::FETCH_ASSOC);

            // Check mcc_employee
            $eStmt = $pdo->prepare("SELECT id, employee_id, full_name, mobile_number FROM mcc_employee WHERE employee_id = :id OR full_name = :id2");
            $eStmt->execute(['id' => $identifier, 'id2' => $identifier]);
            $empRow = $eStmt->fetch(PDO::FETCH_ASSOC);

            // Create table for deletion requests if it doesn't exist
            $pdo->exec("CREATE TABLE IF NOT EXISTS `mcc_deletion_requests` (
                `id` INT AUTO_INCREMENT PRIMARY KEY,
                `identifier` VARCHAR(150) NOT NULL,
                `role` VARCHAR(50) DEFAULT 'user',
                `reason` TEXT NULL,
                `status` VARCHAR(50) DEFAULT 'Pending Review',
                `requested_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP
            ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;");

            $insStmt = $pdo->prepare("INSERT INTO mcc_deletion_requests (identifier, role, reason, status) VALUES (:identifier, :role, :reason, 'Pending Review')");
            $insStmt->execute([
                'identifier' => $identifier,
                'role' => $role,
                'reason' => $reason
            ]);

            $message = "Your account deletion request for '$identifier' has been received. Our administrative team will verify and process the removal of your personal credentials within 7 working days.";
            $messageType = 'success';

        } catch (Exception $e) {
            $message = 'Error processing your request: ' . $e->getMessage();
            $messageType = 'danger';
        }
    }
}
?>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Delete Account & Data - Mechanized Coach Cleaning (MCC)</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700;800&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
    <style>
        :root {
            --primary: #07203a;
            --primary-light: #0c3b6d;
            --accent: #1987C6;
            --danger: #dc2626;
            --bg: #f8fafc;
            --card-bg: #ffffff;
            --text-main: #1e293b;
            --text-muted: #64748b;
            --border: #e2e8f0;
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Inter', -apple-system, BlinkMacSystemFont, sans-serif;
        }

        body {
            background-color: var(--bg);
            color: var(--text-main);
            line-height: 1.65;
            padding-bottom: 60px;
        }

        .header-bar {
            background: linear-gradient(135deg, #07203a 0%, #0c3b6d 100%);
            color: white;
            padding: 40px 20px;
            text-align: center;
            box-shadow: 0 4px 20px rgba(7, 32, 58, 0.15);
        }

        .header-bar .logo-container {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            gap: 12px;
            margin-bottom: 12px;
        }

        .header-bar h1 {
            font-size: 2.2rem;
            font-weight: 800;
            letter-spacing: -0.5px;
        }

        .header-bar p {
            color: #93c5fd;
            font-size: 0.95rem;
            margin-top: 6px;
        }

        .container {
            max-width: 800px;
            margin: -25px auto 0 auto;
            padding: 0 20px;
        }

        .card {
            background: var(--card-bg);
            border-radius: 14px;
            padding: 40px;
            box-shadow: 0 4px 25px rgba(0, 0, 0, 0.05);
            border: 1px solid var(--border);
        }

        .nav-links {
            display: flex;
            gap: 15px;
            margin-bottom: 30px;
            border-bottom: 1px solid var(--border);
            padding-bottom: 15px;
            flex-wrap: wrap;
        }

        .nav-links a {
            text-decoration: none;
            color: var(--text-muted);
            font-weight: 600;
            font-size: 0.9rem;
            padding: 6px 14px;
            border-radius: 6px;
            transition: all 0.2s;
        }

        .nav-links a.active {
            background: #fee2e2;
            color: var(--danger);
        }

        .nav-links a:hover {
            color: var(--primary);
        }

        h2 {
            font-size: 1.35rem;
            font-weight: 700;
            color: var(--primary);
            margin: 20px 0 12px 0;
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .alert {
            padding: 16px 20px;
            border-radius: 8px;
            margin-bottom: 25px;
            font-size: 0.92rem;
            display: flex;
            align-items: center;
            gap: 12px;
        }

        .alert-success {
            background-color: #f0fdf4;
            color: #166534;
            border: 1px solid #bbf7d0;
        }

        .alert-danger {
            background-color: #fef2f2;
            color: #991b1b;
            border: 1px solid #fecaca;
        }

        .info-box {
            background-color: #fffbeb;
            border: 1px solid #fef3c7;
            color: #92400e;
            padding: 18px 22px;
            border-radius: 8px;
            margin-bottom: 30px;
            font-size: 0.92rem;
        }

        .info-box h4 {
            font-weight: 700;
            margin-bottom: 6px;
            display: flex;
            align-items: center;
            gap: 8px;
        }

        .form-group {
            margin-bottom: 20px;
        }

        .form-label {
            display: block;
            font-size: 0.88rem;
            font-weight: 600;
            color: var(--text-main);
            margin-bottom: 6px;
        }

        .form-control, .form-select, textarea {
            width: 100%;
            padding: 10px 14px;
            border: 1px solid var(--border);
            border-radius: 8px;
            font-size: 0.95rem;
            color: var(--text-main);
            outline: none;
            transition: border-color 0.2s;
        }

        .form-control:focus, .form-select:focus, textarea:focus {
            border-color: var(--accent);
            box-shadow: 0 0 0 3px rgba(25, 135, 198, 0.12);
        }

        .checkbox-group {
            display: flex;
            align-items: flex-start;
            gap: 10px;
            margin-top: 15px;
            margin-bottom: 25px;
        }

        .checkbox-group input {
            margin-top: 4px;
            cursor: pointer;
        }

        .checkbox-group label {
            font-size: 0.88rem;
            color: #475569;
            cursor: pointer;
        }

        .btn-delete {
            background: linear-gradient(135deg, #dc2626 0%, #b91c1c 100%);
            color: white;
            border: none;
            padding: 12px 28px;
            font-size: 0.95rem;
            font-weight: 700;
            border-radius: 8px;
            cursor: pointer;
            display: inline-flex;
            align-items: center;
            gap: 8px;
            transition: all 0.2s;
            box-shadow: 0 4px 12px rgba(220, 38, 38, 0.2);
        }

        .btn-delete:hover {
            background: linear-gradient(135deg, #b91c1c 0%, #991b1b 100%);
            transform: translateY(-1px);
        }

        .footer {
            text-align: center;
            margin-top: 40px;
            color: var(--text-muted);
            font-size: 0.85rem;
        }
    </style>
</head>
<body>

    <header class="header-bar">
        <div class="logo-container">
            <i class="bi bi-person-x fs-2 text-danger"></i>
            <h1>Mechanized Coach Cleaning (MCC)</h1>
        </div>
        <p>User Account & Data Deletion Portal</p>
    </header>

    <div class="container">
        <div class="card">
            <div class="nav-links">
                <a href="privacy-policy.php"><i class="bi bi-shield-lock me-1"></i> Privacy Policy</a>
                <a href="terms-conditions.php"><i class="bi bi-file-earmark-text me-1"></i> Terms & Conditions</a>
                <a href="delete-account.php" class="active"><i class="bi bi-person-x me-1"></i> Delete Account / Data</a>
            </div>

            <?php if (!empty($message)): ?>
                <div class="alert alert-<?= $messageType ?>">
                    <i class="bi <?= ($messageType === 'success') ? 'bi-check-circle-fill' : 'bi-exclamation-triangle-fill' ?> fs-5"></i>
                    <span><?= htmlspecialchars($message) ?></span>
                </div>
            <?php endif; ?>

            <div class="info-box">
                <h4><i class="bi bi-exclamation-triangle-fill"></i> Important Notice Regarding Deletion</h4>
                <p style="margin-bottom: 0;">In accordance with Google Play Developer Policies and railway compliance, you may request the deletion of your account and associated personal data. Note that official audit scorecards, safety records, and chemical logs will be anonymized or retained as required by official railway statutory audit mandates.</p>
            </div>

            <h2><i class="bi bi-trash3 text-danger"></i> Submit Deletion Request</h2>
            <form action="delete-account.php" method="POST">
                <input type="hidden" name="action" value="request_deletion">

                <div class="form-group">
                    <label class="form-label" for="identifier">Username / Employee ID / Email Address <span style="color:red;">*</span></label>
                    <input type="text" class="form-control" id="identifier" name="identifier" placeholder="e.g. prabhunath or EMP-1024 or user@rail.gov.in" required>
                </div>

                <div class="form-group">
                    <label class="form-label" for="role">Account Type / Role</label>
                    <select class="form-select" id="role" name="role">
                        <option value="Auditor / Inspector">Auditor / Inspector</option>
                        <option value="Depot Supervisor / Contractor Staff">Depot Supervisor / Contractor Staff</option>
                        <option value="CDO / Railway Officer">CDO / Railway Officer</option>
                        <option value="Other">Other</option>
                    </select>
                </div>

                <div class="form-group">
                    <label class="form-label" for="reason">Reason for Deletion (Optional)</label>
                    <textarea class="form-control" id="reason" name="reason" rows="3" placeholder="Please let us know why you wish to delete your profile..."></textarea>
                </div>

                <div class="checkbox-group">
                    <input type="checkbox" id="confirm_check" name="confirm_check" value="1" required>
                    <label for="confirm_check">I confirm that I want to request the permanent deletion of my personal user profile and login credentials from the Mechanized Coach Cleaning (MCC) application.</label>
                </div>

                <button type="submit" class="btn-delete">
                    <i class="bi bi-trash3-fill"></i> Request Account Deletion
                </button>
            </form>
        </div>

        <div class="footer">
            &copy; 2026 Mechanized Coach Cleaning (MCC) Portal. All rights reserved.
        </div>
    </div>

</body>
</html>
