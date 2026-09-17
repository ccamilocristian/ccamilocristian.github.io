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
  mapfile -t URLS < <(python3 - "$WORK_DIR/_data/gsc_index_urls.yml" <<'PY'
from pathlib import Path
import sys

in_priority = False
for raw_line in Path(sys.argv[1]).read_text().splitlines():
    if raw_line.startswith("priority:"):
        in_priority = True
        continue
    if in_priority and raw_line and not raw_line.startswith(" "):
        break
    line = raw_line.strip()
    if in_priority and line.startswith("- https://"):
        print(line[2:])
PY
)
fi

for url in "${URLS[@]}"; do
  case "$url" in
    "https://$HOST/"*) ;;
    *)
      echo "[ERROR] URL must use canonical host $HOST: $url" >&2
      exit 1
      ;;
  esac
done

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
HTTP=$(curl -sS -o /tmp/indexnow-response.json -w "%{http_code}" -X POST "https://api.indexnow.org/indexnow" \
  -H "Content-Type: application/json; charset=utf-8" \
  -d "$JSON" || true)
RESP=$(cat /tmp/indexnow-response.json 2>/dev/null || true)
echo "$RESP"
echo "[INFO] HTTP $HTTP — Done."

# Durable local log for IDX-B2 diffs (no secrets beyond public keyLocation already in JSON)
LOG_DIR="$WORK_DIR/docs/indexing"
mkdir -p "$LOG_DIR"
LOG_FILE="$LOG_DIR/indexnow-history.ndjson"
TS=$(date -u +"%Y-%m-%dT%H:%M:%SZ")
python3 - "$LOG_FILE" "$TS" "$HTTP" "$RESP" "${URLS[@]}" <<'PY'
import json, sys
from pathlib import Path
log_path, ts, http, resp, *urls = sys.argv[1:]
entry = {
    "ts": ts,
    "http": http,
    "urlCount": len(urls),
    "urls": urls,
    "response": (resp or "")[:500],
}
with Path(log_path).open("a", encoding="utf-8") as f:
    f.write(json.dumps(entry, ensure_ascii=False) + "\n")
print(f"[INFO] Appended {len(urls)} URL(s) → {log_path}")
PY
