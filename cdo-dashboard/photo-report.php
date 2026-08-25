<?php
require_once 'auth.php';

// Folder check
$uploadDir = __DIR__ . '/uploads';

// Date filters
$fromDate = $_GET['from_date'] ?? date('Y-m-d', strtotime('-6 days'));
$toDate = $_GET['to_date'] ?? date('Y-m-d');

$successMsg = '';
$errorMsg = '';



// Fetch all photo reports in the selected date range
$reportsStmt = $pdo->prepare("
    SELECT * FROM mcc_photo_report 
    WHERE station_id = :station_id AND report_date BETWEEN :from_date AND :to_date
    ORDER BY report_date DESC, id DESC
");
$reportsStmt->execute([
    'station_id' => $stationId,
    'from_date' => $fromDate,
    'to_date' => $toDate
]);
$reportsList = $reportsStmt->fetchAll();

$pageTitle = 'MCC | Photo Report (Before/After)';

$extraStyles = "
.photo-card {
    background: #ffffff !important;
    border: 1px solid #cbd5e1 !important;
    border-radius: 12px !important;
    overflow: hidden;
    box-shadow: 0 4px 6px -1px rgba(0,0,0,0.05) !important;
    transition: transform 0.2s ease, box-shadow 0.2s ease;
}
.photo-card:hover {
    box-shadow: 0 10px 15px -3px rgba(0,0,0,0.1) !important;
}
.report-img {
    height: 200px;
    object-fit: cover;
    width: 100%;
    border-radius: 8px;
    border: 1px solid #e2e8f0;
    transition: opacity 0.2s ease;
    cursor: zoom-in;
}
.report-img:hover {
    opacity: 0.9;
}
";

include 'header.php';
include 'sidebar.php';
?>

<main class="app-main">
  <!-- Content Body -->
  <div class="app-content py-4">
    <div class="container-fluid">
      
      <!-- Compact Meta Information Banner -->
      <div class="mb-4 text-center no-print" style="font-size: 0.85rem; color: #475569; background: #f8fafc; border: 1px solid #e2e8f0; border-radius: 8px; padding: 8px 16px;">
        <span class="me-4"><strong>Depot Station:</strong> <span class="text-primary fw-bold"><?= htmlspecialchars($stationName); ?></span></span>
        <span class="me-4"><strong>Division Name:</strong> <span class="text-dark fw-bold"><?= htmlspecialchars($divisionName); ?></span></span>
        <span class="me-4"><strong>Railway Zone:</strong> <span class="text-dark fw-bold"><?= htmlspecialchars($railwayName); ?></span></span>
        <span><strong>Contractor Agency:</strong> <span class="text-success fw-bold"><?= htmlspecialchars($contractorName); ?></span></span>
      </div>

      <!-- Messages -->
      <?php if (!empty($successMsg)): ?>
        <div class="alert alert-success alert-dismissible fade show rounded-3 shadow-sm mb-4" role="alert">
          <i class="bi bi-check-circle-fill me-2"></i>
          <?= htmlspecialchars($successMsg); ?>
          <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
        </div>
      <?php endif; ?>

      <?php if (!empty($errorMsg)): ?>
        <div class="alert alert-danger alert-dismissible fade show rounded-3 shadow-sm mb-4" role="alert">
          <i class="bi bi-exclamation-triangle-fill me-2"></i>
          <?= htmlspecialchars($errorMsg); ?>
          <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
        </div>
      <?php endif; ?>

      <!-- Filter Toolbar -->
      <div class="card shadow-sm border-0 mb-4 bg-white no-print">
        <div class="card-body p-3 col-md-6 mx-auto">
          <form method="GET" action="photo-report.php" class="row g-3 align-items-center justify-content-center">
            <div class="col-auto">
              <label for="from_date" class="form-label mb-0 fw-bold">From:</label>
            </div>
            <div class="col-auto">
              <input type="date" name="from_date" id="from_date" class="form-control form-control-sm" value="<?= htmlspecialchars($fromDate); ?>">
            </div>
            <div class="col-auto">
              <label for="to_date" class="form-label mb-0 fw-bold">To:</label>
            </div>
            <div class="col-auto">
              <input type="date" name="to_date" id="to_date" class="form-control form-control-sm" value="<?= htmlspecialchars($toDate); ?>">
            </div>
            <div class="col-auto">
              <button type="submit" class="btn btn-primary btn-sm px-3 fw-bold">Filter Range</button>
            </div>
          </form>
        </div>
      </div>

      <!-- Photo Reports List -->
      <div class="d-flex flex-column gap-4">
        <?php if (empty($reportsList)): ?>
          <div class="card border-0 shadow-sm bg-white p-5 text-center text-muted">
            <i class="bi bi-camera-fill fs-1 mb-3 text-secondary"></i>
            <h5>No photo reports found in this date range.</h5>
            <p class="small mb-0">Reports are uploaded through the mobile app. Select a different date range above.</p>
          </div>
        <?php else: ?>
          <?php foreach ($reportsList as $rep): ?>
            <div class="card photo-card border-0">
              <div class="card-header bg-white py-3 border-bottom d-flex align-items-center justify-content-between flex-wrap gap-2">
                <span class="fw-bold text-dark fs-6 d-flex align-items-center">
                  <i class="bi bi-calendar-event text-primary me-2"></i>
                  Report Date: <?= date('d-M-Y (l)', strtotime($rep['report_date'])); ?>
                  <span class="mx-2 text-muted">|</span>
                  <i class="bi bi-geo-alt-fill text-indigo me-1"></i>
                  Area: <span class="text-indigo ms-1"><?= htmlspecialchars($rep['area'] ?: 'Not Specified'); ?></span>
                </span>
              </div>
              <div class="card-body p-4">
                <div class="row g-4">
                  
                  <!-- Before Column -->
                  <div class="col-md-6 border-end">
                    <div class="text-danger fw-bold small mb-2 text-uppercase d-flex align-items-center">
                      <i class="bi bi-x-circle-fill me-1"></i> Before Cleaning
                    </div>
                    <?php if (!empty($rep['before_photo']) && file_exists($uploadDir . '/' . $rep['before_photo'])): ?>
                      <img src="uploads/<?= htmlspecialchars($rep['before_photo']); ?>" alt="Before cleaning image" class="report-img img-fluid shadow-sm">
                    <?php else: ?>
                      <div class="report-img bg-light border d-flex align-items-center justify-content-center text-muted small">
                        No before image uploaded or file missing.
                      </div>
                    <?php endif; ?>
                    <div class="mt-3 bg-light p-3 rounded border-start border-danger border-4 shadow-sm" style="font-size: 0.88rem; line-height: 1.6; letter-spacing: 0.2px;">
                      <span class="text-muted d-block fw-bold text-uppercase mb-1" style="font-size: 0.72rem; letter-spacing: 0.8px;">BEFORE REMARK</span>
                      <span class="text-dark fw-medium"><?= nl2br(htmlspecialchars($rep['before_remark'] ?: 'No remark recorded.')); ?></span>
                    </div>
                  </div>

                  <!-- After Column -->
                  <div class="col-md-6">
                    <div class="text-success fw-bold small mb-2 text-uppercase d-flex align-items-center">
                      <i class="bi bi-check-circle-fill me-1"></i> After Cleaning
                    </div>
                    <?php if (!empty($rep['after_photo']) && file_exists($uploadDir . '/' . $rep['after_photo'])): ?>
                      <img src="uploads/<?= htmlspecialchars($rep['after_photo']); ?>" alt="After cleaning image" class="report-img img-fluid shadow-sm">
                    <?php else: ?>
                      <div class="report-img bg-light border d-flex align-items-center justify-content-center text-muted small">
                        No after image uploaded or file missing.
                      </div>
                    <?php endif; ?>
                    <div class="mt-3 bg-light p-3 rounded border-start border-success border-4 shadow-sm" style="font-size: 0.88rem; line-height: 1.6; letter-spacing: 0.2px;">
                      <span class="text-muted d-block fw-bold text-uppercase mb-1" style="font-size: 0.72rem; letter-spacing: 0.8px;">AFTER REMARK</span>
                      <span class="text-dark fw-medium"><?= nl2br(htmlspecialchars($rep['after_remark'] ?: 'No remark recorded.')); ?></span>
                    </div>
                  </div>

                </div>
              </div>
            </div>
          <?php endforeach; ?>
        <?php endif; ?>
      </div>

    </div>
  </div>
</main>

<!-- Image Zoom Modal -->
<div class="modal fade" id="zoomModal" tabindex="-1" aria-hidden="true" style="backdrop-filter: blur(4px);">
  <div class="modal-dialog modal-dialog-centered modal-lg">
    <div class="modal-content bg-transparent border-0">
      <div class="modal-body text-center p-0 position-relative">
        <button type="button" class="btn-close btn-close-white position-absolute top-0 end-0 m-3" data-bs-dismiss="modal" aria-label="Close" style="z-index: 1050;"></button>
        <img id="zoomedImage" src="" class="img-fluid rounded shadow-lg" style="max-height: 85vh; width: auto;">
      </div>
    </div>
  </div>
</div>

<script>
document.addEventListener('DOMContentLoaded', function() {
  const images = document.querySelectorAll('.report-img');
  const modal = new bootstrap.Modal(document.getElementById('zoomModal'));
  const zoomedImg = document.getElementById('zoomedImage');

  images.forEach(img => {
    img.addEventListener('click', function() {
      zoomedImg.src = this.src;
      modal.show();
    });
  });
});
</script>

<?php
include 'footer.php';
?>
