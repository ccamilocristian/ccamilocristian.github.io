# UX/UI Overhaul - Task 6/8

Data visualization integration plan + first interactive MVP for homepage.

## Implemented placement

- Location: Bento grid on home dashboard (`_layouts/home.html`)
- New module: `Model Performance Explorer`
- Purpose: demonstrate model tradeoff storytelling in context (Accuracy / Recall / F1)

## MVP behavior

- Three metric controls:
  - `Accuracy`
  - `Recall`
  - `F1`
- Three model bars:
  - `Vision-A`
  - `Vision-B`
  - `Vision-C`
- On control click:
  - active control state updates
  - bar heights and values update
  - `aria-live` text announces active metric

## Files updated

- `_layouts/home.html`
  - Added visualization Bento card
  - Added lightweight inline JS controller (no external dependency)
- `assets/css/home.scss`
  - Added styles for controls, chart bars, motion, focus states
  - Added responsive behavior for mobile chart stacking
  - Updated desktop card span rules to include visualization card

## Accessibility baseline

- Keyboard-focus styling on controls
- `role="tablist"` and `aria-selected` handling for metric controls
- `aria-live` announcer for metric changes
- High-contrast active state for selected metric

## Notes

- This MVP uses static demo values to validate interaction and visual language.
- Task 7 can attach real project data and Problem-Process-Impact storytelling per card.
