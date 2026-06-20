# Stitch migration — gap analysis & status

**Reference:** Project `12642385017382224523` · Screen `Portfolio - Interactive Glass Refinement` (`4c4e07b072854526a105f88f373d1633`)

**Local exports:** `.stitch/` (via `bash tools/stitch-sync.sh` + `bash tools/stitch-export-tabs.sh`)

| Surface | Export file | Stitch screen ID | Jekyll status |
|---------|-------------|------------------|---------------|
| Command Center | `stitch-export.html` | `4c4e07b072854526a105f88f373d1633` | ✅ `_layouts/home.html` |
| Profile | `profile-export.html` | `db43e54604f64bf994be6e61c81313c0` | ✅ `tabs/profile.md` + `stitch-profile.scss` |
| Intelligence | `intelligence-export.html` | `c81bd61929f54df8ae60e50425b68d96` | ✅ `tabs/intelligence.md` + `stitch-intelligence.scss` |
| Stack | `stack-export.html` | `fe6b8231195e470b9b5ab820cea599c1` | ✅ `tabs/stack.md` + `stitch-stack.scss` |
| Economics Lens | `economics-lens-export.html` | `eed5bcc9f5a2476e816157f21b1d03ed` | ✅ `tabs/economics-lens.md` + `stitch-economics-lens.scss` |
| Vision Lab | `vision-lab-export.html` | `2fd9d452475b4e5e88d48d90bef6d74e` | ✅ `tabs/vision-lab.md` + `stitch-vision-lab.scss` |
| **Post (reading view)** | `post-export.html` | `9556cff1…` | ✅ `_layouts/post.html` + `stitch-post.scss` |

Manifest: `.stitch/exports-manifest.json` (sync via `tools/stitch-export-tabs.sh`)

_Last updated: 2026-06-20 (T17 sync)_

---

## Migration summary

**All seven Stitch surfaces are ported to Jekyll.** The site runs a dual shell:

| Mode | Trigger | Shell |
|------|---------|-------|
| **Stitch dashboard** | `body.stitch-dashboard` via `_includes/stitch-dashboard-flag.html` | Topbar-only, sidebar hidden, `stitch-shell.scss`, calm canvas, `stitch-footer.html` |
| **Legacy Chirpy** | Non-flagged routes | Sidebar, Chirpy footer, Bootstrap panel |

**Flag scope:** home, post, tag/category archives, primary tabs (`_data/tabs.yml`), and pages with `stitch_legacy: true`.

---

## Migrated in Jekyll

| Stitch element | Jekyll implementation |
|----------------|----------------------|
| Vertical home flow | `_layouts/home.html` — hero, pillars, narrative duo, selected work, notes |
| Glass cards + hover | `card-glass`, `card-glass--interactive`, `assets/js/stitch-glass.js` |
| Design tokens | `assets/css/tokens/` → `--ds-*` + `_legacy-alias.scss` |
| Typography | Inter + JetBrains Mono via `assets/css/_addon/fonts.scss` |
| Topbar (calm) | `_includes/topbar.html` + `stitch-shell.scss` |
| Stitch footer | `_includes/stitch-footer.html` on dashboard routes |
| Profile tab | `_data/profile.yml`, `tabs/profile.md`, `stitch-profile.scss` (PDF-enriched copy, real photo) |
| Intelligence tab | `_data/intelligence_page.yml`, domain filters, artifact cards |
| Stack tab | `_data/stack_page.yml`, proficiency matrix, `skills_cloud.yml` |
| Economics Lens | `_data/economics_lens_page.yml`, bento + filtered posts |
| Vision Lab | `_data/vision_lab.yml`, roadmap + experiments |
| Post reading view | Meta band, domain accent, TOC glass panel, article measure, share row |
| Post metadata chips | `_includes/stitch-post-meta-band.html`, `post-intelligence-metadata.html` |
| Tag UX deprecation | No Topics footer; `/tabs/tags/` → Intelligence; legacy banner on `/tags/*` |

### Post-reading polish (post-export follow-up)

| Fix | Detail |
|-----|--------|
| T18 — measure | Article column widened (`46rem` / flex with TOC); `line-height: 1.8` |
| T19 — tags | Public tag navigation removed; YAML tags kept for internal use |
| Footer bug | `<footer class="stitch-post-tail">` conflicted with Chirpy global `footer { position: absolute }` → use `<div>` |
| `#post-wrapper` min-height | Legacy Chirpy calc disabled on Stitch posts |

---

## Still open (not 1:1 Stitch or intentionally deferred)

| Area | Location | Status / next step |
|------|----------|-------------------|
| **Legacy tabs** | `tabs/archives.md` only | Archives glass (T16). about/categories/hoja-de-vida → redirects (T20) |
| **KPI Snapshot** | `home-legacy-modules` in `home.html` | No Stitch equivalent; keep, redesign, or remove — **T3** deferred |
| **Model Performance Explorer** | `home-legacy-modules` | Mock viz MVP; enable via `command_center.yml` or retire |
| **Bootstrap 4 + jQuery** | Global | Required for Chirpy compat; token-only components on Stitch routes |
| **Dual theme** | `theme_mode: dual` | Stitch screens dark-only; light mode bridge incomplete |
| **Mobile nav** | Topbar | Drawer/collapse works; not re-exported from Stitch |
| **AdSense / Disqus** | `_data/site_ops.yml` | Off on Stitch routes by design — **T7/T8** |
| **EN/ES post pairs** | `_data/post_pairs.yml` | ✅ 5 pares; EN canónico; ES unpublished + redirect |
| **SEO descriptions** | `_posts/*.md` | Auto-generated; fine-tune — **T9** |
| **Selected Work images** | `portfolio_projects.yml` | External URLs; optional local assets — **T4** |
| **Vision Lab case study** | `_data/vision_lab.yml` | Roadmap mock until real experiment — **T6** |

---

## Preserved (internal metadata — not promoted in UI)

| Module | Location | Reason |
|--------|----------|--------|
| `tags:` / `categories:` in post front matter | `_posts/` | Related posts, domain heuristics, Economics Lens filter |
| `/tags/:name/`, `/categories/:name/` | `jekyll-archives` | SEO/bookmarks with deprecation banner |
| Chirpy shell fallback | Non-`stitch_dashboard` pages | Search, legacy posts panel, categories tree |
| KPI + viz modules | Home legacy block | Prior dashboard spec until Stitch recommends replacement |

---

## Stitch prompt — remaining gaps only

Use when asking Stitch for **add-on** designs (not re-exporting migrated tabs):

```
Context: Static Jekyll site (GitHub Pages, Chirpy base). All primary tabs + post reading view are ported.
Calm Technical glass system: card-glass, --ds-* tokens, Inter + JetBrains Mono, max-width 1120px.

Already done — do NOT redesign
------------------------------
Home, Profile, Intelligence, Stack, Economics Lens, Vision Lab, single post reading view.
Topbar-only shell on dashboard routes; sidebar hidden via body.stitch-dashboard.

Still need guidance
-------------------
1. LEGACY TAB POLISH — archives list + CV redirect page: minimal glass list, no Chirpy cards.
2. HOME LEGACY MODULES — KPI Snapshot + Model Performance Explorer: (a) calm glass redesign, or (b) remove.
3. LIGHT MODE — dual theme exists; Stitch exports are dark-only. Provide light token overrides or confirm dark-only portfolio.
4. MOBILE NAV — drawer pattern audit vs Stitch intent (spacing, active state, search).
5. VISION LAB — one real experiment case study layout when content exists.

Constraints: static HTML/Liquid, vanilla JS, preserve URLs, English UI on dashboard surfaces.
```

---

## Next Jekyll steps (priority order)

| ID | Task | Owner |
|----|------|-------|
| **T16** | ~~Polish legacy tabs (archives, Hoja de vida)~~ | **Hecho** |
| **T5** | EN/ES pairs + 301 redirects | RED |
| **T6** | Vision Lab real experiment when documented | RED |
| **T9** | SEO `description:` fine-tune per post | RED |
| **T4** | Local images for Selected Work (optional) | UX |
| **T3** | Model explorer — enable or remove | DBG |
| **T7/T8** | AdSense / Disqus — re-enable only if desired | DBG |

Run `bash tools/stitch-sync.sh --summary` after any new Stitch export to reconcile token drift.
