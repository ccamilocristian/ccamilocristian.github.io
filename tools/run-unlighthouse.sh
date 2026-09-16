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
if [ -d "${HOME}/.unlighthouse/chrome" ] && ! find "${HOME}/.unlighthouse/chrome" -type f -name chrome -print -quit 2>/dev/null | grep -q .; then
  echo "==> Chrome cache incomplete — clearing ~/.unlighthouse/chrome"
  rm -rf "${HOME}/.unlighthouse/chrome"
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
