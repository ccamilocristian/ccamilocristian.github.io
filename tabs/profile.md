---
title: Profile
permalink: /tabs/profile/
redirect_from:
  - /tabs/hoja-de-vida/
  - /tabs/Hoja de vida/
  - /tabs/Hoja%20de%20vida/
  - /tabs/about/
tab_active: Profile
breadcrumb:
  -
    label: Command Center
    url: /
---

{% assign p = site.data.profile %}

<div class="stitch-tab-page stitch-profile-page dashboard-page dashboard-page--profile">

  <header class="stitch-profile-header stitch-reveal" aria-label="Profile introduction">
    <div class="stitch-profile-header-copy">
      <p class="stitch-eyebrow stitch-profile-eyebrow">{{ p.hero.eyebrow }}</p>
      <h1>{{ p.hero.title }}</h1>
      {% if p.hero.name %}
      <p class="stitch-profile-name">{{ p.hero.name }}</p>
      {% endif %}
      {% if p.hero.headline %}
      <p class="stitch-profile-headline">{{ p.hero.headline }}</p>
      {% endif %}
      {% if p.hero.location %}
      <p class="stitch-profile-location">{{ p.hero.location }}</p>
      {% endif %}
    </div>
    {% if p.hero.photo %}
    <figure class="stitch-profile-photo">
      <img src="{{ p.hero.photo | relative_url }}" alt="{{ p.hero.photo_alt | default: site.author }}" width="320" height="385" loading="eager" decoding="async">
    </figure>
    {% endif %}
  </header>

  <section class="stitch-profile-contact stitch-reveal" aria-label="Contact snapshot">
    <div class="stitch-profile-contact-grid">
      <article class="profile-credential-card card-glass">
        <h2 class="profile-credential-label">Contact</h2>
        <ul class="profile-credential-list">
          {% if p.identity.email %}
          <li><a href="mailto:{{ p.identity.email }}">{{ p.identity.email }}</a></li>
          {% endif %}
          {% if p.identity.linkedin %}
          <li><a href="{{ p.identity.linkedin }}" rel="noopener noreferrer">LinkedIn profile</a></li>
          {% endif %}
        </ul>
      </article>

      <article class="profile-credential-card card-glass">
        <h2 class="profile-credential-label">Languages</h2>
        <ul class="profile-credential-list">
          {% for lang in p.languages %}
          <li><strong>{{ lang.name }}</strong> — {{ lang.level }}</li>
          {% endfor %}
        </ul>
      </article>

      <article class="profile-credential-card card-glass profile-credential-card--wide">
        <h2 class="profile-credential-label">Top skills</h2>
        <p class="profile-skills-text">
          {% for skill in p.top_skills %}{{ skill }}{% unless forloop.last %}, {% endunless %}{% endfor %}.
        </p>
      </article>
    </div>
  </section>

  <section class="stitch-profile-exec stitch-reveal" aria-label="Executive summary">
    <div class="stitch-profile-exec-summary">
      <h2 class="stitch-profile-block-label">Executive Summary</h2>
      <p class="stitch-profile-exec-lead">{{ p.executive_summary }}</p>
    </div>
    <div class="stitch-profile-exec-principles">
      <h2 class="stitch-profile-block-label">Operating Principles</h2>
      <ul class="stitch-profile-principles">
        {% for principle in p.operating_principles %}
        <li class="stitch-profile-principle">{{ principle }}</li>
        {% endfor %}
      </ul>
    </div>
  </section>

  <section class="stitch-profile-pillars-section" aria-label="Expertise pillars">
    <h2 class="stitch-profile-block-label stitch-reveal">Expertise Pillars</h2>
    <div class="stitch-profile-pillars-list">
      {% for pillar in p.expertise_pillars %}
      <article class="pillar-card pillar-card--{{ pillar.glow | default: 'primary' }} stitch-reveal">
        <div class="pillar-card-layout">
          <div class="pillar-card-copy">
            <span class="pillar-card-index">{{ pillar.index }}</span>
            <h3 class="pillar-card-title">{{ pillar.title }}</h3>
            <p class="pillar-card-summary">{{ pillar.summary }}</p>
            {% if pillar.highlights %}
            <ul class="pillar-card-highlights">
              {% for item in pillar.highlights %}
              <li>{{ item }}</li>
              {% endfor %}
            </ul>
            {% endif %}
          </div>
          <div class="pillar-card-meta">
            <div class="pillar-card-meta-grid">
              <div>
                <span class="pillar-card-meta-label">Focus</span>
                <span class="pillar-card-meta-value">{{ pillar.focus }}</span>
              </div>
              <div>
                <span class="pillar-card-meta-label">Stack</span>
                <span class="pillar-card-meta-value">{{ pillar.stack }}</span>
              </div>
            </div>
          </div>
        </div>
      </article>
      {% endfor %}
    </div>
  </section>

  <section class="stitch-profile-career" aria-label="Career path">
    <h2 class="stitch-profile-block-label stitch-reveal">Career Path</h2>
    <ol class="stitch-profile-timeline">
      {% for entry in p.career_path %}
      <li class="timeline-item stitch-reveal{% if entry.current %} timeline-item--current{% endif %}">
        <div class="timeline-item-head">
          <div>
            <h3 class="timeline-item-headline">{{ entry.headline }}</h3>
            <p class="timeline-item-role">{{ entry.role }}</p>
            {% if entry.location %}
            <p class="timeline-item-location">{{ entry.location }}</p>
            {% endif %}
          </div>
          <span class="timeline-item-period">{{ entry.period }}</span>
        </div>
        <p class="timeline-item-summary">{{ entry.summary }}</p>
        {% if entry.highlights %}
        <ul class="timeline-item-highlights">
          {% for item in entry.highlights %}
          <li>{{ item }}</li>
          {% endfor %}
        </ul>
        {% endif %}
      </li>
      {% endfor %}
    </ol>
  </section>

  <section class="stitch-profile-credentials stitch-reveal" aria-label="Education and certifications">
    <div class="stitch-profile-credentials-grid">
      <article class="profile-credential-panel card-glass">
        <h2 class="stitch-profile-block-label">Education</h2>
        <ul class="profile-education-list">
          {% for item in p.education %}
          <li class="profile-education-item">
            <h3 class="profile-education-degree">{{ item.degree }}</h3>
            <p class="profile-education-school">{{ item.school }} · {{ item.period }}</p>
            {% if item.note %}
            <p class="profile-education-note">{{ item.note }}</p>
            {% endif %}
          </li>
          {% endfor %}
        </ul>
      </article>

      <article class="profile-credential-panel card-glass">
        <h2 class="stitch-profile-block-label">Certifications</h2>
        <ul class="profile-cert-list">
          {% for cert in p.certifications %}
          <li>{{ cert }}</li>
          {% endfor %}
        </ul>
      </article>
    </div>
  </section>

  {% if p.publications %}
  <section class="stitch-profile-publications stitch-reveal" aria-label="Publications">
    <h2 class="stitch-profile-block-label">Publications</h2>
    {% for pub in p.publications %}
    <article class="profile-publication-card card-glass">
      <div class="profile-publication-main">
        <h3 class="profile-publication-title">{{ pub.title }}</h3>
        <p class="profile-publication-meta">{{ pub.publisher }} · {{ pub.date }}</p>
        {% if pub.abstract %}
        <p class="profile-publication-abstract">{{ pub.abstract }}</p>
        {% endif %}
      </div>
      {% if pub.url %}
      <div class="profile-publication-action">
        <a class="profile-publication-link btn-stitch btn-stitch--glass" href="{{ pub.url }}" rel="noopener noreferrer">{{ pub.link_label | default: "View publication" }}</a>
      </div>
      {% endif %}
    </article>
    {% endfor %}
  </section>
  {% endif %}

  <section class="stitch-profile-cta stitch-reveal" aria-label="Contact">
    <h2>{{ p.cta.title }}</h2>
    <div class="stitch-profile-cta-actions">
      <a class="stitch-profile-cta-primary" href="mailto:{{ p.identity.email | default: site.social.email }}">{{ p.cta.primary.label }}</a>
      <a class="stitch-profile-cta-secondary" href="{{ p.identity.linkedin }}" rel="noopener noreferrer">{{ p.cta.secondary.label }}</a>
    </div>
    {% if p.explore.links %}
    <nav class="stitch-profile-cta-more" aria-label="Explore more">
      {% for link in p.explore.links %}
      <a class="stitch-link-mono" href="{{ link.url | relative_url }}">{{ link.label }} →</a>
      {% endfor %}
    </nav>
    {% endif %}
  </section>

</div>
