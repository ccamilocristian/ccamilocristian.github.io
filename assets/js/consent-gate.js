(function () {
  'use strict';

  var root = document.documentElement;
  var cmpActive = root.getAttribute('data-cmp-active') === 'true';
  var queues = { analytics: [], advertisement: [] };

  function readCategories() {
    if (window.__ckyConsentSnapshot && window.__ckyConsentSnapshot.categories) {
      return window.__ckyConsentSnapshot.categories;
    }
    if (typeof getCkyConsent === 'function') {
      try {
        var data = getCkyConsent();
        if (data && data.categories) return data.categories;
      } catch (e) { /* noop */ }
    }
    return null;
  }

  function cookieYesGrantedFromCookie(category) {
    var raw = document.cookie || '';
    if (category === 'advertisement') {
      return /advertisement:\s*yes/i.test(raw) || /"advertisement"\s*:\s*true/.test(raw);
    }
    if (category === 'analytics') {
      return /analytics:\s*yes/i.test(raw) || /"analytics"\s*:\s*true/.test(raw);
    }
    return false;
  }

  function cookieYesGranted(category) {
    var cats = readCategories();
    if (cats) {
      if (category === 'analytics') return !!cats.analytics;
      if (category === 'advertisement') return !!cats.advertisement;
    }
    if (cookieYesGrantedFromCookie(category)) return true;
    if (typeof cookieyes !== 'undefined' && cookieyes.consent) {
      return !!cookieyes.consent[category];
    }
    return false;
  }

  function cookiebotGranted(category) {
    if (typeof Cookiebot === 'undefined' || !Cookiebot.consent) return false;
    if (category === 'analytics') return Cookiebot.consent.statistics;
    if (category === 'advertisement') return Cookiebot.consent.marketing;
    return false;
  }

  function granted(category) {
    if (!cmpActive) return true;
    return cookieYesGranted(category) || cookiebotGranted(category);
  }

  function runQueue(category) {
    var pending = queues[category];
    if (!pending.length) return;
    queues[category] = [];
    pending.forEach(function (fn) {
      try { fn(); } catch (e) { /* noop */ }
    });
  }

  function sync() {
    if (granted('analytics')) runQueue('analytics');
    if (granted('advertisement')) runQueue('advertisement');
  }

  function on(category, fn) {
    if (typeof fn !== 'function') return;
    if (!cmpActive || granted(category)) {
      fn();
      return;
    }
    queues[category].push(fn);
  }

  document.addEventListener('cookieyes_banner_load', sync);
  document.addEventListener('cookieyes_consent_update', sync);
  window.addEventListener('CookiebotOnAccept', sync);
  window.addEventListener('CookiebotOnDecline', sync);
  window.addEventListener('CookiebotOnLoad', sync);

  if (cmpActive) {
    var attempts = 0;
    var timer = setInterval(function () {
      attempts += 1;
      sync();
      if (attempts > 120) clearInterval(timer);
    }, 250);
  }

  window.siteConsentGate = { on: on, cmpActive: cmpActive, sync: sync };
  sync();
})();
