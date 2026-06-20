# Data Dashboard - A1 IA and Navigation Spec

Task: Architecture A1 (UX+DBG)  
Objective: Reorder IA and primary navigation around real expertise priorities.

## Priority Model (domain-first)

1. Data Analysis
2. Machine Learning
3. Business Intelligence
4. Economics
5. Vision Lab (emerging)

## IA Map (Homepage-first dashboard)

- Command Center (home dashboard)
  - Hero Profile Card (Senior AI Data Engineer + BI + Economist)
  - KPI Snapshot
  - Domain Highlights
  - Latest Insights
  - Skill Cloud / Tech Stack
- Profile (CV and capabilities)
  - Executive summary
  - Experience and projects
  - Tooling and stack
- Intelligence (all technical and analytical posts)
  - Filters by domain and level
  - Reading-time and impact metadata
- Stack (skills and technologies)
  - Weighted cloud by expertise
  - Tool categories
- Economics Lens
  - Economics-focused analyses and decision framing
- Vision Lab (emerging)
  - Experimental CV projects
  - Roadmap and progress

## Navigation Spec (action-oriented labels)

Primary navbar labels:

- Command Center
- Profile
- Intelligence
- Stack
- Economics Lens
- Vision Lab

Secondary behavior:

- Keep search as utility control in topbar
- Preserve language consistency (English-first labels for dashboard brand)
- Highlight active section with high-contrast but minimal style

## Route Mapping Draft

Proposed route targets:

- `/` -> Command Center
- `/tabs/profile/` -> Profile
- `/tabs/intelligence/` -> Intelligence
- `/tabs/stack/` -> Stack
- `/tabs/economics-lens/` -> Economics Lens
- `/tabs/vision-lab/` -> Vision Lab

Implementation notes for Jekyll:

- Create tab pages under `tabs/` matching route slugs.
- Update `_data/tabs.yml` to point menu entries to those slugs.
- Keep legacy archives/tags reachable via internal links to avoid hard break.
- Add redirects from legacy paths where needed (e.g. archives -> intelligence).

## UX Priorities for Next Task (A2)

- Ensure menu labels communicate outcomes, not content buckets.
- Keep cognitive load low: max 6 top-level items.
- Position Vision Lab as growth track without overstating expertise.
- Align home card order with domain priority model above.

## Acceptance Criteria for A1

- Domain priority clearly defined and approved.
- IA map and route draft documented.
- Navigation labels proposed with action-oriented language.
- Ready to implement in `_data/tabs.yml` and `tabs/` pages in A2/A3.
