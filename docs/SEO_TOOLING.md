# SEO tooling — guards, kickoff, Unlighthouse

## Quick commands

```bash
# Regression guard (build + security + bilingual + on-page)
bash tools/verify-seo-security.sh

# Soft title/desc length become hard failures:
SEO_STRICT=1 bash tools/verify-seo-security.sh --no-build

# Automate GSC sitemap + IndexNow + Bing SubmitFeed (if key) + inspection list
bash tools/seo-kickoff.sh

# Site-wide Lighthouse SEO (Unlighthouse)
bash tools/run-unlighthouse.sh
# or: npm install && npm run seo:unlighthouse
```

## On-page guards (`tools/_seo_onpage_checks.py`)

Hard failures include:

- Published post HTML with `robots` **noindex**
- Missing `title` / `description`
- Sitemap gaps for published posts
- **Unquoted colon** in `title` / `description` / impact fields (breaks YAML → wrong permalink; caused the credit 404)
- **Dated-path fallback** builds (`/posts/YYYY-MM-DD-slug/` without the canonical slug) — same class of FM breakage

Soft (WARN unless `SEO_STRICT=1`): title >60 chars, description outside 140–160.

## What the API can / cannot do

| Action | Automatable? | Tool |
|--------|--------------|------|
| Resubmit GSC sitemap | Yes | `seo-kickoff.sh` / Search Console API |
| Inspect index coverage | Yes | `seo-batch.py` / `seo-kickoff.sh` |
| IndexNow notify Bing/Yandex | Yes | `indexnow-ping.sh` |
| Bing SubmitFeed (sitemap) | Yes **if** `BING_WEBMASTER_API_KEY` set | `bing-submit-sitemap.sh` |
| GSC **Request indexing** | **No** (Google blocks API) | Manual URL Inspection UI |
| GSC Security & Manual Actions | **No** public API | Manual GSC UI |
| Bing **first-time site verify** | **No** | Bing Webmaster UI once |

## Unlighthouse (how)

1. Install Node.js ≥ 18.
2. From repo root: `npm install`
3. `bash tools/run-unlighthouse.sh` — downloads Chrome once, then opens a local dashboard (~5678).
4. If you see `chrome folder exists but the executable is missing`:

```bash
bash tools/run-unlighthouse.sh --repair-chrome
```

5. Config: `unlighthouse.config.ts` (max 50 routes, sitemap-first).
6. Output is gitignored (`.unlighthouse/` under the project; browser cache in `~/.unlighthouse/`).

In the dashboard: open the **SEO** tab → filter failed audits (title, meta description, canonical). That list is the on-page backlog.

## Bing one-time key (so the bot can SubmitFeed)

1. [Bing Webmaster](https://www.bing.com/webmasters) → add `https://ccamilocristian.github.io`
2. Verify ownership (XML file or meta — once).
3. Settings → API Access → create key.
4. Locally: `export BING_WEBMASTER_API_KEY='…'` (never commit).
5. Re-run `bash tools/bing-submit-sitemap.sh` or `seo-kickoff.sh`.

Until the key exists, IndexNow still notifies Bing of URL changes.

## Your remaining checklist (manual only)

See [`MANUAL_CHECKLIST.md`](MANUAL_CHECKLIST.md) §1 — only:

1. GSC → Security & Manual Actions
2. GSC → Request indexing for URLs listed by `seo-kickoff.sh`
3. Bing site verify + API key (once), if not done
