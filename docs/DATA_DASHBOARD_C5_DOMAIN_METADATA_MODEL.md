# Data Dashboard - C5 Domain Metadata Model

Task: Content Strategy C5 (RED+DBG)

## Objective

Define and implement a per-post metadata strategy with four fields:

- `domain`
- `technical_level`
- `reading_time`
- `business_impact`

## Metadata contract

Posts can now include this optional front matter:

```yaml
domain: "Business Intelligence"
technical_level: "Advanced"
reading_time: 7
business_impact: "Improves weekly KPI review quality for executive planning."
```

If any field is missing, the system applies deterministic fallbacks based on tags/categories and content length.

## Implemented

### 1) Shared metadata include

Added `_includes/post-intelligence-metadata.html`:

- Computes metadata from front matter first.
- Applies fallback heuristics when fields are absent.
- Emits:
  - domain chip
  - technical level chip
  - reading time chip
  - optional business impact line (`show_impact=true`)

### 2) Home feed integration

Updated `_layouts/home.html`:

- Replaced local metadata logic with shared include for consistency.
- Fixed excerpt rendering to use `post.content` explicitly.

### 3) Intelligence feed integration

Updated `tabs/intelligence.md`:

- Uses shared metadata include for each artifact.
- Displays business impact line for decision framing.
- Uses resolved domain for artifact type labeling.
- Fixed excerpt rendering to use `post.content` explicitly.

### 4) Styling support

Updated `assets/css/_addon/main.scss`:

- Added shared styles for:
  - `.insight-meta`
  - `.insight-chip` (+ domain variants)
  - `.insight-impact`

## Outcome

- Metadata is now standardized, reusable, and progressively adoptable.
- Existing posts work without manual migration due to fallback logic.
- New posts can override defaults with explicit domain/level/time/impact signals.
