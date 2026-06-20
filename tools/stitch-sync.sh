#!/usr/bin/env bash
#
# Pull Stitch design tokens into .stitch/ for diff before editing Sass tokens.
#
# Reference (frozen):
#   Project: Calm Technical Portfolio Command Center
#   Project ID: 12642385017382224523
#   Screen: Portfolio - Interactive Glass Refinement
#   Screen ID: 4c4e07b072854526a105f88f373d1633
#
# Usage:
#   export STITCH_API_KEY="..."   # https://stitch.withgoogle.com/settings
#   bash tools/stitch-sync.sh
#   bash tools/stitch-sync.sh --summary
#   bash tools/stitch-sync.sh --screen-only
#
# Output (gitignored via .gitignore `.*`):
#   .stitch/design-theme.json
#   .stitch/screen-reference.json
#   .stitch/sync-meta.json

set -eu

STITCH_MCP_URL="https://stitch.googleapis.com/mcp"
STITCH_PROJECT_ID="12642385017382224523"
STITCH_SCREEN_ID="4c4e07b072854526a105f88f373d1633"

WORK_DIR="$(cd "$(dirname "$0")/.." && pwd)"
OUT_DIR="${WORK_DIR}/.stitch"

SUMMARY=false
SCREEN_ONLY=false

while [[ $# -gt 0 ]]; do
  case "$1" in
    --summary) SUMMARY=true; shift ;;
    --screen-only) SCREEN_ONLY=true; shift ;;
    -h|--help)
      sed -n '2,20p' "$0" | sed 's/^# \?//'
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

_stitch_call() {
  local tool_name="$1"
  local args_json="$2"
  curl -sS -X POST "$STITCH_MCP_URL" \
    -H "Content-Type: application/json" \
    -H "X-Goog-Api-Key: $STITCH_API_KEY" \
    -d "{\"jsonrpc\":\"2.0\",\"id\":1,\"method\":\"tools/call\",\"params\":{\"name\":\"${tool_name}\",\"arguments\":${args_json}}}"
}

_write_project_export() {
  local response_file="$1"
  local out_path="$2"
  python3 - "$out_path" "$response_file" <<'PY'
import json, sys
out_path, response_file = sys.argv[1], sys.argv[2]
with open(response_file, encoding="utf-8") as f:
    raw = json.load(f)
if "error" in raw:
    print(json.dumps(raw, indent=2), file=sys.stderr)
    sys.exit(1)
content = raw.get("result", {}).get("content") or []
if not content:
    print("Empty Stitch response", file=sys.stderr)
    sys.exit(1)
payload = json.loads(content[0]["text"])
project = payload.get("project", payload)
theme = project.get("designTheme") or {}
export = {
    "source": "stitch.get_project",
    "projectId": project.get("name", "").replace("projects/", ""),
    "title": project.get("title"),
    "designTheme": theme,
}
with open(out_path, "w", encoding="utf-8") as f:
    json.dump(export, f, indent=2, ensure_ascii=False)
    f.write("\n")
print(f"Wrote {out_path}")
PY
}

_write_screen_export() {
  local response_file="$1"
  local out_path="$2"
  python3 - "$out_path" "$response_file" <<'PY'
import json, sys
out_path, response_file = sys.argv[1], sys.argv[2]
with open(response_file, encoding="utf-8") as f:
    raw = json.load(f)
if "error" in raw:
    print(json.dumps(raw, indent=2), file=sys.stderr)
    sys.exit(1)
content = raw.get("result", {}).get("content") or []
if not content:
    print("Empty Stitch response", file=sys.stderr)
    sys.exit(1)
payload = json.loads(content[0]["text"])
screen = payload.get("screen", payload)
export = {
    "source": "stitch.get_screen",
    "projectId": "12642385017382224523",
    "screenId": "4c4e07b072854526a105f88f373d1633",
    "screen": {
        k: screen.get(k)
        for k in ("name", "title", "width", "height", "deviceType", "htmlCode", "screenshot")
        if k in screen
    },
}
with open(out_path, "w", encoding="utf-8") as f:
    json.dump(export, f, indent=2, ensure_ascii=False)
    f.write("\n")
print(f"Wrote {out_path}")
PY
}

mkdir -p "$OUT_DIR"
_resolve_api_key

TMP_RESPONSE="$(mktemp)"
trap 'rm -f "$TMP_RESPONSE"' EXIT

if [[ "$SCREEN_ONLY" != true ]]; then
  echo "Fetching Stitch project projects/${STITCH_PROJECT_ID}..." >&2
  _stitch_call "get_project" "{\"name\":\"projects/${STITCH_PROJECT_ID}\"}" > "$TMP_RESPONSE"
  _write_project_export "$TMP_RESPONSE" "${OUT_DIR}/design-theme.json"
fi

echo "Fetching Stitch screen .../${STITCH_SCREEN_ID}..." >&2
_stitch_call "get_screen" "{\"name\":\"projects/${STITCH_PROJECT_ID}/screens/${STITCH_SCREEN_ID}\"}" > "$TMP_RESPONSE"
_write_screen_export "$TMP_RESPONSE" "${OUT_DIR}/screen-reference.json"

python3 - <<PY
import json, datetime
meta = {
    "syncedAt": datetime.datetime.now(datetime.timezone.utc).replace(microsecond=0).isoformat().replace("+00:00", "Z"),
    "projectId": "${STITCH_PROJECT_ID}",
    "screenId": "${STITCH_SCREEN_ID}",
    "files": [
        ".stitch/design-theme.json",
        ".stitch/screen-reference.json",
    ],
}
with open("${OUT_DIR}/sync-meta.json", "w", encoding="utf-8") as f:
    json.dump(meta, f, indent=2)
    f.write("\n")
print("Wrote ${OUT_DIR}/sync-meta.json")
PY

if [[ "$SUMMARY" == true && -f "${OUT_DIR}/design-theme.json" ]]; then
  python3 - "${OUT_DIR}/design-theme.json" "${WORK_DIR}/assets/css/tokens/_color.scss" <<'PY'
import json, re, sys
theme_path, color_scss = sys.argv[1], sys.argv[2]
with open(theme_path, encoding="utf-8") as f:
    theme = json.load(f)["designTheme"]
nc = theme.get("namedColors") or {}
scss = open(color_scss, encoding="utf-8").read()

def scss_val(token):
    m = re.search(rf"^\s*{re.escape(token)}:\s*([^,]+),?\s*$", scss, re.M)
    return m.group(1).strip() if m else "—"

rows = [
    ("bg-canvas", "background", nc.get("background")),
    ("text-primary", "on_surface", nc.get("on_surface")),
    ("text-secondary", "on_surface_variant", nc.get("on_surface_variant")),
    ("text-tertiary", "outline", nc.get("outline")),
    ("domain-analysis", "overridePrimary", theme.get("overridePrimaryColor")),
    ("domain-ml", "overrideSecondary", theme.get("overrideSecondaryColor")),
    ("domain-vision", "overrideTertiary", theme.get("overrideTertiaryColor")),
    ("domain-bi", "primary_container", nc.get("primary_container")),
    ("domain-economics", "secondary", nc.get("secondary")),
]

print("\n=== Stitch → Sass token diff hint ===")
print(f"{'Sass token':<22} {'Stitch':<28} {'_color.scss':<28}")
print("-" * 78)
for sass_key, stitch_key, stitch_val in rows:
    stitch_val = stitch_val or "—"
    current = scss_val(sass_key)
    flag = " ✓" if str(stitch_val).lower() == current.lower() else " ≠"
    print(f"{sass_key:<22} {str(stitch_val):<28} {current:<28}{flag}")
print("\nNext: align assets/css/tokens/ then run: bundle exec jekyll build")
PY
fi

echo "Done. Review .stitch/ before editing assets/css/tokens/" >&2
