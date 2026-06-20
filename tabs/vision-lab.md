---
title: Vision Lab
permalink: /tabs/vision-lab/
tab_active: Vision Lab
breadcrumb:
  -
    label: Command Center
    url: /
---

{% assign vl = site.data.vision_lab %}

<div class="stitch-tab-page stitch-vision-page dashboard-page dashboard-page--vision">

  <header class="stitch-vision-header stitch-reveal">
    <p class="stitch-vision-eyebrow">{{ vl.hero.eyebrow }}</p>
    <h1>{{ vl.hero.title }}</h1>
    <p class="stitch-vision-lead">{{ vl.hero.lead }}</p>
  </header>

  <section class="stitch-vision-roadmap stitch-reveal" aria-labelledby="vision-roadmap-heading">
    <div class="stitch-vision-section-head">
      <h2 id="vision-roadmap-heading" class="stitch-vision-section-title">Research roadmap</h2>
    </div>
    <div class="stitch-vision-roadmap-grid">
      {% for item in vl.roadmap %}
      <article class="vision-roadmap-card card-glass vision-roadmap-card--{{ item.status }} stitch-reveal">
        <span class="vision-roadmap-phase">{{ item.phase_label }}</span>
        <h3 class="vision-roadmap-name">{{ item.phase }}</h3>
        <p class="vision-roadmap-focus"><strong>Focus:</strong> {{ item.focus }}</p>
        <p class="vision-roadmap-target"><strong>Target:</strong> {{ item.target }}</p>
        {% if item.bullets %}
        <ul class="vision-roadmap-bullets">
          {% for bullet in item.bullets %}
          <li>{{ bullet }}</li>
          {% endfor %}
        </ul>
        {% endif %}
      </article>
      {% endfor %}
    </div>
  </section>

  <section class="stitch-vision-experiments stitch-reveal" aria-labelledby="vision-experiments-heading">
    <div class="stitch-vision-section-head">
      <h2 id="vision-experiments-heading" class="stitch-vision-section-title">Featured experiments</h2>
      <span class="stitch-vision-section-meta">{{ vl.selected_experiments.size }} scoped</span>
    </div>
    <div class="stitch-vision-experiments-grid">
      {% for exp in vl.selected_experiments %}
      <article class="vision-experiment-card card-glass vision-experiment-card--{{ exp.status_badge }} stitch-reveal">
        <div class="vision-experiment-media" aria-hidden="true">
          <span class="vision-experiment-status">{{ exp.status }}</span>
        </div>
        <div class="vision-experiment-body">
          <h4 class="vision-experiment-name">{{ exp.name }}</h4>
          <p class="vision-experiment-objective"><strong>Objective:</strong> {{ exp.objective }}</p>
          <p class="vision-experiment-impact"><strong>Impact hypothesis:</strong> {{ exp.impact_hypothesis }}</p>
          {% if exp.tools %}
          <div class="vision-experiment-tools">
            {% for tool in exp.tools %}
            <span class="vision-experiment-tool">{{ tool }}</span>
            {% endfor %}
          </div>
          {% endif %}
        </div>
      </article>
      {% endfor %}
    </div>
  </section>

  <section class="stitch-vision-philosophy stitch-reveal" aria-labelledby="vision-philosophy-heading">
    <div class="vision-philosophy-card card-glass">
      <div class="vision-philosophy-copy">
        <h2 id="vision-philosophy-heading" class="stitch-vision-section-title">{{ vl.philosophy.title }}</h2>
        {% for paragraph in vl.philosophy.paragraphs %}
        <p class="vision-philosophy-paragraph">{{ paragraph }}</p>
        {% endfor %}
        <ul class="vision-principles-list">
          {% for principle in vl.positioning.principles %}
          <li>{{ principle }}</li>
          {% endfor %}
        </ul>
      </div>
      <div class="vision-philosophy-aside">
        <div class="vision-philosophy-frame" aria-hidden="true">
          <span class="vision-philosophy-frame-label">{{ vl.philosophy.manifesto_label }}</span>
        </div>
      </div>
    </div>
  </section>

  <div class="stitch-vision-footer-action stitch-reveal">
    <a class="stitch-link-mono" href="{{ vl.footer_action.url | relative_url }}">{{ vl.footer_action.label }} →</a>
  </div>

</div>
