# Bing Webmaster snapshot — 2026-09-17

Artifacts from **T-IDX2** + **IDX-B1** (`bing-wm` via [stufently/bing-webmaster-mcp](https://github.com/stufently/bing-webmaster-mcp) v0.1.0, local venv).

| File | Role |
|------|------|
| [`bing-sites-2026-09-17.json`](bing-sites-2026-09-17.json) | Site list + verified |
| [`bing-sitemaps-2026-09-17.json`](bing-sitemaps-2026-09-17.json) | Sitemap status |
| [`bing-crawl-stats-2026-09-17.json`](bing-crawl-stats-2026-09-17.json) | 75 days crawl / InIndex |
| [`bing-crawl-issues-2026-09-17.json`](bing-crawl-issues-2026-09-17.json) | Issues endpoint (empty — not conclusive) |
| [`bing-traffic-queries-2026-09-17.json`](bing-traffic-queries-2026-09-17.json) | Query impressions |

## IDX-B1 summary

| Check | Result |
|-------|--------|
| Site verified | **Yes** — `https://ccamilocristian.github.io/` |
| Sitemap | **Success** · 38 URLs · last crawled **2026-09-14** · submitted 2026-09-16 |
| InIndex (latest day) | **68** (2026-09-13); max observed **69** |
| Crawl health | Mostly 2xx; occasional 4xx=1 — no malware / robots blocks |
| Crawl issues API | Empty rows (Bing quirk — do **not** read as “zero issues”) |

Contrast with GSC (same day): Google sitemap still `isPending` / lastDownloaded **2024-10-16**; only **4/33** inspected URLs “Submitted and indexed”. Bing already holds ~68 pages.

## Traffic (sample)

Top impression queries in the dump (not clicks): `what is pyautogui`, Windows Task Scheduler email, IPC Colombia inflation, Spanish email-automation / music-player queries, brand PDF query.

## CLI notes

```bash
# Install (once; Cursor shells shim system python — use clean env + conda)
python -m venv ~/.local/share/venvs/bing-webmaster-mcp   # with real python
# or: already at ~/.local/share/venvs/bing-webmaster-mcp + symlink ~/.local/bin/bing-wm

export PATH="$HOME/.local/bin:$PATH"
export BING_WM_API_KEY="$BING_WEBMASTER_API_KEY"   # alias our existing env name
export BING_WM_ALLOW_WRITES=false                  # diagnosis-safe

bing-wm sites list --json
bing-wm sitemaps list 'https://ccamilocristian.github.io/' --json
bing-wm crawl stats 'https://ccamilocristian.github.io/' --json
```

MCP stdio entry: `bing-webmaster-mcp` (same venv). Pass `BING_WM_API_KEY` via client env; never commit the key.

Next: **IDX-B2** (URL status vs IndexNow) → **IDX-X1** matrix.
