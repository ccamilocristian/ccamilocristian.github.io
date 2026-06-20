# Data Dashboard - UX Audit Home Semantic Hierarchy

Task: UX+DBG (Home semantic hierarchy and heading structure)

## Objective

Harden semantic structure in home so heading flow and landmark labeling are explicit for assistive technologies.

## Implemented

### 1) Hero landmark association

Updated `_layouts/home.html`:

- Added `aria-describedby="home-hero-lead"` to hero article.
- Added `id="home-hero-lead"` to hero lead paragraph.

This links page H1 context to its supporting description for screen-reader users.

### 2) Feed list semantics

Updated `_layouts/home.html`:

- Added an SR-only heading (`h3`) for the artifact list.
- Added `role="list"` + `aria-labelledby` to `#post-list`.
- Added `role="listitem"` to each `.post-preview` article in that list.

This makes list structure explicit while preserving visual design.

## Outcome

- Home now has clearer semantic relationships between heading, descriptive copy, and list landmarks.
- Structural accessibility is improved without changing visual hierarchy.
