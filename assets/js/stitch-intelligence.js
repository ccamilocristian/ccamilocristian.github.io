(function() {
  "use strict";

  var page = document.querySelector(".stitch-intelligence-page");
  if (!page) return;

  var grid = document.getElementById("intelligence-artifacts-grid");
  var cards = grid ? Array.from(grid.querySelectorAll(".intelligence-card")) : [];
  var searchInput = document.getElementById("intelligence-filter-input");
  var filterButtons = Array.from(page.querySelectorAll("[data-domain-filter]"));
  var activeDomain = "all";

  function normalize(text) {
    return (text || "").toLowerCase().trim();
  }

  function applyFilters() {
    var query = searchInput ? normalize(searchInput.value) : "";

    cards.forEach(function(card) {
      var domain = card.getAttribute("data-domain") || "";
      var haystack = normalize(card.textContent);
      var domainOk = activeDomain === "all" || domain === activeDomain;
      var textOk = !query || haystack.indexOf(query) !== -1;
      card.classList.toggle("is-hidden", !(domainOk && textOk));
    });
  }

  filterButtons.forEach(function(btn) {
    btn.addEventListener("click", function() {
      activeDomain = btn.getAttribute("data-domain-filter") || "all";
      filterButtons.forEach(function(b) {
        b.classList.toggle("is-active", b === btn);
      });
      applyFilters();
    });
  });

  if (searchInput) {
    searchInput.addEventListener("input", applyFilters);
  }

  if (!window.matchMedia("(prefers-reduced-motion: reduce)").matches) {
    var ambients = page.querySelectorAll(".stitch-intelligence-ambient");
    document.addEventListener("mousemove", function(e) {
      var x = e.clientX / window.innerWidth;
      var y = e.clientY / window.innerHeight;
      ambients.forEach(function(glow, index) {
        var speed = (index + 1) * 12;
        glow.style.transform = "translate(" + (x * speed) + "px, " + (y * speed) + "px)";
      });
    }, { passive: true });
  }
})();
