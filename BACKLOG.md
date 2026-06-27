# Backlog

_Last sync: 2026-06-20 (repo cleanup)_

## Estado rápido

| Área | Estado |
|------|--------|
| Stitch shell | **7/7** superficies migradas |
| Contenido | **14 posts** publicados (EN); **9 ES** despublicados + redirect 301 |
| SEO posts | **T9 hecho** — `description:` en 14 posts |
| SEO infra | **T22 hecho** — URL canonical, redirects GTM, hreflang, flagship EN |
| Repo hygiene | **Cleanup hecho** — gitignore, agentes, READMEs, `docs/README.md` |
| Abierto | **T6** (Vision Lab contenido), **T3** (model explorer deferred) |

---

## Acciones manuales post-deploy (T22)

| Acción | Dónde |
|--------|-------|
| Reenviar sitemap | Search Console → Sitemaps → `https://ccamilocristian.github.io/sitemap.xml` |
| 301 legacy ES (opcional) | Cloudflare Rules si usas dominio custom |
| CookieYes + GTM consent | Pasos T21 abajo si aún no publicaste container |

---

## Pendiente — priorizado

| # | ID | Pri | Tarea | Resp | Archivo / acción |
|---|-----|-----|-------|------|------------------|
| 1 | **T6** | Media | Vision Lab → caso real | RED | `_data/vision_lab.yml` cuando exista experimento documentado |
| 2 | **T3** | Media | Model performance explorer | DBG | `_data/command_center.yml` → `mock_modules.model_explorer.enabled: true` — **Deferred** |
| 3 | **T21** | Alta | CMP Consent Mode v2 (CookieYes) | UX | Código listo — verificar GTM consent publish (ver abajo) |

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
