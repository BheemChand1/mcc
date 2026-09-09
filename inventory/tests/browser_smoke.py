"""Optional end-to-end checks. Requires Python Playwright and installed Chromium.

Run: python3 inventory/tests/browser_smoke.py
Uses an isolated temporary SQLite database; never changes the real inventory.
"""
from contextlib import contextmanager
from pathlib import Path
from tempfile import TemporaryDirectory
import json
import os
import re
import socket
import subprocess
import time
import urllib.error
import urllib.request

from playwright.sync_api import sync_playwright, expect

ROOT = Path(__file__).resolve().parents[1]
ARTIFACTS = ROOT / "tests" / "artifacts"
ARTIFACTS.mkdir(exist_ok=True)


@contextmanager
def server(directory, local=True):
    with socket.socket() as sock:
        sock.bind(("127.0.0.1", 0))
        port = sock.getsockname()[1]
    env = dict(os.environ, INVENTORY_LOCAL_DEV="1" if local else "0",
               INVENTORY_DB_PATH=str(Path(directory) / "test.sqlite"))
    session_dir = Path(directory) / "sessions"
    session_dir.mkdir(exist_ok=True)
    log = open(ARTIFACTS / ("local-server.log" if local else "session-server.log"), "w")
    process = subprocess.Popen(["php", "-d", f"session.save_path={session_dir}", "-S", f"127.0.0.1:{port}",
                                "-t", str(ROOT), str(ROOT / "router.php")], env=env, stdout=log, stderr=log)
    base = f"http://127.0.0.1:{port}"
    try:
        for _ in range(100):
            try:
                urllib.request.urlopen(base + "/assets/styles.css", timeout=1)
                break
            except (OSError, urllib.error.URLError):
                if process.poll() is not None:
                    raise RuntimeError("PHP test server could not start")
                time.sleep(.05)
        else:
            raise RuntimeError("PHP test server did not become ready")
        yield base, session_dir
    finally:
        process.terminate()
        process.wait(timeout=10)
        log.close()


def prepare_session(session_dir, sid, role, station=1):
    code = "session_id($argv[1]); session_start(); $_SESSION=['user_id'=>999, 'station_id'=>(int)$argv[3], 'role'=>$argv[2], 'user_name'=>'Test user']; session_write_close();"
    subprocess.run(["php", "-d", f"session.save_path={session_dir}", "-r", code, sid, role, str(station)], check=True)


def main():
    with TemporaryDirectory(prefix="inventory-e2e-") as directory, sync_playwright() as p:
        browser = p.chromium.launch(headless=True)
        errors = []
        with server(directory) as (base, _):
            context = browser.new_context(viewport={"width": 1440, "height": 1100}, device_scale_factor=1)
            page = context.new_page()
            page.on("pageerror", lambda error: errors.append(str(error)))
            page.goto(base)
            expect(page.locator("#totalMaterials")).to_have_text("35")
            expect(page.locator("#registerContent")).to_be_visible()
            expect(page.locator("#pendingStock")).to_have_text("35")
            page.screenshot(path=str(ARTIFACTS / "desktop-empty.png"), full_page=True)

            for path in ["/storage/inventory.sqlite", "/database/schema.sql", "/src/Database.php", "/tests/run.php", "/.gitignore", "/router.php"]:
                assert context.request.get(base + path).status == 404, path
            response = context.request.post(base + "/api.php?action=materials", data={"name": "Invalid"})
            assert response.status == 403, "CSRF missing must be rejected"

            page.locator("#setupStock").click()
            form = page.locator("#materialForm")
            form.locator('[name="opening_quantity"]').fill("536")
            form.locator('[name="opening_date"]').fill("2020-08-01")
            form.locator('[name="minimum_quantity"]').fill("50")
            form.get_by_role("button", name="Save material", exact=True).click()
            expect(page.locator("#materialDialog")).not_to_be_visible()
            expect(page.locator("#pendingStock")).to_have_text("34")
            page.locator("#monthSelect").fill("2020-08")
            expect(page.locator("#registerMonthLabel")).to_have_text("August 2020")

            def add_entry(date, used, received="0", expected=""):
                page.locator(f'[data-add-date="{date}"]').click()
                entry_form = page.locator("#entryForm")
                entry_form.locator('[name="used_quantity"]').fill(used)
                entry_form.locator('[name="received_quantity"]').fill(received)
                entry_form.locator('[name="supervisor"]').fill("AB")
                entry_form.locator('[name="je_sse"]').fill("CD")
                entry_form.locator('[name="notes"]').fill("=1+1")
                if expected:
                    expect(page.locator("#entryClosing")).to_have_text(expected)
                entry_form.get_by_role("button", name="Save daily entry").click()
                expect(page.locator("#entryDialog")).not_to_be_visible()
                expect(page.locator(f'[aria-label="Edit entry for {date}"]')).to_be_visible()

            add_entry("2020-08-01", "8", expected="528 L")
            add_entry("2020-08-02", "7", expected="521 L")
            add_entry("2020-08-12", "8", "450", "963 L")
            expect(page.locator("#monthClosing")).to_have_text("963 L")
            page.locator('[aria-label="Edit entry for 2020-08-01"]').click()
            page.locator('#entryForm [name="used_quantity"]').fill("10")
            expect(page.locator("#entryClosing")).to_have_text("526 L")
            page.locator("#entryForm").get_by_role("button", name="Save daily entry").click()
            expect(page.locator("#entryDialog")).not_to_be_visible()
            expect(page.locator("#monthClosing")).to_have_text("961 L")

            page.locator('[aria-label="Edit entry for 2020-08-01"]').click()
            page.locator('#entryForm [name="used_quantity"]').fill("600")
            page.locator("#entryForm").get_by_role("button", name="Save daily entry").click()
            expect(page.locator("#entryError")).to_contain_text("negative")
            page.locator("#entryForm").get_by_role("button", name="Cancel", exact=True).click()
            expect(page.locator("#monthClosing")).to_have_text("961 L")

            with page.expect_download() as download_info:
                page.locator("#exportRegister").click()
            download = download_info.value
            download.save_as(str(ARTIFACTS / "register.csv"))
            csv = (ARTIFACTS / "register.csv").read_text(encoding="utf-8-sig")
            assert "536,10,0,526" in csv and "'=1+1" in csv
            page.screenshot(path=str(ARTIFACTS / "desktop-register.png"), full_page=True)
            page.emulate_media(media="print")
            page.pdf(path=str(ARTIFACTS / "register-print.pdf"), prefer_css_page_size=True, print_background=True)
            page.emulate_media(media="screen")

            page.get_by_role("link", name=re.compile("Material master")).click()
            page.locator("#materialSearch").fill("glass")
            expect(page.locator("#materialsBody tr")).to_have_count(2)
            page.locator("#materialSearch").fill("heavy duty")
            page.locator('[data-edit-material="1"]').click()
            expect(page.locator('#materialForm [name="unit"]')).to_be_disabled()
            expect(page.locator('#materialForm [name="opening_quantity"]')).to_be_disabled()
            page.locator('#materialForm [name="minimum_quantity"]').fill("1000")
            page.locator("#materialForm").get_by_role("button", name="Save material").click()
            expect(page.locator("#materialDialog")).not_to_be_visible()
            expect(page.locator("#lowStock")).to_have_text("1")
            page.get_by_role("link", name="Stock overview", exact=True).click()
            page.locator('[data-stock="low"]').click()
            expect(page.locator("#overviewBody tr")).to_have_count(1)
            expect(page.locator("#overviewBody")).to_contain_text("961 L")

            page.locator("#addMaterial").click()
            form.locator('[name="name"]').fill("Heavy Duty Exterior Washing Liquid")
            form.get_by_role("button", name="Save material", exact=True).click()
            expect(page.locator("#materialError")).to_contain_text("already exists")
            form.locator('[name="name"]').fill('<img src=x onerror="alert(1)"> Test chemical')
            form.locator('[name="opening_quantity"]').fill("10.125")
            form.get_by_role("button", name="Save material", exact=True).click()
            expect(page.locator("#materialDialog")).not_to_be_visible()
            expect(page.locator("#totalMaterials")).to_have_text("36")
            page.get_by_role("link", name=re.compile("Material master")).click()
            page.locator("#materialSearch").fill("Test chemical")
            expect(page.locator("#materialsBody")).to_contain_text('<img src=x onerror="alert(1)">')
            assert page.locator("#materialsBody img").count() == 0, "Names must be escaped"
            page.locator("#materialSearch").fill("")
            page.screenshot(path=str(ARTIFACTS / "desktop-materials.png"), full_page=True)

            page.locator('[data-register="1"]').first.click()
            expect(page.locator("#registerMaterialName")).to_have_text("Heavy Duty Exterior Washing Liquid")
            page.locator("#themeToggle").click()
            expect(page.locator("html")).to_have_attribute("data-theme", "light")
            page.screenshot(path=str(ARTIFACTS / "desktop-light.png"), full_page=True)
            page.reload()
            expect(page.locator("html")).to_have_attribute("data-theme", "light")
            expect(page.locator("#totalMaterials")).to_have_text("36")

            mobile = context.new_page()
            mobile.set_viewport_size({"width": 390, "height": 844})
            mobile.on("pageerror", lambda error: errors.append(str(error)))
            mobile.goto(base)
            expect(mobile.locator("#registerContent")).to_be_visible()
            mobile.locator("#themeToggle").click()
            mobile.screenshot(path=str(ARTIFACTS / "mobile-register.png"), full_page=True)
            assert mobile.evaluate("document.documentElement.scrollWidth <= window.innerWidth"), "Mobile page must not overflow horizontally"
            mobile.locator("#menuToggle").click()
            expect(mobile.locator("#menuToggle")).to_have_attribute("aria-expanded", "true")
            mobile.get_by_role("link", name=re.compile("Material master")).click()
            expect(mobile.locator("#materialsView")).to_be_visible()
            expect(mobile.locator("#menuToggle")).to_have_attribute("aria-expanded", "false")
            mobile.locator("#addMaterial").click()
            expect(mobile.locator("#materialDialog")).to_be_visible()
            mobile.screenshot(path=str(ARTIFACTS / "mobile-form.png"), full_page=True)
            context.close()

        # The same session rules used when this module is hosted beside MCC.
        with server(directory, local=False) as (base, session_dir):
            anon = browser.new_context()
            response = anon.request.get(base + "/api.php?action=materials")
            assert response.status == 401
            response = anon.request.get(base + "/", max_redirects=0)
            assert response.status == 302 and response.headers["location"] == "../index.php"
            anon.close()

            prepare_session(session_dir, "inventory-viewer-test", "VIEWER")
            viewer = browser.new_context()
            viewer.add_cookies([{"name": "PHPSESSID", "value": "inventory-viewer-test", "url": base}])
            page = viewer.new_page()
            page.goto(base)
            expect(page.locator("#totalMaterials")).to_have_text("36")
            assert page.locator("#addMaterial").count() == 0
            assert page.locator("#addEntry").count() == 0
            token = page.locator('meta[name="csrf-token"]').get_attribute("content")
            response = viewer.request.post(base + "/api.php?action=materials", data={"name": "No permission"}, headers={"X-CSRF-Token": token})
            assert response.status == 403
            viewer.close()

            prepare_session(session_dir, "inventory-editor-test", "CDO")
            editor = browser.new_context()
            editor.add_cookies([{"name": "PHPSESSID", "value": "inventory-editor-test", "url": base}])
            page = editor.new_page()
            page.goto(base)
            expect(page.locator("#addMaterial")).to_be_visible()
            expect(page.locator("#registerContent")).to_be_visible()
            token = page.locator('meta[name="csrf-token"]').get_attribute("content")
            headers = {"X-CSRF-Token": token, "Content-Type": "application/json"}
            invalid = editor.request.post(base + "/api.php?action=materials", data="{bad", headers=headers)
            assert invalid.status == 400
            badtype = editor.request.post(base + "/api.php?action=materials", data=json.dumps({"name": ["x"]}), headers=headers)
            assert badtype.status == 422
            cross_entry = editor.request.put(base + "/api.php?action=entries&id=1", data=json.dumps({"material_id": 2, "entry_date": "2020-08-01", "used_quantity": "0", "received_quantity": "0", "supervisor": "AB", "version": 1}), headers=headers)
            assert cross_entry.status == 422
            editor.close()

            prepare_session(session_dir, "inventory-other-station", "CDO", 2)
            other = browser.new_context()
            other.add_cookies([{"name": "PHPSESSID", "value": "inventory-other-station", "url": base}])
            assert other.request.get(base + "/api.php?action=materials").json()["materials"][0]["station_id"] == 2
            assert other.request.get(base + "/api.php?action=register&material_id=1&month=2020-08").status == 404
            assert other.request.get(base + "/api.php?action=export&material_id=1&month=2020-08").status == 404
            other.close()

        browser.close()
        assert not errors, errors
        print("PASS: Browser forms, ledger corrections, CSV, print, search, low stock, XSS escaping, responsive layout, theme persistence, route protection, authentication, viewer permissions, CSRF, JSON validation, and station isolation.")
        print(f"Screenshots and print output: {ARTIFACTS}")


if __name__ == "__main__":
    main()
