# Data Dashboard - A6 Reusable Module Blueprint

Task: Architecture A6 (UX+DBG)

## Goal

Define and implement a reusable dashboard module system for:

- Hero / profile messaging
- Intelligence feed
- Skill cloud / stack
- Domain highlights (Economics, Vision)

## Reusable system implemented

### 1) Shared include

- Added `_includes/dashboard-module.html`
- Standardized structure:
  - eyebrow
  - title
  - subtitle
  - content block
- Variant classes:
  - `dashboard-module--hero`
  - `dashboard-module--intelligence`
  - `dashboard-module--stack`
  - `dashboard-module--economics`
  - `dashboard-module--vision`

### 2) Shared styling foundation

- Added dashboard module styles to `assets/css/_addon/main.scss`:
  - `.dashboard-grid`
  - `.dashboard-module`
  - eyebrow/title/subtitle/content conventions
  - responsive two-column behavior on larger screens

### 3) Applied across primary sections

- `tabs/profile.md`
- `tabs/intelligence.md`
- `tabs/stack.md`
- `tabs/economics-lens.md`
- `tabs/vision-lab.md`

## Impact

- Primary dashboard sections now share a consistent module architecture.
- Content and layout become easier to evolve without per-page custom structures.
- Future visual-design epic tasks can style one module system instead of many ad-hoc blocks.
