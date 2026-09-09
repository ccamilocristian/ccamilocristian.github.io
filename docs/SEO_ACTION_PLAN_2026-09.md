# SEO Action Plan — 2026-09

Concrete, prioritized plan to recover organic traffic (currently ~0 impressions/clicks)
and compound it. Written after the bilingual-SEO restoration and the UX refresh
(nav cleanup, Command Center identity, palette). It assumes the technical
foundation already shipped and focuses on what still moves the needle.

## 0. Where we are (baseline)

Already fixed (do **not** redo):

- **Bilingual pairs restored** — 9 EN↔ES posts, reciprocal `hreflang` + `x-default`,
  per-language `<html lang>`, in-post language switcher. Verified by
  `tools/verify-seo-security.sh` (all pairs pass).
- **Service-worker adware removed** — the old third-party push worker was hijacking
  the site; `sw.js`/`app.js` are now a self-removing kill-switch. This alone likely
  contributed to the traffic collapse (Google penalizes malicious SW behavior).
- **Sitemap + robots** — `sitemap.xml` present, `robots.txt` does not blanket-disallow,
  no stale `sw_old.js` leaking into the sitemap.
- **Nav noise cut** — Stack + Economics Lens + Vision Lab removed from the primary
  nav; their pages stay indexable so no link equity is lost.

Root-cause hypothesis for zero traffic: (a) adware SW damaging trust/UX signals,
(b) thin/duplicated bilingual signals confusing indexing, (c) a very small,
rarely-updated corpus with weak internal linking and no external signals. (a) and
(b) are addressed. This plan tackles (c) and verification.

## 1. Immediate — verification & reindexing (highest priority)

These are manual steps in Google Search Console (GSC). They gate everything else,
because we need to confirm Google can crawl the healed site.

1. **Confirm no manual/security action.** GSC → Security & Manual Actions. If the
   adware worker triggered anything, request review now (nothing else matters until
   this clears).
2. **Resubmit the sitemap.** GSC → Sitemaps → resubmit `https://<domain>/sitemap.xml`.
3. **URL Inspection + Request Indexing** for the money pages:
   - Home (`/`)
   - `/tabs/profile/`, `/tabs/intelligence/`
   - The top 5 EN posts by past impressions (see `docs/GSC_AUDIT_2026-06-27.md`).
4. **Validate hreflang** with GSC International Targeting (or a crawler) — confirm no
   "no return tag" errors on the 9 pairs.
5. **Set a 4-week checkpoint** to compare impressions/clicks against today's zero.

Success signal: pages move from "Discovered/Crawled – not indexed" to "Indexed"
within 2–3 weeks.

## 2. On-page — make each page earn its keyword (per URL)

For every published post, tighten the fundamentals. Priority order = past impressions.

- **Title tag**: ≤ 60 chars, primary keyword first, human. Avoid "Home"/generic.
- **Meta description**: 140–160 chars, includes the query intent, one concrete outcome.
- **One H1** matching search intent; H2s that mirror sub-questions.
- **Slugs**: short, keyword-bearing, stable (never rename an indexed slug without a
  301 in `_data/post_pairs.yml` / `redirect_from`).
- **Open Graph / Twitter image** per post (unique `og:image`) for CTR on shares.
- **Internal links**: every post links to 2–3 sibling posts and back to Intelligence.
  This is the cheapest win we are currently missing.

Deliverable: a checklist pass, one commit per batch of posts, guarded by
`tools/verify-seo-security.sh` so SEO/security invariants never regress.

## 3. Content — depth on a tight topical cluster

We rank nothing because we cover a little of everything. Pick **one** cluster where
we already have real, first-party work and go deep:

- **Recommended cluster: "Colombia economics + data"** — CPI/IPC indexation engine,
  peso-value calculators, official-series pipelines. We have genuine artifacts, the
  Spanish audience is underserved, and the keywords are low-competition + local.
- Publish 3–4 supporting posts around the existing CPI engine (methodology, data
  sources, a worked example, an FAQ). Interlink them as a hub → spokes.
- Keep the bilingual discipline: EN canonical + ES alternate for each new post, with
  the same hreflang wiring the guard already checks.

This is what turns "indexed" into "ranked".

## 4. Off-page / distribution (compounding signals)

Google needs external corroboration that the site is real and useful.

- Ensure a **Person schema** (JSON-LD) on home/profile with name, job title, sameAs
  links (GitHub, LinkedIn). Name searches for "Cristian Camilo Moreno Narváez" should
  own the SERP — the new identity header supports this.
- Syndicate each new post with a canonical-back link (dev.to / Medium / LinkedIn
  article) pointing to the original. See `docs/DISTRIBUTION_PLAYBOOK.md`.
- Add the profile to relevant directories and get 2–3 genuine backlinks.

## 5. Measurement & guardrails

- **Cadence**: weekly GSC glance (impressions, avg position, coverage), monthly deep
  review vs. `docs/GSC_AUDIT_2026-06-27.md`.
- **Never regress the foundation**: run `bash tools/verify-seo-security.sh` before
  every commit that touches templates, SW, or `_data/post_pairs.yml`.
- **Track leading indicators** first (impressions, indexed count, avg position) before
  expecting clicks; clicks lag indexing by weeks.

## Priority summary

| # | Action | Effort | Impact | When |
|---|--------|--------|--------|------|
| 1 | GSC: clear security, resubmit sitemap, request indexing | low | **critical** | now |
| 2 | Per-page title/description/OG/internal-links pass | med | high | next |
| 3 | Deep topical cluster (Colombia econ + data) | high | high | ongoing |
| 4 | Person schema + syndication + backlinks | med | med | ongoing |
| 5 | Weekly/monthly measurement + guard on every commit | low | high | continuous |

Do #1 first — until Google recrawls the healed site, the rest can't show results.
