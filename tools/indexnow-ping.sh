#!/bin/bash
# Ping IndexNow after deploy (Bing, Yandex, and partners).
# Usage: bash tools/indexnow-ping.sh [url1 url2 ...]

set -eu

WORK_DIR=$(dirname "$(dirname "$(realpath "$0")")")
KEY=$(awk '/^indexnow:/ {f=1} f && /^  key:/ {print $2; exit}' "$WORK_DIR/_data/site_ops.yml")
HOST="ccamilocristian.github.io"

if [[ -z "${KEY:-}" ]]; then
  echo "[ERROR] indexnow.key missing in _data/site_ops.yml" >&2
  exit 1
fi

if [[ $# -gt 0 ]]; then
  URLS=("$@")
else
  mapfile -t URLS < <(grep -E '^\s+- https://' "$WORK_DIR/_data/gsc_index_urls.yml" | head -4 | sed 's/^[[:space:]]*- //')
fi

JSON=$(KEY="$KEY" HOST="$HOST" URLS="${URLS[*]}" python3 - <<'PY'
import json, os
urls = os.environ.get("URLS", "").split()
print(json.dumps({
    "host": os.environ["HOST"],
    "key": os.environ["KEY"],
    "keyLocation": f"https://{os.environ['HOST']}/{os.environ['KEY']}.txt",
    "urlList": urls,
}))
PY
)

echo "[INFO] IndexNow ping for ${#URLS[@]} URL(s)..."
curl -sS -X POST "https://api.indexnow.org/indexnow" \
  -H "Content-Type: application/json; charset=utf-8" \
  -d "$JSON"
echo
echo "[INFO] Done."
