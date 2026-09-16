#!/usr/bin/env bash
# Submit sitemap to Bing Webmaster API (requires API key once from Bing UI).
#
# Key resolution order:
#   1) $BING_WEBMASTER_API_KEY
#   2) _data/site_ops.yml → bing.webmaster_api_key  (do NOT commit real keys)
#
# Usage: bash tools/bing-submit-sitemap.sh
set -euo pipefail
ROOT="$(cd "$(dirname "$0")/.." && pwd)"
SITE="https://ccamilocristian.github.io"
FEED="$SITE/sitemap.xml"

KEY="${BING_WEBMASTER_API_KEY:-}"
if [ -z "$KEY" ]; then
  KEY=$(awk '
    /^bing:/ {f=1; next}
    f && /^[a-z]/ {exit}
    f && /webmaster_api_key:/ {
      gsub(/["'\'']/, "", $2); print $2; exit
    }
  ' "$ROOT/_data/site_ops.yml" 2>/dev/null || true)
fi

if [ -z "${KEY:-}" ] || [ "$KEY" = "null" ] || [ "$KEY" = '""' ]; then
  cat >&2 <<EOF
[SKIP] Bing Webmaster API key not configured.

To automate sitemap submit (one-time setup — you):
  1. https://www.bing.com/webmasters → add/verify $SITE
  2. Settings → API Access → generate API key
  3. export BING_WEBMASTER_API_KEY='…'   # or put under site_ops bing.webmaster_api_key locally (gitignored via secrets)

Until then IndexNow (tools/indexnow-ping.sh) still notifies Bing of URL changes.
EOF
  exit 0
fi

echo "[INFO] Bing SubmitFeed $FEED"
HTTP=$(curl -sS -o /tmp/bing-submit-feed.json -w "%{http_code}" \
  -X POST "https://ssl.bing.com/webmaster/api.svc/json/SubmitFeed?apikey=${KEY}" \
  -H "Content-Type: application/json; charset=utf-8" \
  -d "{\"siteUrl\":\"${SITE}\",\"feedUrl\":\"${FEED}\"}")
echo "[INFO] HTTP $HTTP"
cat /tmp/bing-submit-feed.json 2>/dev/null || true
echo
if [ "$HTTP" != "200" ]; then
  echo "[ERROR] Bing SubmitFeed failed" >&2
  exit 1
fi
echo "[OK] Bing sitemap submitted."
