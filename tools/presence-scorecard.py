#!/usr/bin/env python3
"""Generate a weekly search-presence scorecard from existing Google APIs.

Read-only. It never submits a sitemap or requests indexing.

Usage:
  uv run --with google-api-python-client --with google-auth \
    --with google-analytics-data python tools/presence-scorecard.py
"""
from __future__ import annotations

import csv
import json
import sys
from collections import Counter
from datetime import date, datetime, timedelta, timezone
from pathlib import Path

from google.analytics.data_v1beta import BetaAnalyticsDataClient
from google.analytics.data_v1beta.types import (
    DateRange,
    Dimension,
    Filter,
    FilterExpression,
    Metric,
    RunReportRequest,
)
from google.oauth2 import service_account
from googleapiclient.discovery import build

ROOT = Path(__file__).resolve().parents[1]
CREDS = Path.home() / "mcp_servers" / "google_creds.json"
SITE = "https://ccamilocristian.github.io/"
GA4_PROPERTY = "356406631"


def canonical_urls() -> list[str]:
    source = ROOT / "_data" / "gsc_index_urls.yml"
    urls: list[str] = []
    in_posts = False
    for raw_line in source.read_text().splitlines():
        if raw_line.startswith("all_en_posts:"):
            in_posts = True
            continue
        if in_posts and raw_line and not raw_line.startswith(" "):
            break
        line = raw_line.strip()
        if in_posts and line.startswith("- https://"):
            urls.append(line[2:])
    return urls


def classify_coverage(coverage: str) -> str:
    normalized = coverage.lower()
    if "unknown" in normalized:
        return "unknown"
    if "indexed" in normalized and "not indexed" not in normalized:
        return "indexed"
    if not coverage:
        return "error"
    return "known_not_indexed"


def gsc_data(credentials, urls: list[str], days: int = 28) -> dict:
    gsc = build("searchconsole", "v1", credentials=credentials)
    inspections = []
    for url in [SITE, f"{SITE}tabs/intelligence/", *urls]:
        try:
            response = (
                gsc.urlInspection()
                .index()
                .inspect(body={"inspectionUrl": url, "siteUrl": SITE})
                .execute()
            )
            status = (
                response.get("inspectionResult", {})
                .get("indexStatusResult", {})
            )
            coverage = status.get("coverageState", "")
            inspections.append(
                {
                    "url": url,
                    "coverage": coverage,
                    "state": classify_coverage(coverage),
                    "last_crawl": status.get("lastCrawlTime"),
                    "fetch": status.get("pageFetchState"),
                }
            )
        except Exception as error:  # API errors belong in the report
            inspections.append(
                {"url": url, "coverage": "", "state": "error", "error": str(error)}
            )

    end = date.today() - timedelta(days=3)  # GSC reporting lag
    start = end - timedelta(days=days - 1)

    def query(dimensions: list[str], row_limit: int = 250) -> list[dict]:
        response = (
            gsc.searchanalytics()
            .query(
                siteUrl=SITE,
                body={
                    "startDate": start.isoformat(),
                    "endDate": end.isoformat(),
                    "dimensions": dimensions,
                    "rowLimit": row_limit,
                },
            )
            .execute()
        )
        return response.get("rows", [])

    pages = []
    canonical_set = set(urls)
    for row in query(["page"]):
        page = row["keys"][0]
        path = page.removeprefix(SITE.rstrip("/"))
        if page in canonical_set:
            language_group = "en_canonical"
        elif path.startswith("/posts/"):
            language_group = "legacy_or_other"
        else:
            language_group = "hub"
        pages.append(
            {
                "page": page,
                "group": language_group,
                "clicks": row.get("clicks", 0),
                "impressions": row.get("impressions", 0),
                "ctr": row.get("ctr", 0),
                "position": row.get("position", 0),
            }
        )

    keywords = [
        {
            "query": row["keys"][0],
            "clicks": row.get("clicks", 0),
            "impressions": row.get("impressions", 0),
            "ctr": row.get("ctr", 0),
            "position": row.get("position", 0),
        }
        for row in query(["query"], row_limit=100)
    ]
    return {
        "period": {"start": start.isoformat(), "end": end.isoformat()},
        "inspections": inspections,
        "pages": pages,
        "keywords": keywords,
    }


def ga4_data(credentials, days: int = 28) -> dict:
    client = BetaAnalyticsDataClient(credentials=credentials)
    country_filter = FilterExpression(
        not_expression=FilterExpression(
            filter=Filter(
                field_name="country",
                string_filter=Filter.StringFilter(value="Singapore"),
            )
        )
    )
    request = RunReportRequest(
        property=f"properties/{GA4_PROPERTY}",
        dimensions=[Dimension(name="landingPagePlusQueryString")],
        metrics=[
            Metric(name="sessions"),
            Metric(name="engagedSessions"),
            Metric(name="userEngagementDuration"),
        ],
        date_ranges=[DateRange(start_date=f"{days}daysAgo", end_date="yesterday")],
        dimension_filter=country_filter,
        limit=100,
    )
    response = client.run_report(request)
    rows = []
    for row in response.rows:
        landing = row.dimension_values[0].value
        if landing.startswith("/posts/"):
            rows.append(
                {
                    "landing_page": landing,
                    "sessions": int(row.metric_values[0].value),
                    "engaged_sessions": int(row.metric_values[1].value),
                    "engagement_seconds": float(row.metric_values[2].value),
                }
            )
    return {
        "filter": "country != Singapore",
        "note": "Behavior diagnostic; this is not an indexation metric.",
        "post_landings": rows,
    }


def distribution_data() -> dict:
    path = ROOT / "docs" / "distribution-log.csv"
    if not path.exists():
        return {"published_or_earned": 0, "new_source_urls": 0, "rows": []}
    with path.open(newline="") as handle:
        rows = list(csv.DictReader(handle))
    active = [row for row in rows if row.get("status") in {"published", "earned"}]
    sources = {row["source_url"] for row in active if row.get("source_url")}
    return {
        "published_or_earned": len(active),
        "new_source_urls": len(sources),
        "rows": rows,
    }


def render_markdown(report: dict) -> str:
    counts = Counter(row["state"] for row in report["gsc"]["inspections"])
    posts = len(report["inventory"]["canonical_en_posts"])
    unknown_posts = sum(
        row["state"] == "unknown"
        for row in report["gsc"]["inspections"]
        if row["url"] in report["inventory"]["canonical_en_posts"]
    )
    known_pct = round(100 * (posts - unknown_posts) / posts, 1) if posts else 0

    group_totals: dict[str, dict[str, float]] = {}
    for row in report["gsc"]["pages"]:
        totals = group_totals.setdefault(row["group"], {"clicks": 0, "impressions": 0})
        totals["clicks"] += row["clicks"]
        totals["impressions"] += row["impressions"]

    lines = [
        f"# Presence scorecard — {report['generated'][:10]}",
        "",
        "## Indexation",
        "",
        f"- Canonical EN posts tracked: {posts}",
        f"- Known post URLs: {known_pct}%",
        f"- All inspected states: {dict(counts)}",
        "",
        "## GSC performance",
        "",
        f"Period: {report['gsc']['period']['start']} to {report['gsc']['period']['end']}.",
        "",
        "| Group | Clicks | Impressions |",
        "|---|---:|---:|",
    ]
    for group, totals in sorted(group_totals.items()):
        lines.append(f"| {group} | {totals['clicks']:.0f} | {totals['impressions']:.0f} |")
    lines.extend(
        [
            "",
            "## GA4 human proxy",
            "",
            f"Filter: `{report['ga4']['filter']}`. Sessions remain a behavior metric.",
            f"Post landing rows: {len(report['ga4']['post_landings'])}.",
            "",
            "## Distribution",
            "",
            f"- Published or earned entries: {report['distribution']['published_or_earned']}",
            f"- Distinct source URLs: {report['distribution']['new_source_urls']}",
            "",
            "Review changes week over week; do not re-request indexing from this report.",
        ]
    )
    return "\n".join(lines) + "\n"


def main() -> int:
    if not CREDS.exists():
        print(f"[ERROR] Missing credentials: {CREDS}", file=sys.stderr)
        return 1

    urls = canonical_urls()
    credentials = service_account.Credentials.from_service_account_file(
        str(CREDS),
        scopes=[
            "https://www.googleapis.com/auth/webmasters.readonly",
            "https://www.googleapis.com/auth/analytics.readonly",
        ],
    )
    report = {
        "generated": datetime.now(timezone.utc).isoformat(),
        "inventory": {"canonical_en_posts": urls},
        "gsc": gsc_data(credentials, urls),
        "ga4": ga4_data(credentials),
        "distribution": distribution_data(),
    }

    stamp = datetime.now(timezone.utc).strftime("%Y-%m-%d")
    json_path = ROOT / "docs" / f"PRESENCE_SCORECARD_{stamp}.json"
    md_path = ROOT / "docs" / f"PRESENCE_SCORECARD_{stamp}.md"
    json_path.write_text(json.dumps(report, indent=2) + "\n")
    md_path.write_text(render_markdown(report))
    print(f"[WROTE] {json_path}")
    print(f"[WROTE] {md_path}")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
