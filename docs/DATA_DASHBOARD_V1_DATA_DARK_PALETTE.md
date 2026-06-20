# Data Dashboard - V1 Data-Dark Palette Finalization

Task: Visual Design V1 (UX)

## Objective

Finalize a domain-aware Data-Dark palette where emphasis follows real expertise priority:

1. Data Analysis
2. Machine Learning
3. Business Intelligence
4. Economics
5. Vision Lab (lighter/emerging)

## Token updates applied

Updated `assets/css/tokens/_color.scss` with:

- Core interface support:
  - `border-soft`, `border-strong`
  - `glow-cyan`, `glow-blue`, `glow-violet`
- Domain accents:
  - `domain-analysis`
  - `domain-ml`
  - `domain-bi`
  - `domain-economics`
  - `domain-vision`
- Domain soft backgrounds:
  - `domain-analysis-soft`
  - `domain-ml-soft`
  - `domain-bi-soft`
  - `domain-economics-soft`
  - `domain-vision-soft`

## Module mapping

Updated `assets/css/_addon/main.scss` so dashboard modules consume domain tokens:

- `dashboard-module--hero` -> Analysis accent
- `dashboard-module--stack` -> ML accent
- `dashboard-module--intelligence` -> BI accent
- `dashboard-module--economics` -> Economics accent
- `dashboard-module--vision` -> Vision accent with lighter/emerging treatment

Each variant now uses token-based border + subtle gradient background.

## Home hero mapping

Updated `assets/css/home.scss`:

- `hero-pillar--primary` now uses analysis domain tokens.
- `hero-pillar--emerging` now uses vision domain tokens (lighter emphasis).

## Outcome

- Palette is now explicit, tokenized, and domain-aware.
- Visual emphasis aligns with strategic positioning (CV as emerging).
- Foundation is ready for V2 typography hierarchy pass.
