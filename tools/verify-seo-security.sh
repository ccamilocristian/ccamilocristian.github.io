#!/usr/bin/env bash
#
# verify-seo-security.sh — regression guard for the two invariants that must
# never break: (1) bilingual SEO and (2) service-worker security.
#
# It builds the production site (unless --no-build) and asserts a set of
# hard invariants against _site/. Exits non-zero on the first failure so it
# can gate commits/CI.
#
# Usage:
#   bash tools/verify-seo-security.sh            # build + verify
#   bash tools/verify-seo-security.sh --no-build # verify an existing _site/

set -uo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
cd "$ROOT"
DEST="_site"
FAIL=0

pass() { printf '  \033[32mPASS\033[0m %s\n' "$1"; }
fail() { printf '  \033[31mFAIL\033[0m %s\n' "$1"; FAIL=1; }

# Adware / third-party push-vendor tokens that must never ship again. Vendor
# names only — generic words like "notification"/"push" appear legitimately in
# our own kill-switch code and comments, so matching them would false-positive.
ADWARE_RE='choupsee|onesignal|pushly|webpushr|foxpush|pushalert|pushnews|pushwoosh|sendpulse|push-ad-network'

if [ "${1:-}" != "--no-build" ]; then
  echo "==> Building production site"
  JEKYLL_ENV=production bundle exec jekyll build >/dev/null || { echo "build failed"; exit 2; }
fi

[ -d "$DEST" ] || { echo "no $DEST (build first)"; exit 2; }

echo "==> Security invariants"
if [ -f "$DEST/sw.js" ]; then pass "sw.js present"; else fail "sw.js missing"; fi
if grep -q "unregister(" "$DEST/sw.js" 2>/dev/null; then pass "sw.js is a self-removing kill-switch"; else fail "sw.js lacks unregister() (not a kill-switch)"; fi
if grep -Eiq "$ADWARE_RE" "$DEST/sw.js" 2>/dev/null; then fail "sw.js contains adware tokens"; else pass "sw.js free of adware tokens"; fi
if [ -f "$DEST/app.js" ] && grep -q "getRegistrations" "$DEST/app.js"; then pass "app.js only touches existing SW registrations"; else fail "app.js does not gate SW on getRegistrations"; fi
HITS=$(grep -RiEl "$ADWARE_RE" "$DEST" 2>/dev/null | grep -v "verify-seo-security" || true)
if [ -z "$HITS" ]; then pass "no adware tokens anywhere in $DEST"; else fail "adware tokens found in: $HITS"; fi

echo "==> SEO invariants"
SITEMAP="$DEST/sitemap.xml"
if [ -f "$SITEMAP" ]; then pass "sitemap.xml present"; else fail "sitemap.xml missing"; fi

# robots.txt must exist and must not blanket-disallow the whole site.
if [ -f "$DEST/robots.txt" ]; then
  if grep -Eq '^\s*Disallow:\s*/\s*$' "$DEST/robots.txt"; then fail "robots.txt blanket-disallows the site"; else pass "robots.txt does not blanket-disallow"; fi
else
  fail "robots.txt missing"
fi

# Every bilingual pair: both language URLs indexable in sitemap + reciprocal hreflang.
PAIRS=$(awk '/canonical:/{c=$NF} /alternate:/{print c" "$NF}' _data/post_pairs.yml)
PAIR_OK=0; PAIR_TOTAL=0
while read -r canon alt; do
  [ -z "$canon" ] && continue
  PAIR_TOTAL=$((PAIR_TOTAL+1))
  cpage="$DEST/posts/$canon/index.html"
  apage="$DEST/posts/$alt/index.html"
  ok=1
  grep -q "posts/$canon/" "$SITEMAP" || { fail "sitemap missing EN $canon"; ok=0; }
  grep -q "posts/$alt/" "$SITEMAP"   || { fail "sitemap missing ES $alt"; ok=0; }
  for p in "$cpage" "$apage"; do
    [ -f "$p" ] || { fail "missing built page $p"; ok=0; continue; }
    grep -q 'hreflang="en"' "$p" || { fail "$p lacks hreflang en"; ok=0; }
    grep -q 'hreflang="es"' "$p" || { fail "$p lacks hreflang es"; ok=0; }
    grep -q 'hreflang="x-default"' "$p" || { fail "$p lacks x-default"; ok=0; }
    grep -q '<link rel="canonical"' "$p" || { fail "$p lacks canonical"; ok=0; }
  done
  grep -q '<html lang="en"' "$cpage" 2>/dev/null || { fail "$canon not <html lang=en>"; ok=0; }
  grep -q '<html lang="es"' "$apage" 2>/dev/null || { fail "$alt not <html lang=es>"; ok=0; }
  [ "$ok" -eq 1 ] && PAIR_OK=$((PAIR_OK+1))
done <<< "$PAIRS"
if [ "$PAIR_OK" -eq "$PAIR_TOTAL" ] && [ "$PAIR_TOTAL" -gt 0 ]; then pass "all $PAIR_TOTAL bilingual pairs: sitemap + reciprocal hreflang + per-lang <html lang>"; fi

echo "==> HTML-Proofer (internal links/images/scripts)"
if bundle exec htmlproofer "$DEST" --disable-external --allow-hash-href --ignore-empty-alt --ignore-missing-alt >/tmp/htmlproofer_guard.log 2>&1; then
  pass "html-proofer passed"
else
  fail "html-proofer failed (see /tmp/htmlproofer_guard.log)"
fi

echo
if [ "$FAIL" -eq 0 ]; then
  printf '\033[32mALL INVARIANTS HOLD\033[0m — SEO + security intact.\n'
else
  printf '\033[31mREGRESSION DETECTED\033[0m — fix before committing.\n'
fi
exit $FAIL
