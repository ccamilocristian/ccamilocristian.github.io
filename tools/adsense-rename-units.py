#!/usr/bin/env python3
"""Rename AdSense ad units to match site_ops placement names (T26b).

Requires OAuth token with scope https://www.googleapis.com/auth/adsense
Re-run: uv run --with google-auth-oauthlib generate_adsense_token.py (mcp_servers, write scope)

Usage:
  ADSENSE_TOKEN=~/mcp_servers/adsense_token.json \\
  uv run --with google-api-python-client --with google-auth --with google-auth-oauthlib \\
    python tools/adsense-rename-units.py [--dry-run]
"""
from __future__ import annotations

import argparse
import os
import re
import sys
from pathlib import Path

from google.oauth2.credentials import Credentials
from googleapiclient.discovery import build

ROOT = Path(__file__).resolve().parents[1]
DEFAULT_TOKEN = Path.home() / "mcp_servers" / "adsense_token.json"
SCOPE = "https://www.googleapis.com/auth/adsense"

LABELS = {
    "in_article": "site-in-article",
    "post_footer": "site-post-footer",
    "sidebar": "site-sidebar-300x250",
    "mid_article": "site-mid-article-native",
    "home_bridge": "site-home-bridge",
    "in_feed": "site-intelligence-in-feed",
}


def _load_adsense_config() -> tuple[str, dict[str, str]]:
    text = (ROOT / "_data" / "site_ops.yml").read_text()
    client = re.search(r"client:\s*(ca-pub-\d+)", text)
    if not client:
        raise ValueError("adsense.client missing in site_ops.yml")
    slots: dict[str, str] = {}
    in_slots = False
    for line in text.splitlines():
        if re.match(r"\s+slots:\s*$", line):
            in_slots = True
            continue
        if in_slots:
            m = re.match(r"\s+(\w+):\s*\"(\d+)\"", line)
            if m:
                slots[m.group(1)] = m.group(2)
                continue
            if re.match(r"\s+\w", line) and not line.strip().startswith("#"):
                break
    return client.group(1), slots


def main() -> int:
    parser = argparse.ArgumentParser()
    parser.add_argument("--dry-run", action="store_true")
    parser.add_argument("--token", type=Path, default=Path(os.environ.get("ADSENSE_TOKEN", DEFAULT_TOKEN)))
    args = parser.parse_args()

    if not args.token.exists():
        print(f"[ERROR] Token not found: {args.token}", file=sys.stderr)
        print("Re-auth with write scope in ~/mcp_servers/generate_adsense_token.py", file=sys.stderr)
        return 1

    try:
        client_id, slots = _load_adsense_config()
    except ValueError as e:
        print(f"[ERROR] {e}", file=sys.stderr)
        return 1
    account = client_id.replace("ca-", "")
    parent = f"accounts/{account}/adclients/{client_id}"

    creds = Credentials.from_authorized_user_file(str(args.token), [SCOPE])
    client = build("adsense", "v2", credentials=creds)

    ok = fail = 0
    for key, slot_id in slots.items():
        label = LABELS.get(key, f"site-{key.replace('_', '-')}")
        path = f"{parent}/adunits/{slot_id}"
        if args.dry_run:
            print(f"[dry-run] {slot_id} -> {label}")
            ok += 1
            continue
        try:
            updated = (
                client.accounts()
                .adclients()
                .adunits()
                .patch(name=path, updateMask="displayName", body={"displayName": label})
                .execute()
            )
            print(f"OK {slot_id} -> {updated.get('displayName')}")
            ok += 1
        except Exception as e:
            print(f"FAIL {slot_id}: {e}", file=sys.stderr)
            fail += 1

    print(f"\nDone: {ok} ok, {fail} failed")
    return 0 if fail == 0 else 1


if __name__ == "__main__":
    raise SystemExit(main())
