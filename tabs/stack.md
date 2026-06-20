---
title: Stack
permalink: /tabs/stack/
tab_active: Stack
breadcrumb:
  -
    label: Command Center
    url: /
---

{% assign sp = site.data.stack_page %}
{% assign skills = site.data.skills_cloud %}

<div class="stitch-tab-page stitch-stack-page dashboard-page dashboard-page--stack">

  <header class="stitch-stack-header stitch-reveal">
    <p class="stitch-stack-eyebrow">{{ sp.hero.eyebrow }}</p>
    <h1>{{ sp.hero.title }}</h1>
    <p class="stitch-stack-lead">{{ sp.hero.lead }}</p>
  </header>

  <div class="stitch-stack-legend stitch-reveal" aria-label="Domain legend">
    {% for item in sp.legend %}
    <div class="stitch-stack-legend-item">
      <span class="stack-accent-dot stack-accent-dot--{{ item.domain }}" aria-hidden="true"></span>
      <span class="stitch-stack-legend-label">{{ item.label }}</span>
    </div>
    {% endfor %}
  </div>

  <div class="stitch-stack-matrix-wrap stitch-reveal">
    <div class="stitch-stack-matrix-ambient" aria-hidden="true"></div>
    <div class="stitch-stack-matrix">
      {% for tier in sp.proficiency_tiers %}
      <section class="stack-proficiency-card card-glass stack-proficiency-card--{{ tier.accent }} stitch-reveal">
        <div class="stack-proficiency-head">
          <h2 class="stack-proficiency-label stack-proficiency-label--{{ tier.accent }}">{{ tier.label }}</h2>
          <span class="stack-proficiency-subtitle">{{ tier.subtitle }}</span>
        </div>
        <div class="stack-tool-cloud">
          {% for item in skills.core_domains %}
            {% if item.weight == tier.key %}
            <span class="stack-tool-tag">
              <span class="stack-accent-dot stack-accent-dot--{{ item.domain }}" aria-hidden="true"></span>
              <span>{{ item.name }}</span>
            </span>
            {% endif %}
          {% endfor %}
          {% for item in skills.tools %}
            {% if item.weight == tier.key %}
            <span class="stack-tool-tag">
              <span class="stack-accent-dot stack-accent-dot--{{ item.domain }}" aria-hidden="true"></span>
              <span>{{ item.name }}</span>
            </span>
            {% endif %}
          {% endfor %}
        </div>
      </section>
      {% endfor %}
    </div>
  </div>

  <div class="stitch-stack-panels stitch-reveal">
    {% for panel in sp.panels %}
    <article class="stack-panel-card card-glass">
      <h3 class="stack-panel-title">{{ panel.title }}</h3>
      <p class="stack-panel-copy">{{ panel.copy }}</p>
    </article>
    {% endfor %}
  </div>

  <div class="stitch-stack-footer-action stitch-reveal">
    <a class="stitch-stack-explore stitch-link-mono" href="{{ sp.explore.url | relative_url }}">{{ sp.explore.label }} →</a>
  </div>

</div>
