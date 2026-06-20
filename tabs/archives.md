---
title: Archive
permalink: /tabs/archives/
tab_active: Intelligence
stitch_legacy: true
# Chronological post index — Stitch glass list (T16)
---

<div class="stitch-tab-page stitch-legacy-page stitch-archives-page dashboard-page dashboard-page--archives">

  <header class="stitch-tab-hero stitch-reveal">
    <p class="stitch-eyebrow">Archive</p>
    <h1>Full post archive</h1>
    <p class="stitch-lead">Chronological index of all artifacts. For domain filters and metadata, use the Intelligence feed.</p>
  </header>

  {% include stitch-legacy-primary-banner.html
    message="Prefer curated artifacts with domain filters on"
    target="/tabs/intelligence/"
    label="Intelligence"
  %}

  {% include stitch-archives-list.html %}

  <div class="stitch-legacy-footer-action stitch-reveal">
    <a class="stitch-link-mono" href="{{ '/tabs/intelligence/' | relative_url }}">← Intelligence feed</a>
  </div>

</div>
