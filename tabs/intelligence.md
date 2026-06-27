---
title: Intelligence
permalink: /tabs/intelligence/
redirect_from:
  - /tabs/tags/
  - /tabs/categories/
  - /tags/
  - /categories/
  - /posts/
tab_active: Intelligence
breadcrumb:
  -
    label: Command Center
    url: /
---

{% assign ip = site.data.intelligence_page %}
{% assign featured_slug = ip.featured.slug %}
{% assign feed_interval = site.data.site_ops.adsense.in_feed_interval | default: 6 %}
{% assign feed_index = 0 %}

<div class="stitch-tab-page stitch-intelligence-page dashboard-page dashboard-page--intelligence">

  <header class="stitch-intelligence-header stitch-reveal">
    <div class="stitch-intelligence-header-main">
      <h1>{{ ip.hero.title }}</h1>
      <p class="stitch-intelligence-lead">{{ ip.hero.lead }}</p>
    </div>
    <div class="stitch-intelligence-search-wrap">
      <label class="sr-only" for="intelligence-filter-input">Filter artifacts</label>
      <input id="intelligence-filter-input" class="stitch-intelligence-search" type="search" placeholder="{{ ip.search_placeholder }}" autocomplete="off">
    </div>
  </header>

  <nav class="stitch-intelligence-filters stitch-reveal" aria-label="Filter by domain">
    {% for filter in ip.domain_filters %}
    <button type="button" class="stitch-intelligence-filter{% if filter.key == 'all' %} is-active{% endif %}" data-domain-filter="{{ filter.key }}">{{ filter.label }}</button>
    {% endfor %}
  </nav>

  <div class="stitch-intelligence-grid-wrap stitch-reveal">
    <div class="stitch-intelligence-ambient stitch-intelligence-ambient--primary" aria-hidden="true"></div>
    <div class="stitch-intelligence-ambient stitch-intelligence-ambient--secondary" aria-hidden="true"></div>
    <div class="stitch-intelligence-ambient stitch-intelligence-ambient--tertiary" aria-hidden="true"></div>

    <div id="intelligence-artifacts-grid" class="stitch-intelligence-grid">
      {% for post in site.posts %}
        {% if post.slug == featured_slug %}
          {% include intelligence-artifact-card.html post=post featured=true image=ip.featured.image %}
          {% assign feed_index = feed_index | plus: 1 %}
        {% endif %}
      {% endfor %}

      {% for post in site.posts %}
        {% unless post.slug == featured_slug %}
          {% include intelligence-artifact-card.html post=post %}
          {% assign feed_index = feed_index | plus: 1 %}
          {% assign feed_mod = feed_index | modulo: feed_interval %}
          {% if feed_mod == 0 %}
            {% include adsense-in-feed-row.html %}
          {% endif %}
        {% endunless %}
      {% endfor %}
    </div>
  </div>

  <div class="stitch-intelligence-footer-action stitch-reveal">
    <a class="stitch-intelligence-load-more" href="{{ ip.footer_action.url | relative_url }}">{{ ip.footer_action.label }}</a>
  </div>

</div>
