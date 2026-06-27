# Backlog

_Last sync: 2026-06-27 (GSC audit + T23 sitemap)_

## Estado rápido

| Área | Estado |
|------|--------|
| Stitch shell | **7/7** superficies migradas |
| Contenido | **14 posts** publicados (EN); **9 ES** despublicados + redirect 301 |
| SEO posts | **T9 hecho** — `description:` en 14 posts |
| SEO infra | **T22 hecho** — URL canonical, redirects GTM, hreflang, flagship EN |
| SEO GSC | **T23 en curso** — sitemap limpio en repo; acciones manuales GSC pendientes |
| Repo hygiene | **Cleanup hecho** — gitignore, agentes, READMEs, `docs/README.md` |
| Abierto | **T6** (Vision Lab), **T3** (deferred), **T24** (indexación EN) |

---

## Acciones manuales post-deploy (T22 / T23)

| Acción | Dónde | Estado |
|--------|-------|--------|
| Reenviar sitemap | Search Console → Sitemaps → `https://ccamilocristian.github.io/sitemap.xml` | Reenviado 27-jun; **repetir tras deploy T23** |
| Eliminar sitemap legacy | GSC → Sitemaps → quitar `…/sitemap` (sin `.xml`) | **Hecho vía API** 27-jun |
| Solicitar indexación EN | GSC → Inspección URL → top slugs EN + `/tabs/intelligence/` | **Pendiente** |
| Vincular GSC ↔ GA4 | GSC → Configuración → Asociaciones | **Verificar** |
| 301 legacy ES (opcional) | Cloudflare Rules si usas dominio custom | Opcional |
| CookieYes + GTM consent | Pasos T21 abajo | Pendiente publish GTM |

**Informe completo:** [`docs/GSC_AUDIT_2026-06-27.md`](docs/GSC_AUDIT_2026-06-27.md)

---

## Pendiente — priorizado

| # | ID | Pri | Tarea | Resp | Archivo / acción |
|---|-----|-----|-------|------|------------------|
| 1 | **T23b** | Alta | Deploy sitemap T23 + reenviar en GSC | DBG | Push → GSC Sitemaps → `sitemap.xml` |
| 2 | **T23c** | Alta | ~~Eliminar sitemap legacy `/sitemap` en GSC~~ | DBG | ✅ Hecho vía API 27-jun |
| 3 | **T24** | Alta | Solicitar indexación URLs EN prioritarias | RED | GSC manual: `music-player-english`, `convertidor-english`, `automation-sending`, `intelligence` |
| 4 | **T24b** | Media | Internal linking EN → hub Intelligence | RED | Posts EN + `_data/intelligence_flagship.yml` |
| 5 | **T23d** | Media | Vigilar procesamiento sitemap (`isPending`) | DBG | 48–72 h post reenvío; ver informe GSC |
| 6 | **T23e** | Media | Revisar informe Páginas en GSC | DBG | Cobertura, duplicados, “rastreada no indexada” |
| 7 | **T23f** | Baja | Bing Webmaster Tools + mismo sitemap | RED | bing.com/webmasters |
| 8 | **T23g** | Baja | Asociar GSC con GA4 (`356406631`) | DBG | GSC → Asociaciones |
| 9 | **T6** | Media | Vision Lab → caso real | RED | `_data/vision_lab.yml` |
| 10 | **T3** | Media | Model performance explorer | DBG | **Deferred** |
| 11 | **T21** | Alta | CMP Consent Mode v2 (CookieYes) | UX | GTM consent publish (ver abajo) |

---

## T21 — CookieYes + Consent Mode v2 (acción manual)

Código en repo: `consent-defaults`, `cookie-consent`, `consent-gate.js`; AdSense/Clarity gated por categoría.

### Paso 1 — Cuenta CookieYes (gratis ≤25k pageviews/mes)

1. [cookieyes.com](https://www.cookieyes.com) → Sign up
2. **Add website** → `https://ccamilocristian.github.io`
3. **Banner customization** → idioma EN (+ ES opcional)
4. **Cookie policy** → generar → copiar URL → pegar en `_data/site_ops.yml` → `policy_url`

### Paso 2 — ID en el repo

En `_data/site_ops.yml`:

```yaml
cookie_consent:
  enabled: true
  provider: cookieyes
  cookieyes_id: "TU_ID_AQUI"   # Dashboard → Get Code → segmento del URL
  policy_url: "https://..."    # URL política generada por CookieYes
```

Commit + push → deploy.

### Paso 3 — CookieYes dashboard

1. **Integrations → Google Consent Mode v2** → Enable
2. Categorías: Analytics = GA4 + Clarity; Advertisement = AdSense + GTM ads
3. **Scan website** → clasificar scripts detectados

### Paso 4 — GTM (`GTM-K8J9KSB8`)

1. **Tags → Google Tag** → **Consent Settings** → *Require additional consent for tag to fire*
   - `analytics_storage` (Analytics)
2. Si añades tags de ads: también `ad_storage`, `ad_user_data`, `ad_personalization`
3. **Admin → Container Settings → Enable consent overview** (si no está)
4. Publish

### Paso 5 — QA producción

- Banner visible en primera visita (modo incógnito)
- Rechazar → no hits GA4 en Network; AdSense no carga
- Aceptar analytics → GA4 Realtime + Clarity OK
- Aceptar ads → `adsbygoogle.js` en Network
- DevTools: `gtag('consent','update',...)` tras clic en banner

**Alternativa:** `provider: cookiebot` + `cookiebot_id` (misma arquitectura).

---

## Stitch migration — cobertura

| Superficie | Export (`.stitch/`) | Jekyll | Notas |
|------------|---------------------|--------|-------|
| Command Center | `stitch-export.html` | ✅ | `_layouts/home.html` |
| Profile | `profile-export.html` | ✅ | `tabs/profile.md` |
| Intelligence | `intelligence-export.html` | ✅ | `tabs/intelligence.md` |
| Stack | `stack-export.html` | ✅ | `tabs/stack.md` |
| Economics Lens | `economics-lens-export.html` | ✅ | `tabs/economics-lens.md` |
| Vision Lab | `vision-lab-export.html` | ✅ | `tabs/vision-lab.md` |
| Post individual | `post-export.html` | ✅ | `_layouts/post.html` + `stitch-post.scss` |

---

## Completado

### SEO / Search Console

| ID | Tarea |
|----|-------|
| T23 | Sitemap: `sitemap_exclude` en `_config.yml`; filtro `page.redirect` en `sitemap.xml`; informe `docs/GSC_AUDIT_2026-06-27.md` |

### Stitch + shell

| ID | Tarea |
|----|-------|
| T11 | Intelligence → `stitch-intelligence.scss` + fix `type: archives` |
| T12 | Stack → `stitch-stack.scss` + fix `type: tags` |
| T13 | Economics Lens → `stitch-economics-lens.scss` |
| T14 | Vision Lab → `stitch-vision-lab.scss` |
| T15 | Post → `post-export.html` + `stitch-post.scss` |
| T16 | Legacy tabs → glass archives; `Hoja de vida` removed → redirect Profile |
| T18 | Post layout — columna, TOC, line-height, drop cap |
| T19 | Deprecar tags en UI — sin Topics; Stack → Intelligence; redirect `/tabs/tags/` |
| T20 | Orphan cleanup — about/categories/404/root redirects |

### Contenido + perfil

| ID | Tarea |
|----|-------|
| T1 | Foto real de perfil → `assets/img/profile/{avatar,portrait}.png` |
| T2 | Copy Profile vs LinkedIn — `_data/profile.yml` |
| T5 | 9 pares EN/ES — EN canónico; ES `published: false` + redirect 301 |
| T5b | 4 posts solo-ES traducidos a EN |
| T9 | SEO — `description:` pulidas en 14 posts (tono humano, ~120–140 chars) |
| T7 | AdSense + Clarity — loader diferido, anti-CLS, in-article slot, GA4 desde `_config.yml` |

### Docs + repo

| ID | Tarea |
|----|-------|
| T10 | `README_UX_EVOLUTION.md` sync |
| T17 | `docs/STITCH_MIGRATION_GAP.md` sync |
| — | **Repo cleanup** — `.gitignore`, `.cursor/rules/`, READMEs, `docs/README.md` (stubs `categories/` conservados — mismo patrón que `tags/`) |

---

## Changelog reciente

- **T23** — GSC audit (`docs/GSC_AUDIT_2026-06-27.md`); `sitemap_exclude` (assets, 404, 9 slugs ES legacy); skip redirect stubs en `sitemap.xml`
- **T7** — AdSense re-enabled (post footer, deferred loader, `.ad-slot` anti-CLS); Microsoft Clarity `xa15jprgqu`; GA4 ID from `_config.yml`; removed legacy ad network includes
- **T7b** — Monetización: slot in-article native `6874018777` (fluid), pre-related, loader solo en posts, unfilled collapse
- **Analytics** — GTM `GTM-K8J9KSB8` (head + noscript); direct GA4 off when GTM active (`skip_direct_ga4`)
- **T21 (código)** — Consent Mode v2 scaffold: CookieYes/Cookiebot hook, consent defaults, AdSense + Clarity gated; pending `cookieyes_id`
- **T7c** — Ad Fase 1–2: post footer `8047040393` + sidebar sticky `9362724975`
- **T7d** — Ad Fase 3–4: mid `6813985623`, home `5343588914`, in-feed `9226993605`
- **T22** — SEO/infra: URL sin trailing slash, redirect layout + GTM, portfolio EN links, search absolute_url; Propeller meta removed; hreflang EN; intelligence_flagship EN slugs; Disqus off (T8); ad pending UX (hide Sponsored until filled); portfolio imágenes locales; preconnect cleanup
- **T9** — 14 `description:` reescritas; meta duplicado eliminado en posts 2023
- **T5b** — `loan-simulator`, `minsalud-decrees`, `music-player`, `step-colombia-english`
- **T5** — 9 duplicados ES despublicados; redirect 301 a EN
- **T20** — páginas huérfanas, redirects raíz, 404 Stitch
- **T19** — footer Topics removido; tag archives con banner deprecación
- **T18** — post footer fuera de glass; fix conflicto Chirpy `footer {}`
