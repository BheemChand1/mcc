'use strict';

(() => {
    const $ = id => document.getElementById(id);
    const canWrite = document.querySelector('meta[name="inventory-write"]').content === '1';
    const csrf = document.querySelector('meta[name="csrf-token"]').content;
    const state = { materials: [], register: null, materialId: null, view: 'register', stockFilter: 'all', today: '', month: '', materialEdit: null, entryEdit: null, request: 0, saving: false, entryVersion: null };
    let toastTimer;
    const escape = value => String(value ?? '').replace(/[&<>"']/g, character => ({ '&': '&amp;', '<': '&lt;', '>': '&gt;', '"': '&quot;', "'": '&#39;' }[character]));
    const icon = name => `<svg aria-hidden="true"><use href="#i-${name}"/></svg>`;
    const quantity = value => (Number(value) / 1000).toLocaleString('en-IN', { maximumFractionDigits: 3 });
    const rawQuantity = value => String(Number(value) / 1000);
    const withUnit = (value, unit) => `${quantity(value)} <small>${escape(unit)}</small>`;
    const dateObject = value => new Date(`${value}T12:00:00`);
    const dateLabel = value => value ? dateObject(value).toLocaleDateString('en-GB', { day: '2-digit', month: 'short', year: 'numeric' }) : '—';
    const monthLabel = value => dateObject(`${value}-01`).toLocaleDateString('en-GB', { month: 'long', year: 'numeric' });
    const reference = material => material.catalog_number ? `MAT-${String(material.catalog_number).padStart(3, '0')}` : `NEW-${material.id}`;
    const stockStatus = material => !material.opening_date ? 'pending' : Number(material.current_qty) <= Number(material.minimum_qty) ? 'low' : 'ready';
    const statusText = { pending: 'Opening pending', low: 'Low stock', ready: 'In stock' };
    const badge = material => `<span class="badge badge-${stockStatus(material)}">${statusText[stockStatus(material)]}</span>`;

    function notify(message) {
        clearTimeout(toastTimer);
        $('toast').querySelector('span').textContent = message;
        $('toast').hidden = false;
        toastTimer = setTimeout(() => { $('toast').hidden = true; }, 4500);
    }

    function showError(id, message) {
        $(id).textContent = message;
        $(id).hidden = !message;
    }

    function pageError(error) {
        $('pageErrorText').textContent = error.message || 'Could not load inventory. Please try again.';
        $('pageError').hidden = false;
        $('syncStatus').textContent = 'Connection needs attention';
    }

    async function api(action, { method = 'GET', data, query = {} } = {}) {
        const url = new URL('api.php', window.location.href);
        url.search = new URLSearchParams({ action, ...query }).toString();
        const response = await fetch(url, {
            method, credentials: 'same-origin', headers: { Accept: 'application/json', ...(data ? { 'Content-Type': 'application/json', 'X-CSRF-Token': csrf } : {}) },
            ...(data ? { body: JSON.stringify(data) } : {}),
        });
        let payload;
        try { payload = await response.json(); } catch { throw new Error('The server returned an unreadable response. Check that Inventory is running with PHP.'); }
        if (!response.ok) throw new Error(payload.error || 'The request could not be completed.');
        return payload;
    }

    function renderStats() {
        if ($('totalMaterials')) $('totalMaterials').textContent = state.materials.length;
        if ($('navCount')) $('navCount').textContent = state.materials.length;
        if ($('updatedToday')) $('updatedToday').textContent = state.materials.filter(m => Number(m.updated_today) > 0).length;
        if ($('lowStock')) $('lowStock').textContent = state.materials.filter(m => stockStatus(m) === 'low').length;
        if ($('pendingStock')) $('pendingStock').textContent = state.materials.filter(m => stockStatus(m) === 'pending').length;
        const chemicals = state.materials.filter(m => m.category === 'Chemical').length;
        if ($('categoryCount')) $('categoryCount').textContent = `${chemicals} chemicals · ${state.materials.length - chemicals} other materials`;
    }

    function renderMaterialOptions() {
        $('materialSelect').innerHTML = state.materials.map(m => `<option value="${m.id}">${escape(reference(m))} · ${escape(m.name)}</option>`).join('');
        $('materialSelect').value = String(state.materialId);
        $('materialSelect').disabled = !state.materials.length;
    }

    function renderMaterials() {
        const search = $('materialSearch').value.trim().toLocaleLowerCase();
        const category = $('categoryFilter').value;
        const items = state.materials.filter(m => (category === 'all' || m.category === category) && `${m.name} ${reference(m)}`.toLocaleLowerCase().includes(search));
        $('materialResults').textContent = `${items.length} materials`;
        $('materialsBody').innerHTML = items.length ? items.map(m => `<tr>
            <!-- <td class="empty-dash">${escape(reference(m))}</td> -->
            <td class="material-cell"><button data-register="${m.id}">${escape(m.name)}</button><small>${m.opening_date ? `Opening ${quantity(m.opening_qty)} ${escape(m.unit)} on ${dateLabel(m.opening_date)}` : 'Set opening stock to start recording'}</small></td>
            <td>${escape(m.category)}</td><td class="empty-dash">${escape(m.unit)}</td>
            <td class="numeric">${m.opening_date ? quantity(m.current_qty) : '—'}</td><td class="numeric empty-dash">${quantity(m.minimum_qty)}</td>
            <td>${badge(m)}</td><td>${canWrite ? `<button class="table-link" data-edit-material="${m.id}">${m.opening_date ? 'Edit material' : 'Set up stock'}</button>` : `<button class="table-link" data-register="${m.id}">View register</button>`}</td>
        </tr>`).join('') : '<tr><td colspan="7" class="empty-state">No materials match your search. Try another name or category.</td></tr>';
    }

    function renderOverview() {
        const items = state.materials.filter(m => state.stockFilter === 'all' || stockStatus(m) === state.stockFilter);
        $('overviewResults').textContent = `${items.length} materials`;
        $('overviewBody').innerHTML = items.length ? items.map(m => `<tr>
            <td class="material-cell"><button data-register="${m.id}">${escape(m.name)}</button><small>${escape(reference(m))} · ${escape(m.category)}</small></td>
            <td class="numeric">${m.opening_date ? `${quantity(m.current_qty)} ${escape(m.unit)}` : '—'}</td><td>${badge(m)}</td>
            <td class="empty-dash">${dateLabel(m.last_entry_date)}</td><td>${Number(m.updated_today) ? '<span class="green">Recorded</span>' : '<span class="empty-dash">Not recorded</span>'}</td>
            <td><button class="table-link" data-register="${m.id}">Open register →</button></td>
        </tr>`).join('') : '<tr><td colspan="6" class="empty-state">No materials in this stock category.</td></tr>';
    }

    function renderRegister() {
        const { material, entries, summary, month } = state.register;
        const displayMaterial = { ...material, current_qty: summary.current_qty };
        $('registerMaterialName').textContent = material.name;
        $('materialCode').textContent = reference(material);
        $('materialCategory').textContent = `${material.category} · ${material.unit}`;
        $('currentStock').textContent = material.opening_date ? `${quantity(summary.current_qty)} ${material.unit}` : 'Not set';
        $('materialStatus').className = `badge badge-${stockStatus(displayMaterial)}`;
        $('materialStatus').textContent = statusText[stockStatus(displayMaterial)];
        $('setupBanner').hidden = !!material.opening_date;
        $('monthOpening').innerHTML = material.opening_date ? withUnit(summary.opening_qty, material.unit) : '—';
        $('monthUsed').innerHTML = withUnit(summary.used_qty, material.unit);
        $('monthReceived').innerHTML = withUnit(summary.received_qty, material.unit);
        $('monthClosing').innerHTML = material.opening_date ? withUnit(summary.closing_qty, material.unit) : '—';
        $('registerMonthLabel').textContent = monthLabel(month);
        $('entryCount').textContent = `${entries.length} ${entries.length === 1 ? 'day' : 'days'} recorded`;
        $('registerUnitNote').textContent = `All quantities in ${material.unit} · — = no entry`;
        const days = new Date(Number(month.slice(0, 4)), Number(month.slice(5, 7)), 0).getDate();
        const byDate = new Map(entries.map(e => [e.entry_date, e]));
        let html = '';
        for (let day = 1; day <= days; day++) {
            const date = `${month}-${String(day).padStart(2, '0')}`;
            const entry = byDate.get(date);
            const dateText = dateObject(date).toLocaleDateString('en-GB', { day: '2-digit', month: 'short' });
            const weekDay = dateObject(date).toLocaleDateString('en-GB', { weekday: 'short' });
            const dateCell = `<span>${dateText}</span><span class="day-name">${weekDay}</span>${date === state.today ? '<span class="today-mark">TODAY</span>' : ''}`;
            const canAdd = canWrite && (!material.opening_date || date >= material.opening_date) && date <= state.today;
            html += `<tr class="${date === state.today ? 'today-row ' : ''}${entry ? '' : 'unsaved-row'}"><td>${dateCell}</td>`;
            if (entry) {
                html += `<td class="numeric">${quantity(entry.opening_qty)}</td><td class="numeric ${Number(entry.used_qty) ? 'amber' : 'empty-dash'}">${quantity(entry.used_qty)}</td><td class="numeric ${Number(entry.received_qty) ? 'green' : 'empty-dash'}">${quantity(entry.received_qty)}</td><td class="numeric closing-col cyan">${quantity(entry.closing_qty)}</td><td>${escape(entry.supervisor)}${entry.notes ? `<small class="record-note">${escape(entry.notes)}</small>` : ''}</td><td>${entry.je_sse ? escape(entry.je_sse) : '<span class="empty-dash">—</span>'}</td><td class="action-col">${canWrite ? `<button class="icon-button row-action" data-edit-entry="${entry.id}" aria-label="Edit entry for ${date}" title="Edit entry">${icon('edit')}</button>` : ''}</td>`;
            } else {
                html += `<td class="numeric">—</td><td class="numeric">—</td><td class="numeric">—</td><td class="numeric closing-col">—</td><td>—</td><td>—</td><td class="action-col">${canAdd ? `<button class="icon-button row-action" data-add-date="${date}" aria-label="Add entry for ${date}" title="Add daily entry">${icon('plus')}</button>` : ''}</td>`;
            }
            html += '</tr>';
        }
        $('ledgerBody').innerHTML = html;
        $('ledgerFoot').innerHTML = `<tr><td>Month total</td><td class="numeric">${material.opening_date ? quantity(summary.opening_qty) : '—'}</td><td class="numeric amber">${quantity(summary.used_qty)}</td><td class="numeric green">${quantity(summary.received_qty)}</td><td class="numeric cyan">${material.opening_date ? quantity(summary.closing_qty) : '—'}</td><td colspan="2">${entries.length} ${entries.length === 1 ? 'entry' : 'entries'}</td><td class="action-col"></td></tr>`;
        $('registerLoading').hidden = true;
        $('registerContent').hidden = false;
        if (canWrite) $('addEntry').disabled = false;
        $('exportRegister').disabled = false;
        $('printRegister').disabled = false;
    }

    async function loadRegister() {
        const request = ++state.request;
        state.register = null;
        $('registerLoading').textContent = 'Loading your stock register…';
        $('registerLoading').hidden = false;
        $('registerContent').hidden = true;
        if (canWrite) $('addEntry').disabled = true;
        $('exportRegister').disabled = true;
        $('printRegister').disabled = true;
        if (!state.materialId) return;
        try {
            const register = await api('register', { query: { material_id: state.materialId, month: state.month } });
            if (request !== state.request) return;
            state.register = register;
            renderRegister();
        } catch (error) {
            if (request !== state.request) return;
            $('registerLoading').textContent = 'The register could not be loaded. Use Retry above.';
            pageError(error);
        }
    }

    async function refresh() {
        $('pageError').hidden = true;
        try {
            const data = await api('materials');
            state.materials = data.materials;
            state.today = data.today;
            if (!state.month) state.month = state.today.slice(0, 7);
            $('monthSelect').value = state.month;
            $('todayLabel').textContent = dateLabel(state.today);
            if (!state.materials.some(m => Number(m.id) === Number(state.materialId))) state.materialId = state.materials[0]?.id ?? null;
            renderStats();
            renderMaterialOptions();
            renderMaterials();
            renderOverview();
            await loadRegister();
            if ($('pageError').hidden) $('syncStatus').textContent = `Last loaded ${new Date().toLocaleTimeString('en-GB', { hour: '2-digit', minute: '2-digit', timeZone: 'Asia/Kolkata' })} IST · Database connected`;
        } catch (error) { pageError(error); }
    }

    function closeSidebar() {
        document.body.classList.remove('sidebar-open');
        $('sidebarScrim').hidden = true;
        $('menuToggle').setAttribute('aria-expanded', 'false');
    }

    function setView() {
        const requested = location.hash.slice(1);
        state.view = ['register', 'materials', 'overview'].includes(requested) ? requested : 'register';
        for (const view of ['register', 'materials', 'overview']) $(view + 'View').hidden = view !== state.view;
        document.querySelectorAll('[data-view]').forEach(link => {
            link.classList.toggle('active', link.dataset.view === state.view);
            if (link.dataset.view === state.view) link.setAttribute('aria-current', 'page'); else link.removeAttribute('aria-current');
        });
        closeSidebar();
    }

    function openRegister(id) {
        state.materialId = Number(id);
        $('materialSelect').value = String(id);
        location.hash = 'register';
        setView();
        loadRegister();
    }

    function openMaterial(material = null) {
        if (!canWrite || state.saving) return;
        state.materialEdit = material;
        const form = $('materialForm');
        form.reset();
        for (const field of form.elements) field.disabled = false;
        showError('materialError', '');
        const locked = !!material && Number(material.entry_count) > 0;
        $('materialDialogTitle').textContent = material ? (material.opening_date ? 'Edit material' : 'Set opening stock') : 'Add material';
        $('materialDialogDescription').textContent = material ? 'Review this material’s details and stock settings.' : 'Add a material and set its starting stock.';
        for (const name of ['name', 'category', 'unit']) if (material) form.elements[name].value = material[name];
        form.elements.opening_quantity.value = material ? rawQuantity(material.opening_qty) : '0';
        form.elements.minimum_quantity.value = material ? rawQuantity(material.minimum_qty) : '0';
        form.elements.opening_date.value = material?.opening_date || state.today;
        form.elements.opening_date.max = state.today;
        for (const name of ['unit', 'opening_quantity', 'opening_date']) form.elements[name].disabled = locked;
        $('openingHint').textContent = locked ? 'Unit and opening stock are locked because daily entries exist. Add receipts through the daily register.' : 'Choose the date this stock was available. Leave the date blank to set up stock later.';
        $('materialDialog').showModal();
    }

    function entryPreview() {
        if (!state.register || !$('entryDialog').open) return;
        const form = $('entryForm');
        const { material, all_balances } = state.register;
        const date = form.elements.entry_date.value;
        let opening = Number(material.opening_qty);
        // Earlier balances automatically include every prior day and prior month.
        // When moving an edited entry forward, remove its old movement first.
        for (const row of all_balances) {
            if (row.entry_date < date) opening = Number(row.closing_qty);
        }
        if (state.entryEdit && state.entryEdit.entry_date < date) opening -= Number(state.entryEdit.received_qty) - Number(state.entryEdit.used_qty);
        const used = Math.round(Number(form.elements.used_quantity.value || '0') * 1000);
        const received = Math.round(Number(form.elements.received_quantity.value || '0') * 1000);
        const closing = opening - used + received;
        const invalid = !date || date < material.opening_date || date > state.today || !Number.isFinite(closing) || closing < 0;
        $('entryOpening').textContent = `${quantity(opening)} ${material.unit}`;
        $('entryClosing').textContent = invalid ? 'Check date / quantities' : `${quantity(closing)} ${material.unit}`;
        $('entryClosing').parentElement.classList.toggle('invalid', invalid);
    }

    function openEntry(entry = null, chosenDate = null) {
        if (!canWrite || !state.register || state.saving) return;
        const { material, entries } = state.register;
        let date = chosenDate || state.today;
        if (!entry && !chosenDate && state.month !== state.today.slice(0, 7)) {
            date = state.month < state.today.slice(0, 7) ? `${state.month}-01` : state.today;
            if (material.opening_date && date < material.opening_date) date = material.opening_date;
        }
        if (!entry) entry = entries.find(e => e.entry_date === date) || null;
        state.entryEdit = entry;
        state.entryVersion = material.version;
        const form = $('entryForm');
        form.reset();
        showError('entryError', '');
        $('entryDialogTitle').textContent = entry ? 'Edit daily entry' : 'Add daily entry';
        $('entryMaterialName').textContent = material.name;
        $('entryUnit').textContent = material.unit;
        form.elements.entry_date.value = entry?.entry_date || date;
        form.elements.entry_date.min = material.opening_date || '2000-01-01';
        form.elements.entry_date.max = state.today;
        form.elements.used_quantity.value = entry ? rawQuantity(entry.used_qty) : '0';
        form.elements.received_quantity.value = entry ? rawQuantity(entry.received_qty) : '0';
        for (const name of ['supervisor', 'je_sse', 'notes']) form.elements[name].value = entry?.[name] || '';
        $('entryDialog').showModal();
        entryPreview();
    }

    async function saveForm(event, kind) {
        event.preventDefault();
        if (state.saving) return;
        const form = event.target;
        if (!form.reportValidity()) return;
        const data = Object.fromEntries(new FormData(form));
        const edit = kind === 'material' ? state.materialEdit : state.entryEdit;
        if (kind === 'material' && edit) {
            data.version = edit.version;
            // Disabled locked values still travel for explicit server-side verification.
            for (const name of ['unit', 'opening_quantity', 'opening_date']) data[name] = form.elements[name].value;
        }
        if (kind === 'entry') {
            data.material_id = state.register.material.id;
            data.version = state.register.material.version;
        }
        showError(kind + 'Error', '');
        const submit = form.querySelector('[type="submit"]');
        const originalLabel = submit.textContent;
        const buttons = [...form.querySelectorAll('button')];
        state.saving = true;
        buttons.forEach(button => { button.disabled = true; });
        submit.textContent = 'Saving…';
        try {
            const result = await api(kind === 'material' ? 'materials' : 'entries', { method: edit ? 'PUT' : 'POST', data, query: edit ? { id: edit.id } : {} });
            if (kind === 'material') state.materialId = Number(result.material.id);
            else { state.month = data.entry_date.slice(0, 7); $('monthSelect').value = state.month; }
            $(kind + 'Dialog').close();
            notify(kind === 'material' ? 'Material saved successfully.' : 'Daily entry saved. Balances are up to date.');
            await refresh();
        } catch (error) {
            showError(kind + 'Error', error.message);
            $(kind + 'Error').scrollIntoView({ block: 'nearest' });
        } finally {
            state.saving = false;
            buttons.forEach(button => { button.disabled = false; });
            submit.textContent = originalLabel;
        }
    }

    document.addEventListener('click', event => {
        const button = event.target.closest('button');
        if (!button) return;
        if (button.dataset.close && !state.saving) $(button.dataset.close).close();
        if (button.dataset.editMaterial) openMaterial(state.materials.find(m => Number(m.id) === Number(button.dataset.editMaterial)));
        if (button.dataset.register) openRegister(button.dataset.register);
        if (button.dataset.editEntry) openEntry(state.register?.entries.find(e => Number(e.id) === Number(button.dataset.editEntry)));
        if (button.dataset.addDate) openEntry(null, button.dataset.addDate);
        if (button.dataset.stock) {
            state.stockFilter = button.dataset.stock;
            document.querySelectorAll('[data-stock]').forEach(tab => { const active = tab === button; tab.classList.toggle('active', active); tab.setAttribute('aria-pressed', String(active)); });
            renderOverview();
        }
    });
    $('materialSelect').addEventListener('change', () => { state.materialId = Number($('materialSelect').value); loadRegister(); });
    $('monthSelect').addEventListener('change', () => {
        if (!$('monthSelect').value || !$('monthSelect').checkValidity()) { $('monthSelect').value = state.month; return; }
        state.month = $('monthSelect').value;
        loadRegister();
    });
    $('materialSearch').addEventListener('input', renderMaterials);
    $('categoryFilter').addEventListener('change', renderMaterials);
    $('retryButton').addEventListener('click', refresh);
    $('materialForm').addEventListener('submit', event => saveForm(event, 'material'));
    $('entryForm').addEventListener('submit', event => saveForm(event, 'entry'));
    $('entryForm').addEventListener('input', entryPreview);
    document.querySelectorAll('dialog').forEach(dialog => dialog.addEventListener('cancel', event => { if (state.saving) event.preventDefault(); }));
    if (canWrite) {
        $('addMaterial').addEventListener('click', () => openMaterial());
        $('addEntry').addEventListener('click', () => openEntry());
        $('setupStock').addEventListener('click', () => openMaterial(state.materials.find(m => Number(m.id) === Number(state.materialId))));
    }
    $('exportRegister').addEventListener('click', () => {
        if (!state.register) return;
        const query = new URLSearchParams({ action: 'export', material_id: state.materialId, month: state.month });
        window.location.assign(`api.php?${query}`);
    });
    $('printRegister').addEventListener('click', () => { if (state.register) window.print(); });
    $('exportMaterials').addEventListener('click', () => { window.location.assign('api.php?action=export_materials'); });
    $('printMaterials').addEventListener('click', () => window.print());
    $('exportOverview').addEventListener('click', () => { window.location.assign('api.php?action=export_overview'); });
    $('printOverview').addEventListener('click', () => window.print());
    $('helpButton').addEventListener('click', () => $('helpDialog').showModal());
    $('menuToggle').addEventListener('click', () => {
        const open = document.body.classList.toggle('sidebar-open');
        $('sidebarScrim').hidden = !open;
        $('menuToggle').setAttribute('aria-expanded', String(open));
    });
    $('sidebarScrim').addEventListener('click', closeSidebar);
    document.addEventListener('keydown', event => { if (event.key === 'Escape') closeSidebar(); });
    $('themeToggle').addEventListener('click', () => {
        const theme = document.documentElement.dataset.theme === 'dark' ? 'light' : 'dark';
        document.documentElement.dataset.theme = theme;
        try { localStorage.setItem('mcc-inventory-theme', theme); } catch { /* Theme still works with storage disabled. */ }
    });
    try { const theme = localStorage.getItem('mcc-inventory-theme'); if (['light', 'dark'].includes(theme)) document.documentElement.dataset.theme = theme; } catch { /* Use the default theme. */ }
    window.addEventListener('hashchange', setView);
    setView();
    refresh();
})();
