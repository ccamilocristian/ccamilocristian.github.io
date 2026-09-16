# Backlog

_Last sync: 2026-09-17 (P-M* mobile perf on `cursor/perf-mobile-pm`; gsccli+Bing MCP diagnosis plan)_

_Prev sync: 2026-09-16 (SEOmator follow-ups merged #16)_

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
| Live regression | ✅ PRs #9–#16 live; smoke HTML/CSS **44/44 PASS** (2026-09-17) |
| Lighthouse desktop **live** (post-#16) | Home **Perf 95 · Acc 100 · BP 100 · SEO 100** · Archives **98 / 100** |
| Lighthouse **mobile** home (post-#16) | **Perf 75** — LCP **6.9 s** (render-delay 89%); ver P-M* abajo |
| SEOptimer home (guest, 16 Sep) | Overall **B** · On-Page **A-** · Links **A-** · **Usability F** · **Performance A** · Social **A+** |
| Unlighthouse | Stale pre-#15 — **re-run pending** (P-UL) |
| Frase structural | **Closed**; GEO editorial **open** (G1–G3) |
| Semana | **P-M1** avatar.png · P-M4/P-M5 · GSC · P-U1 Usability F |

### Smoke PR #16 (2026-09-17) — PASS

| Check | Resultado |
|-------|-----------|
| Bootstrap + FA non-blocking, GTM idle, CookieYes pending/async | ✅ live |
| og:image `.webp`, Person schema, archives sin ads/intel JS | ✅ |
| CMP CSS `#0a58ca`, GA4 directo + consent denied default | ✅ |
| LH desktop Acc / render-blocking | ✅ Acc **100**, RB score **1** |
| Manual: CookieYes Accept → GA4 Realtime | ⏳ tú (incógnito) |

### Hecho esta ronda (PRs #9–#16)

| PR | Qué |
|----|-----|
| #9–#13 | Credit 404, P1 WebP/fonts, a11y, llms, meta/og/H1/alts |
| #14 | Person + Organization JSON-LD; tertiary contrast |
| #15 | CookieYes async; FA defer; archives trim |
| #16 | Bootstrap defer; GTM idle; CMP CLS/contrast; og WebP |

### Lighthouse live

| Página | Form | Perf | Acc | BP | SEO | Notas |
|--------|------|------|-----|----|-----|-------|
| `/` | desktop | **95** | **100** | 100 | 100 | Post-#16 smoke |
| `/tabs/archives/` | desktop | **98** | **100** | 100 | 100 | Post-#16 |
| `/` | **mobile** | **75** | — | — | — | LCP 6.9 s; unused JS 147 KiB |

---

## SEOptimer / “SEOmator” — por qué se siente Performance bajo

**Aclaración:** en SEOptimer guest la categoría **Performance = A** (no F). El **overall B** lo arrastra **Usability F**. Si viste “performance bajo”, suele ser:

1. Confundir **Usability F** / overall B con Performance  
2. **PageSpeed / Lighthouse mobile** (nuestro mobile Perf **75**, LCP 6.9 s)  
3. Un reporte **SEOmator de pago** (sin URL pública; 404 al scrape)

### Grades SEOptimer (guest HTML, ~16 Sep)

| Categoría | Grado |
|-----------|-------|
| Overall | **B** |
| Performance | **A** ← no es el problema |
| Usability | **F** ← baja el overall |
| On-Page / Links / Social | A- / A- / A+ |

### Causa real mobile (LH) — LCP render-delay 89%

LCP = texto `#home-hero-lead` (no imagen). Main thread ocupado por JS/CSS/imagenes antes de pintar.

| Peso | Recurso | Tarea |
|------|---------|-------|
| ~375 KiB | `avatar.png` aún en home | **P-M1** |
| ~187+120 KiB | gtag + gtm.js | **P-M2** |
| ~45 KiB unused | Bootstrap + home.css + FA rules | **P-M3** |
| thumbs PNG | case cards (`municipios.PNG`, `tabla.PNG`, …) | **P-M4** |
| ~86+68 KiB | jQuery + Bootstrap JS en stitch | **P-M5** |
| Usability F | checklist paywall | **P-U1** |
| Cache TTL GH Pages | no controlable | ignorar |

### Tareas nuevas (meter a cola — necesitan GO para código)

| ID | Tarea | Pri |
|----|-------|-----|
| **P-M1** | Home: `site.avatar` → `portrait-sm.webp` | **Done** (`cursor/perf-mobile-pm`) |
| **P-M2** | GTM solo tras consent analytics (Clarity pattern) | **Done** (this PR) |
| **P-M3** | Trim unused CSS (subset Bootstrap / home.css) | **Deferred** — CSS already non-blocking; low ROI vs P-M5 |
| **P-M4** | Case-card thumbs → WebP | **Done** (tabla/municipios/ries_edu) |
| **P-M5** | Home: lazy jQuery/Bootstrap/home.min (idle/interaction) | **Done** (this PR) |
| **P-U1** | Login SEOptimer → anotar checks Usability F reales | **P2** manual |
| **P-U2** | Tras P-M*: re-LH mobile + Refresh SEOptimer | **P2** |
| **P-UL** | Re-run Unlighthouse cuando haya RAM | **P3** |
| **G1–G3** | GEO: TL;DR / FAQ schema / question-H2 (content GO) | editorial |

### Hacer ahora (top 5)

1. **Merge** `cursor/perf-mobile-pm` (P-M1/2/4/5) → re-LH mobile  
2. **GO T-IDX1** — setup `nalyk/gsccli` + IDX-G1/G2  
3. **GO T-IDX2** — setup `stufently/bing-webmaster-mcp` + IDX-B1/B2  
4. **IDX-X1** matriz Google↔Bing money URLs  
5. Request indexing solo P0 · no GEO sin content GO  

### Cola residual

| Fuente | Hallazgo | Estado |
|--------|----------|--------|
| LH desktop #16 | RB / CMP contrast / CLS | **Done** |
| LH mobile | LCP 6.9 s · avatar.png · gtag/GTM · jQuery | **Open** P-M* |
| SEOptimer | Perf **A** OK; Usability **F** → overall B | **Open** P-U1 |
| SEOmator SaaS | Sin reporte público | N/A |

---

---

## HotH PDF audit (`RkYHPw20No59jo_h`) — hecho vs falta

Fuente: [HotH / Website Audit PDF](https://thehoth.websiteauditserver.com/download-pdf.inc/RkYHPw20No59jo_h) (27 pp., home). Grades PDF: Overall **B** · On-Page **B** · GEO **B** · Links **F** · Usability **B** · Performance **A**.

| Check HotH | PDF | Live / repo ahora | Acción |
|------------|-----|-------------------|--------|
| Title 50–60 | WARN (30) | Home brand title **30** (intencional) | **H-T1** opcional enriquecer ≤60 sin matar marca |
| Meta 120–160 | WARN (180) | **128** live | **Done** (#13) — PDF stale |
| `html lang` | PASS | `en` | Done |
| 1× H1 | PASS | 1 | Done |
| H2–H6 presentes | PASS | sí | Done |
| Skipped heading level | WARN (1) | revisar outline home | **H-H1** |
| Keyword consistency | WARN | brand vs skill keywords | Parked / editorial |
| Thin content (610 words) | WARN | home es dashboard, no article | Parked (no inflar home) |
| Image alt (1 missing) | WARN | CookieYes `close.svg` | **H-A1** (CMP; bajo ROI) |
| Canonical / SSL / no noindex | PASS | OK | Done |
| robots.txt + sitemap | PASS | OK + Sitemap ref | Done |
| Analytics GA/GTM/Clarity | PASS | OK | Done |
| Schema JSON-LD | PASS | WebSite + **Person** (+ Org live) | Done (#14) |
| GEO / AI structure | GEO **B** | `llms.txt` done; FAQ/TL;DR open | **G1–G3** (ya en cola) |
| Links | **F** | suele = backlinks off-page, no on-page bug | **H-L1** documentar; outreach opcional |
| Usability | **B** (HotH) / **F** (SEOptimer) | LH Acc **100** | **P-U1** (cruzar checks) |
| Performance | **A** | Desktop LH **95** | OK; mobile → **P-M*** |
| PSI desktop “poor” en PDF | WARN stale | Desktop live **95** post-#16 | Ignore / re-run PSI |
| Inline styles | WARN | GTM noscript + stitch delays + ads vars | **H-I1** low ROI |
| Social FB / IG / YT | WARN missing | LinkedIn + X OK | **H-S1** opcional (no inventar redes) |
| LocalBusiness / NAP | WARN | Portfolio personal, no local biz | **Ignore** (Person schema basta) |
| DMARC / SPF on `github.io` | WARN | DNS de user Pages; email es Outlook | **H-D1** solo si hay dominio propio |
| og:image | PDF OG sin image listado completo | **webp** live | **Done** (#16) |
| WWW redirect | N/A en PDF canónico | user Pages | Ignore |

### Tareas nuevas desde HotH (añadidas a cola)

| ID | Tarea | Pri | Notas |
|----|-------|-----|-------|
| **H-H1** | Arreglar skipped heading en home (outline H1→H2→H3) | P2 | UX/a11y + HotH |
| **H-T1** | Valorar title home 50–60 con keyword sin matar marca | P3 | Tradeoff brand |
| **H-A1** | Alt en iconos CMP si controlable; si no, documentar false positive | P3 | CookieYes |
| **H-L1** | Aclarar Links F = backlink profile; plan mínimo (directories, guest?) | P3 | Off-page |
| **H-I1** | Reducir inline styles stitch (animation-delay → CSS classes) | P3 | Cosmético perf |
| **H-S1** | No crear FB/IG/YT solo por el audit; link solo si existen | — | Skip unless real |
| **H-D1** | SPF/DMARC cuando exista dominio custom (no `github.io`) | parked | DNS |

---

## Tooling: auditoría de indexación Google / Bing (repos)

No hay un único “oráculo” que sustituya GSC **Request indexing** (sigue siendo manual). Sí hay CLIs/MCP que **inspeccionan coverage, sitemaps, URL Inspection y Bing** sin más rodeos. Encajan encima de lo que ya tenemos (`tools/seo-kickoff.sh`, `seo-batch.py`, IndexNow, Bing SubmitFeed).

### Google Search Console / indexación

| Repo | Para qué | Encaje |
|------|----------|--------|
| [nalyk/gsccli](https://github.com/nalyk/gsccli) | CLI GSC + Indexing API + URL Inspection batch + MCP | **Top candidato** para diagnosticar indexed/unknown/noindex stale |
| [samalyxx/gsc-seo-mcp](https://github.com/samalyxx/gsc-seo-mcp) | MCP: analytics + URL inspection + sitemaps | Si quieres chat-driven audit en Cursor |
| [acamolese/google-search-console-mcp](https://github.com/acamolese/google-search-console-mcp) | MCP read-only + HTML audit (EN/IT) | Diagnóstico performance + indexing hints |
| [ildrm/python-seo-auditor](https://github.com/ildrm/python-seo-auditor) (“Atlas”) | Crawler 84 checks + GSC + PSI/CrUX | Auditoría técnica sitewide (no solo index) |
| [naphiertech/search-engine-launch](https://github.com/naphiertech/search-engine-launch) | Skill launch/troubleshoot GSC **y** Bing | Checklist unificado crawl/index |
| [jonny-1812/seo-geo-aeo](https://github.com/jonny-1812/seo-geo-aeo) | robots vs 15 crawlers + indexability + GSC setup | Complemento GEO/AI bots |
| Ya en repo | `seo-kickoff.sh` / `seo-batch.py` / `_seo_onpage_checks.py` | Keep; ampliar con gsccli si hace falta |

**Límite real:** Google **no** expone “Request indexing” por API. URL Inspection API = leer estado; el botón UI sigue siendo humano.

### Bing Webmaster / IndexNow

| Repo | Para qué | Encaje |
|------|----------|--------|
| [stufently/bing-webmaster-mcp](https://github.com/stufently/bing-webmaster-mcp) | MCP/CLI: performance, **indexing status**, sitemaps, URL submit | **Top Bing** |
| [NmadeleiDev/bing_webmaster_cli](https://github.com/NmadeleiDev/bing_webmaster_cli) | CLI token-based para agents | Alternativa ligera |
| [btakita/webmaster](https://github.com/btakita/webmaster) | CLI unificado search engines | Multi-motor |
| [zRelux/search-console-cli](https://github.com/zRelux/search-console-cli) | Node CLI GSC **+** Bing | Un solo binario |
| [kilicdev/seo-indexer](https://github.com/kilicdev/seo-indexer) | Submit sitemap URLs multi-engine | Complemento IndexNow |
| Ya en repo | `indexnow-ping.sh` + `bing-submit-sitemap.sh` | Keep |

### Tarea de adopción tooling

| ID | Tarea | Pri |
|----|-------|-----|
| **T-IDX1** | Instalar/usar **[nalyk/gsccli](https://github.com/nalyk/gsccli)** con service account actual | **P1** setup |
| **T-IDX2** | Instalar/usar **[stufently/bing-webmaster-mcp](https://github.com/stufently/bing-webmaster-mcp)** + `BING_WEBMASTER_API_KEY` | **P1** setup |
| **T-IDX3** | Documentar flujo en `docs/SEO_TOOLING.md` (comandos + límites Request indexing) | **P2** docs |

### Diagnóstico profundo — checklist operativo (post-setup gsccli + Bing MCP)

Herramientas fijas: **gsccli** (Google) · **bing-webmaster-mcp** (Bing). Nuestro `seo-kickoff.sh` / IndexNow se quedan como ping; el diagnóstico vive aquí.

| ID | Tarea | Tool | Entregable |
|----|-------|------|------------|
| **IDX-G1** | Inventory sitios GSC + sitemap status (`isPending`, lastDownloaded) | gsccli | Tabla sitemaps |
| **IDX-G2** | Batch **URL Inspection** money EN+ES + hubs (/, profile, intelligence, archives) | gsccli | CSV: coverageState, robotsTxtState, indexingState, lastCrawl |
| **IDX-G3** | Triage unknown / excluded / soft-404 / duplicate / crawled-not-indexed | gsccli | Lista P0 con causa |
| **IDX-G4** | Diff sitemap URLs vs Inspection “URL is on Google” | gsccli + sitemap.xml | Gaps a re-pedir indexing |
| **IDX-G5** | Search Analytics 90d: queries/pages con impress≥1 y CTR=0 (oportunidad) | gsccli | Top 20 |
| **IDX-G6** | Confirmar ES “noindex stale” vs live (Inspection live vs indexed) | gsccli | Clear/false-alarm |
| **IDX-B1** | Bing site verify + sitemap get + crawl stats | bing-webmaster-mcp | Snapshot Bing |
| **IDX-B2** | Bing URL / traffic ranking vs IndexNow ping log | bing-webmaster-mcp | Indexed? submitted? |
| **IDX-B3** | Submit URLs críticas a Bing API (si no indexadas) + re-check 7d | bing-webmaster-mcp | Queue |
| **IDX-X1** | Matriz única Google↔Bing por URL money (una fila = una URL) | ambos | `docs/INDEXING_MATRIX_YYYY-MM-DD.md` |
| **IDX-X2** | Automatizar reporte semanal (script wrapper en `tools/`) | ambos | `tools/indexing-diagnosis.sh` |
| **IDX-X3** | Lo que **sigue manual**: GSC Request indexing UI + Security | — | Checklist en MANUAL |

**Orden sugerido:** T-IDX1 → IDX-G1/G2 → T-IDX2 → IDX-B1/B2 → IDX-X1 → IDX-G3/G4 → Request indexing solo URLs P0.


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

### Performance mobile / SEOptimer (2026-09-17)

| ID | Tarea | Tipo |
|----|-------|------|
| ~~**P-M1**~~ | ~~avatar → webp~~ | ✅ this PR |
| ~~**P-M4**~~ | ~~thumbs WebP~~ | ✅ this PR |
| ~~**P-M5**~~ | ~~home lazy Chirpy JS~~ | ✅ this PR |
| ~~**P-M2**~~ | ~~GTM post-consent~~ | ✅ this PR |
| **P-M3** | Unused CSS trim | código (GO) |
| **P-U1** | Anotar Usability F SEOptimer | manual |
| **P-U2** | Re-LH mobile + SEOptimer refresh | QA post P-M* |

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
