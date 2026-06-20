# Data Dashboard - V5 Latest Insights Card Redesign

Task: Visual Design V5 (UX+DBG)

## Objective

Transform Latest Insights cards from plain post previews into decision-oriented cards with scannable metadata.

## Implemented

### 1) Card metadata layer in home feed

Updated `_layouts/home.html`:

- Added computed metadata per post:
  - `reading_time` (estimated from content length)
  - `domain` (heuristic from tags/categories)
  - `technical_level` (heuristic from tags)
- Injected metadata row with chips:
  - Domain
  - Technical Level
  - Reading Time

### 2) Visual chip system

Updated `assets/css/home.scss`:

- Added:
  - `.insight-meta`
  - `.insight-chip`
  - `.insight-chip--domain`
  - `.insight-chip--level`
  - `.insight-chip--reading`
- Chips follow Data-Dark tokenized accents for quick scanning and hierarchy.

## Outcome

- Feed supports faster triage for readers:
  - what domain a post belongs to
  - expected depth
  - time cost to consume
- Latest Insights now behaves like a dashboard signal surface, not a generic blog list.
