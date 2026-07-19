# Metrics smoke — 2026-07-19

## Live home checks

| Check | Result |
|-------|--------|
| Direct GA4 `gtag/js?id=G-4FK52MWLPP` | Present |
| Consent default `analytics_storage: denied` | Present |
| CookieYes script | Present |
| GTM `GTM-K8J9KSB8` | Present |
| GTM Google Tag | Paused (Live v7) |

## Code paths

1. `consent-defaults.html` → deny-by-default + `wait_for_update: 1500`
2. `consent-gate.js` → CookieYes categories → `gtag('consent','update')`
3. `google-analytics.html` → direct `gtag('config')` (Consent Mode Advanced)
4. `analytics-events.js` → `outbound_click` / `site_search` via dataLayer **and** `gtag('event')`

## QA (human)

1. Incognito → `/?debug_consent=1`
2. Accept analytics → Realtime `page_view`
3. Console: `window.siteConsentGate.debugDump()` → `analyticsGranted: true`
4. Click external link → Network / DebugView `outbound_click`
