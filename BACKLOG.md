# Backlog

_Last sync: 2026-06-27_

Punto de entrada del proyecto. Para visión → [`README_UX_EVOLUTION.md`](README_UX_EVOLUTION.md). Para migración Stitch → [`docs/STITCH_MIGRATION_GAP.md`](docs/STITCH_MIGRATION_GAP.md).

**Horizonte semanal:** [`docs/WEEK_PLAN_2026-06-27.md`](docs/WEEK_PLAN_2026-06-27.md)  
**Auditorías:** [GSC](docs/GSC_AUDIT_2026-06-27.md) · [GA4](docs/GA4_AUDIT_2026-06-27.md) · [AdSense](docs/ADSENSE_AUDIT_2026-06-27.md) · [API run](docs/API_RUN_2026-06-27.md)

---

## Vista rápida

| Métrica | Estado |
|---------|--------|
| Stitch shell | **7/7** completo |
| Posts | **14 EN** + 9 ES redirect |
| Tareas abiertas | **~14** (solo manual / decisión) |
| Semana | **27 jun – 3 jul** — medición + indexación + AdSense |

### Hacer hoy (top 5)

1. **T21** — Publish GTM con consent (`GTM-K8J9KSB8`)
2. **T25b** — QA consent GA4 en incógnito
3. **T23b** — Push deploy sitemap T23 → reenviar en GSC
4. **T24** — Solicitar indexación 6 URLs EN en GSC (manual UI)
5. **T25c** — Filtro bots Singapore en GA4 (UI o habilitar Admin API)

---

## Por hacer — Alta (esta semana)

### Medición y consent (T21, T25)

| ID | Tarea | Tipo | Día |
|----|-------|------|-----|
| **T21** | Publish GTM con consent settings | manual GTM | Lun |
| **T25a** | Consent en tags GA4 + ads en GTM | manual GTM | Lun |
| **T25b** | QA consent: rechazar/aceptar → GA4 Realtime | manual QA | Lun |
| **T25d** | Asociar GSC ↔ GA4 (`356406631`) | manual GSC | Lun |
| **T26d** | QA ads tras consent `advertisement` | manual QA | Lun |

### Search Console (T23–T24)

| ID | Tarea | Tipo | Día |
|----|-------|------|-----|
| **T23b** | Deploy sitemap T23 + reenviar GSC | deploy | Mar |
| **T24** | Solicitar indexación URLs EN | manual GSC | Mar |
| **T23d** | Vigilar sitemap `isPending` → procesado | manual GSC | Mar–Mié |

### Calidad GA4 (T25)

| ID | Tarea | Tipo | Día |
|----|-------|------|-----|
| **T25c** | Filtro/exclusión tráfico Singapore (bots) | manual GA4 | Mié |
| ~~**T25f**~~ | ~~Corregir URLs `//` en pagePath~~ | ✅ código | — |

### AdSense (T26)

| ID | Tarea | Tipo | Día |
|----|-------|------|-----|
| ~~**T26a**~~ | ~~Mapear 6 slot IDs ↔ ad units dashboard~~ | ✅ API AdSense | — |
| **T26b** | Renombrar ad units en AdSense | manual AdSense | Jue |
| **T26c** | QA visual 6 placements | manual QA | Jue |

---

## Por hacer — Media (esta semana si hay tiempo)

| ID | Tarea | Tipo | Día |
|----|-------|------|-----|
| ~~**T24b**~~ | ~~Internal linking EN → Intelligence~~ | ✅ código | — |
| ~~**T23e**~~ | ~~Informe Páginas GSC (cobertura)~~ | ✅ API → `GSC_API_SNAPSHOT` | — |
| ~~**T25e**~~ | ~~Investigar pico tráfico 20-jun~~ | ✅ API GA4 | — |
| **T25g** | Revisar Enhanced Measurement GA4 | manual GA4 | Mié |
| **T25i** | Segmento “Tráfico humano LATAM” | manual GA4 | Mié |
| **T26e** | AdSense Policy + invalid traffic | manual AdSense | Jue |
| **T26f** | Evaluar densidad ads home vs post | decisión | Jue |
| ~~**T26g**~~ | ~~Ads en posts con más tráfico~~ | ✅ código | — |
| ~~**T25h**~~ | ~~2 eventos custom GA4 (outbound, search)~~ | ✅ código | — |
| **T25j** | Snapshot baseline 7d post-fix | docs | Vie |
| **T6** | Vision Lab — caso real | contenido | Vie |

---

## Por hacer — Baja

| ID | Tarea | Tipo |
|----|-------|------|
| **T23f** | Bing Webmaster Tools + sitemap | manual |
| **T23g** | GSC ↔ GA4 (si no hecho en T25d) | manual |
| **T26h** | Priorizar ads en slugs EN cuando indexen | código |
| **T26i** | Evaluar Auto ads AdSense | decisión |
| **T26j** | Meta: 1.000 pageviews/mes para RPM estable | meta |

---

## Aparcamiento (deferred)

| ID | Tarea | Notas |
|----|-------|-------|
| **T3** | Model performance explorer | Sin datos reales aún |
| **T27** | Google Ads (campanas de pago) | No hay cuenta; ver `ADSENSE_AUDIT` §8 |

---

## Solo manual — por permisos del bot

| Área | El bot puede | Solo tú (UI humana) |
|------|--------------|---------------------|
| **GSC** | Leer keywords/páginas, inspeccionar URL, submit sitemap | **Solicitar indexación**, vigilar cobertura visual |
| **GA4** | Leer reportes Data API | **Filtros**, segmentos, Enhanced Measurement, **vincular GSC** |
| **GTM** | — | **Publish** container + consent en tags |
| **AdSense** | Leer earnings (OAuth) | **Renombrar units**, Policy center, QA visual |
| **Google Ads** | — | No hay cuenta (solo AdSense publisher) |

Lista accionable post-deploy: [`docs/API_RUN_2026-06-27.md`](docs/API_RUN_2026-06-27.md) § manual.

---

### GSC
| Acción | Estado |
|--------|--------|
| Eliminar sitemap `/sitemap` | ✅ API 27-jun |
| Reenviar `sitemap.xml` post-deploy T23 | ⏳ (API bloqueada hasta deploy) |
| Indexación EN (T24) — inspección API | ✅ 6 URLs “unknown”; **solicitar en UI** |

### GA4
| Acción | Estado |
|--------|--------|
| GTM publish + consent QA | ⏳ |
| Filtro bots Singapore | ⏳ |
| GSC ↔ GA4 asociación | ⏳ |

### AdSense
| Acción | Estado |
|--------|--------|
| Mapear 6 slots ↔ dashboard | ✅ API 27-jun (`site_ops.yml`) |
| QA placements post-consent | ⏳ |
| Policy center limpio | ⏳ |

---

## Hecho

### SEO / Search Console
| ID | Entrega |
|----|---------|
| T22 | Canonical, redirects, hreflang, flagship EN |
| T23 | `sitemap_exclude`, filtro redirects, informe GSC |
| T23c | Sitemap legacy eliminado en GSC ✅ |
| T25e | Pico 20-jun: 17 sesiones Singapore (bots) ✅ |
| T25f | `normalize-url.html` + redirect + hreflang ✅ |
| T26a | Mapa 6 slots ↔ AdSense (API) ✅ |
| T24b | `music-player-english`, `automation-sending` en flagship ✅ |
| T23e | Snapshot GSC páginas + 14 inspecciones EN ✅ |
| T25h | `analytics-events.js` (outbound_click, site_search) ✅ |
| T26g | `mid_article_priority_slugs` en posts alto tráfico ✅ |
| T24† | Inspección API 6 URLs EN — pendiente indexación manual |

### Analytics / monetización (código)
| ID | Entrega |
|----|---------|
| T7–T7d | AdSense 6 slots, Clarity, GTM, anti-CLS |
| T21† | Consent scaffold + CookieYes ID — **falta publish GTM** |

### Auditorías (27-jun)
| Doc | Contenido |
|-----|-----------|
| `GSC_AUDIT_2026-06-27.md` | Indexación, sitemap, EN vs ES |
| `GA4_AUDIT_2026-06-27.md` | Bots SG, bounce 84%, fuentes |
| `ADSENSE_AUDIT_2026-06-27.md` | $0.02/30d, slots vs dashboard |
| `API_RUN_2026-06-27.md` | Batch API GSC/GA4/AdSense + límites |

### Stitch + contenido + docs
Stitch **7/7** (T11–T20) · Perfil T1–T2 · EN/ES T5/T5b · SEO descriptions T9 · Repo cleanup · `README_UX_EVOLUTION` T10 · `STITCH_MIGRATION_GAP` T17

---

## Referencias

### T21 — CookieYes + GTM (resumen)
1. CookieYes → Consent Mode v2 ON  
2. GTM → tags con consent requerido → **Publish**  
3. QA incógnito: rechazar / aceptar analytics / aceptar ads  

### IDs
`~/mcp_servers/.env` — GA4 `356406631`, AdSense `pub-2402437399062384`, GTM `GTM-K8J9KSB8`

### Changelog reciente
| Fecha | Entrega |
|-------|---------|
| 2026-06-27 | Batch API: T25e, T26a, T24 inspección, T25f, T24b; `API_RUN` |
| 2026-06-27 | T23 sitemap limpio (commit `ded08b0`) |
| 2026-06 | T22 SEO infra |
