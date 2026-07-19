# T24 — Solicitar indexación en GSC (manual)

**API no puede** ejecutar "Solicitar indexación" — solo inspección + IndexNow.  
**Estado API 2026-07-19:** **3 indexadas**, **16 unknown**.  
Detalle JSON: [`T24_INDEX_STATUS_2026-07-19.json`](T24_INDEX_STATUS_2026-07-19.json)

Si ya pulsaste “Solicitar indexación”, la cobertura puede seguir en *unknown* 1–7 días hasta el crawl.
No repitas la solicitud para una URL sin cambios durante 7–14 días. Solo vuelve
a solicitar tras un cambio material o si la prueba publicada falla.

---

## Ya indexadas (no action)

- `https://ccamilocristian.github.io/`
- `https://ccamilocristian.github.io/tabs/intelligence/`
- `https://ccamilocristian.github.io/posts/optimation-consumer-english/`

---

## Solicitar indexación (unknown — priorizar)

En [Search Console → Inspección de URLs](https://search.google.com/search-console/inspect):

1. Pegar URL exacta  
2. Probar URL publicada → **200**  
3. **Solicitar indexación**

### Prioridad alta (queries GSC ES + hubs)

| # | URL |
|---|-----|
| 1 | `https://ccamilocristian.github.io/posts/colombia-cpi-indexation-engine-english/` (post-deploy) |
| 2 | `https://ccamilocristian.github.io/posts/real-cost-of-credit-colombia-english/` (post-deploy) |
| 3 | `https://ccamilocristian.github.io/posts/music-player-english/` |
| 4 | `https://ccamilocristian.github.io/posts/convertidor-english/` |
| 5 | `https://ccamilocristian.github.io/posts/automation-sending/` |
| 6 | `https://ccamilocristian.github.io/posts/loan-simulator-english/` |
| 7 | `https://ccamilocristian.github.io/posts/icfes-english/` |
| 8 | `https://ccamilocristian.github.io/tabs/profile/` |

### Resto unknown

| # | URL |
|---|-----|
| 9 | `https://ccamilocristian.github.io/posts/scraping-colombia-english/` |
| 10 | `https://ccamilocristian.github.io/posts/minsalud-decrees-english/` |
| 11 | `https://ccamilocristian.github.io/posts/step-colombia-english/` |
| 12 | `https://ccamilocristian.github.io/posts/creating-fun-game/` |
| 13 | `https://ccamilocristian.github.io/posts/experimental-desing/` |
| 14 | `https://ccamilocristian.github.io/posts/mastering-visualization-plotly/` |
| 15 | `https://ccamilocristian.github.io/posts/behavioral-economics-data-analysis-applications/` |
| 16 | `https://ccamilocristian.github.io/posts/introduction-pyautogui-be/` |
| 17 | `https://ccamilocristian.github.io/posts/mcp-bigquery-server-python-english/` |
| 18 | `https://ccamilocristian.github.io/posts/local-rag-ollama-python-english/` |

---

## Hecho vía bot (soporte T24)

- Inspección API 19 URLs → `T24_INDEX_STATUS_2026-07-19.json`
- Sitemap reenviado 2026-07-19 (`isPending: true`; `lastDownloaded` aún 2024-10-16)
- IndexNow ping de URLs unknown
- Enlaces “Start here” en `/tabs/intelligence/` → canónicos EN

---

## No usar

- `https://ccamilocristian.github.io/music-player-english` → 404 sin `/posts/`
