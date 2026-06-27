#!/usr/bin/env python3
"""Read-only SEO batch: GSC sitemap status + URL inspection + GTM Live audit.

Requires: google_creds.json at ~/mcp_servers/ (service account).
Usage: uv run --with google-api-python-client --with google-auth python tools/seo-batch.py
"""
from __future__ import annotations

import json
import sys
from datetime import datetime, timezone
from pathlib import Path

from google.oauth2 import service_account
from googleapiclient.discovery import build

ROOT = Path(__file__).resolve().parents[1]
CREDS = Path.home() / "mcp_servers" / "google_creds.json"
SITE = "https://ccamilocristian.github.io/"
SITEMAP = "https://ccamilocristian.github.io/sitemap.xml"
GTM_CP = "accounts/6361961802/containers/256082250"


def _urls() -> list[str]:
    yml = ROOT / "_data" / "gsc_index_urls.yml"
    urls: list[str] = []
    for line in yml.read_text().splitlines():
        line = line.strip()
        if line.startswith("- https://"):
            urls.append(line[2:].strip())
    hub = "https://ccamilocristian.github.io/tabs/intelligence/"
    if hub not in urls:
        urls.append(hub)
    return urls


def main() -> int:
    if not CREDS.exists():
        print(f"[ERROR] Missing {CREDS}", file=sys.stderr)
        return 1

    report: dict = {"generated": datetime.now(timezone.utc).isoformat(), "tasks": {}}

    creds_ro = service_account.Credentials.from_service_account_file(
        str(CREDS), scopes=["https://www.googleapis.com/auth/webmasters.readonly"]
    )
    gsc = build("searchconsole", "v1", credentials=creds_ro)

    try:
        sm = gsc.sitemaps().get(siteUrl=SITE, feedpath=SITEMAP).execute()
        report["tasks"]["T23d"] = {
            "lastSubmitted": sm.get("lastSubmitted"),
            "lastDownloaded": sm.get("lastDownloaded"),
            "isPending": sm.get("isPending"),
            "warnings": sm.get("warnings"),
            "errors": sm.get("errors"),
            "contents": sm.get("contents"),
        }
    except Exception as e:
        report["tasks"]["T23d"] = {"error": str(e)}

    results = []
    indexed = pending = 0
    for url in _urls():
        r = gsc.urlInspection().index().inspect(
            body={"inspectionUrl": url, "siteUrl": SITE}
        ).execute()
        ir = r.get("inspectionResult", {})
        idx = ir.get("indexStatusResult", {})
        cov = idx.get("coverageState", "")
        needs = "indexed" not in cov.lower()
        pending += int(needs)
        indexed += int(not needs)
        results.append(
            {
                "url": url.replace("https://ccamilocristian.github.io", ""),
                "coverage": cov,
                "needs_manual_request": needs,
            }
        )
    report["tasks"]["T24"] = {
        "indexed": indexed,
        "pending": pending,
        "total": len(results),
        "results": results,
    }

    creds_gtm = service_account.Credentials.from_service_account_file(
        str(CREDS), scopes=["https://www.googleapis.com/auth/tagmanager.readonly"]
    )
    gtm = build("tagmanager", "v2", credentials=creds_gtm)
    ver = gtm.accounts().containers().versions().live(parent=GTM_CP).execute()
    report["tasks"]["GTM"] = {
        "containerVersionId": ver.get("containerVersionId"),
        "tags": [t["name"] for t in ver.get("tag", [])],
    }

    out = ROOT / "docs" / f"SEO_BATCH_{datetime.now(timezone.utc).strftime('%Y-%m-%d')}.json"
    out.write_text(json.dumps(report, indent=2) + "\n")
    print(json.dumps(report, indent=2))
    print(f"\n[WROTE] {out}")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
