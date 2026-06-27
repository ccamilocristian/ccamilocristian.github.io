# Backlog

_Last sync: 2026-06-27 (baseline + IndexNow ping)_

Punto de entrada del proyecto. Para visión → [`README_UX_EVOLUTION.md`](README_UX_EVOLUTION.md). Para migración Stitch → [`docs/STITCH_MIGRATION_GAP.md`](docs/STITCH_MIGRATION_GAP.md).

**Horizonte semanal:** [`docs/WEEK_PLAN_2026-06-27.md`](docs/WEEK_PLAN_2026-06-27.md)  
**Auditorías:** [GSC](docs/GSC_AUDIT_2026-06-27.md) · [GA4](docs/GA4_AUDIT_2026-06-27.md) · [AdSense](docs/ADSENSE_AUDIT_2026-06-27.md) · [API run](docs/API_RUN_2026-06-27.md)

---

## Vista rápida

| Métrica | Estado |
|---------|--------|
| Stitch shell | **7/7** completo |
| Posts | **14 EN** + 9 ES redirect |
| Tareas abiertas | **~7** (manual UI; T25c filtro en GA4) |
| Semana | **27 jun – 3 jul** — medición + indexación + AdSense |

### Hacer hoy (top 5)

1. **T24** — GSC: 13 URLs → [`docs/T24_GSC_INDEX_NOW.md`](docs/T24_GSC_INDEX_NOW.md)
2. **T25c** — Filtro Singapore → [`docs/TU_TURNO_MANUAL.md`](docs/TU_TURNO_MANUAL.md) §2
3. **T25b** — QA consent incógnito → [`docs/TU_TURNO_MANUAL.md`](docs/TU_TURNO_MANUAL.md) §4
4. **T23f** — Bing Webmaster → [`docs/TU_TURNO_MANUAL.md`](docs/TU_TURNO_MANUAL.md) §6

---

## Estado de alineación (¿estamos midiendo bien?)

| Capa | Estado | Notas |
|------|--------|-------|
| **GTM Live v6** | ✅ | config tag + DLV (`link_url`, `search_term`, `page_path`) |
| **GA4 pageviews** | ✅ | `G-4FK52MWLPP` vía GTM; `skip_direct_ga4: true` (sin duplicados) |
| **Consent site** | ✅ | CookieYes ID activo + `consent-defaults.html` deny-by-default |
| **Consent QA** | ⏳ | Falta prueba incógnito post-v5 |
| **Eventos custom** | ✅ | GTM v6: DLV + `eventSettingsTable` |
| **Clarity** | ✅ | Tras consent analytics |
| **AdSense** | ✅ código | 6 slots alineados; **no es Google Ads** (no hay campañas) |
| **GSC orgánico** | ⚠️ | 98% tráfico en URLs ES legacy; EN casi sin indexar |
| **Sitemap GSC** | ⏳ | Reenviado API 27-jun; `isPending`; live ~73 URLs (sin assets) |
| **GA4 datos limpios** | ⏳ | Filtro Singapore — **manual UI** (API 404 en dataFilters) |
| **GSC ↔ GA4 link** | ✅ | Vinculado manual 27-jun |
| **URLs `//` en GA4** | ⚠️ | Fix en repo; datos viejos hasta estabilizar |
| **Bing / IndexNow** | ✅ ping | T32 key live + `indexnow-ping.sh` ejecutado |
| **Docs internos** | ✅ | `BACKLOG.md` excluido del build (`d0dcf76`) |

**Veredicto:** medición **casi alineada** — GTM y código coinciden. Datos aún **no son confiables** para decisiones hasta filtro bots + QA consent + indexación EN.

### GTM — warnings típicos (T31)

| Warning UI | Causa | Fix |
|------------|-------|-----|
| GA4 Event sin “Configuration tag” | `gaawe` usa `measurementIdOverride` suelto | Vincular al Google Tag (API) |
| Eventos sin parámetros | Tags solo envían nombre | Añadir DLV `link_url`, `search_term` |
| Consent overview | CookieYes update no en GTM | Opcional: tag Consent Update en GTM |

---

## Por hacer — Alta (esta semana)

### Medición y consent (T21, T25)

| ID | Tarea | Tipo | Día |
|----|-------|------|-----|
| ~~**T21**~~ | ~~Publish GTM con consent~~ | ✅ API v5 | — |
| **T25a** | Consent ads (AdSense vía sitio, no GTM) | verificar QA | Lun |
| **T25b** | QA consent: rechazar/aceptar → GA4 Realtime | manual QA | Lun |
| ~~**T25d**~~ | ~~Asociar GSC ↔ GA4~~ | ✅ manual | — |
| **T26d** | QA ads tras consent `advertisement` | manual QA | Lun |
| ~~**T31**~~ | ~~GTM warnings: config tag + DLV~~ | ✅ API v6 Live | — |

### Search Console (T23–T24)

| ID | Tarea | Tipo | Día |
|----|-------|------|-----|
| **T23b** | Deploy sitemap T23 + reenviar GSC | ~~deploy~~ ✅ push; reenviado API | Mar |
| **T24** | Solicitar indexación URLs EN | manual GSC | 13/15 pendientes → [`T24_GSC_INDEX_NOW.md`](docs/T24_GSC_INDEX_NOW.md) |
| **T23d** | Vigilar sitemap `isPending` → procesado | manual GSC | Mar–Mié |

### Calidad GA4 (T25)

| ID | Tarea | Tipo | Día |
|----|-------|------|-----|
| **T25c** | Filtro/exclusión tráfico Singapore (bots) | **manual GA4** (API bloqueada) | Mié |
| ~~**T25f**~~ | ~~Corregir URLs `//` en pagePath~~ | ✅ código | — |

### AdSense (T26)

| ID | Tarea | Tipo | Día |
|----|-------|------|-----|
| ~~**T26a**~~ | ~~Mapear 6 slot IDs ↔ ad units dashboard~~ | ✅ API AdSense | — |
| **T26b** | Renombrar ad units | manual AdSense | → [`T26_ADSENSE_MANUAL.md`](docs/T26_ADSENSE_MANUAL.md) §1 |
| **T26c** | QA visual 6 placements | manual QA | → [`T26_ADSENSE_MANUAL.md`](docs/T26_ADSENSE_MANUAL.md) §2 |

---

## Por hacer — Media (esta semana si hay tiempo)

| ID | Tarea | Tipo | Día |
|----|-------|------|-----|
| ~~**T24b**~~ | ~~Internal linking EN → Intelligence~~ | ✅ código | — |
| ~~**T23e**~~ | ~~Informe Páginas GSC~~ | ✅ API | — |
| ~~**T25e**~~ | ~~Investigar pico 20-jun~~ | ✅ API GA4 | — |
| **T25g** | Revisar Enhanced Measurement GA4 | ~~API~~ scroll/outbound/search ON ✅ | Mié |
| **T25i** | Segmento “Tráfico humano LATAM” | manual GA4 | Mié |
| **T29** | GA4 Explorations + Looker storytelling | manual GA4 | Mié |
| **T26e** | AdSense Policy + invalid traffic | manual AdSense | → [`T26_ADSENSE_MANUAL.md`](docs/T26_ADSENSE_MANUAL.md) §3 |
| ~~**T26f**~~ | ~~Evaluar densidad ads home vs post~~ | ✅ decisión | Mantener 6 placements |
| ~~**T26h**~~ | ~~Priorizar ads en slugs EN~~ | ✅ código | 14 slugs EN mid-article |
| ~~**T26i**~~ | ~~Evaluar Auto ads~~ | ✅ decisión | OFF |
| ~~**T25h**~~ | ~~2 eventos custom GA4~~ | ✅ GTM+código | — |
| ~~**T25j**†~~ | ~~Baseline pre-filtro~~ | ✅ `GA4_BASELINE_2026-06-27.md` | — |
| **T6** | Vision Lab — caso real | contenido | Vie |

---

## Por hacer — Baja / pensar en grande

| ID | Tarea | Tipo |
|----|-------|------|
| **T23f** | Bing Webmaster Tools + mismo sitemap | manual |
| **T33** | Yandex Webmaster (opcional, mercado RU) | manual |
| **T23g** | GSC ↔ GA4 (si no hecho en T25d) | manual |
| ~~**T26h**~~ | ~~Priorizar ads en slugs EN cuando indexen~~ | ✅ código | 14 slugs EN |
| ~~**T26i**~~ | ~~Evaluar Auto ads AdSense~~ | ✅ decisión | OFF |
| **T26j** | Meta: 1.000 pageviews/mes para RPM estable | meta |
| ~~**T28**~~ | ~~Habilitar Analytics Admin API~~ | ✅ GCP 27-jun | — |
| ~~**T32**~~ | ~~IndexNow key + ping script~~ | ✅ código | — |

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
| **GTM** | Editar + publish vía API | ✅ v6 Live (T31) |
| **AdSense** | Leer earnings (OAuth) | **Renombrar units**, Policy center, QA visual |
| **Google Ads** | — | No hay cuenta (solo AdSense publisher) |

Lista accionable: [`docs/MANUAL_CHECKLIST.md`](docs/MANUAL_CHECKLIST.md)

---

### GSC
| Acción | Estado |
|--------|--------|
| Eliminar sitemap `/sitemap` | ✅ API 27-jun |
| Reenviar `sitemap.xml` post-deploy T23 | ✅ API 27-jun (aún `isPending`) |
| Indexación EN (T24) | ⏳ 2/15 indexadas; **13 solicitudes manuales** → `docs/T24_GSC_INDEX_NOW.md` |

### GA4
| Acción | Estado |
|--------|--------|
| GTM publish + consent QA | ✅ v5 API 27-jun — falta QA incógnito |
| Filtro bots Singapore | ⏳ |
| GSC ↔ GA4 asociación | ✅ 27-jun |

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
| T26h | 14 slugs EN en `mid_article_priority_slugs` ✅ |
| T26f/i | Densidad mantenida; Auto ads OFF ✅ |
| T32 | IndexNow key + `tools/indexnow-ping.sh` ✅ |
| T21 | GTM v6 — consent + eventos + DLV ✅ |
| T31 | Config tag + DLV publicado v6 ✅ |
| T24† | Batch inspección 2/15 indexadas; IndexNow 18 URLs ✅ |
| T23d† | Sitemap reenviado API; `isPending`, `lastDownloaded` 2024-10-16 |
| T25c† | Filtro SG — API 404; pasos UI en `TU_TURNO_MANUAL.md` |
| T34 | Excluir `BACKLOG.md` + `README_UX_EVOLUTION.md` del build ✅ |
| T32† | IndexNow ping ejecutado post-deploy ✅ |

### Auditorías (27-jun)
| Doc | Contenido |
|-----|-----------|
| `GSC_AUDIT_2026-06-27.md` | Indexación, sitemap, EN vs ES |
| `GA4_AUDIT_2026-06-27.md` | Bots SG, bounce 84%, fuentes |
| `ADSENSE_AUDIT_2026-06-27.md` | $0.02/30d, slots vs dashboard |
| `GA4_BASELINE_2026-06-27.md` | Baseline pre-filtro (T25j) |
| `MANUAL_CHECKLIST.md` | Checklist UI copiable |

### Stitch + contenido + docs
Stitch **7/7** (T11–T20) · Perfil T1–T2 · EN/ES T5/T5b · SEO descriptions T9 · Repo cleanup · `README_UX_EVOLUTION` T10 · `STITCH_MIGRATION_GAP` T17

---

## Referencias

### T21 — CookieYes + GTM (resumen)
1. CookieYes → Consent Mode v2 ON  
2. GTM → tags con consent requerido → **Publish**  
3. QA incógnito: rechazar / aceptar analytics / aceptar ads  

### T29 — GA4 storytelling (plantilla)

Crear en GA4 → Explore (semanal):

1. **Funnel:** Home → Post EN → Intelligence tab  
2. **Path exploration:** entradas orgánicas GSC vs Direct  
3. **Segmento comparativo:** Human LATAM vs All traffic  
4. **Eventos:** `outbound_click`, `site_search` post-v5  
5. **Looker Studio** (opcional): 1 página con KPIs — users, engagement, top posts EN, AdSense RPM

### T29 — KPIs narrativa semanal

| Pregunta | Fuente |
|----------|--------|
| ¿Crece tráfico EN indexado? | GSC páginas + GA4 `/posts/*-english/` |
| ¿Bounce baja post-filtro SG? | GA4 segmento humano |
| ¿Ads generan impresiones reales? | AdSense + GA4 tras consent ads |
| ¿Keywords suben posición? | GSC queries (IPC, reproductor, email python) |

### IDs
`~/mcp_servers/.env` — GA4 `356406631` · GTM `6361961802/256082250` · AdSense `pub-2402437399062384`

**Google Ads:** no aplica — solo **AdSense publisher**. Campañas de pago = T27 aparcado.

### Changelog reciente
| Fecha | Entrega |
|-------|---------|
| 2026-06-27 | T25j baseline, MANUAL_CHECKLIST, IndexNow ping, exclude docs |
| 2026-06-27 | GTM v5 API publish; matriz alineación |
| 2026-06-27 | Commit `51b24b8` GTM docs + `0142acd` URL redirects |
| 2026-06-27 | T23 sitemap limpio (commit `ded08b0`) |
| 2026-06 | T22 SEO infra |
