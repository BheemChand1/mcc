<?php
/**
 * MCC - Admin Panel Login Portal
 * Handles administrator authentication and directs to the Admin Dashboard.
 */
session_name('MCC_ADMIN_SESS');
session_start();

// If admin is already logged in, redirect to admin dashboard
if (isset($_SESSION['user_id']) && $_SESSION['role'] === 'ADMIN') {
    header("Location: index.php");
    exit();
}

$error = '';
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    require_once '../connection.php';
    
    $username = trim($_POST['username'] ?? '');
    $password = $_POST['password'] ?? '';
    
    if (empty($username) || empty($password)) {
        $error = 'Please fill in all fields.';
    } else {
        try {
            // Retrieve active administrator
            $stmt = $pdo->prepare("SELECT * FROM mcc_users WHERE username = :username LIMIT 1");
            $stmt->execute(['username' => $username]);
            $user = $stmt->fetch();
            
            if ($user) {
                if ($user['status'] === 'Active') {
                    // Check if role is ADMIN
                    if ($user['role'] === 'ADMIN') {
                        // Verify the password using bcrypt
                        if (password_verify($password, $user['password_hash'])) {
                            // Store variables in session
                            $_SESSION['user_id'] = $user['user_id'];
                            $_SESSION['username'] = $user['username'];
                            $_SESSION['user_name'] = $user['user_name'];
                            $_SESSION['role'] = $user['role'];
                            $_SESSION['station_id'] = $user['station_id'];
                            
                            // Redirect to Admin Dashboard
                            header("Location: index.php");
                            exit();
                        } else {
                            $error = 'Invalid password. Please try again.';
                        }
                    } else {
                        $error = 'Access denied. Administrator privileges required.';
                    }
                } else {
                    $error = 'Your account is inactive. Please contact system support.';
                }
            } else {
                $error = 'Username not found.';
            }
        } catch (PDOException $e) {
            $error = 'System error: ' . $e->getMessage();
        }
    }
}
?>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>MCC Admin Portal | Login</title>
  
  <!-- Fonts & Icons -->
  <link href="https://fonts.googleapis.com/css2?family=Outfit:wght@300;400;500;600;700;800&display=swap" rel="stylesheet">
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css" />
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" />
  
  <style>
    :root {
      --primary-cyan: #06b6d4;
      --primary-blue: #3b82f6;
      --bg-dark: #090d16;
      --card-bg: rgba(17, 25, 40, 0.75);
      --border-color: rgba(255, 255, 255, 0.125);
    }

    body {
      font-family: 'Outfit', sans-serif;
      background: radial-gradient(circle at 0% 0%, #1e1b4b 0%, var(--bg-dark) 50%, #0f172a 100%);
      min-height: 100vh;
      display: flex;
      align-items: center;
      justify-content: center;
      margin: 0;
      padding: 20px;
      overflow-x: hidden;
      position: relative;
    }

    /* Ambient background lights */
    .bg-glow-1 {
      position: absolute;
      width: 500px;
      height: 500px;
      background: radial-gradient(circle, rgba(59, 130, 246, 0.15) 0%, transparent 70%);
      top: -100px;
      left: -100px;
      z-index: 0;
    }
    
    .bg-glow-2 {
      position: absolute;
      width: 600px;
      height: 600px;
      background: radial-gradient(circle, rgba(6, 182, 212, 0.1) 0%, transparent 75%);
      bottom: -150px;
      right: -150px;
      z-index: 0;
    }

    .login-container {
      width: 100%;
      max-width: 440px;
      z-index: 10;
      position: relative;
    }

    .login-card {
      background: var(--card-bg);
      backdrop-filter: blur(20px);
      -webkit-backdrop-filter: blur(20px);
      border: 1px solid var(--border-color);
      border-radius: 24px;
      padding: 45px 35px;
      box-shadow: 0 20px 50px rgba(0, 0, 0, 0.4);
      transition: all 0.4s cubic-bezier(0.165, 0.84, 0.44, 1);
    }

    .login-card:hover {
      border-color: rgba(6, 182, 212, 0.3);
      box-shadow: 0 25px 60px rgba(6, 182, 212, 0.15);
      transform: translateY(-4px);
    }

    .login-header {
      text-align: center;
      margin-bottom: 35px;
    }

    .login-logo {
      height: 85px;
      width: auto;
      margin-bottom: 20px;
      filter: drop-shadow(0 0 15px rgba(59, 130, 246, 0.5));
      animation: pulse 3s infinite alternate;
    }

    @keyframes pulse {
      0% { transform: scale(1); filter: drop-shadow(0 0 10px rgba(59, 130, 246, 0.4)); }
      100% { transform: scale(1.04); filter: drop-shadow(0 0 20px rgba(6, 182, 212, 0.6)); }
    }

    .login-title {
      font-size: 1.75rem;
      font-weight: 800;
      color: #ffffff;
      margin: 0;
      letter-spacing: 0.5px;
      background: linear-gradient(135deg, #ffffff 30%, #94a3b8 100%);
      -webkit-background-clip: text;
      -webkit-text-fill-color: transparent;
    }

    .login-subtitle {
      font-size: 0.9rem;
      color: #94a3b8;
      margin-top: 6px;
      font-weight: 400;
    }

    /* Form Fields */
    .form-group {
      margin-bottom: 22px;
      position: relative;
    }

    .form-label {
      font-size: 0.85rem;
      font-weight: 600;
      color: #cbd5e1;
      margin-bottom: 8px;
      display: block;
      letter-spacing: 0.5px;
      text-transform: uppercase;
    }

    .input-wrapper {
      position: relative;
    }

    .input-icon {
      position: absolute;
      left: 16px;
      top: 50%;
      transform: translateY(-50%);
      color: #64748b;
      font-size: 1.1rem;
      transition: color 0.3s ease;
    }

    .form-control {
      background: rgba(15, 23, 42, 0.6);
      border: 1px solid rgba(255, 255, 255, 0.08);
      border-radius: 12px;
      color: #ffffff;
      padding: 12px 16px 12px 46px;
      font-size: 0.95rem;
      font-weight: 400;
      transition: all 0.3s ease;
      box-shadow: inset 0 2px 4px rgba(0, 0, 0, 0.2);
    }

    .form-control:focus {
      background: rgba(15, 23, 42, 0.8);
      border-color: var(--primary-cyan);
      box-shadow: 0 0 0 4px rgba(6, 182, 212, 0.15);
      color: #ffffff;
    }

    .form-control:focus + .input-icon {
      color: var(--primary-cyan);
    }

    /* Button */
    .btn-login {
      background: linear-gradient(135deg, var(--primary-blue) 0%, var(--primary-cyan) 100%);
      border: none;
      border-radius: 12px;
      color: #ffffff;
      font-weight: 700;
      font-size: 1rem;
      padding: 14px;
      width: 100%;
      transition: all 0.3s ease;
      box-shadow: 0 4px 15px rgba(59, 130, 246, 0.3);
      position: relative;
      overflow: hidden;
    }

    .btn-login:hover {
      box-shadow: 0 6px 20px rgba(6, 182, 212, 0.4);
      transform: translateY(-1px);
    }

    .btn-login:active {
      transform: translateY(1px);
    }

    .btn-login::after {
      content: '';
      position: absolute;
      top: 0;
      left: -50%;
      width: 200%;
      height: 100%;
      background: linear-gradient(to right, transparent, rgba(255, 255, 255, 0.15), transparent);
      transform: skewX(-25deg);
      transition: 0.75s;
    }

    .btn-login:hover::after {
      left: 125%;
    }

    /* Alert */
    .alert-custom {
      background: rgba(239, 68, 68, 0.15);
      border: 1px solid rgba(239, 68, 68, 0.3);
      color: #fca5a5;
      border-radius: 12px;
      padding: 12px 16px;
      margin-bottom: 25px;
      font-size: 0.88rem;
      display: flex;
      align-items: center;
      gap: 10px;
      animation: slideIn 0.3s ease-out;
    }

    @keyframes slideIn {
      from { transform: translateY(-10px); opacity: 0; }
      to { transform: translateY(0); opacity: 1; }
    }

    .back-to-home {
      display: block;
      text-align: center;
      margin-top: 25px;
      color: #64748b;
      text-decoration: none;
      font-size: 0.85rem;
      transition: color 0.2s ease;
    }

    .back-to-home:hover {
      color: #cbd5e1;
    }
  </style>
</head>
<body>

  <!-- Ambient Lights -->
  <div class="bg-glow-1"></div>
  <div class="bg-glow-2"></div>

  <div class="login-container">
    <div class="login-card">
      <div class="login-header">
        <img src="../cdo-dashboard/Indian_Railways.svg" alt="Indian Railways Logo" class="login-logo">
        <h1 class="login-title">MCC Admin Panel</h1>
        <p class="login-subtitle">Secure Administration System Login</p>
      </div>

      <?php if (!empty($error)): ?>
        <div class="alert-custom" role="alert">
          <i class="bi bi-exclamation-triangle-fill"></i>
          <div><?php echo htmlspecialchars($error); ?></div>
        </div>
      <?php endif; ?>

      <form action="login.php" method="POST" autocomplete="off">
        <div class="form-group">
          <label for="username" class="form-label">Username</label>
          <div class="input-wrapper">
            <input type="text" class="form-control" id="username" name="username" placeholder="Enter admin username" required autofocus>
            <i class="bi bi-person-fill input-icon"></i>
          </div>
        </div>

        <div class="form-group">
          <label for="password" class="form-label">Password</label>
          <div class="input-wrapper">
            <input type="password" class="form-control" id="password" name="password" placeholder="Enter security password" required>
            <i class="bi bi-lock-fill input-icon"></i>
          </div>
        </div>

        <button type="submit" class="btn btn-login mt-2">
          Secure Login &nbsp;<i class="bi bi-shield-lock-fill"></i>
        </button>
      </form>
      
      <a href="../index.php" class="back-to-home">
        <i class="bi bi-arrow-left"></i> Back to CDO Login Portal
      </a>
    </div>
  </div>

  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
