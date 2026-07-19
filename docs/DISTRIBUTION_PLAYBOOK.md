# Distribution playbook

One useful adaptation per channel, one canonical English URL, and a measurable
link. Do not publish identical full text unless the platform exposes a verified
canonical setting.

## UTM convention

Use lowercase values:

```text
?utm_source=linkedin&utm_medium=social&utm_campaign=presence_2026q3&utm_content=cpi_launch
```

Allowed `utm_source`: `linkedin`, `x`, `devto`, `hashnode`, `reddit`,
`hackernews`, `github`, `rss`. Use `social`, `syndication`, `community`, or
`referral` as the medium.

## Initial channel sequence

| Channel | Owner | Frequency | URL to lead with | KPI |
|---|---|---|---|---|
| GitHub profile/repo | Human | setup + monthly | Site home, CPI, MCP | qualified referrals, stars, profile visits |
| LinkedIn | Human | weekly | CPI, ICFES, MCP/RAG | link clicks, saves, technical replies |
| X | Human | launch + monthly | CPI or MCP/RAG | link clicks, qualified replies |
| Dev.to | Human + Bot draft | monthly | Python/DE article with canonical | referrals, followers, indexed backlink |
| Reddit/HN | Human | only when directly relevant | reproducible tool/dataset | substantive discussion, referrals |
| RSS | Bot | every publication | `/feed.xml` | feed referrals/subscribers |

Start with Dev.to. Add Hashnode only if Dev.to produces no qualified signal
after two posts or if an existing Hashnode audience is stronger. Defer Medium.

## GitHub UI checklist

The local environment does not provide GitHub CLI access, so these repository
settings remain a one-time human action:

1. Add topics: `jekyll`, `data-engineering`, `machine-learning`, `python`,
   `economics`, `portfolio`.
2. Set the repository homepage to `https://ccamilocristian.github.io/`.
3. Pin this repository on the GitHub profile.
4. Upload a Calm Technical social preview using the existing brand system.
5. Confirm the profile bio and LinkedIn URL use the same name and headline as
   the site.

## Ready-to-adapt launch copy

### LinkedIn — Colombia CPI

> Inflation adjustments become hard to review when the calculator hides its
> source months. I built a small Python workflow around Colombia's official
> monthly IPC series: validate missing months, index a peso value, and export
> the observations and formula as an audit CSV.
>
> The useful part is not the final number. It is being able to reproduce why
> that number changed when DANE publishes a new month.
>
> [canonical CPI URL with UTM]

### GitHub profile/repository

Use these three featured links:

1. Colombia CPI indexation in Python — official data and audit trail.
2. MCP server for BigQuery — an inspectable agent/data interface.
3. Local RAG with Ollama — local retrieval and evaluation workflow.

### Dev.to syndication header

Set the platform canonical URL to:

```text
https://ccamilocristian.github.io/posts/colombia-cpi-indexation-engine-english/
```

Add this first-line note:

> Originally published on Cristian Camilo Moreno Narvaez's portfolio. This
> edition preserves the canonical source and update history.

## Community guardrails

- Answer the question in the post itself; the link is supporting material.
- Read community rules before sharing.
- Do not ask for votes, cross-post on the same day, or reuse promotional copy.
- Stack Overflow answers must be complete without leaving the site.
- Awesome-list and directory submissions must meet their documented criteria.
- University/alumni listings require a real affiliation.

## Deferred channels

- Medium: activate only with an existing publication/audience and canonical
  support.
- Newsletter: activate at 25 interested subscribers or a sustainable two-post
  monthly cadence.
- YouTube/Shorts: reconsider when a proven article can become a useful
  screencast in under three hours.

Record every publication or earned mention in `docs/distribution-log.csv`.
