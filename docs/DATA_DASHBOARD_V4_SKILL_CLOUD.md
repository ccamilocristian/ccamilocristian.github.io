# Data Dashboard - V4 Weighted Skill Cloud

Task: Visual Design V4 (UX+DBG)

## Objective

Replace tag-like stack listing with a weighted skill cloud that reflects real expertise order:

1. Data Analysis
2. Machine Learning
3. Business Intelligence
4. Economics
5. Vision Lab (emerging)

## Implemented

### 1) Data model for weighted skills

Added `_data/skills_cloud.yml` with:

- `core_domains` (priority domains)
- `tools` (technical stack by depth)
- per-item fields:
  - `name`
  - `weight` (`core`, `strong`, `growth`, `emerging`)
  - `domain` (`analysis`, `ml`, `bi`, `economics`, `vision`)

### 2) Stack page visualization

Updated `tabs/stack.md`:

- Replaced plain tag loop with dashboard modules:
  - Weighted domain cloud
  - Weighted tools cloud
  - Legacy taxonomy bridge
- Keeps migration safety via link to legacy tags page.

### 3) Shared visual system styles

Updated `assets/css/_addon/main.scss`:

- Added reusable styles:
  - `.skill-cloud`
  - `.skill-pill`
  - `.skill-pill--core|strong|growth|emerging`
  - `.skill-pill--analysis|ml|bi|economics|vision`
  - `.skill-legend`

## Outcome

- Stack now communicates capability depth instead of flat taxonomy.
- Visual hierarchy matches strategic positioning (Vision clearly lighter/emerging).
- Structure is data-driven and easy to maintain.
