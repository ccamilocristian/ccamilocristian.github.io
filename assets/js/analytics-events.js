/**
 * GA4 custom events — dual path:
 * 1) dataLayer push (GTM custom-event tags)
 * 2) gtag('event', …) when available (direct GA4; survives paused Google Tag)
 *
 * outbound_click — external links
 * site_search — SimpleJekyllSearch result selection
 */
(function () {
  'use strict';

  function pushEvent(name, params) {
    var payload = params || {};
    window.dataLayer = window.dataLayer || [];
    window.dataLayer.push(Object.assign({ event: name }, payload));
    if (typeof window.gtag === 'function') {
      try {
        window.gtag('event', name, payload);
      } catch (e) { /* noop */ }
    }
  }

  function isExternal(href) {
    if (!href || href.indexOf('http') !== 0) return false;
    try {
      var link = new URL(href);
      return link.hostname !== window.location.hostname;
    } catch (e) {
      return false;
    }
  }

  function onOutboundClick(e) {
    var anchor = e.target.closest('a[href]');
    if (!anchor || !isExternal(anchor.href)) return;
    pushEvent('outbound_click', {
      link_url: anchor.href,
      link_text: (anchor.textContent || '').trim().slice(0, 100),
      page_path: window.location.pathname
    });
  }

  function hookSiteSearch() {
    var input = document.getElementById('search-input');
    var results = document.getElementById('search-results');
    if (!results) return;

    results.addEventListener('click', function (e) {
      var anchor = e.target.closest('a[href]');
      if (!anchor) return;
      var query = input ? (input.value || '').trim() : '';
      pushEvent('site_search', {
        search_term: query,
        link_url: anchor.href,
        page_path: window.location.pathname
      });
    });
  }

  document.addEventListener('click', onOutboundClick, true);
  if (document.readyState === 'loading') {
    document.addEventListener('DOMContentLoaded', hookSiteSearch);
  } else {
    hookSiteSearch();
  }
})();
