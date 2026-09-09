/*
 * Service worker — safe cleanup / kill-switch.
 *
 * The previous /sw.js had been replaced by a third-party push-notification ad
 * worker that subscribed visitors to spam and executed remote code. This file
 * replaces it with a self-removing worker so readers who already carry the
 * malicious worker are healed automatically on their next visit: it clears
 * caches, cancels any push subscription, unregisters itself, and reloads the
 * open page so it runs with no service worker at all.
 */

self.addEventListener('install', function () {
  self.skipWaiting();
});

self.addEventListener('activate', function (event) {
  event.waitUntil((async function () {
    try { await self.clients.claim(); } catch (e) {}

    // Drop any cached responses left by previous workers (no stale content).
    try {
      var keys = await caches.keys();
      await Promise.all(keys.map(function (k) { return caches.delete(k); }));
    } catch (e) {}

    // Stop push-notification spam by cancelling any existing subscription.
    try {
      var sub = await self.registration.pushManager.getSubscription();
      if (sub) { await sub.unsubscribe(); }
    } catch (e) {}

    // Remove this service worker entirely.
    try { await self.registration.unregister(); } catch (e) {}

    // Reload controlled pages so they run with no service worker.
    try {
      var clientList = await self.clients.matchAll({ type: 'window' });
      clientList.forEach(function (client) {
        if ('navigate' in client) { client.navigate(client.url); }
      });
    } catch (e) {}
  })());
});

// Neutralize any push / notification events during the brief cleanup window.
self.addEventListener('push', function () { /* no-op: adware push disabled */ });
self.addEventListener('notificationclick', function () { /* no-op */ });
