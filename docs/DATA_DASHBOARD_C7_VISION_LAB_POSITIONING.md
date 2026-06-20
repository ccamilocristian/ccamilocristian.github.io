# Data Dashboard - C7 Vision Lab Positioning

Task: Content Strategy C7 (RED)

## Objective

Position Computer Vision explicitly as a growth track with transparent roadmap and selected experiments, avoiding over-claiming maturity.

## Implemented

### 1) Data-driven Vision Lab model

Added `_data/vision_lab.yml` with:

- positioning narrative and principles
- 3-phase roadmap (Foundations -> Model Comparison -> Intelligence Integration)
- selected experiment portfolio with status, objective, and impact hypothesis

### 2) Vision Lab page reframed

Updated `tabs/vision-lab.md`:

- Hero module now uses the shared Vision Lab positioning model.
- Roadmap module now renders milestone cards from data.
- Added third module: `Current Vision Experiment Portfolio` for explicit experiment inventory.

### 3) Homepage alignment

Updated `_layouts/home.html` Vision card copy:

- Clarifies Vision as a growth track with milestones and selected experiments.
- CTA updated to `See roadmap and experiments`.

### 4) Styling support

Updated `assets/css/_addon/main.scss`:

- Added dedicated styles for roadmap and experiment cards:
  - `.vision-roadmap-list`, `.vision-roadmap-item`
  - `.vision-experiment-list`, `.vision-experiment-item`
  - `.vision-experiment-head`, `.vision-experiment-status`

## Outcome

- Vision Lab is now clearly positioned as an intentional growth lane with governed progression.
- Visitors can distinguish current capability level, roadmap direction, and experiment scope in one pass.
