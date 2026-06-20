# Data Dashboard - C6 Historical Content Rebalance

Task: Content Strategy C6 (RED+UX)

## Objective

Surface existing economics and data science posts as flagship credibility assets, instead of leaving them buried in chronology.

## Implemented

### 1) Curated flagship module in Intelligence

Updated `tabs/intelligence.md`:

- Added curated slug buckets for two credibility lanes:
  - economics flagship set
  - data science flagship set
- Implemented `Historical Credibility Assets` module above the main intelligence feed.
- Each lane now renders up to 4 selected historical posts with date context.

### 2) UX support styles

Updated `assets/css/_addon/main.scss`:

- Added reusable layout and card styles for flagship surfaces:
  - `.flagship-grid`
  - `.flagship-block`
  - `.flagship-intro`
  - `.flagship-item`
- Responsive behavior included (2-column layout from desktop breakpoint).

## Outcome

- Legacy high-value content (economics + data science) is now explicitly promoted as credibility evidence.
- New visitors can assess depth faster without scanning full chronological archives.
