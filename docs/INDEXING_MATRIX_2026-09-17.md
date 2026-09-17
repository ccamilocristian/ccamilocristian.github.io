# Indexing matrix — 2026-09-17

**IDX-X1** — one row per URL (money EN+ES + hubs). Sources: GSC Inspection (G2) + Bing `GetUrlInfo` (B2).

| Artifact | Path |
|----------|------|
| This matrix | [`INDEXING_MATRIX_2026-09-17.md`](INDEXING_MATRIX_2026-09-17.md) |
| Machine CSV | [`indexing/indexing-matrix-2026-09-17.csv`](indexing/indexing-matrix-2026-09-17.csv) |
| GSC batch | [`indexing/GSC_INSPECT_2026-09-17.md`](indexing/GSC_INSPECT_2026-09-17.md) |
| Bing↔IndexNow | [`indexing/BING_B2_INDEXNOW_2026-09-17.md`](indexing/BING_B2_INDEXNOW_2026-09-17.md) |

## Engine snapshot

| Engine | Signal |
|--------|--------|
| Google sitemap | `isPending` · lastDownloaded **2024-10-16** |
| Bing sitemap | Success · 38 URLs · last crawl **2026-09-14** · InIndex ~**68** |
| IndexNow key | Live · history log from next ping |
| URLs in matrix | **33** · Bing knows **33/33** |

## Gap counts

| Gap | n |
|-----|--:|
| `bing_known_gsc_unknown` | 22 |
| `bing_known_gsc_stale_noindex` | 6 |
| `ok_both` | 4 |
| `bing_known_gsc_crawled_not_indexed` | 1 |

## Priority buckets (for IDX-G3 / Request indexing)

| Bucket | n | Action |
|--------|--:|--------|
| `P0_es_stale_noindex` | 6 | GSC UI: Prove live → Request indexing (ES historic traffic) |
| `P0_crawled_not_indexed` | 1 | GSC UI: Request indexing |
| `P0_money_en_unknown` | 8 | GSC UI: Request indexing (money EN) |
| `P1_en_or_es_unknown` | 11 | After P0; sitemap unstick may help |
| `P1_hub_unknown` | 3 | Low urgency hubs (archives/stack/economics-lens) |
| `P3_ok` | 4 | No action |

### P0 checklist (copy into GSC URL Inspection)

1. `https://ccamilocristian.github.io/posts/automatizacion-envio-correos/` — es_stale_noindex · GSC: Excluded by ‘noindex’ tag · Bing crawl: 2026-09-16
1. `https://ccamilocristian.github.io/posts/convertidor-IPC/` — es_stale_noindex · GSC: Excluded by ‘noindex’ tag · Bing crawl: 2026-08-15
1. `https://ccamilocristian.github.io/posts/icfes-conexion-api/` — es_stale_noindex · GSC: Excluded by ‘noindex’ tag · Bing crawl: 2026-09-13
1. `https://ccamilocristian.github.io/posts/liquidador-intereses/` — es_stale_noindex · GSC: Excluded by ‘noindex’ tag · Bing crawl: 2026-09-14
1. `https://ccamilocristian.github.io/posts/optimizacion_teoria_consumidor/` — es_stale_noindex · GSC: Excluded by ‘noindex’ tag · Bing crawl: 2026-08-30
1. `https://ccamilocristian.github.io/posts/reproductor-musica/` — es_stale_noindex · GSC: Excluded by ‘noindex’ tag · Bing crawl: 2026-09-16
1. `https://ccamilocristian.github.io/posts/scraping-plebiscito-colombia/` — crawled_not_indexed · GSC: Crawled - currently not indexed · Bing crawl: 2026-09-03
1. `https://ccamilocristian.github.io/posts/automation-sending/` — money_en_unknown · GSC: URL is unknown to Google · Bing crawl: 2026-09-16
1. `https://ccamilocristian.github.io/posts/colombia-cpi-indexation-engine-english/` — money_en_unknown · GSC: URL is unknown to Google · Bing crawl: 2026-09-12
1. `https://ccamilocristian.github.io/posts/convertidor-english/` — money_en_unknown · GSC: URL is unknown to Google · Bing crawl: 2026-07-30
1. `https://ccamilocristian.github.io/posts/loan-simulator-english/` — money_en_unknown · GSC: URL is unknown to Google · Bing crawl: 2026-09-16
1. `https://ccamilocristian.github.io/posts/local-rag-ollama-python-english/` — money_en_unknown · GSC: URL is unknown to Google · Bing crawl: 2026-08-15
1. `https://ccamilocristian.github.io/posts/mcp-bigquery-server-python-english/` — money_en_unknown · GSC: URL is unknown to Google · Bing crawl: 2026-09-06
1. `https://ccamilocristian.github.io/posts/music-player-english/` — money_en_unknown · GSC: URL is unknown to Google · Bing crawl: 2026-09-16
1. `https://ccamilocristian.github.io/posts/real-cost-of-credit-colombia-english/` — money_en_unknown · GSC: URL is unknown to Google · Bing crawl: 2026-07-31

**Do not** Request-index the 4 `ok_both` rows. Prefer waiting on Google sitemap `lastDownloaded` moving off 2024-10-16 in parallel.

## Full matrix

| Pri | Slug | GSC | Bing last crawl | IndexNow kickoff | Gap |
|-----|------|-----|-----------------|------------------|-----|
| P0 | `automatizacion-envio-correos` | Excluded by ‘noindex’ tag | 2026-09-16 | Y | `bing_known_gsc_stale_noindex` |
| P0 | `convertidor-IPC` | Excluded by ‘noindex’ tag | 2026-08-15 | Y | `bing_known_gsc_stale_noindex` |
| P0 | `icfes-conexion-api` | Excluded by ‘noindex’ tag | 2026-09-13 | N | `bing_known_gsc_stale_noindex` |
| P0 | `liquidador-intereses` | Excluded by ‘noindex’ tag | 2026-09-14 | N | `bing_known_gsc_stale_noindex` |
| P0 | `optimizacion_teoria_consumidor` | Excluded by ‘noindex’ tag | 2026-08-30 | N | `bing_known_gsc_stale_noindex` |
| P0 | `reproductor-musica` | Excluded by ‘noindex’ tag | 2026-09-16 | Y | `bing_known_gsc_stale_noindex` |
| P0 | `scraping-plebiscito-colombia` | Crawled - currently not indexed | 2026-09-03 | N | `bing_known_gsc_crawled_not_indexed` |
| P0 | `automation-sending` | URL is unknown to Google | 2026-09-16 | Y | `bing_known_gsc_unknown` |
| P0 | `colombia-cpi-indexation-engine-english` | URL is unknown to Google | 2026-09-12 | Y | `bing_known_gsc_unknown` |
| P0 | `convertidor-english` | URL is unknown to Google | 2026-07-30 | Y | `bing_known_gsc_unknown` |
| P0 | `loan-simulator-english` | URL is unknown to Google | 2026-09-16 | N | `bing_known_gsc_unknown` |
| P0 | `local-rag-ollama-python-english` | URL is unknown to Google | 2026-08-15 | N | `bing_known_gsc_unknown` |
| P0 | `mcp-bigquery-server-python-english` | URL is unknown to Google | 2026-09-06 | N | `bing_known_gsc_unknown` |
| P0 | `music-player-english` | URL is unknown to Google | 2026-09-16 | Y | `bing_known_gsc_unknown` |
| P0 | `real-cost-of-credit-colombia-english` | URL is unknown to Google | 2026-07-31 | Y | `bing_known_gsc_unknown` |
| P1 | `behavioral-economics-data-analysis-applications` | URL is unknown to Google | 2026-09-15 | N | `bing_known_gsc_unknown` |
| P1 | `creating-fun-game` | URL is unknown to Google | 2026-09-09 | N | `bing_known_gsc_unknown` |
| P1 | `experimental-desing` | URL is unknown to Google | 2026-08-18 | N | `bing_known_gsc_unknown` |
| P1 | `icfes-english` | URL is unknown to Google | 2026-08-29 | N | `bing_known_gsc_unknown` |
| P1 | `introduction-pyautogui-be` | URL is unknown to Google | 2026-09-08 | N | `bing_known_gsc_unknown` |
| P1 | `mastering-visualization-plotly` | URL is unknown to Google | 2026-07-19 | N | `bing_known_gsc_unknown` |
| P1 | `ministerio-salud` | URL is unknown to Google | 2026-08-30 | N | `bing_known_gsc_unknown` |
| P1 | `minsalud-decrees-english` | URL is unknown to Google | 2026-08-12 | N | `bing_known_gsc_unknown` |
| P1 | `scraping-colombia-english` | URL is unknown to Google | 2026-09-16 | N | `bing_known_gsc_unknown` |
| P1 | `step-colombia-english` | URL is unknown to Google | 2026-08-27 | N | `bing_known_gsc_unknown` |
| P1 | `step-colombia` | URL is unknown to Google | 2026-07-29 | N | `bing_known_gsc_unknown` |
| P1 | `archives` | URL is unknown to Google | 2026-09-11 | N | `bing_known_gsc_unknown` |
| P1 | `economics-lens` | URL is unknown to Google | 2026-09-04 | N | `bing_known_gsc_unknown` |
| P1 | `stack` | URL is unknown to Google | 2026-09-17 | N | `bing_known_gsc_unknown` |
| P3 | `home` | Submitted and indexed | 2026-09-16 | Y | `ok_both` |
| P3 | `optimation-consumer-english` | Submitted and indexed | 2026-09-11 | N | `ok_both` |
| P3 | `intelligence` | Submitted and indexed | 2026-08-18 | Y | `ok_both` |
| P3 | `profile` | Submitted and indexed | 2026-09-14 | Y | `ok_both` |

## Next

- **IDX-G3** — freeze P0 list above (already drafted here)
- **IDX-G4** — full sitemap.xml vs “on Google” diff
- **IDX-X3** — manual Request indexing **only P0**
