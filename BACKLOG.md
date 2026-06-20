# Backlog

_Last sync: 2026-06-20 (repo cleanup)_

## Estado rápido

| Área | Estado |
|------|--------|
| Stitch shell | **7/7** superficies migradas |
| Contenido | **14 posts** publicados (EN); **9 ES** despublicados + redirect 301 |
| SEO posts | **T9 hecho** — `description:` en 14 posts |
| Repo hygiene | **Cleanup hecho** — gitignore, agentes, READMEs, `docs/README.md` |
| Abierto | **T6** (Vision Lab), **T3/T4** (home opcional), **T8** (Disqus off) |

---

## Pendiente — priorizado

| # | ID | Pri | Tarea | Resp | Archivo / acción |
|---|-----|-----|-------|------|------------------|
| 1 | **T6** | Media | Vision Lab → caso real | RED | `_data/vision_lab.yml` cuando exista experimento documentado |
| 2 | **T4** | Media | Imágenes Selected Work locales | UX | `_data/portfolio_projects.yml` → `assets/img/cases/` |
| 3 | **T3** | Media | Model performance explorer | DBG | `_data/command_center.yml` → `mock_modules.model_explorer.enabled: true` — **Deferred** |
| 4 | **T8** | Baja | Re-enable Disqus en Stitch | DBG | `_data/site_ops.yml` — **Off** (T15 ya hecho) |

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
- **T9** — 14 `description:` reescritas; meta duplicado eliminado en posts 2023
- **T5b** — `loan-simulator`, `minsalud-decrees`, `music-player`, `step-colombia-english`
- **T5** — 9 duplicados ES despublicados; redirect 301 a EN
- **T20** — páginas huérfanas, redirects raíz, 404 Stitch
- **T19** — footer Topics removido; tag archives con banner deprecación
- **T18** — post footer fuera de glass; fix conflicto Chirpy `footer {}`
