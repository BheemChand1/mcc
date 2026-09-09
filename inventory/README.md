# MCC Inventory

A self-contained PHP inventory module. Every module file, asset, SQL schema, and the default SQLite database lives inside `inventory/`. No existing MCC file or database is changed or required for local development.

## Run locally

Requires PHP 8.1+ with `pdo_sqlite` and `mbstring` (both are present in the current workspace runtime). No Composer, Node, external CDN, or database server is required.

From the existing project root:

```sh
php inventory/database/init.php
INVENTORY_LOCAL_DEV=1 php -S 127.0.0.1:8081 -t inventory inventory/router.php
```

Open **http://127.0.0.1:8081**. The development server must use `router.php` to prevent access to database and internal files. Local mode is accepted only by PHP's development server on a loopback client connection. It uses station 1 and the actor “Local operator”.

The database is created automatically if absent at `inventory/storage/inventory.sqlite`, and seeded once per station. The init script can also initialize another station: `php inventory/database/init.php 2`. Existing records are never reset on restart or reseeding.

## Use in the existing PHP application

1. Keep the complete `inventory/` folder beside the existing `cdo-dashboard/` folder.
2. Enable `pdo_sqlite` and `mbstring`, and allow the PHP web-server user to write to `inventory/storage/` and its SQLite file. Do not use world-writable permissions.
3. Sign in through the existing MCC login, then visit **`/inventory/`** (or `<project-base>/inventory/`). The module uses the existing `user_id`, `station_id`, `role`, and name session fields. Session cookie scope must include `/inventory/`. `VIEWER` accounts are read-only, including at the API layer. Each station gets its own catalogue and register records.
4. Apache must allow the included `.htaccess` rules (`AllowOverride All` and access authorization support). Nested deny rules protect `storage`, `src`, `database`, and `tests`. There is no automatic change to existing navigation.

For Nginx, `.htaccess` is not applied. Add equivalent private-directory rules to your server configuration before serving the module, adapting the URL prefix if this project is hosted in a subdirectory:

```nginx
location ~ ^/inventory/(storage|src|database|tests)(/|$) { deny all; }
location ~ ^/inventory/(router\.php|README\.md|\.gitignore)$ { deny all; }
```

Place those rules before a generic PHP regex location. Alternatively, set `INVENTORY_DB_PATH` in the PHP process environment to an absolute SQLite path outside the web root; its parent directory must already exist and be writable. Never expose the SQLite database through static hosting. The inventory folder is not a static HTML site.

## Daily workflow

1. Open **Material master**. The 35 material names from the supplied reference photograph are included in the same order. Spelling is normalized; similar tools, including the two window squeezer entries, remain separate. Suggested categories and units are editable before any daily entry.
2. Choose **Set up stock**, confirm the unit, enter opening quantity, opening date, and optional low-stock threshold. No quantities or historic signatures from the handwritten photo are assumed or imported. Starting quantities remain unset until you configure them.
3. In **Daily register**, select a material and month. Click **Add daily entry** or the plus on an unrecorded date. Enter usage, receipts, supervisor name/initials, optional JE/SSE name/initials, and notes.
4. The backend computes `closing = opening − used + received`. The next entry carries the previous closing balance, including across gaps and months. Blank rows represent unrecorded dates; recording zero usage explicitly creates an entry.
5. Edit a saved row to correct a date, quantities, notes, or sign-off names. Later balances recalculate. Any change creating a negative balance on any later day is rolled back completely. Unit and opening stock are locked after the first saved entry; new receipts belong in the register.
6. Export the selected month to **CSV**, or use **Print** for a landscape register / browser Save as PDF. **Stock overview** filters in-stock, low-stock, and pending materials. The theme toggle switches dark/light mode.

Sign-off fields store typed names or initials, not cryptographic or verified electronic signatures. No paper signatures are copied. There is no destructive delete interface; records can be corrected with an audit trail. Existing MCC chemical consumption reports are independent and are not deducted automatically.

## Data and API

- `database/schema.sql`: SQLite table definitions and indexes.
- `database/materials.php`: all 35 reference material names, categories, and suggested units.
- `src/InventoryService.php`: validation, station scoping, decimal quantities, transactions, balances, and change audit.
- `src/Database.php`: database connection and schema initialization.
- `src/bootstrap.php`: MCC session handling, CSRF, headers, and explicit local development mode.
- `api.php`: JSON endpoints and CSV export.
- `index.php`, `assets/app.js`, `assets/styles.css`: responsive frontend using the existing MCC dark-blue/cyan design language, with local assets only.

Quantities are stored as integer thousandths of each material's chosen unit, supporting up to 3 decimal places without floating-point balance drift. Supported quantity range is 0–999,999,999.999. The catalogue, entries, and change history are stored in SQLite, not browser storage. `localStorage` stores only the theme preference. Dates use `Asia/Kolkata`; audit timestamps are UTC.

API routes are relative to `inventory/api.php`:

| Method | Query | Purpose |
| --- | --- | --- |
| GET | `action=materials` | Station catalogue, current stock and today's recorded status |
| GET | `action=register&material_id=1&month=2026-09` | Monthly ledger and balance summaries |
| GET | `action=export&material_id=1&month=2026-09` | CSV download with formula injection protection |
| POST | `action=materials` | Add a material |
| PUT | `action=materials&id=1` | Edit a material; requires its current `version` |
| POST | `action=entries` | Add a daily entry; requires `material_id` and material `version` |
| PUT | `action=entries&id=1` | Edit a daily entry; requires `material_id` and material `version` |

Mutations require JSON, a valid session, write access, and `X-CSRF-Token` from the page's meta tag. Material payload fields: `name`, `category`, `unit`, `opening_quantity`, `opening_date`, `minimum_quantity`. Entry fields: `material_id`, `version`, `entry_date`, `used_quantity`, `received_quantity`, `supervisor`, `je_sse`, `notes`. Send quantity values as decimal strings in the selected unit. Responses use `*_qty` integer thousandths. Duplicate names/dates or stale versions return 409; invalid data returns 422. Parallel updates are serialized in SQLite transactions and stale material versions are rejected.

`inventory_audit` retains before/after JSON, action, actor, station, and timestamp for all material/entry changes through the service. Reads, exports, and initial reference seeding are not audit events. Keep the SQLite file backed up using SQLite's backup command/API during operation, or copy it while the app is stopped. The database is ignored by Git to avoid committing operational data.

## Verify

```sh
php inventory/tests/run.php
node --check inventory/assets/app.js
```

The PHP regression tests use an in-memory database. They verify the reference catalogue, ledger arithmetic, cross-month carry-forward, correction recalculation, negative-stock rollback, duplicate prevention, station isolation, decimal precision, version conflicts, opening-stock locks, and persistence in a temporary database.
