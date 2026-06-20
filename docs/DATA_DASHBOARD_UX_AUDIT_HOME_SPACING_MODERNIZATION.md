# Data Dashboard - UX Audit Home Spacing Modernization

Task: UX+DBG+RED (home feed spacing and explicit CTA)

## Objective

Reduce visual density in home post previews and add an explicit action CTA per card.

## Implemented

### 1) Explicit CTA in each post preview

Updated `_layouts/home.html`:

- Added explicit preview CTA under excerpt:
  - `Leer más` (from `site.data.label.post.button.read_more`)
- Keeps title link while adding a clearer click target for scanning users.

### 2) Label-driven microcopy

Updated `_data/label.yml`:

- Added:
  - `post.button.read_more: "Leer más"`

### 3) Spacing and rhythm refinement

Updated `assets/css/home.scss`:

- Increased list separation and internal breathing space:
  - `#post-list` top margin increased
  - `.post-preview` padding increased
  - `.post-preview` bottom gap increased
  - `.post-content` vertical margins adjusted
- Added `.post-read-more--preview` spacing rule.

## Outcome

- Home feed feels less dense and more modern.
- Each preview now has an explicit action CTA consistent with Spanish microcopy.
