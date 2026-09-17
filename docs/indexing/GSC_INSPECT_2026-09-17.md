# GSC inspect snapshot — 2026-09-17

Artifacts from **IDX-G1** + **IDX-G2** (`gsccli` 1.2.1, SA `siteFullUser`).

| File | Role |
|------|------|
| [`gsc-sitemaps-2026-09-17.json`](gsc-sitemaps-2026-09-17.json) | Sitemap inventory |
| [`urls-inspect-2026-09-17.txt`](urls-inspect-2026-09-17.txt) | 33 URLs (hubs + 18 EN + 9 ES) |
| [`gsc-inspect-2026-09-17.ndjson`](gsc-inspect-2026-09-17.ndjson) | Raw batch Inspection |
| [`gsc-inspect-2026-09-17.csv`](gsc-inspect-2026-09-17.csv) | Flattened + issue buckets |

## IDX-G1 — sitemap

| Field | Value |
|-------|-------|
| path | `https://ccamilocristian.github.io/sitemap.xml` |
| lastSubmitted | **2026-09-16** |
| lastDownloaded | **2024-10-16** |
| isPending | **true** |
| errors / warnings | 0 / 0 |

Live sitemap lists EN+ES posts and hubs. Google has not re-fetched it since Oct 2024 despite yesterday’s resubmit — primary discovery bottleneck.

## IDX-G2 — coverage (33 URLs)

| coverageState | n |
|---------------|--:|
| URL is unknown to Google | 22 |
| Excluded by ‘noindex’ tag | 6 |
| Submitted and indexed | 4 |
| Crawled - currently not indexed | 1 |

**Indexed (PASS):** `/`, `/tabs/profile/`, `/tabs/intelligence/`, `/posts/optimation-consumer-english/`.

### Live vs GSC (spot-check)

ES pages reported as noindex are **stale GSC state**. Live HTML (2026-09-17):

- `rel=canonical` → self URL
- no `robots` / `noindex` meta
- reciprocal `hreflang` EN↔ES + `x-default` → EN

Inspection `userCanonical` still pointing at EN (and one `//posts/` double-slash) is leftover from the old redirect-stub era — matches **IDX-G6** / `docs/MANUAL_CHECKLIST.md`.

### Issue buckets (CSV)

| Bucket | n | Meaning |
|--------|--:|---------|
| `OK_indexed` | 4 | Healthy |
| `P0_stale_noindex_needs_recrawl` | 6 | ES live OK; force re-crawl |
| `P0_crawled_not_indexed` | 1 | `/posts/scraping-plebiscito-colombia/` |
| `P0_money_en_unknown` | 4 | credit / CPI / RAG / MCP EN |
| `P1_unknown` | 15 | other posts unknown |
| `P1_hub_unknown` | 3 | archives / stack / economics-lens |

## Preliminary P0 (for IDX-G3 / Request indexing UI)

Do **not** Request-index everything. After Bing setup + matrix, prioritize:

1. Sitemap: wait for `lastDownloaded` to move, or re-submit + ping once Google clears pending
2. ES stale noindex (6) — Prove URL live → Request indexing
3. Money EN unknown: credit, CPI, local-RAG, MCP-BigQuery
4. `/posts/scraping-plebiscito-colombia/` (crawled, not indexed)

Full triage = **IDX-G3**. Next runbook step = **T-IDX2** Bing MCP.
