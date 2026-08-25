<?php
/**
 * MCC - CDO Dashboard Login Portal
 * Handles authentication and redirects users to the CDO Dashboard.
 */
session_start();

// If user is already logged in, redirect to dashboard
if (isset($_SESSION['user_id'])) {
    header("Location: cdo-dashboard/index.php");
    exit();
}

$error = '';
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    require_once 'connection.php';
    
    $username = trim($_POST['username'] ?? '');
    $password = $_POST['password'] ?? '';
    
    if (empty($username) || empty($password)) {
        $error = 'Please enter both username and password.';
    } else {
        try {
            // Securely retrieve the user from the database using PDO
            $stmt = $pdo->prepare("SELECT * FROM mcc_users WHERE username = :username LIMIT 1");
            $stmt->execute(['username' => $username]);
            $user = $stmt->fetch();
            
            if ($user) {
                if ($user['status'] === 'Active') {
                    // Verify the password using bcrypt
                    if (password_verify($password, $user['password_hash'])) {
                        // Store variables in session
                        $_SESSION['user_id'] = $user['user_id'];
                        $_SESSION['username'] = $user['username'];
                        $_SESSION['user_name'] = $user['user_name'];
                        $_SESSION['role'] = $user['role'];
                        $_SESSION['station_id'] = $user['station_id'];
                        
                        // Redirect to the CDO dashboard
                        header("Location: cdo-dashboard/index.php");
                        exit();
                    } else {
                        $error = 'Incorrect password. Please try again.';
                    }
                } else {
                    $error = 'Your account is inactive. Please contact the administrator.';
                }
            } else {
                $error = 'Username not found.';
            }
        } catch (PDOException $e) {
            $error = 'System error occurred: ' . $e->getMessage();
        }
    }
}
?>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>MCC | CDO Login Portal</title>
  
  <!-- Styling aligned with CDO Dashboard (Roboto, Bootstrap, AdminLTE Theme Colors) -->
  <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@300;400;500;700;900&display=swap" rel="stylesheet">
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css" />
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/admin-lte@4.0.0-beta3/dist/css/adminlte.css" />
  
  <style>
    :root {
      --primary-blue: #1987C6;
      --primary-blue-dark: #126392;
      --bg-dark: #0f172a;
      --text-muted: #64748b;
    }

    body {
      font-family: 'Roboto', sans-serif;
      background: linear-gradient(135deg, var(--bg-dark) 0%, #1e293b 50%, var(--primary-blue) 100%);
      background-size: cover;
      min-height: 100vh;
      display: flex;
      align-items: center;
      justify-content: center;
      margin: 0;
      padding: 20px;
    }

    .login-container {
      width: 100%;
      max-width: 420px;
      animation: fadeIn 0.6s ease-out-back;
    }

    @keyframes fadeIn {
      0% {
        opacity: 0;
        transform: translateY(20px);
      }
      100% {
        opacity: 1;
        transform: translateY(0);
      }
    }

    .login-card {
      background: rgba(255, 255, 255, 0.95);
      backdrop-filter: blur(12px);
      border: 1px solid rgba(255, 255, 255, 0.2);
      border-radius: 16px;
      padding: 35px 30px;
      box-shadow: 0 15px 35px rgba(0, 0, 0, 0.25);
      transition: all 0.3s ease;
    }

    .login-card:hover {
      box-shadow: 0 20px 45px rgba(0, 0, 0, 0.3);
      transform: translateY(-2px);
    }

    .login-header {
      text-align: center;
      margin-bottom: 30px;
    }

    .login-logo {
      height: 90px;
      width: auto;
      margin-bottom: 15px;
      filter: drop-shadow(0 4px 6px rgba(0,0,0,0.1));
    }

    .login-title {
      font-size: 1.5rem;
      font-weight: 700;
      color: #1e293b;
      margin: 0 0 5px 0;
      text-transform: uppercase;
      letter-spacing: 0.5px;
    }

    .login-subtitle {
      font-size: 0.85rem;
      color: var(--text-muted);
      margin: 0;
    }

    /* Forms */
    .form-group {
      margin-bottom: 20px;
      position: relative;
    }

    .form-label {
      font-size: 0.8rem;
      font-weight: 600;
      color: #475569;
      text-transform: uppercase;
      margin-bottom: 6px;
      display: block;
      letter-spacing: 0.5px;
    }

    .input-group {
      position: relative;
    }

    .input-group-icon {
      position: absolute;
      left: 14px;
      top: 50%;
      transform: translateY(-50%);
      color: #94a3b8;
      font-size: 1.1rem;
      transition: color 0.2s;
      z-index: 10;
    }

    .form-control {
      width: 100%;
      padding: 12px 14px 12px 42px;
      font-size: 0.95rem;
      border: 1px solid #cbd5e1;
      border-radius: 8px;
      color: #1e293b;
      background-color: #f8fafc;
      transition: all 0.2s ease;
    }

    .form-control:focus {
      background-color: #fff;
      border-color: var(--primary-blue);
      box-shadow: 0 0 0 3px rgba(25, 135, 198, 0.15);
      outline: none;
    }

    .form-control:focus + .input-group-icon {
      color: var(--primary-blue);
    }

    /* Password Toggle */
    .password-toggle {
      position: absolute;
      right: 14px;
      top: 50%;
      transform: translateY(-50%);
      color: #94a3b8;
      cursor: pointer;
      font-size: 1.1rem;
      transition: color 0.2s;
      z-index: 10;
    }

    .password-toggle:hover {
      color: var(--primary-blue);
    }

    /* Button */
    .btn-login {
      background: linear-gradient(135deg, var(--primary-blue) 0%, var(--primary-blue-dark) 100%);
      color: #fff;
      border: none;
      border-radius: 8px;
      padding: 12px;
      font-weight: 700;
      font-size: 1rem;
      width: 100%;
      cursor: pointer;
      display: flex;
      align-items: center;
      justify-content: center;
      gap: 10px;
      box-shadow: 0 4px 6px rgba(25, 135, 198, 0.2);
      transition: all 0.2s ease;
      margin-top: 10px;
    }

    .btn-login:hover {
      transform: translateY(-1px);
      box-shadow: 0 6px 15px rgba(25, 135, 198, 0.35);
      opacity: 0.95;
    }

    .btn-login:active {
      transform: translateY(1px);
    }

    /* Error alert styling */
    .alert-error {
      background-color: #fef2f2;
      border: 1px solid #fee2e2;
      color: #b91c1c;
      border-radius: 8px;
      padding: 12px 16px;
      font-size: 0.85rem;
      margin-bottom: 22px;
      display: flex;
      align-items: center;
      gap: 10px;
      animation: shake 0.4s ease-in-out;
    }

    @keyframes shake {
      0%, 100% { transform: translateX(0); }
      25% { transform: translateX(-4px); }
      75% { transform: translateX(4px); }
    }

    .footer-note {
      text-align: center;
      margin-top: 25px;
      font-size: 0.75rem;
      color: rgba(255, 255, 255, 0.6);
    }
  </style>
</head>
<body>

  <div class="login-container">
    <div class="login-card">
      <div class="login-header">
        <img class="login-logo" src="cdo-dashboard/Indian_Railways.svg" alt="Indian Railways Logo">
        <h1 class="login-title">MCC Portal</h1>
        <p class="login-subtitle">Coaching Depot Officer Login</p>
      </div>

      <?php if (!empty($error)): ?>
        <div class="alert-error">
          <i class="bi bi-exclamation-triangle-fill"></i>
          <div><?php echo htmlspecialchars($error); ?></div>
        </div>
      <?php endif; ?>

      <form action="index.php" method="POST" autocomplete="off">
        <div class="form-group">
          <label for="username" class="form-label">Username</label>
          <div class="input-group">
            <input type="text" id="username" name="username" class="form-control" placeholder="Enter username" required value="<?php echo htmlspecialchars($username ?? ''); ?>">
            <i class="bi bi-person-fill input-group-icon"></i>
          </div>
        </div>

        <div class="form-group">
          <label for="password" class="form-label">Password</label>
          <div class="input-group">
            <input type="password" id="password" name="password" class="form-control" placeholder="Enter password" required>
            <i class="bi bi-lock-fill input-group-icon"></i>
            <i class="bi bi-eye-slash password-toggle" id="togglePassword"></i>
          </div>
        </div>

        <button type="submit" class="btn-login">
          <span>Sign In</span>
          <i class="bi bi-arrow-right"></i>
        </button>
      </form>
    </div>
    
    <div class="footer-note">
      &copy; <?php echo date('Y'); ?> Indian Railways | Mechanized Cleaning Coaching (MCC) Portal
    </div>
  </div>

  <script>
    // Toggle Password Visibility
    const togglePassword = document.querySelector('#togglePassword');
    const passwordInput = document.querySelector('#password');

    togglePassword.addEventListener('click', function () {
      // Toggle type attribute
      const type = passwordInput.getAttribute('type') === 'password' ? 'text' : 'password';
      passwordInput.setAttribute('type', type);
      
      // Toggle icon
      this.classList.toggle('bi-eye');
      this.classList.toggle('bi-eye-slash');
    });

    // Add submit loader animation
    const form = document.querySelector('form');
    const submitBtn = document.querySelector('.btn-login');

    form.addEventListener('submit', function() {
      submitBtn.innerHTML = `
        <span class="spinner-border spinner-border-sm" role="status" aria-hidden="true"></span>
        <span>Signing In...</span>
      `;
      submitBtn.style.pointerEvents = 'none';
      submitBtn.style.opacity = '0.85';
    });
  </script>
</body>
</html>