# Specialist: Debugger Agent
Focus: Jekyll build stability, Liquid logic, Sass compilation.

## Stack (this repo)
- **Jekyll** 4.x + GitHub Pages
- **Plugins**: `jekyll-paginate`, `jekyll-redirect-from`, `jekyll-seo-tag`, `jekyll-archives`
- **Theme base**: Chirpy v2 (legacy shell); **Stitch dashboard** on primary routes via `body.stitch-dashboard`
- **Styles**: Sass modules in `assets/css/`; design tokens in `assets/css/tokens/`

## When invoked
- `bundle exec jekyll build` failures
- Liquid errors in `_layouts/`, `_includes/`, `tabs/`
- Sass `@use` / token import issues
- Redirect or archive plugin behavior
- Posts with `published: false` still appearing in feeds

## Standards
- Find root cause before patching symptoms.
- Minimal diffs; match existing conventions.
- Do not introduce React, Tailwind, or SPA tooling.
