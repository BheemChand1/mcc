<?php
declare(strict_types=1);
require __DIR__ . '/src/bootstrap.php';
if (!$inventoryAuthenticated) {
    header('Location: ../index.php');
    exit;
}
$escape = static fn (string $text): string => htmlspecialchars($text, ENT_QUOTES, 'UTF-8');
?>
<!doctype html>
<html lang="en" data-theme="dark">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="csrf-token" content="<?= $escape($_SESSION['inventory_csrf']) ?>">
    <meta name="inventory-write" content="<?= $inventoryCanWrite ? '1' : '0' ?>">
    <title>Inventory Management | MCC</title>
    <link rel="icon" href="assets/railway-logo.svg" type="image/svg+xml">
    <link rel="stylesheet" href="assets/styles.css">
    <script src="assets/app.js" defer></script>
</head>
<body>
<svg class="icon-library" xmlns="http://www.w3.org/2000/svg" aria-hidden="true">
    <symbol id="i-grid" viewBox="0 0 24 24"><rect x="3" y="3" width="7" height="7" rx="1.5"/><rect x="14" y="3" width="7" height="7" rx="1.5"/><rect x="3" y="14" width="7" height="7" rx="1.5"/><rect x="14" y="14" width="7" height="7" rx="1.5"/></symbol>
    <symbol id="i-book" viewBox="0 0 24 24"><path d="M5 3h14v18H5a2 2 0 0 1-2-2V5a2 2 0 0 1 2-2ZM7 3v18M11 8h4M11 12h4"/></symbol>
    <symbol id="i-box" viewBox="0 0 24 24"><path d="m12 3 9 5v9l-9 5-9-5V8l9-5Zm0 10 9-5M3 8l9 5v9M7.5 5.5l9 5"/></symbol>
    <symbol id="i-flask" viewBox="0 0 24 24"><path d="M9 3h6M10 3v6L4.5 18a2 2 0 0 0 1.7 3h11.6a2 2 0 0 0 1.7-3L14 9V3M7 14h10"/></symbol>
    <symbol id="i-plus" viewBox="0 0 24 24"><path d="M12 5v14M5 12h14"/></symbol>
    <symbol id="i-arrow" viewBox="0 0 24 24"><path d="M5 12h14m-6-6 6 6-6 6"/></symbol>
    <symbol id="i-download" viewBox="0 0 24 24"><path d="M12 3v12m-5-5 5 5 5-5M4 16v5h16v-5"/></symbol>
    <symbol id="i-print" viewBox="0 0 24 24"><path d="M7 8V3h10v5M7 17H3V9h18v8h-4M7 14h10v7H7zM17 11h1"/></symbol>
    <symbol id="i-search" viewBox="0 0 24 24"><circle cx="10.5" cy="10.5" r="6.5"/><path d="m16 16 5 5"/></symbol>
    <symbol id="i-calendar" viewBox="0 0 24 24"><rect x="3" y="5" width="18" height="16" rx="2"/><path d="M7 3v4M17 3v4M3 11h18M7 15h2M13 15h2"/></symbol>
    <symbol id="i-check" viewBox="0 0 24 24"><path d="m5 12 4 4L19 6"/><circle cx="12" cy="12" r="10"/></symbol>
    <symbol id="i-alert" viewBox="0 0 24 24"><path d="m12 3 10 18H2L12 3ZM12 9v5M12 17v.2"/></symbol>
    <symbol id="i-clock" viewBox="0 0 24 24"><circle cx="12" cy="12" r="9"/><path d="M12 7v6l4 2"/></symbol>
    <symbol id="i-edit" viewBox="0 0 24 24"><path d="m16 3 5 5-12 12-6 1 1-6L16 3ZM13 6l5 5"/></symbol>
    <symbol id="i-sun" viewBox="0 0 24 24"><circle cx="12" cy="12" r="4"/><path d="M12 2v2M12 20v2M2 12h2M20 12h2M5 5l1 1M18 18l1 1M5 19l1-1M18 6l1-1"/></symbol>
    <symbol id="i-menu" viewBox="0 0 24 24"><path d="M4 6h16M4 12h16M4 18h16"/></symbol>
    <symbol id="i-info" viewBox="0 0 24 24"><circle cx="12" cy="12" r="9"/><path d="M12 11v6M12 7v.2"/></symbol>
    <symbol id="i-close" viewBox="0 0 24 24"><path d="m6 6 12 12M6 18 18 6"/></symbol>
</svg>
<aside class="sidebar" id="sidebar">
    <a class="brand" href="#register" aria-label="MCC Inventory home">
        <img src="assets/railway-logo.svg" alt="Indian Railways" width="46" height="46">
        <span><strong>MCC</strong><small>OPERATIONS PORTAL</small></span>
    </a>
    <div class="workspace"><span class="workspace-icon"><svg><use href="#i-box"/></svg></span><div><strong>Inventory</strong><small>Materials &amp; chemicals</small></div><span class="workspace-dot"></span></div>
    <div class="nav-label">WORKSPACE</div>
    <nav aria-label="Inventory navigation">
        <a href="#register" class="nav-item active" data-view="register" aria-current="page"><svg><use href="#i-book"/></svg>Daily register<span class="nav-arrow">›</span></a>
        <a href="#materials" class="nav-item" data-view="materials"><svg><use href="#i-flask"/></svg>Material master<span class="nav-count" id="navCount">—</span></a>
        <a href="#overview" class="nav-item" data-view="overview"><svg><use href="#i-grid"/></svg>Stock overview</a>
    </nav>
    <div class="sidebar-note"><span class="eyebrow">EVERY DROP ACCOUNTED FOR</span><p>A clear record of what comes in, what gets used, and what remains.</p><span class="note-line"></span></div>
    <div class="sidebar-bottom"><span class="avatar">M</span><div><strong><?= $escape((string) ($_SESSION['user_name'] ?? $_SESSION['username'] ?? 'Local operator')) ?></strong><small><?= $inventoryCanWrite ? 'Inventory management' : 'Read-only access' ?></small></div></div>
</aside>
<div class="sidebar-scrim" id="sidebarScrim" hidden></div>
<div class="app-main">
    <header class="topbar">
        <div class="topbar-left"><button class="icon-button menu-button" id="menuToggle" aria-label="Open navigation" aria-expanded="false" aria-controls="sidebar"><svg><use href="#i-menu"/></svg></button><span class="breadcrumb">Operations <span>/</span> <strong>Inventory</strong></span></div>
        <div class="topbar-right"><span class="station"><span class="live-dot"></span><?= $escape($inventoryStationName) ?></span><span class="top-separator"></span><button class="icon-button" id="helpButton" aria-label="How to use inventory"><svg><use href="#i-info"/></svg></button><button class="icon-button" id="themeToggle" aria-label="Toggle light or dark theme"><svg><use href="#i-sun"/></svg></button></div>
    </header>
    <main class="content">
        <div class="page-heading"><div><div class="eyebrow accent">MATERIALS &amp; CHEMICALS</div><h1>Inventory management</h1><p>Keep your stores in balance. One day at a time.</p></div><div class="heading-actions"><span class="today-label" id="todayLabel"></span><?php if ($inventoryCanWrite): ?><button class="button button-primary" id="addMaterial"><svg><use href="#i-plus"/></svg>Add material</button><?php endif; ?></div></div>
        <div class="error-banner" id="pageError" role="alert" hidden><span id="pageErrorText"></span><button class="button button-small" id="retryButton">Retry</button></div>
        <noscript><div class="error-banner">Enable JavaScript to view and update the inventory register.</div></noscript>
        <!--
        <section class="stats-grid" aria-label="Inventory at a glance">
            <article class="stat-card"><div class="stat-label">Total materials <span class="stat-icon cyan"><svg><use href="#i-box"/></svg></span></div><div class="stat-value" id="totalMaterials">—</div><div class="stat-caption" id="categoryCount">Loading your material catalogue</div></article>
            <article class="stat-card"><div class="stat-label">Updated today <span class="stat-icon green"><svg><use href="#i-check"/></svg></span></div><div class="stat-value" id="updatedToday">—</div><div class="stat-caption">Materials with a daily entry</div></article>
            <article class="stat-card"><div class="stat-label">Low stock <span class="stat-icon amber"><svg><use href="#i-alert"/></svg></span></div><div class="stat-value" id="lowStock">—</div><div class="stat-caption">At or below minimum stock</div></article>
            <article class="stat-card"><div class="stat-label">Opening stock pending <span class="stat-icon purple"><svg><use href="#i-clock"/></svg></span></div><div class="stat-value" id="pendingStock">—</div><div class="stat-caption">Set a balance to start recording</div></article>
        </section>
        -->

        <section id="registerView" class="view">
            <div class="section-heading"><div><h2><svg><use href="#i-book"/></svg>Daily stock register</h2><p>Your material ledger, with balances carried forward automatically.</p></div><div class="button-group"><button class="button button-quiet" id="exportRegister" disabled><svg><use href="#i-download"/></svg>Export CSV</button><button class="button button-quiet" id="printRegister" disabled><svg><use href="#i-print"/></svg>Print</button></div></div>
            <div class="panel">
                <div class="register-filters"><label class="material-picker">Select material<select id="materialSelect" disabled><option>Loading materials…</option></select></label><label class="month-picker">Register month<input type="month" id="monthSelect" min="2000-01"></label><?php if ($inventoryCanWrite): ?><button class="button button-primary" id="addEntry" disabled><svg><use href="#i-plus"/></svg>Add daily entry</button><?php endif; ?></div>
                <div id="registerLoading" class="loading-state" role="status">Loading your stock register…</div>
                <div id="registerContent" hidden>
                    <div class="material-heading"><div class="material-title"><span class="material-symbol"><svg><use href="#i-flask"/></svg></span><div><div class="material-meta"><span id="materialCode"></span><span class="dot-separator">·</span><span id="materialCategory"></span></div><h3 id="registerMaterialName"></h3></div></div><div class="material-stock"><span id="materialStatus" class="badge"></span><small>Current stock <strong id="currentStock"></strong></small></div></div>
                    <div class="setup-banner" id="setupBanner" hidden><svg><use href="#i-info"/></svg><div><strong>Start with your opening stock</strong><p>Enter the quantity on hand and its date to begin this material’s register.</p></div><?php if ($inventoryCanWrite): ?><button class="button button-small" id="setupStock">Set opening stock <span>→</span></button><?php endif; ?></div>
                    <div class="month-summary"><div><span>Opening balance</span><strong id="monthOpening">—</strong></div><div><span><i class="movement-dot amber-bg"></i>Used this month</span><strong id="monthUsed" class="amber">—</strong></div><div><span><i class="movement-dot green-bg"></i>Received this month</span><strong id="monthReceived" class="green">—</strong></div><div><span>Closing balance</span><strong id="monthClosing" class="cyan">—</strong></div></div>
                    <div class="ledger-caption"><span id="registerMonthLabel"></span><span><i class="live-dot"></i><span id="entryCount"></span></span></div>
                    <div class="table-scroll ledger-scroll" tabindex="0" aria-label="Daily stock register table"><table class="ledger-table"><caption class="sr-only">Daily material register with opening, used, received, closing and sign-off names</caption><thead><tr><th scope="col">Date</th><th scope="col" class="numeric">Opening balance</th><th scope="col" class="numeric">Used</th><th scope="col" class="numeric">Received</th><th scope="col" class="numeric closing-col">Closing balance</th><th scope="col">Supervisor sign-off</th><th scope="col">JE / SSE</th><th scope="col" class="action-col"><span class="sr-only">Actions</span></th></tr></thead><tbody id="ledgerBody"></tbody><tfoot id="ledgerFoot"></tfoot></table></div>
                    <div class="register-footer"><span><svg><use href="#i-info"/></svg>Closing balance = Opening balance − Used + Received</span><span id="registerUnitNote"></span></div>
                </div>
            </div>
            <div class="below-register"><span><svg><use href="#i-check"/></svg>Every saved entry is stored with a change history.</span><span>Sign-off fields record names / initials.</span></div>
        </section>

        <section id="materialsView" class="view" hidden>
            <div class="section-heading"><div><h2><svg><use href="#i-flask"/></svg>Material master</h2><p>Manage your chemicals, equipment, units, and opening balances.</p></div><div class="button-group"><button class="button button-quiet" id="exportMaterials"><svg><use href="#i-download"/></svg>Export CSV</button><button class="button button-quiet" id="printMaterials"><svg><use href="#i-print"/></svg>Print</button></div></div>
            <div class="panel"><div class="list-filters"><label class="search-field"><svg><use href="#i-search"/></svg><input type="search" id="materialSearch" placeholder="Search material name or reference no." aria-label="Search materials"></label><select id="categoryFilter" aria-label="Filter by category"><option value="all">All categories</option><option>Chemical</option><option>Equipment</option><option>Consumable</option></select><span class="results-count" id="materialResults"></span></div><div class="table-scroll" tabindex="0" aria-label="Material master table"><table class="master-table"><thead><tr><!-- <th scope="col">Ref.</th> --><th scope="col">Material name</th><th scope="col">Category</th><th scope="col">Unit</th><th scope="col" class="numeric">Current stock</th><th scope="col" class="numeric">Minimum stock</th><th scope="col">Status</th><th scope="col">Actions</th></tr></thead><tbody id="materialsBody"></tbody></table></div><div class="list-footer">Units are suggested from your reference list. Confirm each unit when setting opening stock.</div></div>
        </section>

        <section id="overviewView" class="view" hidden>
            <div class="section-heading"><div><h2><svg><use href="#i-grid"/></svg>Stock overview</h2><p>See what is available and which materials need attention.</p></div><div class="button-group"><button class="button button-quiet" id="exportOverview"><svg><use href="#i-download"/></svg>Export CSV</button><button class="button button-quiet" id="printOverview"><svg><use href="#i-print"/></svg>Print</button></div></div>
            <div class="panel"><div class="list-filters"><div class="filter-tabs" aria-label="Filter by stock status"><button class="filter-tab active" data-stock="all" aria-pressed="true">All materials</button><button class="filter-tab" data-stock="low" aria-pressed="false">Low stock</button><button class="filter-tab" data-stock="pending" aria-pressed="false">Opening pending</button><button class="filter-tab" data-stock="ready" aria-pressed="false">In stock</button></div><span id="overviewResults" class="results-count"></span></div><div class="table-scroll" tabindex="0" aria-label="Stock overview table"><table class="master-table"><thead><tr><th scope="col">Material</th><th scope="col" class="numeric">Available quantity</th><th scope="col">Status</th><th scope="col">Last entry</th><th scope="col">Today’s register</th><th scope="col">Action</th></tr></thead><tbody id="overviewBody"></tbody></table></div></div>
        </section>
        <footer class="app-footer"><span>MCC <span> / </span> Inventory management</span><span id="syncStatus" role="status">Connecting to your inventory…</span></footer>
    </main>
</div>

<dialog id="materialDialog" class="form-dialog" aria-labelledby="materialDialogTitle">
    <form id="materialForm">
        <div class="dialog-header"><div><span class="eyebrow accent">MATERIAL MASTER</span><h2 id="materialDialogTitle">Add material</h2></div><button type="button" class="icon-button" data-close="materialDialog" aria-label="Close material form"><svg><use href="#i-close"/></svg></button></div>
        <div class="dialog-body"><p class="dialog-description" id="materialDialogDescription">Add a material and set its starting stock.</p><div class="form-error" id="materialError" role="alert" hidden></div>
            <label>Material name <span class="required">*</span><input name="name" maxlength="180" required placeholder="e.g. Heavy Duty Exterior Washing Liquid" autocomplete="off"></label>
            <div class="form-grid"><label>Category <span class="required">*</span><select name="category"><option>Chemical</option><option>Equipment</option><option>Consumable</option></select></label><label>Stock unit <span class="required">*</span><select name="unit"><option value="L">Litres (L)</option><option value="mL">Millilitres (mL)</option><option value="kg">Kilograms (kg)</option><option value="g">Grams (g)</option><option value="pcs">Pieces (pcs)</option><option value="rolls">Rolls</option><option value="sets">Sets</option></select></label></div>
            <div class="form-divider"><span>Opening stock</span></div>
            <div class="form-grid"><label>Opening quantity<input name="opening_quantity" type="number" min="0" max="999999999.999" step="0.001" value="0" required inputmode="decimal"></label><label>Opening stock date<input name="opening_date" type="date" min="2000-01-01"></label></div>
            <p class="field-hint" id="openingHint">Choose the date this stock was available. Leave the date blank to set up stock later.</p>
            <label>Low stock threshold<input name="minimum_quantity" type="number" min="0" max="999999999.999" step="0.001" value="0" required inputmode="decimal"></label><p class="field-hint">A material is flagged when its available quantity reaches this level.</p>
        </div><div class="dialog-footer"><button type="button" class="button" data-close="materialDialog">Cancel</button><button type="submit" class="button button-primary">Save material</button></div>
    </form>
</dialog>

<dialog id="entryDialog" class="form-dialog" aria-labelledby="entryDialogTitle">
    <form id="entryForm">
        <div class="dialog-header"><div><span class="eyebrow accent">DAILY STOCK REGISTER</span><h2 id="entryDialogTitle">Add daily entry</h2></div><button type="button" class="icon-button" data-close="entryDialog" aria-label="Close daily entry form"><svg><use href="#i-close"/></svg></button></div>
        <div class="dialog-body"><div class="entry-material"><svg><use href="#i-flask"/></svg><strong id="entryMaterialName"></strong><span class="badge cyan-badge" id="entryUnit"></span></div><div class="form-error" id="entryError" role="alert" hidden></div>
            <label>Entry date <span class="required">*</span><input name="entry_date" type="date" required min="2000-01-01"></label>
            <div class="balance-preview"><span>Opening balance for this date</span><strong id="entryOpening">—</strong></div>
            <div class="form-grid"><label>Quantity used <span class="required">*</span><input name="used_quantity" type="number" min="0" max="999999999.999" step="0.001" value="0" required inputmode="decimal"></label><label>Quantity received <span class="required">*</span><input name="received_quantity" type="number" min="0" max="999999999.999" step="0.001" value="0" required inputmode="decimal"></label></div>
            <div class="closing-preview"><span>Calculated closing balance</span><output id="entryClosing">—</output></div><p class="field-hint">The next entry carries this balance forward. You can record zero usage.</p>
            <div class="form-grid"><label>Supervisor name / initials <span class="required">*</span><input name="supervisor" maxlength="100" required placeholder="Supervisor sign-off"></label><label>JE / SSE name / initials<input name="je_sse" maxlength="100" placeholder="Optional sign-off"></label></div>
            <label>Notes <span class="optional">(optional)</span><textarea name="notes" maxlength="1000" rows="2" placeholder="Receipt reference or a note about today’s usage"></textarea></label>
        </div><div class="dialog-footer"><button type="button" class="button" data-close="entryDialog">Cancel</button><button type="submit" class="button button-primary">Save daily entry</button></div>
    </form>
</dialog>

<dialog id="helpDialog" class="form-dialog" aria-labelledby="helpTitle"><div class="dialog-header"><h2 id="helpTitle">Your digital stock register</h2><button type="button" class="icon-button" data-close="helpDialog" aria-label="Close help"><svg><use href="#i-close"/></svg></button></div><div class="dialog-body help-content"><ol><li><strong>Set up a material.</strong> The 35 materials from your reference list are ready in Material master. Confirm the unit, opening quantity, and the date that stock was available.</li><li><strong>Record each day.</strong> Select a material, then add the quantities used and received, plus the supervisor’s name or initials. JE/SSE sign-off is optional.</li><li><strong>Balances update automatically.</strong> Closing = opening − used + received. The next entry starts with the previous closing balance, even across months.</li><li><strong>Correct an entry.</strong> Use the edit button on a saved row. Later balances recalculate, and changes that would create negative stock are rejected. Changes are recorded in the database audit history.</li><li><strong>Share the register.</strong> Select a month and export a CSV, or print the register with blank rows for unrecorded days.</li></ol><p>Only one entry per material per date is allowed. Blank dates have no saved entry. Unit and opening stock are locked after the first entry; add subsequent receipts through the daily register.</p><p>Supervisor and JE/SSE fields store typed names or initials; they are not verified electronic signatures.</p></div><div class="dialog-footer"><button class="button button-primary" data-close="helpDialog">Got it</button></div></dialog>
<div class="toast" id="toast" role="status" hidden><svg><use href="#i-check"/></svg><span></span></div>
</body>
</html>
