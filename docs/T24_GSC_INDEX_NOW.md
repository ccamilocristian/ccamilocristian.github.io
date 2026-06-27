# T24 — Solicitar indexación en GSC (manual)

**API no puede** ejecutar "Solicitar indexación" — solo inspección.  
Estado API 2026-06-27: **13 URLs pendientes**, **2 ya indexadas**.

---

## Ya indexadas ✅ (no action)

- `https://ccamilocristian.github.io/posts/optimation-consumer-english/`
- `https://ccamilocristian.github.io/tabs/intelligence/`

---

## Solicitar indexación ahora (13 URLs)

En [Search Console → Inspección de URLs](https://search.google.com/search-console/inspect):

1. Pegar URL exacta (con `/posts/`)
2. Esperar prueba en vivo → debe ser **200**
3. Clic **「Solicitar indexación」**

| # | URL |
|---|-----|
| 1 | `https://ccamilocristian.github.io/posts/music-player-english/` |
| 2 | `https://ccamilocristian.github.io/posts/convertidor-english/` |
| 3 | `https://ccamilocristian.github.io/posts/automation-sending/` |
| 4 | `https://ccamilocristian.github.io/posts/icfes-english/` |
| 5 | `https://ccamilocristian.github.io/posts/scraping-colombia-english/` |
| 6 | `https://ccamilocristian.github.io/posts/loan-simulator-english/` |
| 7 | `https://ccamilocristian.github.io/posts/minsalud-decrees-english/` |
| 8 | `https://ccamilocristian.github.io/posts/step-colombia-english/` |
| 9 | `https://ccamilocristian.github.io/posts/creating-fun-game/` |
| 10 | `https://ccamilocristian.github.io/posts/experimental-desing/` |
| 11 | `https://ccamilocristian.github.io/posts/mastering-visualization-plotly/` |
| 12 | `https://ccamilocristian.github.io/posts/behavioral-economics-data-analysis-applications/` |
| 13 | `https://ccamilocristian.github.io/posts/introduction-pyautogui-be/` |

---

## Hecho vía bot (soporte T24)

- ✅ Inspección API 15 URLs → `T24_INDEX_STATUS_2026-06-27.json`
- ✅ IndexNow ping 15 URLs (Bing/Yandex partners)

---

## ⚠️ No usar

- `https://ccamilocristian.github.io/music-player-english` → 404 (sin `/posts/`)
