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

  <section class="stitch-intelligence-start-here stitch-reveal" aria-labelledby="intelligence-start-here">
    <h2 id="intelligence-start-here">Start here</h2>
    <p class="stitch-intelligence-lead">Canonical English artifacts organized by the decision or system they help build.</p>
    <h3>Economics and Colombia</h3>
    <ul class="stitch-intelligence-start-list">
      <li><a href="{{ '/posts/colombia-cpi-indexation-engine-english/' | relative_url }}">Colombia CPI indexation engine with a monthly audit trail</a></li>
      <li><a href="{{ '/posts/real-cost-of-credit-colombia-english/' | relative_url }}">Real cost of credit: amortization, Fisher, and CPI</a></li>
      <li><a href="{{ '/posts/convertidor-english/' | relative_url }}">Original Colombia CPI / IPC calculator (Python)</a></li>
      <li><a href="{{ '/posts/loan-simulator-english/' | relative_url }}">Loan interest and amortization simulator</a></li>
      <li><a href="{{ '/posts/optimation-consumer-english/' | relative_url }}">Consumer optimization under a budget constraint</a></li>
    </ul>
    <h3>Python systems</h3>
    <ul class="stitch-intelligence-start-list">
      <li><a href="{{ '/posts/music-player-english/' | relative_url }}">Music player with tkinter &amp; pygame</a></li>
      <li><a href="{{ '/posts/automation-sending/' | relative_url }}">Scheduled email delivery with Python</a></li>
      <li><a href="{{ '/posts/icfes-english/' | relative_url }}">ICFES API → BigQuery pipeline</a></li>
      <li><a href="{{ '/posts/mcp-bigquery-server-python-english/' | relative_url }}">MCP server for BigQuery</a></li>
      <li><a href="{{ '/posts/local-rag-ollama-python-english/' | relative_url }}">Local RAG with Ollama</a></li>
    </ul>
  </section>

  <div class="stitch-intelligence-footer-action stitch-reveal">
    <a class="stitch-intelligence-load-more" href="{{ ip.footer_action.url | relative_url }}">{{ ip.footer_action.label }}</a>
  </div>

</div>
