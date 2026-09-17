# IDX-B2 — Bing URL status vs IndexNow (2026-09-17)

| File | Role |
|------|------|
| [`bing-url-info-2026-09-17.ndjson`](bing-url-info-2026-09-17.ndjson) | `bing-wm index url` for 33 URLs |
| [`bing-vs-gsc-indexnow-2026-09-17.csv`](bing-vs-gsc-indexnow-2026-09-17.csv) | Join Bing ↔ GSC ↔ IndexNow-intended |
| [`indexnow-history.ndjson`](indexnow-history.ndjson) | Append-only ping log (**new**; empty until next ping) |

## IndexNow plumbing

| Check | Result |
|-------|--------|
| Key file live | **200**, body matches `_data/site_ops.yml` key |
| Durable ping log (before today) | **Missing** — `indexnow-ping.sh` only printed curl output |
| Fix | Script now appends to `docs/indexing/indexnow-history.ndjson` |
| Intended set | `seo-kickoff.sh` PRIORITY_URLS (11 URLs) — not a historical log |

Reconstructed “intended” set (kickoff): home, profile, intelligence, CPI, credit, music EN, convertidor EN, automation EN, convertidor ES, reproductor ES, automatizacion ES.

## Bing `GetUrlInfo` (33/33 after throttle retry)

All inspected URLs have `DiscoveryDate` / `LastCrawledDate` — Bing knows the whole money+hub set. Several last crawls on **2026-09-16** (same day as IndexNow/sitemap submit via kickoff).

| Gap vs GSC | n | Meaning |
|------------|--:|---------|
| `ok_both` | 4 | Indexed in GSC + known to Bing |
| `bing_known_gsc_unknown` | 22 | **Main story** — Bing crawled; GSC still “URL is unknown” |
| `bing_known_gsc_stale_noindex` | 6 | ES live OK; GSC stale noindex; Bing still crawls |
| `bing_known_gsc_crawled_not_indexed` | 1 | `scraping-plebiscito-colombia` |
| IndexNow intended known to Bing | **11/11** | Ping/sitemap path works for Bing |

## Conclusions

1. **IndexNow + Bing sitemap are doing their job** — no Bing gap on the kickoff URL set.
2. **Google is the bottleneck** (stuck sitemap download + unknown/stale states), not Bing discovery.
3. Future B2 diffs: run `indexnow-ping.sh`, then compare `indexnow-history.ndjson` timestamps vs `bing-wm index url` `LastCrawledDate`.
4. API note: Bing `GetUrlInfo` throttles (`ThrottleHost`) — batch ≤1 rps with backoff.

Next: **IDX-X1** matrix (formal one-row-per-URL Google↔Bing) — CSV above is a draft.
