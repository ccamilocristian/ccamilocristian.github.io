#!/usr/bin/env python3
"""Regenerate raster favicons from the brand SVG.

Single source of truth: assets/img/favicons/favicon.svg. This renders every
PNG size the site references (see _includes/favicons.html) plus a multi-size
favicon.ico, so the icon set stays consistent with the brand.

Usage:
    pip install cairosvg pillow
    python3 tools/gen-favicons.py
"""
import io
import re
from pathlib import Path

import cairosvg
from PIL import Image

ROOT = Path(__file__).resolve().parents[1]
FAV = ROOT / "assets" / "img" / "favicons"
SVG = FAV / "favicon.svg"

# Files whose size is not encoded in the name.
FIXED = {
    "apple-icon.png": 180,
    "apple-icon-precomposed.png": 180,
    "favicon.svg": None,  # skip
    "manifest.json": None,
    "browserconfig.xml": None,
}

ICO_SIZES = [16, 32, 48]


def render_png(size: int) -> bytes:
    return cairosvg.svg2png(url=str(SVG), output_width=size, output_height=size)


def main() -> None:
    svg_data = SVG.read_bytes()
    if not svg_data:
        raise SystemExit(f"missing {SVG}")

    written = 0
    for path in sorted(FAV.glob("*.png")):
        name = path.name
        if name in FIXED and FIXED[name] is None:
            continue
        if name in FIXED:
            size = FIXED[name]
        else:
            m = re.search(r"(\d+)x\1", name)  # e.g. 144x144
            if not m:
                m2 = re.search(r"(\d+)", name)  # e.g. favicon-32x32 already caught; fallback
                size = int(m2.group(1)) if m2 else None
            else:
                size = int(m.group(1))
        if not size:
            print(f"skip (no size): {name}")
            continue
        path.write_bytes(render_png(size))
        written += 1
        print(f"  {name} -> {size}px")

    # Multi-size .ico
    imgs = [Image.open(io.BytesIO(render_png(s))).convert("RGBA") for s in ICO_SIZES]
    ico = FAV / "favicon.ico"
    imgs[0].save(ico, format="ICO", sizes=[(s, s) for s in ICO_SIZES])
    print(f"  favicon.ico -> {ICO_SIZES}")
    print(f"Done: {written} PNGs + favicon.ico")


if __name__ == "__main__":
    main()
