---
title: Economics Lens
permalink: /tabs/economics-lens/
tab_active: Economics Lens
breadcrumb:
  -
    label: Command Center
    url: /
---

{% assign ep = site.data.economics_lens_page %}
{% assign featured_slug = ep.featured.slug %}

{% assign econ_posts = site.posts | where_exp: "post", "post.tags contains 'economics'" %}
{% assign econ_posts_es = site.posts | where_exp: "post", "post.categories contains 'Economics'" %}
{% assign posts = "" | split: "" %}
{% for p in econ_posts %}
  {% assign posts = posts | push: p %}
{% endfor %}
{% for p in econ_posts_es %}
  {% assign posts = posts | push: p %}
{% endfor %}
{% assign posts = posts | uniq %}

<div class="stitch-tab-page stitch-economics-page dashboard-page dashboard-page--economics">

  <header class="stitch-economics-header stitch-reveal">
    <h1>{{ ep.hero.title }}</h1>
    <p class="stitch-economics-lead">{{ ep.hero.lead }}</p>
  </header>

  <div class="stitch-economics-bento stitch-reveal">
    <div class="stitch-economics-ambient stitch-economics-ambient--primary" aria-hidden="true"></div>
    <div class="stitch-economics-ambient stitch-economics-ambient--secondary" aria-hidden="true"></div>

    <div class="stitch-economics-main">
      {% for post in posts %}
        {% if post.slug == featured_slug %}
        <section class="economics-featured-card card-glass stitch-reveal">
          <div class="economics-featured-icon" aria-hidden="true">⚖</div>
          <div class="economics-featured-head">
            <span class="economics-featured-badge">{{ ep.featured.badge }}</span>
            <span class="economics-featured-ref">{{ ep.featured.ref_label }}</span>
          </div>
          <h2 class="economics-featured-title">
            <a href="{{ post.url | relative_url }}">{{ post.title }}</a>
          </h2>
          <p class="economics-featured-excerpt">
            {% assign feat_excerpt = post.description %}
            {% if feat_excerpt == nil or feat_excerpt == "" %}
              {% assign feat_excerpt = post.content | markdownify | strip_html | truncate: 220 %}
            {% endif %}
            {{ feat_excerpt }}
          </p>
          <div class="economics-featured-meta">
            <div class="economics-featured-meta-item">
              <span class="economics-featured-meta-label">Level</span>
              <span class="economics-featured-meta-value">{{ post.technical_level | default: "Intermediate" }}</span>
            </div>
            <div class="economics-featured-meta-item">
              <span class="economics-featured-meta-label">Read time</span>
              <span class="economics-featured-meta-value">{{ post.reading_time | default: 1 }} min</span>
            </div>
          </div>
          <a class="btn-stitch btn-stitch--tertiary" href="{{ post.url | relative_url }}">Deep dive</a>
        </section>
        {% endif %}
      {% endfor %}

      {% if posts.size == 0 %}
      <section class="economics-featured-card card-glass stitch-reveal">
        <p class="stitch-economics-empty">No economics-focused entries matched current filters yet.</p>
      </section>
      {% endif %}

      <div class="economics-artifact-grid">
        {% assign secondary_count = 0 %}
        {% for post in posts %}
          {% unless post.slug == featured_slug %}
            {% if secondary_count < 2 %}
            <article class="economics-artifact-card card-glass stitch-reveal">
              <div class="economics-artifact-head">
                <span class="economics-artifact-code">EC-{{ post.date | date: "%m%y" }}</span>
                <time class="economics-artifact-date" datetime="{{ post.date | date_to_xmlschema }}">{{ post.date | date: "%b %Y" }}</time>
              </div>
              <h3 class="economics-artifact-title">
                <a href="{{ post.url | relative_url }}">{{ post.title }}</a>
              </h3>
              <p class="economics-artifact-excerpt">
                {{ post.content | markdownify | strip_html | truncate: 120 }}
              </p>
              <a class="stitch-link-mono economics-artifact-link" href="{{ post.url | relative_url }}">Read artifact →</a>
            </article>
            {% assign secondary_count = secondary_count | plus: 1 %}
            {% endif %}
          {% endunless %}
        {% endfor %}
      </div>
    </div>

    <aside class="stitch-economics-sidebar">
      <section class="economics-frameworks-card card-glass stitch-reveal">
        <h2 class="economics-sidebar-title">Decision frameworks</h2>
        <ul class="economics-framework-list">
          {% for item in ep.frameworks %}
          <li class="economics-framework-item">
            <span class="economics-framework-num">{{ item.number }}</span>
            <div class="economics-framework-body">
              <span class="economics-framework-name">{{ item.title }}</span>
              <span class="economics-framework-sub">{{ item.subtitle }}</span>
            </div>
          </li>
          {% endfor %}
        </ul>
      </section>

      <section class="economics-principles stitch-reveal">
        <h2 class="economics-sidebar-title">Economic principles</h2>
        <div class="economics-principles-grid">
          {% for item in ep.principles %}
          <div class="economics-principle-card card-glass economics-principle-card--{{ item.accent }}">
            <span class="economics-principle-label">Principle</span>
            <span class="economics-principle-name">{{ item.label }}</span>
          </div>
          {% endfor %}
        </div>
      </section>

      <section class="economics-signals-card card-glass stitch-reveal">
        <h2 class="economics-sidebar-title">Corpus snapshot</h2>
        <div class="economics-signals-list">
          <div class="economics-signal-row">
            <span class="economics-signal-label">Articles indexed</span>
            <span class="economics-signal-value">{{ posts.size }}</span>
          </div>
          <div class="economics-signal-bar">
            <span class="economics-signal-bar-fill" style="width: {% if posts.size > 0 %}100{% else %}0{% endif %}%;"></span>
          </div>
          <div class="economics-signal-row">
            <span class="economics-signal-label">Domains covered</span>
            <span class="economics-signal-value">Economics</span>
          </div>
          <div class="economics-signal-bar economics-signal-bar--primary">
            <span class="economics-signal-bar-fill" style="width: 72%;"></span>
          </div>
        </div>
      </section>
    </aside>
  </div>

  <section class="economics-banner-card card-glass stitch-reveal">
    <h3 class="economics-banner-title">{{ ep.banner.title }}</h3>
    <p class="economics-banner-copy">{{ ep.banner.copy }}</p>
  </section>

  <div class="stitch-economics-footer-action stitch-reveal">
    <a class="stitch-link-mono" href="{{ ep.footer_action.url | relative_url }}">{{ ep.footer_action.label }} →</a>
  </div>

</div>
