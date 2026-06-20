#!/usr/bin/env bash
#
# Download Stitch HTML exports for inner dashboard tabs into .stitch/
#
# Project: Calm Technical Portfolio Command Center (12642385017382224523)
#
# Usage:
#   export STITCH_API_KEY="..."   # or configure stitch in ~/.cursor/mcp.json
#   bash tools/stitch-export-tabs.sh
#   bash tools/stitch-export-tabs.sh --profile   # include Profile screen
#   bash tools/stitch-export-tabs.sh --all       # include Command Center + Profile + 4 tabs
#
# Output:
#   .stitch/intelligence-export.html
#   .stitch/stack-export.html
#   .stitch/economics-lens-export.html
#   .stitch/vision-lab-export.html
#   .stitch/post-export.html
#   .stitch/exports-manifest.json

set -eu

STITCH_PROJECT_ID="12642385017382224523"
WORK_DIR="$(cd "$(dirname "$0")/.." && pwd)"
OUT_DIR="${WORK_DIR}/.stitch"

INCLUDE_PROFILE=false
INCLUDE_HOME=false

while [[ $# -gt 0 ]]; do
  case "$1" in
    --profile) INCLUDE_PROFILE=true; shift ;;
    --all) INCLUDE_PROFILE=true; INCLUDE_HOME=true; shift ;;
    -h|--help)
      sed -n '2,22p' "$0" | sed 's/^# \?//'
      exit 0
      ;;
    *)
      echo "Unknown option: $1" >&2
      exit 1
      ;;
  esac
done

_resolve_api_key() {
  if [[ -n "${STITCH_API_KEY:-}" ]]; then
    return 0
  fi
  if [[ -f "${HOME}/.cursor/mcp.json" ]] && command -v python3 >/dev/null 2>&1; then
    STITCH_API_KEY="$(python3 -c "
import json, os
p = os.path.expanduser('~/.cursor/mcp.json')
d = json.load(open(p))
print(d.get('mcpServers', {}).get('stitch', {}).get('headers', {}).get('X-Goog-Api-Key', ''))
" 2>/dev/null || true)"
    if [[ -n "$STITCH_API_KEY" ]]; then
      echo "Using STITCH_API_KEY from ~/.cursor/mcp.json" >&2
      return 0
    fi
  fi
  echo "Error: set STITCH_API_KEY or configure stitch in ~/.cursor/mcp.json" >&2
  exit 1
}

_resolve_api_key
mkdir -p "$OUT_DIR"

python3 - "$OUT_DIR" "$STITCH_PROJECT_ID" "$INCLUDE_PROFILE" "$INCLUDE_HOME" <<'PY'
import json, os, sys, urllib.request
from datetime import datetime, timezone

out_dir, project_id, include_profile, include_home = sys.argv[1:5]
include_profile = include_profile == "true"
include_home = include_home == "true"

api_key = os.environ.get("STITCH_API_KEY")
if not api_key:
    api_key = json.load(open(os.path.expanduser("~/.cursor/mcp.json")))["mcpServers"]["stitch"]["headers"]["X-Goog-Api-Key"]

SCREENS = {
    "intelligence-export.html": ("c81bd61929f54df8ae60e50425b68d96", "Intelligence - Glassmorphism Evolution"),
    "stack-export.html": ("fe6b8231195e470b9b5ab820cea599c1", "Stack - Glassmorphism Evolution"),
    "economics-lens-export.html": ("eed5bcc9f5a2476e816157f21b1d03ed", "Economics Lens - Glassmorphism Evolution"),
    "vision-lab-export.html": ("2fd9d452475b4e5e88d48d90bef6d74e", "Vision Lab - Interactive Evolution"),
    "post-export.html": ("9556cff129b54da1b80b7d3e49b866ed", "Single Post - Economics Brief Evolution"),
}

if include_profile:
    SCREENS["profile-export.html"] = ("db43e54604f64bf994be6e61c81313c0", "Profile - Glassmorphism Evolution")

if include_home:
    SCREENS["stitch-export.html"] = ("4c4e07b072854526a105f88f373d1633", "Portfolio - Interactive Glass Refinement")

def stitch_call(tool, args):
    payload = json.dumps({"jsonrpc": "2.0", "id": 1, "method": "tools/call", "params": {"name": tool, "arguments": args}}).encode()
    req = urllib.request.Request(
        "https://stitch.googleapis.com/mcp",
        data=payload,
        headers={"Content-Type": "application/json", "X-Goog-Api-Key": api_key},
    )
    with urllib.request.urlopen(req, timeout=120) as resp:
        raw = json.load(resp)
    if "error" in raw:
        raise RuntimeError(raw["error"])
    return json.loads(raw["result"]["content"][0]["text"])

manifest = {
    "exportedAt": datetime.now(timezone.utc).replace(microsecond=0).isoformat().replace("+00:00", "Z"),
    "projectId": project_id,
    "screens": [],
}

for filename, (screen_id, fallback_title) in SCREENS.items():
    print(f"Fetching {fallback_title} ({screen_id})...", flush=True)
    data = stitch_call("get_screen", {"name": f"projects/{project_id}/screens/{screen_id}"})
    screen = data.get("screen", data)
    url = (screen.get("htmlCode") or {}).get("downloadUrl")
    if not url:
        raise RuntimeError(f"No downloadUrl for screen {screen_id}")
    out_path = os.path.join(out_dir, filename)
    with urllib.request.urlopen(url, timeout=120) as resp:
        html = resp.read()
    with open(out_path, "wb") as f:
        f.write(html)
    print(f"  Wrote {out_path} ({len(html)} bytes)", flush=True)
    manifest["screens"].append({
        "file": f".stitch/{filename}",
        "screenId": screen_id,
        "title": screen.get("title", fallback_title),
        "deviceType": screen.get("deviceType"),
        "bytes": len(html),
    })

manifest_path = os.path.join(out_dir, "exports-manifest.json")
with open(manifest_path, "w", encoding="utf-8") as f:
    json.dump(manifest, f, indent=2)
    f.write("\n")
print(f"Done. Manifest: {manifest_path}")
PY

echo "Review .stitch/*-export.html before Sass/Liquid migration." >&2
