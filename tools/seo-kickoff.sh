#!/usr/bin/env bash
# Automate everything the APIs allow for reindex / discovery kickoff.
# Cannot: GSC "Request indexing", GSC Security & Manual Actions UI, Bing site verify (first time).
#
# Usage: bash tools/seo-kickoff.sh
set -euo pipefail
ROOT="$(cd "$(dirname "$0")/.." && pwd)"
cd "$ROOT"
SITE="https://ccamilocristian.github.io/"
SITEMAP="${SITE}sitemap.xml"
CREDS="${HOME}/mcp_servers/google_creds.json"

PRIORITY_URLS=(
  "https://ccamilocristian.github.io/"
  "https://ccamilocristian.github.io/tabs/profile/"
  "https://ccamilocristian.github.io/tabs/intelligence/"
  "https://ccamilocristian.github.io/posts/colombia-cpi-indexation-engine-english/"
  "https://ccamilocristian.github.io/posts/real-cost-of-credit-colombia-english/"
  "https://ccamilocristian.github.io/posts/music-player-english/"
  "https://ccamilocristian.github.io/posts/convertidor-english/"
  "https://ccamilocristian.github.io/posts/automation-sending/"
  "https://ccamilocristian.github.io/posts/convertidor-IPC/"
  "https://ccamilocristian.github.io/posts/reproductor-musica/"
  "https://ccamilocristian.github.io/posts/automatizacion-envio-correos/"
)

echo "==> 1) Live HTTP smoke"
for u in "${PRIORITY_URLS[@]}"; do
  code=$(curl -sL -o /dev/null -w "%{http_code}" "$u")
  printf '  %s %s\n' "$code" "$u"
  [ "$code" = "200" ] || { echo "[ERROR] expected 200"; exit 1; }
done

echo "==> 2) GSC sitemap submit"
if [ -f "$CREDS" ]; then
  uv run --with google-api-python-client --with google-auth python3 - <<'PY'
from pathlib import Path
from google.oauth2 import service_account
from googleapiclient.discovery import build
CREDS = Path.home() / "mcp_servers" / "google_creds.json"
SITE = "https://ccamilocristian.github.io/"
SITEMAP = SITE + "sitemap.xml"
creds = service_account.Credentials.from_service_account_file(
    str(CREDS), scopes=["https://www.googleapis.com/auth/webmasters"]
)
gsc = build("searchconsole", "v1", credentials=creds)
gsc.sitemaps().submit(siteUrl=SITE, feedpath=SITEMAP).execute()
sm = gsc.sitemaps().get(siteUrl=SITE, feedpath=SITEMAP).execute()
print("  lastSubmitted:", sm.get("lastSubmitted"))
print("  lastDownloaded:", sm.get("lastDownloaded"))
print("  isPending:", sm.get("isPending"))
print("  contents:", sm.get("contents"))
PY
else
  echo "  [SKIP] missing $CREDS"
fi

echo "==> 3) IndexNow (Bing/Yandex partners)"
bash tools/indexnow-ping.sh "${PRIORITY_URLS[@]}"

echo "==> 4) Bing Webmaster SubmitFeed (if API key present)"
bash tools/bing-submit-sitemap.sh || true

echo "==> 5) GSC URL Inspection summary"
if [ -f "$CREDS" ]; then
  uv run --with google-api-python-client --with google-auth python3 - <<'PY'
from pathlib import Path
from google.oauth2 import service_account
from googleapiclient.discovery import build
urls = """
https://ccamilocristian.github.io/
https://ccamilocristian.github.io/tabs/profile/
https://ccamilocristian.github.io/tabs/intelligence/
https://ccamilocristian.github.io/posts/colombia-cpi-indexation-engine-english/
https://ccamilocristian.github.io/posts/real-cost-of-credit-colombia-english/
https://ccamilocristian.github.io/posts/music-player-english/
https://ccamilocristian.github.io/posts/convertidor-english/
https://ccamilocristian.github.io/posts/automation-sending/
https://ccamilocristian.github.io/posts/convertidor-IPC/
https://ccamilocristian.github.io/posts/reproductor-musica/
""".strip().splitlines()
creds = service_account.Credentials.from_service_account_file(
    str(Path.home() / "mcp_servers" / "google_creds.json"),
    scopes=["https://www.googleapis.com/auth/webmasters.readonly"],
)
gsc = build("searchconsole", "v1", credentials=creds)
manual = []
for url in urls:
    r = gsc.urlInspection().index().inspect(
        body={"inspectionUrl": url, "siteUrl": "https://ccamilocristian.github.io/"}
    ).execute()
    cov = r.get("inspectionResult", {}).get("indexStatusResult", {}).get("coverageState", "?")
    need = "indexed" not in cov.lower() or "not indexed" in cov.lower() or "excluded" in cov.lower() or "unknown" in cov.lower()
    mark = "MANUAL" if need else "ok"
    print(f"  [{mark}] {cov} | {url}")
    if need:
        manual.append(url)
print("\n=== YOU ONLY (GSC UI — API cannot Request indexing) ===")
for u in manual:
    print(u)
print("Also confirm: Search Console → Security & Manual Actions (no API).")
PY
else
  echo "  [SKIP] missing creds"
fi

echo
echo "==> Done. Next: npm run seo:unlighthouse  OR  bash tools/run-unlighthouse.sh"
