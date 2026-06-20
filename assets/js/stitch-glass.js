(function() {
  "use strict";

  var stitchShell = document.body.classList.contains("stitch-dashboard");
  if (!stitchShell) return;

  var reducedMotion = window.matchMedia("(prefers-reduced-motion: reduce)").matches;

  if (reducedMotion) {
    document.querySelectorAll(".metadata-chip").forEach(function(chip) {
      chip.classList.add("reveal");
    });
    document.querySelectorAll(".stitch-reveal").forEach(function(el) {
      el.classList.add("is-visible");
    });
  } else {
    document.querySelectorAll(".card-glass").forEach(function(card) {
      card.addEventListener("mousemove", function(e) {
        var rect = card.getBoundingClientRect();
        card.style.setProperty("--mouse-x", (e.clientX - rect.left) + "px");
        card.style.setProperty("--mouse-y", (e.clientY - rect.top) + "px");
      });
    });

    var observerOptions = { threshold: 0.1, rootMargin: "0px 0px -50px 0px" };
    var shimmerObserver = new IntersectionObserver(function(entries) {
      entries.forEach(function(entry) {
        if (!entry.isIntersecting) return;
        var chips = entry.target.querySelectorAll(".metadata-chip");
        chips.forEach(function(chip, index) {
          setTimeout(function() {
            chip.classList.add("reveal");
            chip.classList.add("shimmer");
            setTimeout(function() {
              chip.classList.remove("shimmer");
            }, 1500);
          }, index * 100);
        });
        shimmerObserver.unobserve(entry.target);
      });
    }, observerOptions);

    document.querySelectorAll(".card-glass, .stitch-animate-in").forEach(function(el) {
      shimmerObserver.observe(el);
    });

    var revealObserver = new IntersectionObserver(function(entries) {
      entries.forEach(function(entry) {
        if (!entry.isIntersecting) return;
        var parent = entry.target.parentElement;
        var siblings = parent ? Array.from(parent.children).filter(function(el) {
          return el.classList.contains("stitch-reveal");
        }) : [];
        var index = siblings.indexOf(entry.target);
        if (index >= 0) {
          entry.target.style.transitionDelay = (index * 0.1) + "s";
        }
        entry.target.classList.add("is-visible");
        revealObserver.unobserve(entry.target);
      });
    }, { threshold: 0.05, rootMargin: "0px 0px -80px 0px" });

    document.querySelectorAll(".stitch-reveal").forEach(function(el) {
      revealObserver.observe(el);
    });
  }

  var topbar = document.getElementById("topbar-wrapper");
  if (topbar) {
    window.addEventListener("scroll", function() {
      if (window.scrollY > 20) {
        topbar.style.backgroundColor = "rgba(15, 20, 28, 0.9)";
        topbar.style.boxShadow = "0 10px 30px rgba(0, 0, 0, 0.25)";
      } else {
        topbar.style.backgroundColor = "rgba(18, 19, 24, 0.8)";
        topbar.style.boxShadow = "none";
      }
    }, { passive: true });
  }
})();
