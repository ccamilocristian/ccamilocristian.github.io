# UX/UI Overhaul - Task 7/8

Portfolio story cards integrated using Problem-Process-Impact structure.

## Deliverables completed

- Standardized story-card content model (Problem, Process, Impact, Metric)
- Placement mapped to Bento dashboard via dedicated `Portfolio Story Cards` section
- Reusable content source added in data layer for maintainability

## Files updated

- `_data/portfolio_projects.yml`
  - Added 3 project entries with narrative and CTA links
- `_layouts/home.html`
  - Added `bento-card--cases` section
  - Renders project cards from data file (loop-based)
- `assets/css/home.scss`
  - Added `case-grid` and `case-card` styles
  - Desktop layout spans all 12 columns with 3-card grid

## Story card schema

- `title`
- `post_url`
- `problem`
- `process`
- `impact`
- `metric`

## Notes

- This implementation keeps cards data-driven to simplify edits and localization.
- Task 8 can now focus on QA/performance/accessibility polish and final consistency pass.
