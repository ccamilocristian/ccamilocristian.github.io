/**
 * GA4-ready custom events via dataLayer (GTM picks these up after publish).
 * outbound_click — external links from post/page content
 * site_search — SimpleJekyllSearch result selection
 */
(function () {
  'use strict';

  function pushEvent(name, params) {
    window.dataLayer = window.dataLayer || [];
    window.dataLayer.push(Object.assign({ event: name }, params || {}));
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
