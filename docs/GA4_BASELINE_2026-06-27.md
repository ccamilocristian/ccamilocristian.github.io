# GA4 baseline — pre-filtro Singapore (T25j)

**Fecha:** 2026-06-27 · **Propiedad:** `356406631` (`G-4FK52MWLPP`)  
**Contexto:** Post GTM v5, pre-filtro bots, pre-indexación EN masiva.

---

## Resumen 30 días

| Métrica | Valor | Nota |
|---------|-------|------|
| Sesiones (auditoría previa) | ~185 | 84% bounce |
| Tráfico SG | ~65% users | Bots — filtrar T25c |
| Home pageviews | 133 | Hub principal |
| Posts EN con vistas | 6+ slugs | Volumen bajo aún |

---

## Top páginas (pagePath)

| Vistas | Retención | Ruta | Tipo |
|--------|-----------|------|------|
| 133 | 14s | `/` | Home |
| 18 | 59s | `/posts/reproductor-musica/` | ES legacy ⚠️ |
| 5 | 14s | `/posts/liquidador-intereses/` | ES legacy |
| 4 | 5s | `/tabs/intelligence/` | Hub EN |
| 3 | 12s | `/posts/creating-fun-game/` | EN |
| 2 | 1s | `/posts/music-player-english/` | EN canónico |
| 2 | 35s | `/posts/optimation-consumer-english/` | EN indexado GSC |

**URLs `//` en datos:** `//posts/music-player-english/` (2) — fix deployado; debería desaparecer en nuevas sesiones.

---

## Comparar en 7 días (post T25c + T24)

- [ ] Sesiones totales sin Singapore
- [ ] Bounce rate humano LATAM
- [ ] Pageviews `/posts/*-english/` vs ES legacy
- [ ] Eventos `outbound_click`, `site_search` en DebugView
- [ ] AdSense impresiones con consent ads

---

## Fuente

API `get_ga4_page_performance` · Auditoría [`GA4_AUDIT_2026-06-27.md`](GA4_AUDIT_2026-06-27.md)
