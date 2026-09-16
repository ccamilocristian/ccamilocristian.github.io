# Backlog

_Last sync: 2026-09-16 (SEOmator follow-ups: Bootstrap defer, GTM idle, CMP CLS/contrast, og WebP)_

_Prev sync: 2026-09-16 (LH live post-#15; SEOmator/Frase consolidated open/closed)_

Punto de entrada del proyecto. Para visión → [`README_UX_EVOLUTION.md`](README_UX_EVOLUTION.md). Para migración Stitch → [`docs/STITCH_MIGRATION_GAP.md`](docs/STITCH_MIGRATION_GAP.md).

**Horizonte semanal:** [`docs/WEEK_PLAN_2026-06-27.md`](docs/WEEK_PLAN_2026-06-27.md)  
**Pipeline contenido:** [`docs/CONTENT_PIPELINE.md`](docs/CONTENT_PIPELINE.md) — posts publicados vs ideas pendientes  
**Auditorías:** [GSC](docs/GSC_AUDIT_2026-06-27.md) · [GA4](docs/GA4_AUDIT_2026-06-27.md) · [AdSense](docs/ADSENSE_AUDIT_2026-06-27.md) · [API run](docs/API_RUN_2026-06-27.md)

---

## Vista rápida

| Métrica | Estado |
|---------|--------|
| Stitch shell | **3 tabs en nav** (Command Center · Profile · Intelligence; Stack/Economics Lens/Vision Lab fuera del menú pero indexables) |
| Posts | **18 EN + 9 ES bilingües** (indexables, hreflang recíproco) |
| Live regression | ✅ credit canonical (PR #9) · meta/og/H1/alts (#13) · Person/Org schema + tertiary (#14) · CMP idle/FA/archives (#15) |
| Lighthouse desktop **live** (2026-09-16 post-#15) | Home **Perf 83 · Acc 96 · BP 100 · SEO 100** · Archives **Perf 98 · Acc 96 · BP 100 · SEO 100** |
| Unlighthouse (stale pre-#15) | SEO **99** · Perf **~79** · A11y **92** — **re-run pending** |
| SEOmator-equivalent home | On-page/schema/llms **PASS**; residual = Bootstrap block + unused GTM/gtag + CookieYes button contrast + GEO editorial |
| Frase structural | **Closed** (H1/alt/meta/schema Person); GEO editorial **open** |
| Semana | GSC re-crawl · optional Bootstrap defer · money-post GEO only with content GO |

### Hecho esta ronda (PRs #9–#15)

| PR | Qué quedó live |
|----|----------------|
| #9 | Credit YAML 404 → canonical + redirect + kickoff |
| #10 | P1 home: WebP hero, fonts non-blocking, ≤2 preconnect, jQuery defer, false `math` cleared |
| #11 | A11y home (pillars/tap/footer) + YAML colon/dated-path guards |
| #12 | `llms.txt`, archives H1, sitemap noise |
| #13 | Site/tab meta ≤160, og:image/logo, `dynamic_title: false`, alts |
| #14 | Person + Organization JSON-LD; tertiary `#aeb1bc` |
| #15 | CookieYes idle inject; FA non-blocking; archives sin AdSense/Intelligence JS |

### Lighthouse live (desktop, post-#15)

| Página | Perf | Acc | BP | SEO | Notas |
|--------|------|-----|----|-----|-------|
| `/` | **83** | 96 | 100 | 100 | Was ~66–67 local pre-#15; CLS 0.273 (CookieYes banner) |
| `/tabs/archives/` | **98** | 96 | 100 | 100 | Was **37** local; idle CMP + no ads/intel JS |

Acc residual en ambas: **solo botones CookieYes** (`#fff` on `#1578f7` = 4.14:1) — dashboard CMP, no tokens del sitio.

### SEOmator / SEOptimer / Rank Math — consolidado

Auditoría equivalente live home (2026-09-16) + hallazgos históricos de SEOptimer (grade B, Usability F) y Rank Math PDF.

#### Cerrado / PASS

| Ítem | Estado |
|------|--------|
| Title ≤60, meta ≤160, 1× H1, canonical, HTTPS, no noindex | ✅ |
| og:title/url/image/type + twitter:card | ✅ (`portrait-sm.png` via seo-tag; WebP hero aparte) |
| `robots.txt` + `llms.txt` 200 | ✅ |
| Schema WebSite + **Person** + **Organization** (`sameAs`) | ✅ |
| Imágenes hero/optimation WebP; ≤2 preconnect | ✅ |
| CMP no parser-blocking; FA non-blocking | ✅ |
| Archives weight (intel JS / AdSense off) | ✅ |

#### Abierto — técnico (ROI medio; necesita GO)

| # | Ítem | Origen | Acción |
|---|------|--------|--------|
| 1 | Render-blocking **Bootstrap CSS** (~210–240 ms) | LH / PSI / SEOmator perf | `media=print` onload **o** subset / drop on stitch-only routes (FOUC risk) |
| 2 | Unused JS ~270 KiB (**gtag ×2 + GTM**) | LH / PSI | Decidir: `skip_direct_ga4: true` si GTM Google Tag ON, **o** mantener direct + GTM sin googtag (hoy: direct ON, GTM tag paused) — re-verificar doble carga `gtag/js` |
| 3 | Unused CSS ~44–53 KiB | LH | Trim Chirpy/Bootstrap surface on stitch pages |
| 4 | CLS home 0.27 | LH | Banner CookieYes late paint — reservar espacio / load earlier after LCP tradeoff |
| 5 | CookieYes Accept/Reject contrast 4.14 | LH a11y | Cambiar colores en **CookieYes dashboard** (no repo) |
| 6 | `page.css` ~163 KB en archives | Perf residual | CSS split / critical path (mayor esfuerzo) |
| 7 | Optimation / MathJax posts | UL outlier | Ya WebP + math gated; residual MathJax weight |
| 8 | og:image apunta a `.png` sm | Rank Math nit | Prefer `portrait-sm.webp` in `site.logo` / defaults if seo-tag accepts |

#### Abierto — editorial GEO (Frase; **no** fingir con template)

| # | Ítem | Notas |
|---|------|-------|
| 9 | Missing summary / TL;DR | Reescribir 2–3 money posts |
| 10 | FAQ JSON-LD | Solo si hay FAQ real en el post |
| 11 | Question-style H2s | Editorial |
| 12 | Weak definitions / AI structure / fact density | Editorial |

#### No actionable / ignorar

| Ítem | Por qué |
|------|---------|
| `www.` → 404 | User `*.github.io` no soporta www redirect |
| Cache TTL GTM/CookieYes/jsDelivr | Fuera de control en GH Pages |
| SEOptimer Usability **F** (paywall) | Sin checklist; viewport/tap ya OK en LH a11y 96 |
| Security headers (CSP / X-Frame) | Limitado en GH Pages; bajo ROI |
| Minify local `consent-gate.js` | Cosmético |

### Frase issue table — status (2026-09-16 tarde)

| Issue | Status | Notes |
|-------|--------|-------|
| Missing H1 (1) | **Done** | Credit YAML 404 fixed |
| Multiple H1 (7) | **Done** | `dynamic_title: false` |
| Missing alt (7) | **Done** | Flagged posts |
| Long meta (4) | **Done** | Site 128; tabs/archives own desc |
| Thin schema (4) | **Partial** | Person+Org done; FAQ schema still open |
| Summary / TL;DR / question-H2 / definitions / AI structure / fact density | **Open** | Content GO only |

### Audits we actually ran

1. SEOptimer home · 2. Unlighthouse (stale — re-run pending) · 3. PageSpeed (viejo) + Lighthouse local + **Lighthouse live home/archives post-#15** · 4. Frase MD · 5. Rank Math PDF (HotH) · 6. SEOmator-equivalent checklist · 7. `seo-kickoff` / GSC · 8. `verify-seo-security`

### Hacer ahora (top 5)

1. **GSC** — wait / Request indexing money EN+ES si siguen unknown/stale noindex
2. **CookieYes dashboard** — darken Accept/Reject blue (cierra Acc 96→~100)
3. **GO candidato:** Bootstrap non-blocking **o** gtag double-load cleanup (#2 arriba)
4. **No chase** GEO FAQ/TL;DR unless content GO on 2–3 money posts
5. Re-run `bash tools/run-unlighthouse.sh` when RAM allows (stale scores)

### Cola reportes residual (planificar con GO)

| Fuente | Hallazgo | Acción candidata | Estado |
|--------|----------|------------------|--------|
| LH live | Bootstrap render-blocking | Non-blocking / subset | Open |
| LH live | Unused gtag+GTM ~270 KiB | Dedupe analytics path | Open |
| LH live | CookieYes btn contrast | CMP dashboard colors | Open (manual) |
| LH live | Home CLS 0.27 | Banner layout reserve | Open |
| PSI (stale) | Image delivery 667 KiB | Fixed hero WebP | **Done** |
| PSI (stale) | >4 preconnect | Fixed ≤2 | **Done** |
| SEOptimer | Usability F | Likely FP; ignore unless new evidence | Parked |
| Mem host | 0 swap | zram/swap / close Chrome piles | Ops |

---

## Estado de alineación (¿estamos midiendo bien?)

| Capa | Estado | Notas |
|------|--------|-------|
| **GTM Live v7** | ✅ | Google Tag **paused** (anti-doble page_view); eventos + DLV activos |
| **GA4 pageviews** | ✅ código | Direct gtag ON + Consent Mode; live smoke OK 19-jul |
| **Consent site** | ✅ | CookieYes → `gtag('consent','update')`; `?debug_consent=1` |
| **Consent QA** | ⏳ | Incógnito Accept → Realtime (T25b manual) |
| **Eventos custom** | ✅ | Dual path: `dataLayer` + `gtag('event')` en `analytics-events.js` |
| **Clarity** | ✅ | Tras consent analytics |
| **AdSense** | ✅ código | 6 slots alineados; **no es Google Ads** (no hay campañas) |
| **GSC orgánico** | ⚠️ | 2026-09-16: 3 indexed (/, Blog, 1 EN); money EN **unknown**; ES IPC/música **stale noindex** |
| **Sitemap GSC** | ⏳ | Reenviado **2026-09-16**; `isPending`; `lastDownloaded` aún **2024-10-16** (cuenta 73 stale) |
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
| ~~**T26f**~~ | ~~Densidad ads equilibrada~~ | ✅ | móvil 2 · desktop 2–3 · mid XOR in-article |
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

### On-page money batch (2026-09-16)
| Entrega | Estado |
|---------|--------|
| Titles ≤60 + descriptions 140–160 on CPI/credit/music/convertidor/automation/loan (+ ES pairs) | ✅ |
| Remaining WARN posts (Plotly, Icfes, RAG, …) | ⏳ next batch |

### SEO GO#1 — reindex kickoff (2026-09-16)
| Entrega | Estado |
|---------|--------|
| GSC sitemap resubmit API | ✅ (re-run via `seo-kickoff.sh`) |
| IndexNow money URLs | ✅ |
| URL Inspection prioridad | ✅ 3 ok · 8 MANUAL Request indexing |
| SEO on-page + noindex guards | ✅ `tools/_seo_onpage_checks.py` |
| Unlighthouse wiring | ✅ `package.json` + `unlighthouse.config.ts` |
| Bing SubmitFeed | ⏳ needs API key once (IndexNow already pings Bing) |
| Solicitar indexación (UI) | ⏳ solo humano |
| GSC Security & Manual Actions | ⏳ solo humano |

### Home spacing tighten (2026-09-09)
| Entrega | Estado |
|---------|--------|
| `.stitch-home` gap: 3.5–4rem → **2.5rem / 3rem** (`--ds-space-10` / `--ds-space-12`) | ✅ |
| `.stitch-section-head` margin-bottom: 1.5rem → **1rem** | ✅ |

### Auditoría: limpieza estructural + SEO bilingüe (2026-09-09)
| Entrega | Estado |
|---------|--------|
| Vision Lab despublicado (nav, teaser home, filtro Intelligence); archivos locales conservados | ✅ |
| "Vision Lab" → "Computer Vision" (skill real, Presight) en Stack/pilares/includes; tier EMERGING vacío retirado | ✅ |
| Código muerto eliminado: `intelligence_flagship.yml`, `dashboard-module.html`, `post-paginator.html` | ✅ |
| Economics Lens: métrica inventada (72%) → métrica real (avanzados) | ✅ |
| **9 posts ES republicados** como alternates indexables (`lang`/`ref`, sin colisión de redirect) | ✅ |
| hreflang recíproco EN↔ES + `x-default`→EN + `<html lang>` por página + selector de idioma | ✅ |
| Feeds on-site en inglés (Intelligence/Economics/Home); prev-next y related sin mezclar idioma | ✅ |
| `sitemap_exclude` limpiado; sitemap incluye ES (38 URLs) | ✅ |
| Docs rectores actualizados (`.cursorrules`, `README_UX_EVOLUTION`, `BACKLOG`) | ✅ |

### Presencia 30/60/90 (19-jul)
| Entrega | Estado |
|---------|--------|
| Baseline EN/ES + ledger manual GSC/Bing | ✅ repo |
| Internal linking desde Home, Intelligence y post indexado | ✅ |
| Sitemap `lastmod` real + archivos thin fuera | ✅ |
| Atom autodiscovery + feed ampliado | ✅ |
| E1 CPI mensual + E2 crédito real | ✅ |
| Refresh music-player + automation-sending | ✅ |
| README + playbook + log de distribución | ✅ repo; publicación externa manual |
| Scorecard semanal GSC/GA4/distribución | ✅ script |

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
| T26f | Densidad equilibrada: móvil 2 · desktop 2–3 · mid XOR in-article |
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
