# Checklist manual — solo lo que la API no puede hacer

_Actualizado 2026-09-17 evening · Bot: diagnóstico G1–G4 + Bing OK · Guía: [`SEO_TOOLING.md`](SEO_TOOLING.md)_

---

## Por qué GSC “no mejora” (17-sep evening) — leer esto

### 1. `lastDownloaded` = 2024-10-16 **no lo controlamos**

El sitemap live está bien (HTTP 200, XML válido, ~36 URLs, en `robots.txt`). Bing lo lee sin problema.  
Google tiene el submit en cola (`isPending`) pero **no ha vuelto a descargar** desde oct-2024. Eso es un patrón conocido en **GitHub Pages** (`github.io` compartido / crawl budget / fetch sticky) — documentado en foros GSC y reportes 2024–2026.  

**Reenviar el sitemap muchas veces no lo arregla.** Deja de hacerlo.  
Éxito ≠ ver `lastDownloaded` moverse. Éxito = URL Inspection / cobertura por página.

### 2. Las “8 P0” no son un panel en la consola

Son nuestra lista interna de triage. En GSC **no aparecen juntas**. Solo ves cada URL cuando la pegas en Inspección.  
Si ya hiciste **Solicitar indexación** en las 8: la consola puede seguir igual días/semanas; no hay barra de progreso. No re-pidas.

### 3. Qué sí puedes mirar (por URL)

Inspección → **Probar URL publicada** → debe: 200, sin noindex, canonical = esa URL.  
Si live OK y “Indexación” aún dice unknown/noindex: **normal** hasta el próximo crawl de Google.

| Qué miras | Estado ahora | Acción |
|-----------|--------------|--------|
| Sitemaps última lectura | **2024-10-16** · pending | **Ignorar / no más resubmits** |
| Coverage charts | Lentos | Esperar; no proxy de salud del HTML |
| Bing | ~68 InIndex | OK — ya ganado |
| HTML live ES/EN | Self-canonical, sin noindex | No hace falta redeploy |

---

## Respuesta rápida: ¿hace falta push/deploy otra vez?

**No.** El HTML live de las ES (p. ej. `…/posts/reproductor-musica/`) **ya** está sin `noindex` y con canonical a sí misma.  
GSC “Último rastreo + noindex” es la **copia vieja indexada**.  
Usa **Probar URL publicada** (prueba en vivo). El nuevo crawl llega solo; no requiere otro push salvo que cambies el repo.

---

## 1. Solo tú — GSC / Bing

**Ya hecho por bot:** sitemap GSC (submit 16-sep, aún pending download) · IndexNow · HTTP 200 · Bing SubmitFeed + `bing-wm` InIndex ~68 · matriz GSC↔Bing

### A. Security & Manual Actions (~30 s) — ✅ si “no hay nada”

1. [Search Console](https://search.google.com/search-console) → `ccamilocristian.github.io`
2. **Security & Manual Actions**
3. Sin problemas = listo. No pidas review si está limpio.

### B. Solicitar indexación — ⚠️ URL con `/posts/`

**Nunca** pegues `https://ccamilocristian.github.io/convertidor-IPC` → **404**.  
Siempre: `https://ccamilocristian.github.io/posts/convertidor-IPC/`

Por cada URL en [Inspección](https://search.google.com/search-console/inspect):

1. Pegar URL canónica  
2. **Probar URL publicada** → 200, sin noindex, canonical = esa misma URL  
3. **Solicitar indexación** (una vez; esperar **7–14 días** antes de repetir)

#### Ya pedidas 16-sep — **esperar** (no re-pedir aún)

| URL | Inspection 17-sep |
|-----|-------------------|
| `/tabs/profile/` | Indexed (OK) |
| `/posts/colombia-cpi-indexation-engine-english/` | Still unknown |
| `/posts/real-cost-of-credit-colombia-english/` | Still unknown |
| `/posts/music-player-english/` | Still unknown |
| `/posts/convertidor-english/` | Still unknown |
| `/posts/automation-sending/` | Still unknown |
| `/posts/convertidor-IPC/` | Still stale noindex |
| `/posts/reproductor-musica/` | Still stale noindex |

#### P0 pendientes de pedir (haz estas)

1. `https://ccamilocristian.github.io/posts/automatizacion-envio-correos/`
2. `https://ccamilocristian.github.io/posts/icfes-conexion-api/`
3. `https://ccamilocristian.github.io/posts/liquidador-intereses/`
4. `https://ccamilocristian.github.io/posts/optimizacion_teoria_consumidor/`
5. `https://ccamilocristian.github.io/posts/scraping-plebiscito-colombia/`
6. `https://ccamilocristian.github.io/posts/loan-simulator-english/`
7. `https://ccamilocristian.github.io/posts/local-rag-ollama-python-english/`
8. `https://ccamilocristian.github.io/posts/mcp-bigquery-server-python-english/`

Si “Probar URL publicada” sale bien pero el panel “Indexación” aún dice noindex/unknown: **normal** hasta el próximo crawl.

### C. Bing — ✅ verificado + InIndex ~68 (17-sep)

No es el problema. Consola Bing / `bing-wm` ya ven el sitio sano.  
Tras cada deploy grande: `bash tools/seo-kickoff.sh` (IndexNow + SubmitFeed).

### D. Sitemap GSC — **dejar de obsesionarse**

`lastDownloaded` pegado en 2024-10-16 + `isPending` tras muchos submits = **atasco Google↔github.io**, no bug de tu XML.  
Opcional nuclear (una sola vez, no en bucle): Sitemaps → eliminar `sitemap.xml` → esperar 1 día → volver a añadir la misma URL.  
Si tras eso sigue igual: acepta el estado y trabaja solo con **Inspección URL**.

---

## 2. Consent + GA4 (T25b) — manual QA

Incógnito → `https://ccamilocristian.github.io/`

- [ ] Rechazar cookies → GA4 Realtime ≈ 0
- [ ] Aceptar analytics → page_view
- [ ] Aceptar ads → `adsbygoogle.js`

## 3. GA4 admin (T25c)

- [ ] Filtro Singapore / bots

## 4. AdSense (opcional)

- [ ] Policy center limpio · QA visual placements
