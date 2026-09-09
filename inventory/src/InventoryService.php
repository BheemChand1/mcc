<?php
declare(strict_types=1);

namespace Inventory;

use PDO;
use PDOException;
use RuntimeException;

final class ValidationException extends RuntimeException
{
    public int $status;

    public function __construct(string $message, int $status = 422)
    {
        parent::__construct($message);
        $this->status = $status;
    }
}

final class InventoryService
{
    private const MAX_QTY = 999999999999;

    public function __construct(private PDO $db, private int $stationId, private string $actor)
    {
        if ($stationId < 1) {
            throw new ValidationException('A valid station assignment is required.', 403);
        }
    }

    public static function quantity(mixed $value, string $label): int
    {
        if (!is_string($value) && !is_int($value) && !is_float($value)) {
            throw new ValidationException("$label must be a non-negative quantity.");
        }
        $value = trim((string) $value);
        if (!preg_match('/^\d{1,9}(?:\.\d{1,3})?$/D', $value)) {
            throw new ValidationException("$label must be between 0 and 999,999,999.999, with up to 3 decimal places.");
        }
        $parts = explode('.', $value, 2);
        return ((int) $parts[0] * 1000) + (int) str_pad($parts[1] ?? '', 3, '0');
    }

    public static function displayQuantity(int $quantity): string
    {
        return (string) intdiv($quantity, 1000) . ($quantity % 1000 ? '.' . rtrim(str_pad((string) ($quantity % 1000), 3, '0', STR_PAD_LEFT), '0') : '');
    }

    private static function text(mixed $value, string $label, int $limit, bool $required = false): string
    {
        if (!is_string($value)) {
            throw new ValidationException("$label must be text.");
        }
        $value = trim($value);
        if (($required && $value === '') || mb_strlen($value) > $limit || preg_match('/[\x00-\x08\x0B\x0C\x0E-\x1F]/', $value)) {
            throw new ValidationException("$label is required and must be at most $limit characters, without control characters.");
        }
        return $value;
    }

    private static function date(mixed $value): string
    {
        if (!is_string($value) || !preg_match('/^\d{4}-\d{2}-\d{2}$/D', $value)) {
            throw new ValidationException('Enter a valid date in YYYY-MM-DD format.');
        }
        [$year, $month, $day] = array_map('intval', explode('-', $value));
        if ($year < 2000 || !checkdate($month, $day, $year) || $value > date('Y-m-d')) {
            throw new ValidationException('Date must be valid, from the year 2000 onward, and cannot be in the future.');
        }
        return $value;
    }

    private function transaction(callable $callback): mixed
    {
        $this->db->beginTransaction();
        try {
            $result = $callback();
            $this->db->commit();
            return $result;
        } catch (\Throwable $e) {
            if ($this->db->inTransaction()) {
                $this->db->rollBack();
            }
            if ($e instanceof PDOException && (
                str_contains($e->getMessage(), 'Duplicate entry') ||
                str_contains($e->getMessage(), 'UNIQUE constraint') ||
                (string) $e->getCode() === '23000'
            )) {
                throw new ValidationException('This material name or daily entry already exists. Edit the existing record instead.', 409);
            }
            throw $e;
        }
    }

    public function seed(): void
    {
        $check = $this->db->prepare('SELECT station_id FROM inventory_seeded_stations WHERE station_id = ?');
        $check->execute([$this->stationId]);
        if ($check->fetch()) {
            return;
        }
        $this->transaction(function () use ($check): void {
            $check->execute([$this->stationId]);
            if ($check->fetch()) {
                return;
            }
            $isSqlite = $this->db->getAttribute(PDO::ATTR_DRIVER_NAME) === 'sqlite';
            $sql = $isSqlite
                ? 'INSERT OR IGNORE INTO inventory_materials (station_id, catalog_number, name, category, unit, created_at, updated_at) VALUES (?, ?, ?, ?, ?, ?, ?)'
                : 'INSERT IGNORE INTO inventory_materials (station_id, catalog_number, name, category, unit, created_at, updated_at) VALUES (?, ?, ?, ?, ?, ?, ?)';
            $insert = $this->db->prepare($sql);
            $now = date('Y-m-d H:i:s');
            foreach (require dirname(__DIR__) . '/database/materials.php' as $index => $material) {
                $insert->execute([$this->stationId, $index + 1, ...$material, $now, $now]);
            }
            $seedSql = $isSqlite
                ? 'INSERT OR IGNORE INTO inventory_seeded_stations (station_id, seeded_at) VALUES (?, ?)'
                : 'INSERT IGNORE INTO inventory_seeded_stations (station_id, seeded_at) VALUES (?, ?)';
            $this->db->prepare($seedSql)->execute([$this->stationId, $now]);
        });
    }

    public function material(int $id): array
    {
        $statement = $this->db->prepare('SELECT * FROM inventory_materials WHERE id = ? AND station_id = ?');
        $statement->execute([$id, $this->stationId]);
        $material = $statement->fetch();
        if (!$material) {
            throw new ValidationException('Material not found at your station.', 404);
        }
        return $material;
    }

    private function rows(int $id): array
    {
        $statement = $this->db->prepare('SELECT * FROM inventory_entries WHERE material_id = ? ORDER BY entry_date, id');
        $statement->execute([$id]);
        return $statement->fetchAll();
    }

    private function balances(array $material, array $rows): array
    {
        $balance = (int) $material['opening_qty'];
        foreach ($rows as &$row) {
            if ($material['opening_date'] === null || $row['entry_date'] < $material['opening_date']) {
                throw new ValidationException('An entry cannot be earlier than the opening stock date.');
            }
            $row['opening_qty'] = $balance;
            $balance += (int) $row['received_qty'] - (int) $row['used_qty'];
            if ($balance < 0) {
                throw new ValidationException('This change would make stock negative on ' . $row['entry_date'] . '. Check the opening quantity, receipts, and usage.');
            }
            if ($balance > self::MAX_QTY) {
                throw new ValidationException('The closing quantity exceeds the supported limit on ' . $row['entry_date'] . '.');
            }
            $row['closing_qty'] = $balance;
        }
        unset($row);
        return $rows;
    }

    public function materials(): array
    {
        $statement = $this->db->prepare('SELECT m.*, COUNT(e.id) AS entry_count, MAX(e.entry_date) AS last_entry_date,
            m.opening_qty + COALESCE(SUM(e.received_qty - e.used_qty), 0) AS current_qty,
            COALESCE(SUM(CASE WHEN e.entry_date = :today THEN 1 ELSE 0 END), 0) AS updated_today
            FROM inventory_materials m LEFT JOIN inventory_entries e ON e.material_id = m.id
            WHERE m.station_id = :station GROUP BY m.id ORDER BY (m.catalog_number IS NULL), m.catalog_number, m.id');
        $statement->execute(['today' => date('Y-m-d'), 'station' => $this->stationId]);
        return $statement->fetchAll();
    }

    public function register(int $id, string $month): array
    {
        if (!preg_match('/^\d{4}-(0[1-9]|1[0-2])$/D', $month) || (int) substr($month, 0, 4) < 2000) {
            throw new ValidationException('Choose a valid month.');
        }
        // Keep metadata and entries from the same database snapshot.
        $inTransaction = $this->db->inTransaction();
        if (!$inTransaction) {
            $this->db->beginTransaction();
        }
        try {
            $material = $this->material($id);
            $all = $this->balances($material, $this->rows($id));
            if (!$inTransaction && $this->db->inTransaction()) {
                $this->db->commit();
            }
        } catch (\Throwable $e) {
            if (!$inTransaction && $this->db->inTransaction()) {
                $this->db->rollBack();
            }
            throw $e;
        }
        $first = $month . '-01';
        $last = date('Y-m-t', strtotime($first));
        $opening = $material['opening_date'] !== null && $material['opening_date'] <= $last ? (int) $material['opening_qty'] : 0;
        $selected = [];
        $used = $received = 0;
        foreach ($all as $entry) {
            if ($entry['entry_date'] < $first) {
                $opening = $entry['closing_qty'];
            }
            if ($entry['entry_date'] >= $first && $entry['entry_date'] <= $last) {
                $selected[] = $entry;
                $used += (int) $entry['used_qty'];
                $received += (int) $entry['received_qty'];
            }
        }
        $current = $all ? end($all)['closing_qty'] : (int) $material['opening_qty'];
        return ['material' => $material, 'entries' => $selected, 'month' => $month,
            'summary' => ['opening_qty' => $opening, 'used_qty' => $used, 'received_qty' => $received,
                'closing_qty' => $opening + $received - $used, 'current_qty' => $current, 'entry_count' => count($selected)],
            'all_balances' => array_map(fn (array $e): array => ['id' => $e['id'], 'entry_date' => $e['entry_date'], 'closing_qty' => $e['closing_qty']], $all)];
    }

    public function dailyReport(string $date): array
    {
        $date = self::date($date);
        $statement = $this->db->prepare('
            SELECT e.*, m.name AS material_name, m.category, m.unit, m.catalog_number
            FROM inventory_entries e
            JOIN inventory_materials m ON e.material_id = m.id
            WHERE m.station_id = ? AND e.entry_date = ?
            ORDER BY (m.catalog_number IS NULL), m.catalog_number, m.id
        ');
        $statement->execute([$this->stationId, $date]);
        return $statement->fetchAll();
    }

    private function checkVersion(array $material, mixed $version): void
    {
        if ($version === null || $version === '' || $version === false) {
            return;
        }
        if (!is_numeric($version) || (int) $version !== (int) $material['version']) {
            throw new ValidationException('This material changed since you opened it. Reload the page, then try again.', 409);
        }
    }

    private function audit(int $id, string $action, ?array $before, array $after): void
    {
        $entryDate = $after['entry_date'] ?? $before['entry_date'] ?? null;
        $usedQty = (int) ($after['used_qty'] ?? $before['used_qty'] ?? 0);
        $receivedQty = (int) ($after['received_qty'] ?? $before['received_qty'] ?? 0);
        $openingQty = (int) ($after['opening_qty'] ?? $before['opening_qty'] ?? $after['opening_quantity'] ?? 0);
        $closingQty = (int) ($after['closing_qty'] ?? $before['closing_qty'] ?? $after['minimum_qty'] ?? 0);
        $supervisor = (string) ($after['supervisor'] ?? $before['supervisor'] ?? '');
        $jeSse = (string) ($after['je_sse'] ?? $before['je_sse'] ?? '');
        $notes = (string) ($after['notes'] ?? $before['notes'] ?? '');
        $details = (string) ($after['name'] ?? $after['action'] ?? $action);

        $this->db->prepare('
            INSERT INTO inventory_audit 
            (station_id, material_id, action, actor, entry_date, used_qty, received_qty, opening_qty, closing_qty, supervisor, je_sse, notes, details, created_at) 
            VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
        ')->execute([
            $this->stationId,
            $id,
            $action,
            $this->actor,
            $entryDate,
            $usedQty,
            $receivedQty,
            $openingQty,
            $closingQty,
            $supervisor,
            $jeSse,
            $notes,
            $details,
            date('Y-m-d H:i:s')
        ]);
    }

    public function saveMaterial(array $input, ?int $id = null): array
    {
        $name = self::text($input['name'] ?? '', 'Material name', 180, true);
        $category = $input['category'] ?? '';
        $unit = $input['unit'] ?? '';
        if (!in_array($category, ['Chemical', 'Equipment', 'Consumable'], true) || !in_array($unit, ['L', 'mL', 'kg', 'g', 'pcs', 'rolls', 'sets'], true)) {
            throw new ValidationException('Choose a supported category and unit.');
        }
        $opening = self::quantity($input['opening_quantity'] ?? '0', 'Opening quantity');
        $minimum = self::quantity($input['minimum_quantity'] ?? '0', 'Minimum stock');
        $date = empty($input['opening_date']) ? null : self::date($input['opening_date']);
        if ($date === null && $opening !== 0) {
            throw new ValidationException('An opening date is required when you enter opening stock.');
        }
        return $this->transaction(function () use ($id, $input, $name, $category, $unit, $opening, $minimum, $date): array {
            $checkStmt = $this->db->prepare('SELECT id FROM inventory_materials WHERE station_id = ? AND LOWER(name) = LOWER(?)' . ($id !== null ? ' AND id != ?' : ''));
            $checkParams = $id !== null ? [$this->stationId, $name, $id] : [$this->stationId, $name];
            $checkStmt->execute($checkParams);
            if ($checkStmt->fetch()) {
                throw new ValidationException('This material name already exists. Choose a different name.', 409);
            }
            $before = $id === null ? null : $this->material($id);
            if ($before !== null) {
                $this->checkVersion($before, $input['version'] ?? null);
                $rows = $this->rows($id);
                if ($rows && ($unit !== $before['unit'] || $opening !== (int) $before['opening_qty'] || $date !== $before['opening_date'])) {
                    throw new ValidationException('Unit and opening stock are locked after the first daily entry. Record new stock as received in the daily register.');
                }
            }
            $now = gmdate('c');
            if ($id === null) {
                $this->db->prepare('INSERT INTO inventory_materials (station_id, name, category, unit, opening_qty, opening_date, minimum_qty, created_at, updated_at) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)')
                    ->execute([$this->stationId, $name, $category, $unit, $opening, $date, $minimum, $now, $now]);
                $id = (int) $this->db->lastInsertId();
            } else {
                $this->db->prepare('UPDATE inventory_materials SET name = ?, category = ?, unit = ?, opening_qty = ?, opening_date = ?, minimum_qty = ?, version = version + 1, updated_at = ? WHERE id = ? AND station_id = ?')
                    ->execute([$name, $category, $unit, $opening, $date, $minimum, $now, $id, $this->stationId]);
            }
            $after = $this->material($id);
            $this->audit($id, $before === null ? 'material.created' : 'material.updated', $before, $after);
            return $after;
        });
    }

    public function saveEntry(int $materialId, array $input, ?int $entryId = null): array
    {
        $date = self::date($input['entry_date'] ?? '');
        $used = self::quantity($input['used_quantity'] ?? '0', 'Used quantity');
        $received = self::quantity($input['received_quantity'] ?? '0', 'Received quantity');
        $supervisor = self::text($input['supervisor'] ?? '', 'Supervisor name / initials', 100, true);
        $je = self::text($input['je_sse'] ?? '', 'JE/SSE name / initials', 100);
        $notes = self::text($input['notes'] ?? '', 'Notes', 1000);
        return $this->transaction(function () use ($materialId, $entryId, $input, $date, $used, $received, $supervisor, $je, $notes): array {
            $material = $this->material($materialId);
            $this->checkVersion($material, $input['version'] ?? null);
            if ($material['opening_date'] === null) {
                $this->db->prepare('UPDATE inventory_materials SET opening_date = ? WHERE id = ? AND station_id = ?')
                    ->execute([$date, $materialId, $this->stationId]);
                $material['opening_date'] = $date;
            }
            $before = null;
            if ($entryId !== null) {
                $statement = $this->db->prepare('SELECT * FROM inventory_entries WHERE id = ? AND material_id = ?');
                $statement->execute([$entryId, $materialId]);
                $before = $statement->fetch();
                if (!$before) {
                    throw new ValidationException('Daily entry not found.', 404);
                }
            }
            $now = gmdate('c');
            if ($entryId === null) {
                $this->db->prepare('INSERT INTO inventory_entries (material_id, entry_date, used_qty, received_qty, supervisor, je_sse, notes, created_by, updated_by, created_at, updated_at) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)')
                    ->execute([$materialId, $date, $used, $received, $supervisor, $je, $notes, $this->actor, $this->actor, $now, $now]);
                $entryId = (int) $this->db->lastInsertId();
            } else {
                $this->db->prepare('UPDATE inventory_entries SET entry_date = ?, used_qty = ?, received_qty = ?, supervisor = ?, je_sse = ?, notes = ?, updated_by = ?, updated_at = ? WHERE id = ? AND material_id = ?')
                    ->execute([$date, $used, $received, $supervisor, $je, $notes, $this->actor, $now, $entryId, $materialId]);
            }
            // Recheck every later day as well: a backdated edit must not create negative stock.
            $rows = $this->balances($material, $this->rows($materialId));
            $after = array_values(array_filter($rows, fn (array $r): bool => (int) $r['id'] === $entryId))[0];
            $this->db->prepare('UPDATE inventory_materials SET version = version + 1, updated_at = ? WHERE id = ? AND station_id = ?')->execute([$now, $materialId, $this->stationId]);
            $this->audit($materialId, $before === null ? 'entry.created' : 'entry.updated', $before, $after);
            return $after;
        });
    }
}
