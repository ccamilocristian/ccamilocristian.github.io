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
| Resubmit GSC sitemap | Yes | `seo-kickoff.sh` / Search Console API / `gsccli sitemaps submit` |
| Inspect index coverage | Yes | `gsccli inspect` / `seo-batch.py` / `seo-kickoff.sh` |
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

Until the key exists, IndexNow still notifies Bing of URL changes. Pings now append to `docs/indexing/indexnow-history.ndjson` (IDX-B2).

## gsccli — Google Search Console CLI (T-IDX1 ✅)

Primary tool for indexing diagnosis (runbook in `BACKLOG.md`).

```bash
# One-time install (Node ≥ 22; user prefix — no sudo)
npm config set prefix "$HOME/.local"
npm i -g @nalyk/gsccli@latest
export PATH="$HOME/.local/bin:$PATH"   # add to ~/.zshrc

# Auth = existing service account (already a GSC siteFullUser)
gsccli config set credentials ~/mcp_servers/google_creds.json
gsccli config set site 'https://ccamilocristian.github.io/'

gsccli auth status
gsccli sites list
gsccli sitemaps list
gsccli inspect url 'https://ccamilocristian.github.io/posts/…/'
```

Local site config: `.gsccli.json` (site URL only). Global SA path: `~/.gsccli/config.json`.

**Smoke 2026-09-17:** `sites list` → `siteFullUser`; sitemap `isPending: true`, `lastDownloaded: 2024-10-16`.

**IDX-G1/G2 ✅:** snapshot + 33-URL batch → [`docs/indexing/GSC_INSPECT_2026-09-17.md`](indexing/GSC_INSPECT_2026-09-17.md).

## bing-wm — Bing Webmaster CLI / MCP (T-IDX2 ✅)

Package: [stufently/bing-webmaster-mcp](https://github.com/stufently/bing-webmaster-mcp) (PyPI name may lag; install from GitHub if needed).

```bash
# Local venv (avoid Cursor python shim: use env -i + conda/system python)
# Current machine: ~/.local/share/venvs/bing-webmaster-mcp → ~/.local/bin/bing-wm
export PATH="$HOME/.local/bin:$PATH"
export BING_WM_API_KEY="$BING_WEBMASTER_API_KEY"  # same key as tools/bing-submit-sitemap.sh
export BING_WM_ALLOW_WRITES=false                 # read-only / plan-only for agents

bing-wm sites list --json
bing-wm sitemaps list 'https://ccamilocristian.github.io/' --json
bing-wm crawl stats 'https://ccamilocristian.github.io/' --json
bing-wm index url 'https://ccamilocristian.github.io/' 'https://ccamilocristian.github.io/posts/…/'
```

MCP: run `bing-webmaster-mcp` (stdio) with `BING_WM_API_KEY` in the client env.

**Smoke 2026-09-17 (IDX-B1):** site verified; sitemap Success (38 URLs, last crawl 2026-09-14); InIndex ≈ **68**. See [`docs/indexing/BING_SNAPSHOT_2026-09-17.md`](indexing/BING_SNAPSHOT_2026-09-17.md).

## Free “Semrush-like” options (what we lack vs what to add)

Semrush/Ahrefs rigor = proprietary **indexes**. Free tools never match that. For this site, prefer **first-party** data + one thin tracker:

| Gap vs Semrush | Recommended free path | Priority |
|----------------|----------------------|----------|
| Organic ranking (real) | **GSC** Search Analytics via `gsccli` (already) | Have |
| Bing queries / InIndex | **`bing-wm traffic` / crawl** (just set up) | Have |
| On-page / CWV audit | **Unlighthouse** + SEOptimer guest (already) | Have |
| Position tracking (chosen KWs) | **[SerpBear](https://github.com/towfiqi/serpbear)** + free-tier scraper, or weekly GSC export | **P2** if we pick ≤20 money KWs |
| Keyword ideas (no paid API) | Google Autocomplete / Ads Keyword Planner; optional self-host **[UpgradeSEO](https://github.com/upgrade-ventures/upgradeseo)** | **P3** |
| Backlinks (honest free) | Bing Webmaster inbound links (`bing-wm links`) + OpenPageRank — **not** Ahrefs-depth | **P2** via Bing we already have |
| Competitor SERP | Skip unless DataForSEO budget; Common Crawl via UpgradeSEO is weak | Park |
| All-in-one “free Semrush” clones | OpenSEO / CrawlSEO need **DataForSEO $** for real backlinks/KW — skip for now | Park |

**Do not install** SerpBear/UpgradeSEO until we define a KW list (content GO). Next indexing runbook stays Bing/GSC.

## Your remaining checklist (manual only)

See [`MANUAL_CHECKLIST.md`](MANUAL_CHECKLIST.md) §1 — only:

1. GSC → Security & Manual Actions
2. GSC → Request indexing for **P0** URLs only (after IDX-G3)
3. Bing site verify + API key — ✅ done (key in env; site verified 2026-09-17)
