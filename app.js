---
layout: compress
# Chirpy v2.2
# https://github.com/cotes2020/jekyll-theme-chirpy
# © 2020 Cotes Chung
# MIT Licensed
---

/* Service worker cleanup.
 *
 * We no longer ship a PWA/precache worker (keeps content always fresh). We only
 * touch the service worker to remove any leftover registration — this heals
 * readers who still carry the old third-party push-ad worker — and we register
 * nothing new for clean visitors. */
if ('serviceWorker' in navigator) {
  navigator.serviceWorker.getRegistrations().then(function (registrations) {
    if (registrations && registrations.length) {
      // Point the existing registration at the self-removing /sw.js, which
      // clears caches, cancels push spam, and unregisters itself.
      navigator.serviceWorker.register('{{ "/sw.js" | relative_url }}');
    }
  }).catch(function () {});
}