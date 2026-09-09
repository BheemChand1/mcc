<?php
declare(strict_types=1);

require __DIR__ . '/src/bootstrap.php';
header('Content-Type: application/json; charset=utf-8');

function respond(array $data, int $status = 200): never
{
    http_response_code($status);
    echo json_encode($data, JSON_THROW_ON_ERROR | JSON_UNESCAPED_UNICODE);
    exit;
}

function positiveId(mixed $value): int
{
    if (!is_scalar($value) || !ctype_digit((string) $value) || (int) $value < 1) {
        throw new \Inventory\ValidationException('A valid record ID is required.');
    }
    return (int) $value;
}

try {
    if (!$inventoryAuthenticated) {
        respond(['error' => 'Please sign in to MCC to access inventory.'], 401);
    }
    $method = $_SERVER['REQUEST_METHOD'];
    if (!in_array($method, ['GET', 'POST', 'PUT'], true)) {
        header('Allow: GET, POST, PUT');
        respond(['error' => 'Method not supported.'], 405);
    }
    if ($method !== 'GET') {
        if (!$inventoryCanWrite) {
            respond(['error' => 'Your account has read-only access.'], 403);
        }
        $token = $_SERVER['HTTP_X_CSRF_TOKEN'] ?? '';
        if (!is_string($token) || !hash_equals($_SESSION['inventory_csrf'], $token)) {
            respond(['error' => 'Your session has changed. Reload the page before saving.'], 403);
        }
        if (!str_starts_with(strtolower($_SERVER['CONTENT_TYPE'] ?? ''), 'application/json')) {
            respond(['error' => 'Send the request as application/json.'], 415);
        }
        $body = file_get_contents('php://input', false, null, 0, 32769);
        if (strlen($body) > 32768) {
            respond(['error' => 'Request is too large.'], 413);
        }
        try {
            $input = json_decode($body, true, 32, JSON_THROW_ON_ERROR);
        } catch (\JsonException $e) {
            respond(['error' => 'The request contains invalid JSON.'], 400);
        }
        if (!is_array($input) || array_is_list($input)) {
            respond(['error' => 'Expected a JSON object.'], 400);
        }
    }
    session_write_close();
    $action = $_GET['action'] ?? 'materials';
    $service = inventoryService();
    if ($method === 'GET' && $action === 'materials') {
        respond(['materials' => $service->materials(), 'today' => date('Y-m-d'), 'can_write' => $inventoryCanWrite]);
    }
    if ($method === 'GET' && $action === 'export_materials') {
        $materials = $service->materials();
        $today = date('Y-m-d');
        header('Content-Type: text/csv; charset=utf-8');
        header('Content-Disposition: attachment; filename="inventory-material-master-' . $today . '.csv"');
        $out = fopen('php://output', 'w');
        fwrite($out, "\xEF\xBB\xBF");
        $safe = static fn (string $value): string => preg_match('/^[\s]*[=+@\-\t\r]/u', $value) ? "'" . $value : $value;
        $line = static function (array $values) use ($out): void { fputcsv($out, $values, ',', '"', '', "\r\n"); };
        $line(['MCC Material Master Catalog - ' . $today]);
        $line(['Ref No', 'Material name', 'Category', 'Unit', 'Opening quantity', 'Opening date', 'Current stock', 'Minimum stock', 'Status']);
        foreach ($materials as $mat) {
            $statusText = $mat['opening_date'] === null ? 'Opening stock pending' : ($mat['is_low_stock'] ? 'Low stock' : 'In stock');
            $line([
                '#' . $mat['catalog_number'],
                $safe($mat['name']),
                $mat['category'],
                $mat['unit'],
                $mat['opening_date'] !== null ? \Inventory\InventoryService::displayQuantity($mat['opening_qty']) : 'Unset',
                $mat['opening_date'] ?? 'Unset',
                \Inventory\InventoryService::displayQuantity($mat['current_qty']),
                \Inventory\InventoryService::displayQuantity($mat['minimum_qty']),
                $statusText
            ]);
        }
        fclose($out);
        exit;
    }
    if ($method === 'GET' && $action === 'export_overview') {
        $materials = $service->materials();
        $today = date('Y-m-d');
        header('Content-Type: text/csv; charset=utf-8');
        header('Content-Disposition: attachment; filename="inventory-stock-overview-' . $today . '.csv"');
        $out = fopen('php://output', 'w');
        fwrite($out, "\xEF\xBB\xBF");
        $safe = static fn (string $value): string => preg_match('/^[\s]*[=+@\-\t\r]/u', $value) ? "'" . $value : $value;
        $line = static function (array $values) use ($out): void { fputcsv($out, $values, ',', '"', '', "\r\n"); };
        $line(['MCC Stock Overview Report - ' . $today]);
        $line(['Material name', 'Category', 'Unit', 'Available quantity', 'Minimum stock', 'Stock status', 'Last entry date', 'Recorded today']);
        foreach ($materials as $mat) {
            $statusText = $mat['opening_date'] === null ? 'Opening stock pending' : ($mat['is_low_stock'] ? 'Low stock' : 'In stock');
            $line([
                $safe($mat['name']),
                $mat['category'],
                $mat['unit'],
                \Inventory\InventoryService::displayQuantity($mat['current_qty']),
                \Inventory\InventoryService::displayQuantity($mat['minimum_qty']),
                $statusText,
                $mat['last_entry_date'] ?? 'No entries',
                $mat['has_entry_today'] ? 'Yes' : 'No'
            ]);
        }
        fclose($out);
        exit;
    }
    if ($method === 'GET' && $action === 'daily_report') {
        $date = $_GET['date'] ?? date('Y-m-d');
        respond(['date' => $date, 'entries' => $service->dailyReport($date)]);
    }
    if ($method === 'GET' && ($action === 'register' || $action === 'export')) {
        $month = $_GET['month'] ?? date('Y-m');
        if (!is_string($month)) {
            throw new \Inventory\ValidationException('Choose a valid month.');
        }
        $register = $service->register(positiveId($_GET['material_id'] ?? null), $month);
        if ($action === 'register') {
            respond($register);
        }
        header('Content-Type: text/csv; charset=utf-8');
        header('Content-Disposition: attachment; filename="inventory-' . $register['material']['id'] . '-' . $month . '.csv"');
        $out = fopen('php://output', 'w');
        fwrite($out, "\xEF\xBB\xBF");
        // Spreadsheet formula injection protection for all user-entered text cells.
        $safe = static fn (string $value): string => preg_match('/^[\s]*[=+@\-\t\r]/u', $value) ? "'" . $value : $value;
        $line = static function (array $values) use ($out): void { fputcsv($out, $values, ',', '"', '', "\r\n"); };
        $line(['Material', $safe($register['material']['name']), 'Unit', $register['material']['unit'], 'Month', $month]);
        $line(['Date', 'Opening balance', 'Used', 'Received', 'Closing balance', 'Supervisor sign-off (name / initials)', 'JE/SSE sign-off (name / initials)', 'Notes']);
        foreach ($register['entries'] as $entry) {
            $line([$entry['entry_date'], \Inventory\InventoryService::displayQuantity($entry['opening_qty']), \Inventory\InventoryService::displayQuantity($entry['used_qty']), \Inventory\InventoryService::displayQuantity($entry['received_qty']), \Inventory\InventoryService::displayQuantity($entry['closing_qty']), $safe($entry['supervisor']), $safe($entry['je_sse']), $safe($entry['notes'])]);
        }
        $summary = $register['summary'];
        $line(['MONTH TOTAL', \Inventory\InventoryService::displayQuantity($summary['opening_qty']), \Inventory\InventoryService::displayQuantity($summary['used_qty']), \Inventory\InventoryService::displayQuantity($summary['received_qty']), \Inventory\InventoryService::displayQuantity($summary['closing_qty']), '', '', '']);
        fclose($out);
        exit;
    }
    if ($action === 'materials' && in_array($method, ['POST', 'PUT'], true)) {
        respond(['material' => $service->saveMaterial($input, $method === 'PUT' ? positiveId($_GET['id'] ?? null) : null)], $method === 'POST' ? 201 : 200);
    }
    if ($action === 'entries' && in_array($method, ['POST', 'PUT'], true)) {
        respond(['entry' => $service->saveEntry(positiveId($input['material_id'] ?? null), $input, $method === 'PUT' ? positiveId($_GET['id'] ?? null) : null)], $method === 'POST' ? 201 : 200);
    }
    respond(['error' => 'Endpoint not found.'], 404);
} catch (\Inventory\ValidationException $e) {
    respond(['error' => $e->getMessage()], $e->status);
} catch (\Throwable $e) {
    error_log('Inventory: ' . $e->getMessage());
    respond(['error' => 'Inventory error: ' . $e->getMessage()], 500);
}
