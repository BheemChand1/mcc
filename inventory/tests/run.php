<?php
declare(strict_types=1);
if (PHP_SAPI !== 'cli') {
    http_response_code(404);
    exit;
}
require dirname(__DIR__) . '/src/Database.php';
require dirname(__DIR__) . '/src/InventoryService.php';
date_default_timezone_set('Asia/Kolkata');

use Inventory\Database;
use Inventory\InventoryService;
use Inventory\ValidationException;

$checks = 0;
function check(bool $condition, string $message): void
{
    global $checks;
    if (!$condition) throw new RuntimeException('FAIL: ' . $message);
    $checks++;
    echo "PASS: $message\n";
}
function rejects(callable $callback, string $message, int $status = 422): void
{
    try { $callback(); } catch (ValidationException $error) {
        check($error->status === $status, $message);
        return;
    }
    throw new RuntimeException('FAIL: Expected rejection: ' . $message);
}
function materialData(string $name, string $opening = '536', string $unit = 'L'): array
{
    return ['name' => $name, 'category' => 'Chemical', 'unit' => $unit, 'opening_quantity' => $opening, 'opening_date' => '2020-08-01', 'minimum_quantity' => '50'];
}
function entry(InventoryService $service, int $id, string $date, string $used, string $received = '0', ?int $entryId = null): array
{
    return $service->saveEntry($id, ['entry_date' => $date, 'used_quantity' => $used, 'received_quantity' => $received, 'supervisor' => 'AB', 'je_sse' => 'CD', 'notes' => 'Test', 'version' => $service->material($id)['version']], $entryId);
}

$db = new PDO('sqlite::memory:', null, null, [PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION, PDO::ATTR_DEFAULT_FETCH_MODE => PDO::FETCH_ASSOC]);
$db->exec("
CREATE TABLE inventory_materials (
    id INTEGER PRIMARY KEY AUTOINCREMENT, station_id INTEGER NOT NULL, catalog_number INTEGER, name TEXT NOT NULL, category TEXT NOT NULL, unit TEXT NOT NULL, opening_qty INTEGER NOT NULL DEFAULT 0, opening_date TEXT, minimum_qty INTEGER NOT NULL DEFAULT 0, version INTEGER NOT NULL DEFAULT 1, created_at TEXT NOT NULL, updated_at TEXT NOT NULL, UNIQUE (station_id, name)
);
CREATE TABLE inventory_entries (
    id INTEGER PRIMARY KEY AUTOINCREMENT, material_id INTEGER NOT NULL, entry_date TEXT NOT NULL, used_qty INTEGER NOT NULL DEFAULT 0, received_qty INTEGER NOT NULL DEFAULT 0, supervisor TEXT NOT NULL, je_sse TEXT NOT NULL DEFAULT '', notes TEXT NOT NULL DEFAULT '', created_by TEXT NOT NULL, updated_by TEXT NOT NULL, created_at TEXT NOT NULL, updated_at TEXT NOT NULL, UNIQUE (material_id, entry_date)
);
CREATE TABLE inventory_audit (
    id INTEGER PRIMARY KEY AUTOINCREMENT, station_id INTEGER NOT NULL, material_id INTEGER NOT NULL, action TEXT NOT NULL, actor TEXT NOT NULL, entry_date TEXT, used_qty INTEGER NOT NULL DEFAULT 0, received_qty INTEGER NOT NULL DEFAULT 0, opening_qty INTEGER NOT NULL DEFAULT 0, closing_qty INTEGER NOT NULL DEFAULT 0, supervisor TEXT, je_sse TEXT, notes TEXT, details TEXT, created_at TEXT NOT NULL
);
CREATE TABLE inventory_seeded_stations ( station_id INTEGER PRIMARY KEY, seeded_at TEXT NOT NULL );
");
$service = new InventoryService($db, 1, 'Test operator');
$service->seed();
check(count($service->materials()) === 35, 'All 35 reference materials are seeded');
check($service->materials()[0]['name'] === 'Heavy Duty Exterior Washing Liquid', 'Reference order is preserved');
check($service->materials()[34]['name'] === 'Window Glass Squeezer', 'Last reference material is retained separately');
$service->seed();
check(count($service->materials()) === 35, 'Seeding is idempotent');
check(count(array_filter($service->materials(), fn ($m) => $m['opening_date'] !== null)) === 0, 'No opening stock is invented');
$autoEntry = entry($service, 1, '2020-08-01', '0');
check($autoEntry['entry_date'] === '2020-08-01', 'Unconfigured opening stock auto-initializes opening date');

$material = $service->saveMaterial(materialData('Ledger test'));
$id = (int) $material['id'];
$first = entry($service, $id, '2020-08-01', '8');
check($first['opening_qty'] === 536000 && $first['closing_qty'] === 528000, 'Photo calculation: 536 minus 8 equals 528');
$second = entry($service, $id, '2020-08-02', '7');
check($second['opening_qty'] === 528000 && $second['closing_qty'] === 521000, 'Next day carries the prior closing balance');
$receipt = entry($service, $id, '2020-08-12', '8', '450');
check($receipt['opening_qty'] === 521000 && $receipt['closing_qty'] === 963000, 'Receipt and usage are applied together');
$nextMonth = entry($service, $id, '2020-09-01', '10');
$register = $service->register($id, '2020-09');
check($register['summary']['opening_qty'] === 963000 && $register['summary']['closing_qty'] === 953000, 'Opening balance carries across months and gaps');
check(count($register['entries']) === 1, 'Monthly register excludes entries from other months');
$empty = $service->register($id, '2020-10');
check($empty['summary']['opening_qty'] === 953000 && $empty['summary']['closing_qty'] === 953000 && !$empty['entries'], 'An empty month carries stock without inventing daily records');
$beforeStart = $service->register($id, '2020-07');
check($beforeStart['summary']['opening_qty'] === 0, 'Months before opening stock do not show future stock');

entry($service, $id, '2020-08-01', '10', '0', (int) $first['id']);
$adjusted = $service->register($id, '2020-09');
check($adjusted['summary']['closing_qty'] === 951000, 'Editing an earlier day recalculates future balances');
entry($service, $id, '2020-08-05', '3');
check($service->register($id, '2020-09')['summary']['closing_qty'] === 948000, 'Backdated insertion recalculates future balances');
$august = $service->register($id, '2020-08');
check($august['summary']['opening_qty'] + $august['summary']['received_qty'] - $august['summary']['used_qty'] === $august['summary']['closing_qty'], 'Monthly totals obey the ledger equation');

rejects(fn () => entry($service, $id, '2020-08-02', '7'), 'Duplicate material/date is rejected', 409);
rejects(fn () => $service->saveMaterial(materialData('ledger TEST')), 'Duplicate material name is rejected case-insensitively', 409);
rejects(fn () => $service->saveMaterial(materialData('   ')), 'Blank material name is rejected');
rejects(fn () => entry($service, $id, '2020-07-31', '0'), 'An entry before the opening stock date is rejected');
rejects(fn () => entry($service, $id, '2020-02-30', '0'), 'An impossible calendar date is rejected');
rejects(fn () => entry($service, $id, date('Y-m-d', strtotime('+1 day')), '0'), 'Future dates are rejected');
rejects(fn () => entry($service, $id, '2020-08-03', '-1'), 'Negative quantities are rejected');
rejects(fn () => entry($service, $id, '2020-08-03', '1.0001'), 'More than three decimal places is rejected');
rejects(fn () => entry($service, $id, '2020-08-03', '1e3'), 'Scientific notation is rejected');
rejects(fn () => $service->saveEntry($id, ['entry_date' => '2020-08-03', 'supervisor' => '', 'version' => $service->material($id)['version']]), 'Supervisor sign-off is required');
rejects(fn () => $service->saveEntry($id, ['entry_date' => '2020-08-03', 'supervisor' => ['invalid'], 'version' => $service->material($id)['version']]), 'Invalid JSON field types are rejected');

$small = $service->saveMaterial(materialData('Rollback test', '10'));
$smallId = (int) $small['id'];
$smallFirst = entry($service, $smallId, '2020-08-01', '2');
entry($service, $smallId, '2020-08-02', '8');
$beforeVersion = $service->material($smallId)['version'];
$auditBefore = (int) $db->query('SELECT COUNT(*) FROM inventory_audit')->fetchColumn();
rejects(fn () => entry($service, $smallId, '2020-08-01', '3', '0', (int) $smallFirst['id']), 'An edit that causes negative stock on a later day is rejected');
check($service->register($smallId, '2020-08')['entries'][0]['used_qty'] === 2000, 'Rejected corrections roll back the original entry');
check($service->material($smallId)['version'] === $beforeVersion, 'Rejected corrections leave the version unchanged');
check((int) $db->query('SELECT COUNT(*) FROM inventory_audit')->fetchColumn() === $auditBefore, 'Rejected corrections do not write false audit events');
rejects(fn () => entry($service, $smallId, '2020-08-03', '1'), 'Insufficient stock rejects a new entry');
check(count($service->register($smallId, '2020-08')['entries']) === 2, 'Rejected new entry is fully rolled back');
entry($service, $smallId, '2020-08-03', '0');
check(count($service->register($smallId, '2020-08')['entries']) === 3, 'Zero usage is a valid explicit daily entry');

$decimal = $service->saveMaterial(materialData('Decimal test', '0.3'));
$decimalId = (int) $decimal['id'];
entry($service, $decimalId, '2020-08-01', '0.1');
$decimalFinal = entry($service, $decimalId, '2020-08-02', '0.2');
check($decimalFinal['closing_qty'] === 0, 'Decimal quantities balance exactly without floating-point drift');
check(InventoryService::displayQuantity(1250) === '1.25' && InventoryService::displayQuantity(1001) === '1.001', 'CSV quantities preserve decimal precision');
rejects(fn () => InventoryService::quantity('1000000000', 'Quantity'), 'Quantity overflow is rejected');

$staleVersion = $service->material($id)['version'];
entry($service, $id, '2020-08-20', '1');
rejects(fn () => $service->saveEntry($id, ['entry_date' => '2020-08-21', 'supervisor' => 'AB', 'version' => $staleVersion]), 'Stale entry form cannot overwrite intervening changes', 409);
rejects(fn () => $service->saveMaterial([...materialData('Ledger test'), 'version' => $staleVersion], $id), 'Stale material form is rejected', 409);
rejects(fn () => $service->saveMaterial([...materialData('Ledger test', '1'), 'version' => $service->material($id)['version']], $id), 'Opening quantity is locked after daily entries exist');
rejects(fn () => $service->saveMaterial([...materialData('Ledger test', '536', 'mL'), 'version' => $service->material($id)['version']], $id), 'Unit is locked after daily entries exist');
$renamed = $service->saveMaterial([...materialData('Renamed ledger test'), 'minimum_quantity' => '15', 'version' => $service->material($id)['version']], $id);
check($renamed['name'] === 'Renamed ledger test' && $renamed['minimum_qty'] === 15000, 'Name and minimum stock can still be edited');

$stationTwo = new InventoryService($db, 2, 'Other station');
$stationTwo->seed();
check(count($stationTwo->materials()) === 35, 'Each station receives its own catalogue');
rejects(fn () => $stationTwo->material($id), 'Other station cannot read a material', 404);
rejects(fn () => $stationTwo->register($id, '2020-08'), 'Other station cannot read a ledger', 404);
rejects(fn () => $stationTwo->saveMaterial([...materialData('Cross station'), 'version' => 1], $id), 'Other station cannot edit a material', 404);
rejects(fn () => $stationTwo->saveEntry($id, ['entry_date' => '2020-08-01', 'supervisor' => 'AB', 'version' => 1]), 'Other station cannot add to a ledger', 404);
check((int) $db->query("SELECT COUNT(*) FROM inventory_audit WHERE action = 'entry.updated' AND actor = 'Test operator'")->fetchColumn() === 1, 'Successful edits retain actor and before/after audit history');

$tempDb = new PDO('sqlite::memory:', null, null, [PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION, PDO::ATTR_DEFAULT_FETCH_MODE => PDO::FETCH_ASSOC]);
$tempDb->exec("
CREATE TABLE inventory_materials (
    id INTEGER PRIMARY KEY AUTOINCREMENT, station_id INTEGER NOT NULL, catalog_number INTEGER, name TEXT NOT NULL, category TEXT NOT NULL, unit TEXT NOT NULL, opening_qty INTEGER NOT NULL DEFAULT 0, opening_date TEXT, minimum_qty INTEGER NOT NULL DEFAULT 0, version INTEGER NOT NULL DEFAULT 1, created_at TEXT NOT NULL, updated_at TEXT NOT NULL, UNIQUE (station_id, name)
);
CREATE TABLE inventory_entries (
    id INTEGER PRIMARY KEY AUTOINCREMENT, material_id INTEGER NOT NULL, entry_date TEXT NOT NULL, used_qty INTEGER NOT NULL DEFAULT 0, received_qty INTEGER NOT NULL DEFAULT 0, supervisor TEXT NOT NULL, je_sse TEXT NOT NULL DEFAULT '', notes TEXT NOT NULL DEFAULT '', created_by TEXT NOT NULL, updated_by TEXT NOT NULL, created_at TEXT NOT NULL, updated_at TEXT NOT NULL, UNIQUE (material_id, entry_date)
);
CREATE TABLE inventory_audit (
    id INTEGER PRIMARY KEY AUTOINCREMENT, station_id INTEGER NOT NULL, material_id INTEGER NOT NULL, action TEXT NOT NULL, actor TEXT NOT NULL, entry_date TEXT, used_qty INTEGER NOT NULL DEFAULT 0, received_qty INTEGER NOT NULL DEFAULT 0, opening_qty INTEGER NOT NULL DEFAULT 0, closing_qty INTEGER NOT NULL DEFAULT 0, supervisor TEXT, je_sse TEXT, notes TEXT, details TEXT, created_at TEXT NOT NULL
);
CREATE TABLE inventory_seeded_stations ( station_id INTEGER PRIMARY KEY, seeded_at TEXT NOT NULL );
");
$persistentService = new InventoryService($tempDb, 1, 'Persistence test');
$persistentService->seed();
$saved = $persistentService->saveMaterial(materialData('Persistent material', '123.456'));
check(count($persistentService->materials()) === 36 && $persistentService->material((int) $saved['id'])['opening_qty'] === 123456, 'Saved data survives closing and reopening the database');
echo "\nAll $checks inventory regression checks passed.\n";
