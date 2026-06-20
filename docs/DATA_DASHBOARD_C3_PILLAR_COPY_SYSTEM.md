# Data Dashboard - C3 Pillar Card Copy System

Task: Content Strategy C3 (RED+UX)

## Objective

Create a reusable copy system for the five expertise lanes:

- Data Analysis
- Machine Learning
- Business Intelligence
- Economics
- Vision Lab (emerging)

## Implemented

### 1) Centralized pillar copy model

Added `_data/pillar_copy.yml` with one structured record per pillar:

- `label`
- `lane` (`primary` or `emerging`)
- `badge` (priority marker)
- `summary` (one-line value proposition)

### 2) Home hero cards now data-driven

Updated `_layouts/home.html`:

- Replaced hardcoded pillar blocks with a loop over `site.data.pillar_copy`.
- Added semantic card structure:
  - heading row (`label` + `badge`)
  - supporting line (`summary`)

### 3) Profile page now reuses same copy

Updated `tabs/profile.md`:

- Replaced handcrafted bullets with looped list from `site.data.pillar_copy`.
- Ensures wording consistency between hero and profile sections.

### 4) UX styling for copy-rich pillar cards

Updated `assets/css/home.scss`:

- Added styles for:
  - `.hero-pillar-head`
  - `.hero-pillar-copy`
- Added domain-specific visual variants:
  - `.hero-pillar--analysis`
  - `.hero-pillar--ml`
  - `.hero-pillar--bi`
  - `.hero-pillar--economics`
  - `.hero-pillar--vision`

## Outcome

- Pillar messaging is now consistent, maintainable, and reusable.
- The same narrative copy drives both homepage credibility and profile detail surfaces.
- Future copy tuning for any pillar now requires editing one data file only.
