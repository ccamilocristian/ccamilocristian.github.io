# Presence baseline — 2026-07-19

This baseline separates search presence from analytics measurement. It is the
comparison point for the 30/60/90-day plan.

## Search presence

Source: GSC URL Inspection and Search Analytics APIs.

- Indexed: 3 (`/`, `/tabs/intelligence/`,
  `/posts/optimation-consumer-english/`)
- Unknown to Google: 16
- Sitemap: submitted 2026-07-19, still pending
- Sitemap last downloaded by Google: 2024-10-16

GSC query signals for the 90 days ending 2026-07-16:

| Query | Impressions | Clicks | Position |
|---|---:|---:|---:|
| calculadora de inflacion colombia | 149 | 0 | 10.4 |
| como hacer un reproductor de musica | 30 | 0 | 8.3 |
| automatizar envio de email python | 27 | 0 | 44.7 |
| enviar correo con python | 24 | 0 | 40.0 |

These queries primarily reflect legacy Spanish URL history. They establish
demand; they do not prove that canonical English URLs have inherited the
signals.

## Measurement context

Source: GA4 Data API, 30 days ending 2026-07-19.

- Home: 32 views, 8.2 seconds average engagement
- Intelligence: 4 views, 5.0 seconds
- Profile: 4 views, 21.0 seconds
- Canonical content has only 1–2 views per listed page
- Historical `//` paths still fragment a small number of rows

GA4 is a behavior diagnostic after consent and bot segmentation. It is not the
indexation KPI.

## Indexing request ledger

The URL Inspection API cannot press “Request indexing.” Record the UI action
here once, then wait 7–14 days unless the live test fails or the page changes
materially.

| Canonical URL | Requested at | Owner | Next review |
|---|---|---|---|
| `/posts/colombia-cpi-indexation-engine-english/` | pending after deploy | Human | +7 days |
| `/posts/music-player-english/` | pending confirmation | Human | +7 days |
| `/posts/convertidor-english/` | pending confirmation | Human | +7 days |
| `/posts/automation-sending/` | pending confirmation | Human | +7 days |
| `/posts/loan-simulator-english/` | pending confirmation | Human | +7 days |
| `/posts/icfes-english/` | pending confirmation | Human | +7 days |
| `/tabs/profile/` | pending confirmation | Human | +7 days |

## Bing Webmaster ledger

IndexNow key and prior pings are live. Bing Webmaster verification and sitemap
submission require the account UI:

- Property: `https://ccamilocristian.github.io/`
- Sitemap: `https://ccamilocristian.github.io/sitemap.xml`
- Verification: pending human confirmation
- Sitemap accepted: pending human confirmation

Do not describe this ledger as complete until both confirmations are recorded.
