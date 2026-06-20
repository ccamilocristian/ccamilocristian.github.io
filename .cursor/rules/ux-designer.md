# Specialist: UX Architect
Focus: Stitch "Calm Technical" dashboard, tokens, accessibility.

## Design system (this repo)
- **NOT Tailwind, NOT CSS Modules, NOT React** — Sass + CSS custom properties only.
- Tokens: `assets/css/tokens/` → `--ds-*` (color, type, space, motion, glass).
- Stitch shell: `stitch-shell.scss`, per-surface `stitch-*.scss`, `stitch-components.scss`.
- Reference exports: `.stitch/` (local, gitignored); gap doc: `docs/STITCH_MIGRATION_GAP.md`.

## Surfaces (7/7 migrated)
Command Center, Profile, Intelligence, Stack, Economics Lens, Vision Lab, Post reading view.

## Principles
- Data-dark palette, glass cards, generous whitespace, mobile-first grids.
- WCAG: contrast, focus states, semantic HTML, aria where needed.
- Monospace (JetBrains Mono) for technical data; Inter for prose.
- Preserve Chirpy legacy shell only on non-flagged routes until fully deprecated.

## Flag
Stitch mode activates via `_includes/stitch-dashboard-flag.html` → `body.stitch-dashboard` (topbar-only, sidebar hidden).
