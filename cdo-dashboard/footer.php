<?php if (basename($_SERVER['PHP_SELF']) !== 'index.php'): ?>
<footer class="app-footer text-center py-4 mt-auto" style="background: linear-gradient(180deg, #07182c 0%, #03101e 100%); border-top: 1px solid #0b476a; color: #8aa3b9;">
  <div class="container-fluid">
    <div class="row align-items-center">
      <div class="col-md-6 text-md-start">
        <p class="mb-0 small" style="color: #8aa3b9;">
          &copy; <?php echo date('Y'); ?> <strong style="color: #f4f8fc;">MCC Dashboard</strong>. All rights reserved.
        </p>
      </div>
      <div class="col-md-6 text-md-end">
        <div class="footer-links">
          <a href="#" class="text-decoration-none small mx-2" style="color: #8aa3b9;">Support</a>
          <a href="#" class="text-decoration-none small mx-2" style="color: #8aa3b9;">Privacy Policy</a>
          <a href="#" class="text-decoration-none small mx-2" style="color: #8aa3b9;">Terms of Service</a>
        </div>
      </div>
    </div>
  </div>
</footer>
<?php endif; ?>

    </div> <!-- Closing app-wrapper -->

    <script
      src="https://cdn.jsdelivr.net/npm/overlayscrollbars@2.10.1/browser/overlayscrollbars.browser.es6.min.js"
      integrity="sha256-dghWARbRe2eLlIJ56wNB+b760ywulqK3DzZYEpsg2fQ="
      crossorigin="anonymous"></script>
    <script
      src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.8/dist/umd/popper.min.js"
      integrity="sha384-I7E8VVD/ismYTF4hNIPjVp/Zjvgyol6VFvRkX/vR+Vc4jQkC+hVqc2pM8ODewa9r"
      crossorigin="anonymous"></script>
    <script
      src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.min.js"
      integrity="sha384-0pUGZvbkm6XF6gxjEnlmuGrJXVbNuzT9qBBavbLwCsOGabYfZo0T0to5eqruptLy"
      crossorigin="anonymous"></script>
    <script
      src="https://cdn.jsdelivr.net/npm/admin-lte@4.0.0-beta3/dist/js/adminlte.js"></script>
    <!-- Flatpickr JS -->
    <script src="https://cdn.jsdelivr.net/npm/flatpickr"></script>

    <script>
    document.addEventListener('DOMContentLoaded', function() {
        if (typeof flatpickr !== 'undefined') {
            flatpickr('input[type="date"]', {
                dateFormat: "Y-m-d",
                altInput: true,
                altFormat: "d-m-Y",
                allowInput: true
            });
        }
    });

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

    // Auto-active Sidebar Links
    document.addEventListener("DOMContentLoaded", function() {
        const currentPath = window.location.pathname.split("/").pop();
        const navLinks = document.querySelectorAll(".nav-sidebar .nav-link");
        
        navLinks.forEach(link => {
            const href = link.getAttribute("href");
            if (href === currentPath || (currentPath === "" && href === "./index.php")) {
                link.classList.add("active");
                // Open parent treeview if any
                const parentTree = link.closest(".nav-treeview");
                if (parentTree) {
                    parentTree.style.display = "block";
                    parentTree.closest(".nav-item").classList.add("menu-open");
                    parentTree.closest(".nav-item").querySelector(".nav-link").classList.add("active");
                }
            } else {
                link.classList.remove("active");
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

