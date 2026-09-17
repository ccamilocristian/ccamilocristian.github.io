# IDX-G4 — Sitemap vs on-Google (2026-09-17 evening)

Live sitemap locs: **36** · Inspected sample: **33** · On Google (inspect PASS): **4**

## Diffs

| Set | n |
|-----|--:|
| In sitemap, not in inspect sample | 3 |
| In inspect sample, not in sitemap | 0 |
| In sitemap, not “Submitted and indexed” (inspect) | 29+ uninspected |
| Inspected but not on Google | 29 |

### On Google (4)

- `https://ccamilocristian.github.io/`
- `https://ccamilocristian.github.io/posts/optimation-consumer-english/`
- `https://ccamilocristian.github.io/tabs/intelligence/`
- `https://ccamilocristian.github.io/tabs/profile/`

### In sitemap but outside our 33-URL inspect sample

- `https://ccamilocristian.github.io/page2/`
- `https://ccamilocristian.github.io/page3/`
- `https://ccamilocristian.github.io/tabs/cookie-policy/`

### Inspected, not on Google (need crawl/index — see G3 P0/P1)

- `https://ccamilocristian.github.io/posts/automation-sending/` · URL is unknown to Google · `P0_money_en_unknown`
- `https://ccamilocristian.github.io/posts/automatizacion-envio-correos/` · Excluded by ‘noindex’ tag · `P0_es_stale_noindex`
- `https://ccamilocristian.github.io/posts/behavioral-economics-data-analysis-applications/` · URL is unknown to Google · `P1_en_or_es_unknown`
- `https://ccamilocristian.github.io/posts/colombia-cpi-indexation-engine-english/` · URL is unknown to Google · `P0_money_en_unknown`
- `https://ccamilocristian.github.io/posts/convertidor-IPC/` · Excluded by ‘noindex’ tag · `P0_es_stale_noindex`
- `https://ccamilocristian.github.io/posts/convertidor-english/` · URL is unknown to Google · `P0_money_en_unknown`
- `https://ccamilocristian.github.io/posts/creating-fun-game/` · URL is unknown to Google · `P1_en_or_es_unknown`
- `https://ccamilocristian.github.io/posts/experimental-desing/` · URL is unknown to Google · `P1_en_or_es_unknown`
- `https://ccamilocristian.github.io/posts/icfes-conexion-api/` · Excluded by ‘noindex’ tag · `P0_es_stale_noindex`
- `https://ccamilocristian.github.io/posts/icfes-english/` · URL is unknown to Google · `P1_en_or_es_unknown`
- `https://ccamilocristian.github.io/posts/introduction-pyautogui-be/` · URL is unknown to Google · `P1_en_or_es_unknown`
- `https://ccamilocristian.github.io/posts/liquidador-intereses/` · Excluded by ‘noindex’ tag · `P0_es_stale_noindex`
- `https://ccamilocristian.github.io/posts/loan-simulator-english/` · URL is unknown to Google · `P0_money_en_unknown`
- `https://ccamilocristian.github.io/posts/local-rag-ollama-python-english/` · URL is unknown to Google · `P0_money_en_unknown`
- `https://ccamilocristian.github.io/posts/mastering-visualization-plotly/` · URL is unknown to Google · `P1_en_or_es_unknown`
- `https://ccamilocristian.github.io/posts/mcp-bigquery-server-python-english/` · URL is unknown to Google · `P0_money_en_unknown`
- `https://ccamilocristian.github.io/posts/ministerio-salud/` · URL is unknown to Google · `P1_en_or_es_unknown`
- `https://ccamilocristian.github.io/posts/minsalud-decrees-english/` · URL is unknown to Google · `P1_en_or_es_unknown`
- `https://ccamilocristian.github.io/posts/music-player-english/` · URL is unknown to Google · `P0_money_en_unknown`
- `https://ccamilocristian.github.io/posts/optimizacion_teoria_consumidor/` · Excluded by ‘noindex’ tag · `P0_es_stale_noindex`
- `https://ccamilocristian.github.io/posts/real-cost-of-credit-colombia-english/` · URL is unknown to Google · `P0_money_en_unknown`
- `https://ccamilocristian.github.io/posts/reproductor-musica/` · Excluded by ‘noindex’ tag · `P0_es_stale_noindex`
- `https://ccamilocristian.github.io/posts/scraping-colombia-english/` · URL is unknown to Google · `P1_en_or_es_unknown`
- `https://ccamilocristian.github.io/posts/scraping-plebiscito-colombia/` · Crawled - currently not indexed · `P0_crawled_not_indexed`
- `https://ccamilocristian.github.io/posts/step-colombia-english/` · URL is unknown to Google · `P1_en_or_es_unknown`
- `https://ccamilocristian.github.io/posts/step-colombia/` · URL is unknown to Google · `P1_en_or_es_unknown`
- `https://ccamilocristian.github.io/tabs/archives/` · URL is unknown to Google · `P1_hub_unknown`
- `https://ccamilocristian.github.io/tabs/economics-lens/` · URL is unknown to Google · `P1_hub_unknown`
- `https://ccamilocristian.github.io/tabs/stack/` · URL is unknown to Google · `P1_hub_unknown`

## Implication

Google’s last successful sitemap download (2024-10-16) predates most current URLs.
Until `lastDownloaded` advances, discovery via sitemap is unreliable; URL Inspection + Request indexing is the lever for P0.
