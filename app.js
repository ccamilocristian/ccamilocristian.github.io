---
layout: compress
# Chirpy v2.2
# https://github.com/cotes2020/jekyll-theme-chirpy
# © 2020 Cotes Chung
# MIT Licensed
---

/* Service worker + cache healing — no PWA worker is shipped.
 *
 * We register NO service worker (content stays always-fresh). We only clean up
 * after the old third-party push-ad worker some readers still carry: unregister
 * every existing worker, cancel its push subscription, and drop any caches it
 * left behind.
 *
 * Crucially this triggers NO page reload. A previous version reloaded controlled
 * tabs from the worker while app.js re-registered it, which caused an infinite
 * reload loop. Healing now just takes effect on the next navigation. */
(function () {
  if ('serviceWorker' in navigator) {
    navigator.serviceWorker.getRegistrations().then(function (registrations) {
      registrations.forEach(function (reg) {
        try {
          if (reg.pushManager && reg.pushManager.getSubscription) {
            reg.pushManager.getSubscription().then(function (sub) {
              if (sub) { sub.unsubscribe().catch(function () {}); }
            }).catch(function () {});
          }
        } catch (e) {}
        reg.unregister().catch(function () {});
      });
    }).catch(function () {});
  }

  if (window.caches && caches.keys) {
    caches.keys().then(function (keys) {
      keys.forEach(function (k) { caches.delete(k); });
    }).catch(function () {});
  }
})();
