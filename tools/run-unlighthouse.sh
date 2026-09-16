#!/usr/bin/env bash
# Run Unlighthouse against production (default) or a local Jekyll server.
# Usage:
#   bash tools/run-unlighthouse.sh
#   bash tools/run-unlighthouse.sh --local
#   bash tools/run-unlighthouse.sh --repair-chrome
set -euo pipefail
ROOT="$(cd "$(dirname "$0")/.." && pwd)"
cd "$ROOT"

if ! command -v npm >/dev/null 2>&1; then
  echo "[ERROR] npm is required. Install Node.js ≥ 18, then re-run." >&2
  exit 1
fi

if [ "${1:-}" = "--repair-chrome" ]; then
  echo "==> Removing broken Unlighthouse Chrome cache (~/.unlighthouse/chrome)"
  rm -rf "${HOME}/.unlighthouse/chrome"
  shift || true
fi

# Incomplete Puppeteer downloads leave a folder without chrome binary.
CHROME_CACHE="${HOME}/.unlighthouse/chrome"
CHROME_BIN=$(find "$CHROME_CACHE" -type f -name chrome -path '*/chrome-linux64/chrome' 2>/dev/null | head -1 || true)
CHROME_ZIP=$(find "$CHROME_CACHE" -maxdepth 1 -type f -name '*-chrome-linux64.zip' 2>/dev/null | head -1 || true)
if [ -z "${CHROME_BIN}" ] && [ -n "${CHROME_ZIP}" ]; then
  # Download hit 100% but unzip aborted — finish extract from the cached zip.
  ver=$(basename "$CHROME_ZIP" | sed 's/-chrome-linux64.zip//')
  dest="$CHROME_CACHE/linux-${ver}"
  echo "==> Completing Chrome extract from $(basename "$CHROME_ZIP")"
  rm -rf "$dest"
  mkdir -p "$dest"
  unzip -q "$CHROME_ZIP" -d "$dest"
  CHROME_BIN="$dest/chrome-linux64/chrome"
fi
if [ -d "$CHROME_CACHE" ] && [ -z "${CHROME_BIN}" ]; then
  echo "==> Chrome cache incomplete — clearing $CHROME_CACHE"
  rm -rf "$CHROME_CACHE"
fi

if [ ! -d node_modules/unlighthouse ]; then
  echo "==> npm install (unlighthouse)"
  npm install
fi

if [ "${1:-}" = "--local" ]; then
  echo "==> Scanning http://127.0.0.1:4000 (start Jekyll with: bundle exec jekyll serve)"
  npm run seo:unlighthouse:local
else
  echo "==> Scanning https://ccamilocristian.github.io"
  npm run seo:unlighthouse
fi
