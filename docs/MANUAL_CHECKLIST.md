# Checklist manual — solo lo que la API no puede hacer

_Actualizado 2026-09-16 · Bot: `bash tools/seo-kickoff.sh` · Guía: [`SEO_TOOLING.md`](SEO_TOOLING.md)_

---

## Respuesta rápida: ¿hace falta push/deploy otra vez?

**No.** El HTML live de las ES (p. ej. `…/posts/reproductor-musica/`) **ya** está sin `noindex` y con canonical a sí misma.  
GSC “Último rastreo 17 jul + noindex” es la **copia vieja indexada**.  
Usa **Probar URL publicada** (prueba en vivo). El nuevo crawl llega solo; no requiere otro push salvo que cambies el repo.

---

## 1. Solo tú — GSC / Bing

**Ya hecho por bot:** sitemap GSC · IndexNow · HTTP 200 · Bing SubmitFeed (2026-09-16, key en `~/.zshrc`)  
→ [`SEO_GO1_2026-09-16.md`](SEO_GO1_2026-09-16.md) · `bash tools/seo-kickoff.sh`

### A. Security & Manual Actions (~30 s) — ✅ si “no hay nada”

1. [Search Console](https://search.google.com/search-console) → `ccamilocristian.github.io`
2. **Security & Manual Actions**
3. Sin problemas = listo. No pidas review si está limpio.

### B. Solicitar indexación — ⚠️ URL con `/posts/`

**Nunca** pegues `https://ccamilocristian.github.io/convertidor-IPC` → **404**.  
Siempre: `https://ccamilocristian.github.io/posts/convertidor-IPC/`

Por cada URL en [Inspección](https://search.google.com/search-console/inspect):

1. Pegar URL canónica (abajo)  
2. **Probar URL publicada** → debe: 200, sin noindex, canonical = esa misma URL  
3. **Solicitar indexación** (una vez; esperar 7–14 días antes de repetir)

| Estado 16-sep | URL |
|---------------|-----|
| Pedida | `https://ccamilocristian.github.io/tabs/profile/` |
| Pedida | `https://ccamilocristian.github.io/posts/colombia-cpi-indexation-engine-english/` |
| Pedida | `https://ccamilocristian.github.io/posts/real-cost-of-credit-colombia-english/` |
| Pedida | `https://ccamilocristian.github.io/posts/music-player-english/` |
| Pedida | `https://ccamilocristian.github.io/posts/convertidor-english/` |
| Pedida | `https://ccamilocristian.github.io/posts/automation-sending/` |
| Pedida (live OK; índice aún stale Jul) | `https://ccamilocristian.github.io/posts/convertidor-IPC/` |
| Pedida (live OK; índice aún stale Jul) | `https://ccamilocristian.github.io/posts/reproductor-musica/` |

Si “Probar URL publicada” sale bien pero el panel “Indexación” aún dice noindex: **normal** hasta el próximo crawl. No hace falta redeploy.

### C. Bing — ✅ key + sitemap (2026-09-16)

1. Sitio verificado en [Bing Webmaster](https://www.bing.com/webmasters)
2. Key en shell persistente:

```bash
# una vez
echo 'export BING_WEBMASTER_API_KEY="…"' >> ~/.zshrc
source ~/.zshrc
bash tools/bing-submit-sitemap.sh
```

3. Tras cada deploy grande: `bash tools/seo-kickoff.sh` (vuelve a SubmitFeed + IndexNow)

### D. Vigilar sitemap GSC

Sitemaps → `lastDownloaded` **> 2024-10-16** y ~**38** URLs (no 73 stale).

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
