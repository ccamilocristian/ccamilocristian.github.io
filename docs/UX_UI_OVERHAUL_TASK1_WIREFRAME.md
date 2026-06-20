# UX/UI Overhaul - Task 1/8

IA + Wireframe Blueprint for a dark, data-centric Bento homepage.

## Scope

- Project: `ccamilocristian.github.io` (Jekyll + Chirpy)
- Task owner(s): UX + Redactor
- Goal: define structure and content flow before visual implementation
- Narrative spine: "The Path from Data to Intelligence"

## Information Architecture (Homepage)

1. Hero Command Center
2. KPI Snapshot Bar
3. Featured Case Studies (Bento cards)
4. The Path from Data to Intelligence (story timeline)
5. Visualization Lab (interactive demos)
6. Stack and Workflow
7. Trust and Credentials
8. Primary CTA Footer Strip

## CTA Hierarchy

1. Primary CTA: `View Portfolio Projects`
2. Secondary CTA: `Book a Data Strategy Call`
3. Tertiary CTA: `Download CV`
4. Contextual CTA inside case cards: `See Pipeline`, `See Impact`

## Desktop Wireframe (Bento map)

Grid: 12 columns, 24px gap, card radius 16px, dark base with subtle glow accents.

- Row 1
  - Card A (cols 1-7): Hero identity + value proposition + primary CTA
  - Card B (cols 8-12): Snapshot metrics (projects, models, impact)
- Row 2
  - Card C (cols 1-4): Economics to AI transition statement
  - Card D (cols 5-8): CV specialization highlights
  - Card E (cols 9-12): Toolchain quick matrix
- Row 3-4
  - Card F (cols 1-8): Featured Project #1 (Problem-Process-Impact)
  - Card G (cols 9-12): Model performance mini chart
  - Card H (cols 1-4): Featured Project #2
  - Card I (cols 5-8): Featured Project #3
  - Card J (cols 9-12): ROI or business delta widget
- Row 5
  - Card K (cols 1-12): Story timeline "Data -> Model -> Decision -> Value"
- Row 6
  - Card L (cols 1-6): Visualization Lab entry point
  - Card M (cols 7-12): Contact/collaboration CTA strip

## Mobile Wireframe (stack order)

Single-column stack, same narrative order:

1. Hero Command Center
2. KPI Snapshot
3. Economics to AI transition
4. CV specialization
5. Toolchain matrix
6. Featured projects (top 3)
7. Story timeline
8. Visualization Lab
9. Contact CTA strip

## Content Blocks (copy placeholders)

### Hero

- Eyebrow: `AI Data Engineer Portfolio`
- Headline: `From Raw Data to Intelligent Decisions`
- Subheadline: `I connect Computer Vision and Economics to build models that improve business outcomes.`

### Story Timeline

- Stage 1: `Data Reality` - messy signals, uncertainty, domain constraints
- Stage 2: `Model Intelligence` - CV/ML pipeline and validation discipline
- Stage 3: `Economic Decision` - risk, cost, and expected value framing
- Stage 4: `Business Impact` - measurable gains in performance and efficiency

### Case Study Card Template

- Problem
- Process (data + model + deployment)
- Impact (metric before/after)
- CTA: `See Pipeline` / `See Impact`

## Visualization Placement (interactive)

- Hero metrics: mini sparklines or counters
- Case section: model performance comparison chart
- Impact card: before/after delta chart
- Visualization Lab: one interactive demo (MVP)

## Accessibility and UX Constraints

- Semantic headings: single `h1`, card titles as `h2`/`h3`
- Keyboard-first focus order across cards
- Minimum AA contrast for text and action states
- Motion reduced when `prefers-reduced-motion` is enabled
- Mobile-first spacing and readable card density

## Handoff to Next Tasks

- Task 2 (Redactor): expand copy system for all sections
- Task 3 (UX): convert this structure into design tokens and component specs
- Task 5 (UX + DBG): implement Bento shell in Jekyll layouts
