# Evolution Plan: UX/UI & Content Redesign

> **Stitch status (2026-06-20):** All 7 primary surfaces migrated (Home → Post). Orphan routes cleaned (T20). EN/ES consolidated (T5/T5b). SEO descriptions done (T9). See `docs/STITCH_MIGRATION_GAP.md` and `BACKLOG.md`. Next: **T6** Vision Lab real case.

## 1. Contexto Actual (Mapeado Automático)

### Stack tecnológico exacto

| Capa | Tecnología |
|------|------------|
| **Generador** | [Jekyll](https://jekyllrb.com/) ≥ 3.8.6 (sitio estático) |
| **Tema base** | [Chirpy v2.x](https://github.com/cotes2020/jekyll-theme-chirpy) |
| **Plantillas** | Liquid (`_layouts/`, `_includes/`, `_posts/`, `tabs/`) |
| **Estilos** | Sass con módulos modernos (`@use`, `@forward`), compilado por Jekyll |
| **Design tokens** | `assets/css/tokens/` → variables CSS `--ds-*` (color, tipografía, espacio, motion) |
| **UI legacy** | Bootstrap 4.0 (CDN), Font Awesome 5.11, jQuery 3.4.1 |
| **Fuentes cargadas** | Inter + JetBrains Mono + Material Symbols (`fonts.scss`); Lato/Roboto legacy en rutas Chirpy |
| **Hosting** | GitHub Pages (`ccamilocristian.github.io`) |
| **Plugins Jekyll** | `jekyll-paginate`, `jekyll-redirect-from`, `jekyll-seo-tag`, `jekyll-archives` |
| **Comentarios / ads** | Disqus + AdSense **off** on Stitch routes (`_data/site_ops.yml`); legacy fallback on non-dashboard pages |

**No usa:** React, Next.js, Vue, Tailwind ni ningún framework SPA. Es HTML estático generado en build time.

### Arquitectura de la página hoy

El sitio está en **transición avanzada** de blog Chirpy clásico hacia un **Stitch "Calm Technical" dashboard**. Las siete superficies principales usan `body.stitch-dashboard` (topbar-only, sidebar oculta, glass tokens). Chirpy legacy persiste como fallback en rutas no flaggeadas.

**Cadena de layouts principal:**

```
index.html → home → page → default → compress
tabs/*.md  → page → default     (Stitch SCSS per tab)
_posts/*   → post  → default     (Stitch reading view when stitch_dashboard)
/tags/*    → tag   → page        (legacy archive + deprecation banner)
```

| Layout | Rol |
|--------|-----|
| `default.html` | Shell global; `stitch-dashboard-flag` → sidebar hidden + Stitch footer |
| `page.html` | Página genérica; panel lateral solo en rutas legacy |
| `home.html` | **Command Center** — Stitch home flow + legacy modules (KPI, viz MVP) |
| `post.html` | **Stitch reading view**: meta band, TOC glass, article card, back to Intelligence |
| `tag.html` / `category.html` | Archivos con banner → Intelligence; listas conservadas por SEO |

**Componentes reutilizables clave:**

- `_includes/stitch-dashboard-flag.html` — activa shell Stitch por layout/tab
- `_includes/stitch-post-meta-band.html` — fecha, dominio, nivel, read time, impact en posts
- `_includes/post-intelligence-metadata.html` — chips de dominio para cards y feed
- `_includes/topbar.html` — navegación primaria + búsqueda + breadcrumb
- `_includes/sidebar.html` — legacy; oculta en rutas `stitch-dashboard`

**Estilos Stitch por superficie:** `stitch-shell.scss`, `stitch-profile.scss`, `stitch-intelligence.scss`, `stitch-stack.scss`, `stitch-economics-lens.scss`, `stitch-vision-lab.scss`, `stitch-post.scss`

**Home (`_layouts/home.html`) — estructura Bento actual:**

1. **Hero Command Card** — headline senior, lead, grid de 5 pilares (`pillar_copy.yml`), CTAs
2. **KPI Snapshot** — contadores de posts, tags, categorías
3. **Narrative Spine** — texto del flujo Analysis → ML → BI → Economics → impacto
4. **Vision Lab teaser** — enlace al carril emergente
5. **Model Performance Explorer** — visualización interactiva MVP (Accuracy / Recall / F1)
6. **Portfolio Story Cards** — casos Problem → Process → Impact (`portfolio_projects.yml`)
7. **Latest Intelligence Artifacts** — feed paginado de posts con metadata enriquecida

**Sistema de diseño:**

- Paleta **data-dark** en tokens (`#070B14` canvas, acentos cyan/blue/violet/green/amber)
- 5 dominios semánticos con color propio: Analysis, ML, BI, Economics, Vision Lab
- Modo claro/oscuro **dual** (`theme_mode: dual`): variables Chirpy legacy + bridge `--ds-*` vía `_legacy-alias.scss`
- Grid responsive mobile-first: 1 col → 2 col → 12 col (≥1200px)

### Rutas y secciones principales

**Navegación primaria** (`_data/tabs.yml` → topbar + sidebar):

| Ruta | Label | Propósito |
|------|-------|-----------|
| `/` | Command Center | Dashboard home (Bento) |
| `/tabs/profile/` | Profile | Perfil ejecutivo + pilares de expertise |
| `/tabs/intelligence/` | Intelligence | Feed de "artefactos de decisión" (posts reframed) |
| `/tabs/stack/` | Stack | Skill cloud ponderado (`skills_cloud.yml`) |
| `/tabs/economics-lens/` | Economics Lens | Posts filtrados por economía |
| `/tabs/vision-lab/` | Vision Lab | Carril emergente CV: roadmap + experimentos |

**Rutas legacy preservadas** (fuera del nav principal):

| Ruta | Estado |
|------|--------|
| `/tabs/archives/` | Legacy list → banner apunta a Intelligence |
| `/tabs/tags/` | **301 redirect** → `/tabs/intelligence/` (tab eliminado, T19) |
| `/tabs/about/` | **301 redirect** → `/tabs/profile/` |
| `/tabs/categories/` | **301 redirect** → `/tabs/intelligence/` |
| `/tabs/hoja-de-vida/` | **301 redirect** → `/tabs/profile/` |
| `/tags/`, `/categories/`, `/posts/` (índice raíz) | **301 redirect** → Intelligence |
| `/tabs/` (índice) | **301 redirect** → Command Center |
| `/404.html` | Stitch shell + recovery links |
| `/posts/:title/` | 14 entradas publicadas (EN); 9 ES despublicados con redirect 301 |
| `/tags/:name/`, `/categories/:name/` | Archivos jekyll-archives + banner deprecación |

### Enfoque de contenido detectado hoy

**Identidad declarada en superficies nuevas (inglés):**
> Senior AI Data Engineer | BI | Economist — convierte señales de datos en sistemas de decisión.

**Identidad en `_config.yml` (inglés, alineada con dashboard):**
> Senior AI Data Engineer · BI · Economist — clear systems from complex data.

**Narrativa operativa unificada (docs C1–C7, implementada en código):**

```
Data Analysis → Machine Learning → Business Intelligence → Economics → impacto medible
```

Vision Lab se posiciona explícitamente como carril **emerging**, no como claim de producción.

**Contenido duro existente (conservar):**

- **14 posts publicados (EN)** con metadata C5 (`domain`, `technical_level`, `reading_time`, `business_impact`); **9 alternates ES** `published: false` + redirect — ver `_data/post_pairs.yml`
- **Profile** enriquecido desde `Profile.pdf` (pilares, carrera, publicación MPRA, foto real)
- **3 case studies** estructurados: pipeline ICFES + BigQuery, scraping plebiscito Colombia, regresión mercado laboral STEP
- **Career history** integrada en `_data/profile.yml` (Profile tab)
- **Skill cloud**: 5 dominios core + ~15 herramientas con pesos (core / strong / growth / emerging)
- **Vision Lab roadmap**: 3 fases + 3 experimentos seleccionados (Planned / In design / Backlog)

**Modelo de datos YAML → UI:**

| Archivo | Consumido por |
|---------|---------------|
| `_data/profile.yml` | Profile tab (hero, pillars, career, publication) |
| `_data/intelligence_page.yml` | Intelligence tab copy + filters |
| `_data/stack_page.yml` | Stack tab copy + explore CTA → Intelligence |
| `_data/economics_lens_page.yml` | Economics Lens tab |
| `_data/pillar_copy.yml` | Home hero, Profile |
| `_data/portfolio_projects.yml` | Home story cards |
| `_data/skills_cloud.yml` | Stack tab |
| `_data/vision_lab.yml` | Vision Lab tab, teaser home |
| `_data/post_pairs.yml` | 9 pares EN/ES — EN canónico, ES despublicado + redirect |
| `_data/site_ops.yml` | AdSense/Disqus toggles |
| `_data/tabs.yml` | Topbar, sidebar |
| `_data/label.yml` | Microcopy UI legacy en español (Chirpy panel) |

**Política de idioma (2026-06):** UI y posts publicados en **inglés**. Contenido ES legacy despublicado (redirect a EN). `label.yml` conserva microcopy Chirpy en español en panel legacy.

**Tensiones restantes (gap vs. visión calm):**

- Tono **tutorial** en posts históricos vs. framing **artefactos de decisión** en Intelligence (reencuadre editorial opcional)
- Home legacy modules (KPI + viz MVP) fuera del diseño Stitch
- Bootstrap 4 + variables Chirpy coexisten con tokens `--ds-*` en rutas legacy
- Light mode dual theme sin variantes Stitch completas
- `categories/` + `tags/` stubs Chirpy (no `jekyll-archives` en Gemfile) — candidatos a migrar en futuro

**Epics completados** (referencia en `docs/` + `BACKLOG.md`):

- UX/UI Overhaul Tasks 1–8: wireframe Bento, tokens, viz MVP, story cards, QA/a11y
- Data Dashboard A1–A6: IA domain-first, hero command card, sidebar deprecation fase 1
- Visual V1–V6: paleta, tipografía, navbar, skill cloud, insights cards, motion
- Content C1–C7: narrative spine, hero messaging, pillar copy, intelligence framing, metadata model
- **Stitch migration T11–T20:** tabs + post + tag deprecation + orphan cleanup + repo cleanup
- **Content T5/T5b/T9:** EN canonical, ES redirect, SEO descriptions

---

## 2. Visión de Evolución y 'Vibe'

La web debe evolucionar hacia la presentación de un perfil maduro y senior. Buscamos equilibrar una alta complejidad técnica (Ingeniería de Datos, analítica avanzada, economía y modelos de IA) con una filosofía de vida enfocada en la tranquilidad, el balance personal, el orden y el crecimiento orgánico. Queremos alejarnos de narrativas puramente transaccionales o hiper-financieras para enfocarnos en la maestría técnica, la resolución de problemas con propósito y la calidad de vida.

---

## 3. Pilares de UX/UI Deseados

* **Estética Minimalista y Técnica:** Interfaces limpias, precisas y profesionales que transmitan calma pero denoten alta capacidad de ingeniería.
* **Espaciado y Aire:** Uso generoso del espacio en blanco para evitar la saturación visual y permitir que el contenido respire.
* **Legibilidad:** Componentes altamente scannables y una paleta de colores cohesiva sin ruido visual.

---

## 4. Estrategia de Conservación (Lo que se QUEDA)

* La arquitectura técnica base y la lógica modular del proyecto que acabas de escanear en el punto 1.
* Todo el portafolio de proyectos reales, trayectoria y datos duros actuales. No eliminamos información, la transformamos visualmente.

**Detalle mapeado desde el código — conservar explícitamente:**

| Activo | Ubicación | Motivo |
|--------|-----------|--------|
| Generador Jekyll + Chirpy | `_config.yml`, `Gemfile`, layouts | Base probada, GitHub Pages nativo, sin migración de stack |
| Sistema de tokens Sass | `assets/css/tokens/` | Infraestructura de diseño ya modular; evolucionar valores, no reescribir arquitectura |
| Stitch shell + tab/post SCSS | `stitch-*.scss`, `stitch-dashboard-flag.html` | Superficie visual principal ya migrada |
| Include `post-intelligence-metadata.html` | `_includes/` | Modelo de enriquecimiento de posts |
| Datos YAML de pilares, portfolio, skills, vision, profile | `_data/*.yml` | Single source of truth del contenido estratégico |
| IA domain-first (6 rutas primarias) | `_data/tabs.yml` | Navegación alineada con expertise real |
| Home Bento shell | `_layouts/home.html`, `home.scss` | Stitch flow + legacy modules pendientes de decisión |
| 14 posts (EN publicados) | `_posts/` | Evidencia técnica; metadata C5 + SEO descriptions (T9) |
| Career data | `_data/profile.yml` | Trayectoria en Profile; CV tab legacy eliminado |
| Tags en front matter (no UI) | `_posts/` | Metadata interna: related posts, heurísticas, Economics Lens |
| Modo claro/oscuro dual | `theme_mode: dual` | Accesibilidad; light Stitch TBD |
| Specs + Stitch gap doc | `docs/` | Decisiones de diseño; `STITCH_MIGRATION_GAP.md` |
| Redirects legacy | `redirect_from` en Intelligence, Profile | SEO y bookmarks (`/tabs/tags/` → Intelligence) |

---

## 5. Estrategia de Cambio (Lo que se TRANSFORMA)

* **El Tono:** Pasa de un formato de currículum rígido a una narrativa de filosofía de trabajo y estilo de vida balanceado.
* **Layouts:** Desacoplar el contenido actual de los estilos antiguos para llevarlos hacia los nuevos componentes limpios y espaciosos.

**Detalle mapeado desde el código — transformar explícitamente:**

| Área | Estado actual | Dirección de cambio |
|------|---------------|---------------------|
| **Copy del hero** | Calm technical EN en home/Profile | Refinar tono balance propósito/vida (sección 2) |
| **Posts (14 EN)** | Stitch reading view + metadata C5 | Reencuadre editorial opcional en Intelligence — **T5/T5b/T9 hecho** |
| **Legacy tabs** | archives glass; about/categories/hoja-de-vida removed | — |
| **Home legacy modules** | KPI Snapshot + Model Performance Explorer | Rediseño Stitch o retirada — **T3** |
| **Sidebar Chirpy** | Oculta en `stitch-dashboard`; visible en legacy | Deprecación total cuando legacy tabs migrados |
| **Bootstrap 4 + Chirpy CSS** | Coexistencia en rutas legacy | Migración progresiva a token-only |
| **Microcopy UI** | `_data/label.yml` español en panel Chirpy | EN en superficies Stitch; legacy panel baja prioridad |
| **AdSense / Disqus** | Off en Stitch (`site_ops.yml`) | Re-enable solo si se desea — **T7/T8** |
| **Vision Lab** | Roadmap + experimentos mock | Caso real documentado — **T6** |
| **Light mode** | Dual theme sin tokens Stitch light | Confirmar dark-only o exportar variantes |

**Principio rector del cambio:** el contenido duro (YAML, posts, CV, case studies) permanece; cambian el **marco narrativo**, la **densidad visual** y el **tono emocional** de la presentación.

---

*Nota para la IA: Lee siempre este archivo antes de sugerir o escribir cualquier cambio de código, diseño o contenido en este repositorio.*
