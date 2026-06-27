# Docs index

Design and migration specs for the Calm Technical dashboard. These files are **excluded from the Jekyll build** (`_config.yml` → `exclude: docs`).

## Read first (operational)

| Doc | Purpose |
|-----|---------|
| [`GSC_AUDIT_2026-06-27.md`](GSC_AUDIT_2026-06-27.md) | Search Console — indexación, sitemap, EN vs ES |
| [`GA4_AUDIT_2026-06-27.md`](GA4_AUDIT_2026-06-27.md) | Google Analytics 4 — tráfico, bots, consent |
| [`ADSENSE_AUDIT_2026-06-27.md`](ADSENSE_AUDIT_2026-06-27.md) | AdSense — ingresos, slots, dashboard |
| [`T24_GSC_INDEX_NOW.md`](T24_GSC_INDEX_NOW.md) | 13 URLs para solicitar indexación |
| [`MANUAL_CHECKLIST.md`](MANUAL_CHECKLIST.md) | Checklist manual UI (T24–T26) |
| [`API_RUN_2026-06-27.md`](API_RUN_2026-06-27.md) | Batch APIs + límites del bot |
| [`GA4_BASELINE_2026-06-27.md`](GA4_BASELINE_2026-06-27.md) | Baseline GA4 pre-filtro |
| [`GSC_API_SNAPSHOT_2026-06-27.json`](GSC_API_SNAPSHOT_2026-06-27.json) | Páginas GSC + inspección 14 URLs EN |
| [`WEEK_PLAN_2026-06-27.md`](WEEK_PLAN_2026-06-27.md) | Horizonte semanal lun–vie |
| [`STITCH_MIGRATION_GAP.md`](STITCH_MIGRATION_GAP.md) | Stitch 7/7 status, dual shell, open gaps |
| [`../README_UX_EVOLUTION.md`](../README_UX_EVOLUTION.md) | Vision, stack, routes, content policy |
| [`../BACKLOG.md`](../BACKLOG.md) | Task queue |

## Stitch / UX overhaul (reference)

| Prefix | Topic |
|--------|--------|
| `UX_UI_OVERHAUL_TASK1–8` | Wireframe, narrative, tokens, bento, viz MVP, story cards, QA |
| `DATA_DASHBOARD_A1–A6` | IA nav, labels, hero, sidebar deprecation, modules |
| `DATA_DASHBOARD_V1–V6` | Palette, typography, navbar, skill cloud, insights, motion |
| `DATA_DASHBOARD_C1–C7` | Narrative spine, hero copy, pillars, intelligence framing, metadata |
| `DATA_DASHBOARD_UX_AUDIT_*` | Home hierarchy, spacing, shell a11y audits |

## Upstream (not project-specific)

| Doc | Note |
|-----|------|
| `README_zh-CN.md` | Chirpy theme wiki copy — safe to ignore |

When a spec is fully implemented, treat it as **archive**; update `STITCH_MIGRATION_GAP.md` and `BACKLOG.md` instead of editing the spec retroactively.
