# Data Dashboard - C4 Intelligence Section Framing

Task: Content Strategy C4 (RED)

## Objective

Reframe content from generic blog entries into decision-oriented intelligence artifacts.

## Implemented

### 1) Intelligence page reframed as artifact feed

Updated `tabs/intelligence.md`:

- Replaced archive-only list framing with an editorial intelligence frame:
  - Signal
  - Method
  - Decision relevance
- Converted feed rendering into artifact cards per post with:
  - artifact type label (heuristic by domain signals)
  - publication date
  - title
  - short excerpt
  - CTA: `Open intelligence artifact`

### 2) Homepage feed language alignment

Updated `_layouts/home.html`:

- Renamed section to `Latest Intelligence Artifacts`.
- Updated feed CTA to `View full intelligence feed` and linked to `/tabs/intelligence/`.

### 3) Readability and UI support styles

Updated `assets/css/_addon/main.scss` with dedicated classes:

- `.intelligence-frame`, `.intelligence-frame-lead`, `.intelligence-frame-points`
- `.intelligence-archives`
- `.intelligence-artifact` and child elements for type/title/excerpt/head row

## Outcome

- Posts are now presented as operational intelligence outputs rather than chronological blog notes.
- Users can quickly infer why a piece exists and what decision value it carries.
