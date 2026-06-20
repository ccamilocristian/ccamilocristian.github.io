# UX/UI Overhaul - Task 3/8

Visual system specification for a dark, cyber-data Bento experience.

## Scope

- Owner: UX Architect
- Inputs: Task 1 wireframe + Task 2 narrative blueprint
- Output: token system + component hierarchy + accessibility targets
- Constraint: implementation must map to modern Dart Sass modules (`@use`/`@forward`)

## Design Principles

1. **Data-Centric Minimalism**: prioritize signal over decoration.
2. **Dashboard Clarity**: every card has one primary purpose and one clear CTA.
3. **Dark-First**: default UI optimized for dark surfaces with controlled glow accents.
4. **Readable Story Layer**: sans-serif for narrative, monospace for metrics/technical values.
5. **Motion with Restraint**: subtle transitions; no animation that harms readability.

## Token Architecture (proposed namespaces)

- `color.*`
- `typography.*`
- `space.*`
- `radius.*`
- `shadow.*`
- `border.*`
- `motion.*`
- `focus.*`
- `grid.*`
- `z.*`

## Color Tokens

## Base Surfaces

- `color.bg.canvas: #070B14`
- `color.bg.elev1: #0B1020`
- `color.bg.elev2: #10172A`
- `color.bg.card: #121A31`
- `color.bg.glass: rgba(18, 26, 49, 0.72)`
- `color.bg.overlay: rgba(4, 8, 16, 0.68)`

## Text

- `color.text.primary: #E6ECFF`
- `color.text.secondary: #B8C4E6`
- `color.text.tertiary: #8A97B8`
- `color.text.inverse: #070B14`

## Data Accent Palette

- `color.accent.cyan: #3CF2FF`
- `color.accent.blue: #4F7DFF`
- `color.accent.violet: #9A6BFF`
- `color.accent.green: #38D39F`
- `color.accent.amber: #F7B955`

## Semantic States

- `color.state.info: #4F7DFF`
- `color.state.success: #38D39F`
- `color.state.warning: #F7B955`
- `color.state.error: #FF6B8B`

## Lines and Dividers

- `color.border.soft: rgba(170, 188, 240, 0.16)`
- `color.border.strong: rgba(170, 188, 240, 0.28)`
- `color.grid.line: rgba(79, 125, 255, 0.12)`

## Glow Tokens

- `color.glow.cyan: rgba(60, 242, 255, 0.38)`
- `color.glow.violet: rgba(154, 107, 255, 0.34)`
- `color.glow.blue: rgba(79, 125, 255, 0.30)`

## Typography Tokens

## Font Families

- `typography.family.story: "Inter", "Source Sans Pro", system-ui, sans-serif`
- `typography.family.data: "JetBrains Mono", "Fira Code", "Roboto Mono", monospace`

## Type Scale

- `typography.size.xs: 0.75rem` (12)
- `typography.size.sm: 0.875rem` (14)
- `typography.size.md: 1rem` (16)
- `typography.size.lg: 1.125rem` (18)
- `typography.size.xl: 1.5rem` (24)
- `typography.size.2xl: 2rem` (32)
- `typography.size.3xl: 2.5rem` (40)

## Weights

- `typography.weight.regular: 400`
- `typography.weight.medium: 500`
- `typography.weight.semibold: 600`
- `typography.weight.bold: 700`

## Line Height

- `typography.line.tight: 1.15`
- `typography.line.normal: 1.5`
- `typography.line.relaxed: 1.7`

## Usage Rules

- Hero and narrative copy: `family.story`
- KPI numbers, chart labels, model metrics: `family.data`
- Section titles (`h2`): semibold + high contrast

## Spacing and Sizing Tokens

- `space.1: 0.25rem`
- `space.2: 0.5rem`
- `space.3: 0.75rem`
- `space.4: 1rem`
- `space.5: 1.25rem`
- `space.6: 1.5rem`
- `space.8: 2rem`
- `space.10: 2.5rem`
- `space.12: 3rem`

Component spacing:

- Card internal padding desktop: `space.6`
- Card internal padding mobile: `space.4`
- Section vertical rhythm desktop: `space.10`
- Section vertical rhythm mobile: `space.8`

## Radius Tokens

- `radius.sm: 10px`
- `radius.md: 14px`
- `radius.lg: 18px`
- `radius.pill: 999px`

## Border and Shadow Tokens

- `border.card: 1px solid color.border.soft`
- `border.active: 1px solid color.border.strong`
- `shadow.card.base: 0 8px 24px rgba(4, 9, 18, 0.36)`
- `shadow.card.hover: 0 14px 34px rgba(4, 9, 18, 0.46)`
- `shadow.glow.primary: 0 0 0 1px color.border.soft, 0 0 22px color.glow.blue`
- `shadow.glow.cta: 0 0 28px color.glow.cyan`

## Motion Tokens

- `motion.fast: 120ms`
- `motion.base: 180ms`
- `motion.slow: 260ms`
- `motion.ease.standard: cubic-bezier(0.2, 0.8, 0.2, 1)`

Rules:

- Hover transitions max `motion.base`
- Avoid parallax-heavy effects
- Respect `prefers-reduced-motion` (disable transform pulses and glow animation)

## Focus and Interaction Tokens

- `focus.ring.width: 2px`
- `focus.ring.color: color.accent.cyan`
- `focus.ring.offset: 2px`
- `focus.shadow: 0 0 0 4px rgba(60, 242, 255, 0.22)`

States:

- Button hover: slight elevation + stronger glow
- Button active: reduce glow, increase border contrast
- Disabled: lower saturation + no glow

## Grid Tokens (Bento)

- Desktop container max width: `1280px`
- Desktop columns: `12`
- Desktop gap: `24px`
- Tablet columns: `8`, gap `16px`
- Mobile columns: `1`, gap `12px`

Card behavior:

- Major narrative cards can span 2-3 columns on desktop.
- KPI cards should never exceed two visual hierarchy levels (metric + caption).

## Component Hierarchy Mapping

1. `hero-command-card` (highest emphasis)
2. `kpi-snapshot-card`
3. `project-feature-card`
4. `timeline-card`
5. `viz-lab-card`
6. `stack-matrix-card`
7. `credentials-card`
8. `cta-strip-card`

Hierarchy controls:

- Emphasis via contrast, size, and spacing before color.
- Use glow only on primary actions and key metrics.

## Accessibility Targets

- Body text contrast >= 4.5:1
- Large heading contrast >= 3:1 (target 4.5:1 where possible)
- Interactive elements always show visible focus state
- Avoid color-only status indicators (pair with icon/text)
- Touch targets >= 44x44 px

## Implementation Notes for Task 4 (Debugger)

- Define tokens in Sass partials with maps and CSS custom properties:
  - `assets/css/tokens/_color.scss`
  - `assets/css/tokens/_type.scss`
  - `assets/css/tokens/_space.scss`
  - `assets/css/tokens/_motion.scss`
- Expose through `@forward`, consume through `@use`
- Keep compatibility with existing theme variables during transition (alias layer)

## Handoff

- Task 4 (DBG): build modular Sass architecture for these tokens.
- Task 5 (UX + DBG): apply tokens to Bento shell components.
