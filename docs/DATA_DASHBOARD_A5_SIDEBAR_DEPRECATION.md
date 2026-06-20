# Data Dashboard - A5 Sidebar Deprecation Roadmap (Phase 1)

Task: Architecture A5 (DBG)

## Goal

Deprecate traditional sidebar dependencies for the dashboard experience and rely on dashboard-native modules.

## Phase 1 implemented

### 1) Home page no longer depends on left sidebar

- Hidden on homepage via `assets/css/home.scss` overrides:
  - `#sidebar { display: none }`
  - `#sidebar-trigger { display: none }`
  - `#topbar-wrapper` and `#main-wrapper` shifted to full-width dashboard mode

### 2) Right panel removed from home

- `_layouts/page.html` updated to skip `panel.html` when `page.layout == "home"` (or `page.hide_panel == true`)
- This avoids legacy “recent posts / trending tags” panel behavior on homepage

### 3) Dashboard-native surfaces now carry those signals

- Latest insights feed: handled inside home Bento module
- Skill/stack direction: routed through new `Stack` section architecture (A3), with visualization refinement in later tasks

## Impact

- Home now behaves as dashboard-first layout rather than legacy blog shell.
- Sidebar remains available for non-home pages to preserve compatibility while migration continues.

## Next (A6)

- Define and stabilize reusable dashboard module system to complete sidebar-era dependency removal across target sections.
