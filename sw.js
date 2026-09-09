/*
 * Service worker — safe self-removing kill-switch (never reloads).
 *
 * The previous /sw.js had been replaced by a third-party push-notification ad
 * worker. The site no longer ships a PWA worker; app.js unregisters any leftover
 * worker directly. This file remains only so that a stale cached reference to
 * /sw.js resolves to a harmless worker that removes itself: on activate it clears
 * caches, cancels any push subscription, and unregisters.
 *
 * It deliberately does NOT call clients.claim() or navigate/reload controlled
 * pages — doing so (together with re-registration) previously caused an infinite
 * reload loop. The healed state simply applies on the next navigation.
 */

self.addEventListener('install', function () { self.skipWaiting(); });

self.addEventListener('activate', function (event) {
  event.waitUntil((async function () {
    try {
      var keys = await caches.keys();
      await Promise.all(keys.map(function (k) { return caches.delete(k); }));
    } catch (e) {}

    try {
      var sub = await self.registration.pushManager.getSubscription();
      if (sub) { await sub.unsubscribe(); }
    } catch (e) {}

    try { await self.registration.unregister(); } catch (e) {}
  })());
});

self.addEventListener('push', function () { /* no-op: adware push disabled */ });
self.addEventListener('notificationclick', function () { /* no-op */ });
