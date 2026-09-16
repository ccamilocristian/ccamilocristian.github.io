import { defineUnlighthouseConfig } from "unlighthouse/config";

/**
 * Site-wide Lighthouse SEO / a11y / performance scan.
 * Run: npm run seo:unlighthouse
 * Docs: docs/SEO_TOOLING.md
 */
export default defineUnlighthouseConfig({
  site: "https://ccamilocristian.github.io",
  scanner: {
    // Prefer sitemap discovery (38 URLs) over unbounded crawl.
    sitemap: true,
    robotsTxt: true,
    maxRoutes: 50,
    // Skip thin / utility routes that inflate noise.
    ignore: [
      "/norobots",
      "/404",
      "/page2",
      "/tags/",
      "/categories/",
      "/assets/",
    ],
  },
  ci: {
    budget: {
      // Soft floors — raise once Core Web Vitals stabilize.
      performance: 50,
      accessibility: 80,
      "best-practices": 70,
      seo: 85,
    },
  },
});
