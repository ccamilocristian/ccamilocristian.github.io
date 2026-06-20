# Data Dashboard - V2 Typography Hierarchy Finalization

Task: Visual Design V2 (UX)

## Objective

Apply a consistent typography system:

- Monospace for data signals and metrics
- High-quality sans-serif for storytelling and explanatory content

## Token updates

Updated `assets/css/tokens/_type.scss`:

- Added `size-3xl`
- Added `line-relaxed`

## Global story typography

Updated `assets/css/_addon/main.scss`:

- `body` now uses `--ds-type-family-story` and tokenized relaxed line height
- `dashboard-module-title`, `subtitle`, and `content` now map to story typography tokens
- Strong text in module content uses semibold tokenized weight

## Home/dashboard typography mapping

Updated `assets/css/home.scss`:

- Hero title and lead mapped to story typography scale/weights
- KPI labels/values mapped to data typography
- Visualization controls/labels/values mapped to data typography
- Case card titles/body and links mapped to story typography
- Post preview titles and helper text aligned to tokenized hierarchy

## Outcome

- Typography now consistently communicates:
  - Narrative/story context (sans-serif)
  - Data/technical signals (monospace)
- Visual reading rhythm is more coherent across Hero, modules, insights, and chart controls.
