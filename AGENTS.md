# AGENTS.md — repo map for AI agents

Read this first. It exists so an agent understands the project without exploring
from scratch (fewer tokens, fewer mistakes). Keep it short and current.

## What this is
Personal site of Cristian Camilo Moreno Narváez (CCMN): **profile + portfolio +
blog**. Static **Jekyll** site (Chirpy-derived) on **GitHub Pages** — no server,
no runtime, **zero LLM calls**. Visual identity: "Calm Technical" dark dashboard.

## Sources of truth (read before big changes)
- `README_UX_EVOLUTION.md` — design vision (Calm Technical, fonts, structure).
- `.cursorrules` — PM persona, workflow, and hard guardrails.
- `BACKLOG.md` — task queue + status.
- `docs/STITCH_MIGRATION_GAP.md` — Stitch migration status.
- `docs/SEO_ACTION_PLAN_2026-09.md` — current SEO plan.

## Layout of the code
- `_layouts/` — page templates (`home.html` = the Command Center/home).
- `_includes/` — partials (`topbar.html`, `favicons.html`, `post-*` intelligence helpers).
- `_data/` — content/config: `tabs.yml` (nav), `command_center.yml` (home),
  `post_pairs.yml` (EN↔ES bilingual pairs), `profile.yml`, `portfolio_projects.yml`.
- `_posts/` — articles. English is canonical; Spanish alternates are `lang: es`.
- `tabs/` — top-level pages (`profile.md`, `intelligence.md`, `stack.md`, `economics-lens.md`).
- `assets/css/` — Sass. Design tokens in `assets/css/tokens/_*.scss` (`--ds-*`);
  dashboard styles in `assets/css/_addon/*.scss`; home in `assets/css/home.scss`.
- `tools/` — helper scripts (SEO, presence, Stitch export). They read secrets from
  the environment or `~/…` paths — never from the repo.
- `sw.js` / `app.js` — service-worker **kill-switch** (see Guardrails).

## Build / serve / test
```bash
bundle exec jekyll build                 # production: prefix JEKYLL_ENV=production
bundle exec jekyll serve --host 0.0.0.0  # local preview on :4000
bash tools/verify-seo-security.sh        # regression guard (build + assert)
```
Run `tools/verify-seo-security.sh` before committing anything that touches
templates, the service worker, or `_data/post_pairs.yml`.

## Guardrails (do not break)
- **Static only.** No React/Next/Vue/Tailwind/SPA frameworks. No server runtime.
- **Styling = Sass**, via `--ds-*` tokens in `assets/css/tokens/`.
- **Bilingual SEO**: EN canonical + ES alternate, reciprocal `hreflang` +
  `x-default`, per-language `<html lang>`. Never rename an indexed slug without a
  redirect in `_data/post_pairs.yml`.
- **Service worker must stay a self-removing kill-switch**: no adware/push vendors,
  and it must never trigger a page reload. `app.js` only cleans up existing SW
  registrations; it registers nothing.
- Preserve `_data/*.yml` structures; reflow skin/metadata, not data shape.

## Token efficiency
Generated/binary paths are excluded from indexing via `.cursorindexingignore`
(`_site/`, caches, raster images, fonts, lockfiles). Prefer editing source over
reading `_site/`. Keep tasks scoped and reference files directly.
