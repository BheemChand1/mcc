<?php
/**
 * MCC - Admin Panel Footer Template
 * Renders the page footer and pulls in essential javascript bundles.
 */
?>
<!-- Footer -->
<footer class="app-footer text-center py-4 mt-auto" style="border-top: 1px solid var(--admin-border); background-color: #ffffff;">
  <div class="container-fluid">
    <div class="row align-items-center">
      <div class="col-md-6 text-md-start">
        <p class="mb-0 text-muted small">
          &copy; <?php echo date('Y'); ?> <strong>MCC Admin Portal</strong>. All rights reserved.
        </p>
      </div>
      <div class="col-md-6 text-md-end">
        <div class="footer-links">
          <a href="#" class="text-muted text-decoration-none small mx-2">Help Center</a>
          <a href="#" class="text-muted text-decoration-none small mx-2">Security Guidelines</a>
        </div>
      </div>
    </div>
  </div>
</footer>

</div> <!-- Closing app-wrapper -->

<!-- Scripts -->
<script src="https://cdn.jsdelivr.net/npm/overlayscrollbars@2.10.1/browser/overlayscrollbars.browser.es6.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.8/dist/umd/popper.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/admin-lte@4.0.0-beta3/dist/js/adminlte.js"></script>

<script>
// Sidebar Scrollbar Customization
const SELECTOR_SIDEBAR_WRAPPER = '.sidebar-wrapper';
document.addEventListener('DOMContentLoaded', function () {
    const sidebarWrapper = document.querySelector(SELECTOR_SIDEBAR_WRAPPER);
    if (sidebarWrapper && typeof OverlayScrollbarsGlobal?.OverlayScrollbars !== 'undefined') {
        OverlayScrollbarsGlobal.OverlayScrollbars(sidebarWrapper, {
            scrollbars: {
                theme: 'os-theme-light',
                autoHide: 'leave',
                clickScroll: true,
            },
        });
    }
});

// Dynamic Active Link Highlighting
document.addEventListener("DOMContentLoaded", function() {
    const currentPath = window.location.pathname.split("/").pop();
    const navLinks = document.querySelectorAll(".nav-sidebar .nav-link");
    
    navLinks.forEach(link => {
        const href = link.getAttribute("href");
        if (href === currentPath || (currentPath === "" && href === "index.php")) {
            link.classList.add("active");
        } else {
            // Keep active state if explicitly defined, otherwise clear
            if(!link.classList.contains('bg-indigo')) {
               link.classList.remove("active");
            }
        }
    });
});
</script>

<?php if (isset($extraScripts)): ?>
<script>
  <?php echo $extraScripts; ?>
</script>
<?php endif; ?>

</body>
</html>
