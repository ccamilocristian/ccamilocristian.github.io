#!/usr/bin/env python3
"""On-page SEO guards for verify-seo-security.sh (stdlib only).

Hard fail (exit 1): published post builds with robots noindex, missing title/description,
sitemap/post-page mismatch, broken front-matter YAML (unquoted colon), or dated-path
fallback builds (permalink regression like credit 404).

Soft warn (exit 0 unless SEO_STRICT=1): title > 60 chars, description outside 140–160.
"""
from __future__ import annotations

import os
import re
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
DEST = ROOT / "_site"
POSTS = ROOT / "_posts"
STRICT = os.environ.get("SEO_STRICT", "").strip() in {"1", "true", "yes"}

FAIL = 0
WARN = 0

# Scalars that often embed ":" (e.g. "Topic: subtitle") and must be quoted in YAML.
_COLON_SCALAR_KEYS = (
    "title",
    "description",
    "impact_label",
    "business_impact",
    "excerpt",
)
# Unquoted scalar that still contains a colon → YAML "mapping values not allowed".
_UNQUOTED_COLON = re.compile(
    r"^("
    + "|".join(_COLON_SCALAR_KEYS)
    + r"):\s+(?!['\"|>\[{])([^#\n]*:\s*[^#\n]+)\s*$"
)


def pass_(msg: str) -> None:
    print(f"  \033[32mPASS\033[0m {msg}")


def fail(msg: str) -> None:
    global FAIL
    FAIL = 1
    print(f"  \033[31mFAIL\033[0m {msg}")


def warn(msg: str) -> None:
    global WARN, FAIL
    WARN += 1
    print(f"  \033[33mWARN\033[0m {msg}")
    if STRICT:
        FAIL = 1


def parse_fm(text: str) -> dict[str, str]:
    if not text.startswith("---"):
        return {}
    end = text.find("\n---", 3)
    if end < 0:
        return {}
    block = text[3:end]
    meta: dict[str, str] = {}
    key = None
    for line in block.splitlines():
        if re.match(r"^[A-Za-z0-9_]+:", line):
            key, _, raw = line.partition(":")
            meta[key.strip()] = raw.strip().strip('"').strip("'")
        elif key and line.startswith("  "):
            meta[key] = (meta.get(key, "") + " " + line.strip()).strip()
    return meta


def fm_block(text: str) -> str:
    if not text.startswith("---"):
        return ""
    end = text.find("\n---", 3)
    if end < 0:
        return ""
    return text[3:end]


def is_published(meta: dict[str, str]) -> bool:
    return meta.get("published", "true").lower() != "false"


def slug_from_post(path: Path) -> str:
    name = path.stem
    return re.sub(r"^\d{4}-\d{2}-\d{2}-", "", name)


def check_unquoted_colons(path: Path, text: str) -> None:
    block = fm_block(text)
    for i, line in enumerate(block.splitlines(), start=2):  # line 1 is ---
        m = _UNQUOTED_COLON.match(line)
        if m:
            fail(
                f"{path.name}:{i}: unquoted '{m.group(1)}:' contains a colon — "
                f'quote it (e.g. {m.group(1)}: "…") or Jekyll may mis-route the permalink'
            )


def main() -> int:
    if not DEST.is_dir():
        fail(f"missing {DEST}")
        return 1

    sitemap = (DEST / "sitemap.xml").read_text(encoding="utf-8", errors="replace")
    sitemap_locs = set(re.findall(r"<loc>([^<]+)</loc>", sitemap))
    post_locs = {u for u in sitemap_locs if "/posts/" in u}
    expected_min = 20
    if len(post_locs) < expected_min:
        fail(f"sitemap has only {len(post_locs)} post URLs (expected ≥{expected_min})")
    else:
        pass_(f"sitemap lists {len(post_locs)} post URLs ({len(sitemap_locs)} total)")

    # Front-matter YAML traps (credit 404: title with unquoted ":")
    yaml_ok = 0
    for path in sorted(POSTS.glob("*.md")):
        text = path.read_text(encoding="utf-8", errors="replace")
        meta = parse_fm(text)
        if not is_published(meta):
            continue
        before = FAIL
        check_unquoted_colons(path, text)
        if FAIL == before:
            yaml_ok += 1
    if yaml_ok and FAIL == 0:
        pass_(f"no unquoted colon traps in {yaml_ok} published post front matters")

    noindex_hits: list[str] = []
    dated_fallback: list[str] = []
    published_slugs: list[str] = []
    for path in sorted(POSTS.glob("*.md")):
        meta = parse_fm(path.read_text(encoding="utf-8", errors="replace"))
        if not is_published(meta):
            continue
        slug = slug_from_post(path)
        published_slugs.append(slug)
        html = DEST / "posts" / slug / "index.html"
        dated_html = DEST / "posts" / path.stem / "index.html"
        # Broken FM → Jekyll may emit /posts/<full-filename-with-date>/ instead of slug.
        if dated_html.is_file() and not html.is_file():
            dated_fallback.append(path.name)
        if not html.is_file():
            continue
        text = html.read_text(encoding="utf-8", errors="replace")
        if re.search(
            r'name=["\']robots["\'][^>]*content=["\'][^"\']*noindex|'
            r'content=["\'][^"\']*noindex[^"\']*["\'][^>]*name=["\']robots["\']',
            text,
            re.I,
        ):
            noindex_hits.append(f"posts/{slug}/")
    if dated_fallback:
        fail(
            "published posts built under dated path (likely broken YAML front matter): "
            + ", ".join(dated_fallback[:8])
        )
    else:
        pass_("no dated-path permalink fallbacks for published posts")
    if noindex_hits:
        fail(f"published post HTML has noindex: {', '.join(noindex_hits[:8])}")
    else:
        pass_(f"no robots noindex on {len(published_slugs)} published post builds")
    title_long = 0
    desc_bad = 0
    missing = 0
    published = 0
    for path in sorted(POSTS.glob("*.md")):
        meta = parse_fm(path.read_text(encoding="utf-8", errors="replace"))
        if not is_published(meta):
            continue
        published += 1
        slug = slug_from_post(path)
        built = DEST / "posts" / slug / "index.html"
        if not built.is_file():
            fail(f"published post missing build output: posts/{slug}/")
            missing += 1
            continue
        if not any(slug in u for u in post_locs):
            fail(f"sitemap missing published post {slug}")

        title = meta.get("title", "")
        desc = meta.get("description", "")
        if not title:
            fail(f"{path.name}: missing title")
            missing += 1
        elif len(title) > 60:
            warn(f"{path.name}: title {len(title)} chars (>60)")
            title_long += 1
        if not desc:
            fail(f"{path.name}: missing description")
            missing += 1
        elif not (140 <= len(desc) <= 160):
            warn(f"{path.name}: description {len(desc)} chars (want 140–160)")
            desc_bad += 1

    if published:
        pass_(f"scanned {published} published posts for title/description")
    if title_long == 0 and desc_bad == 0 and missing == 0:
        pass_("on-page title/description within soft targets")
    elif not STRICT and (title_long or desc_bad):
        print(
            f"  \033[33mNOTE\033[0m {title_long} long titles, {desc_bad} desc length outliers "
            f"(set SEO_STRICT=1 to fail)"
        )

    return 1 if FAIL else 0


if __name__ == "__main__":
    sys.exit(main())
