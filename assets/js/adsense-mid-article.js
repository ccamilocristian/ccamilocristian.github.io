(function () {
  'use strict';

  var mount = document.getElementById('ad-mid-article-mount');
  if (!mount) return;

  var article = document.querySelector('.stitch-post-content, .post-content');
  if (!article) {
    mount.remove();
    return;
  }

  var h2s = article.querySelectorAll('h2');
  if (h2s.length < 2) {
    mount.remove();
    return;
  }

  var slotEl = mount.querySelector('.ad-slot');
  if (!slotEl) {
    mount.remove();
    return;
  }

  mount.removeChild(slotEl);
  mount.remove();

  var anchor = h2s[1];
  if (anchor.nextSibling) {
    anchor.parentNode.insertBefore(slotEl, anchor.nextSibling);
  } else {
    anchor.parentNode.appendChild(slotEl);
  }

  function watchFill() {
    var ins = slotEl.querySelector('.adsbygoogle');
    if (!ins) return;
    function check() {
      var status = ins.getAttribute('data-ad-status');
      if (status === 'unfilled') slotEl.classList.add('ad-slot--unfilled');
      if (status === 'filled') slotEl.classList.remove('ad-slot--unfilled');
    }
    if ('MutationObserver' in window) {
      var mo = new MutationObserver(check);
      mo.observe(ins, { attributes: true, attributeFilter: ['data-ad-status'] });
    }
    setTimeout(check, 4000);
  }

  function doPush() {
    try {
      (window.adsbygoogle = window.adsbygoogle || []).push({});
      watchFill();
    } catch (e) {
      slotEl.classList.add('ad-slot--failed');
    }
  }

  function pushAd() {
    if (window.adsbygoogle) {
      doPush();
      return;
    }
    var attempts = 0;
    var timer = setInterval(function () {
      attempts += 1;
      if (window.adsbygoogle || attempts > 50) {
        clearInterval(timer);
        doPush();
      }
    }, 100);
  }

  function start() {
    function tryGate() {
      if (window.siteConsentGate) {
        window.siteConsentGate.on('advertisement', pushAd);
        return;
      }
      if (document.documentElement.getAttribute('data-cmp-active') === 'true') {
        setTimeout(tryGate, 50);
        return;
      }
      pushAd();
    }
    tryGate();
  }

  if ('IntersectionObserver' in window) {
    var io = new IntersectionObserver(function (entries) {
      if (entries[0].isIntersecting) {
        start();
        io.disconnect();
      }
    }, { rootMargin: '200px' });
    io.observe(slotEl);
  } else {
    start();
  }
})();
