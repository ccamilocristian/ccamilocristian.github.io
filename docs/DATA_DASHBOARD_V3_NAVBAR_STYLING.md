# Data Dashboard - V3 Minimal Navbar Styling

Task: Visual Design V3 (UX+DBG)

## Objective

Implement a high-end, low-noise top navigation aligned to the new IA labels, with clear active state and responsive collapse behavior.

## Implemented

### 1) Topbar primary nav links

Updated `_includes/topbar.html`:

- Added dynamic nav built from `site.data.tabs`
- Active-state logic mirrors sidebar behavior:
  - URL match
  - `page.tab_active`
  - `item.home` for home layout
- Kept breadcrumb and existing search controls for continuity

### 2) Mobile collapse behavior

Updated `_includes/topbar.html`:

- Added `#topbar-nav-trigger` with accessible attributes:
  - `aria-expanded`
  - `aria-controls`
- Added lightweight JS toggle to switch `#topbar-wrapper.nav-open`

### 3) Premium visual style and states

Updated `assets/css/_addon/main.scss`:

- Styled `#topbar-nav` as horizontal chip-style nav
- Styled `.topbar-nav-link` with:
  - subtle hover
  - high-contrast active state
  - domain-aware accent use
- Added mobile dropdown panel style under `nav-open`

## UX outcomes

- Navigation now looks dashboard-native, not blog-default.
- Active section is easier to identify.
- Mobile users can access top-level sections via explicit collapse trigger.
- Design remains compatible with current search and legacy sidebar behavior.
