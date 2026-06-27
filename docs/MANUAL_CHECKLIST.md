# Checklist manual — copiar y tachar

_Orden de impacto · ~45 min total_

---

## 1. Google Search Console (T24, T23d)

- [ ] [Inspección URL](https://search.google.com/search-console) — solicitar indexación (**con `/posts/`**):
  - `https://ccamilocristian.github.io/posts/music-player-english/`
  - `https://ccamilocristian.github.io/posts/convertidor-english/`
  - `https://ccamilocristian.github.io/posts/automation-sending/`
  - `https://ccamilocristian.github.io/tabs/intelligence/`
- [ ] Lista completa: `_data/gsc_index_urls.yml`
- [ ] Sitemaps → vigilar `lastDownloaded` (aún `isPending` / 2024-10-16)

## 2. Consent + GA4 (T25b, T25a, T26d)

Ventana incógnito → `https://ccamilocristian.github.io/`

- [ ] **Rechazar** cookies → [GA4 Realtime](https://analytics.google.com/) = 0 usuarios
- [ ] **Aceptar analytics** → Realtime muestra page_view
- [ ] **Aceptar ads** → Network: `adsbygoogle.js` carga
- [ ] CookieYes dashboard → Consent Mode v2 **ON**

## 3. GA4 admin (T25c, T25d, T25g, T25i)

- [ ] Admin → **Filtros de datos** → excluir tráfico interno o regla Singapore
- [ ] Admin → **Enlaces de productos** → vincular **Search Console**
- [ ] Enhanced Measurement: documentar scroll / outbound / site search ON/OFF
- [ ] Crear segmento **Human LATAM** (excl. Singapore)

## 4. Bing (T23f)

- [ ] [Bing Webmaster](https://www.bing.com/webmasters) → verificar sitio
- [ ] Enviar sitemap: `https://ccamilocristian.github.io/sitemap.xml`
- [ ] IndexNow: ya ejecutado vía `tools/indexnow-ping.sh` ✅

## 5. AdSense (T26b, T26c, T26e)

- [ ] Renombrar ad units descriptivos
- [ ] Policy center sin alertas
- [ ] QA visual 6 placements post-consent

## 6. GTM (T31) — si hay warnings en UI

- [ ] Workspace → **Sync** → vincular GA4 events al Google Tag + DLV
- [ ] O pedir al bot `setup_gtm_consent_and_events` tras sync
