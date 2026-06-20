# Data Dashboard - UX Audit Shell Accessibility Controls

Task: UX+DBG+RED (topbar/search/back-to-top controls)

## Objective

Fix control accessibility gaps in shell elements: topbar triggers, search labeling, cancel microcopy, and back-to-top naming.

## Implemented

### 1) Topbar control labeling

Updated `_includes/topbar.html`:

- Added explicit labels to interactive controls:
  - navigation trigger
  - sidebar trigger
  - search trigger
  - search cleaner
- Converted sidebar/search triggers and cleaner into semantic `<button>` elements while preserving existing IDs for JS behavior.

### 2) Search field semantics and microcopy

Updated `_includes/topbar.html`:

- Added SR-only `<label>` linked to `#search-input`.
- Added `role="search"` + `aria-label` to search wrapper.
- Added `aria-controls="search-results"` in search input.
- Replaced hardcoded `Cancel` with localized label value (`Cancelar`).

Updated `_data/label.yml`:

- Added label keys:
  - `search_cancel`
  - `search_open`
  - `search_clear`
  - `sidebar_open`
  - `back_to_top`
  - `navigate`

### 3) Back-to-top accessible name

Updated `_layouts/default.html`:

- Added `aria-label` and `title` to `#back-to-top`.

### 4) Cleaner button behavior styling

Updated `assets/css/_addon/main.scss`:

- Added style support for `#search-cleaner` button.
- Added visible/focus styles compatible with existing JS class toggle (`visable`).

## Outcome

- Shell controls now expose accessible names and proper form semantics.
- Search interactions retain existing behavior while improving keyboard and screen-reader clarity.
- Microcopy is now consistently localized in Spanish.
