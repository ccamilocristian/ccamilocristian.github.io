# T26 — AdSense (manual + código)

_Estado API 2026-06-27 · Cuenta `pub-2402437399062384`_

---

## Hecho por el bot

| ID | Resultado |
|----|-----------|
| **T26a** | 6/6 slot IDs **ACTIVE** en dashboard |
| **T26g** | Mid-article priority en posts EN alto tráfico |
| **T26h** | **14 slugs EN** en `mid_article_priority_slugs` |
| **T26f** | Decisión: mantener densidad actual (ver §5) |
| **T26i** | Decisión: **Auto ads OFF** (unidades manuales ya desplegadas) |

### Métricas 30 días (API)

| Métrica | Valor |
|---------|-------|
| Ingresos | $0.02 |
| Impresiones | 114 |
| Clics | 0 |
| Page RPM | $0.11 |

**Nota:** el reporte por unidad solo muestra tráfico en unidades **legacy** (`horizontal ad`, `articulo`). Las 6 unidades nuevas del repo aún no acumulan impresiones en reporting — normal hasta QA consent + tráfico real.

---

## 1. Renombrar ad units (T26b) · ~5 min

[AdSense → Ads → By ad unit](https://adsense.google.com/)

| Slot ID | Nombre actual | Renombrar a |
|---------|---------------|---------------|
| `6874018777` | en article | `site-in-article` |
| `8047040393` | horizontal ad | `site-post-footer` |
| `9362724975` | Post sidebar 300x250 | `site-sidebar-300x250` |
| `6813985623` | Post mid-article native | `site-mid-article-native` |
| `5343588914` | Home bridge horizontal | `site-home-bridge` |
| `9226993605` | Intelligence feed horizontal | `site-intelligence-in-feed` |

**Legacy (archivar si no usas):**

| Slot ID | Nombre | Acción |
|---------|--------|--------|
| `1778404697` | bloque | Archivar / no usar en código |
| `1836855266` | articulo | Archivar / no usar en código |

### Opción API (después de re-auth write)

```bash
# En ~/mcp_servers — cambiar scope a adsense (write) y re-ejecutar generate_adsense_token.py
uv run --with google-api-python-client --with google-auth --with google-auth-oauthlib \\
  python tools/adsense-rename-units.py
```

---

## 2. QA visual 6 placements (T26c + T26d) · ~10 min

Incógnito → **aceptar cookies de publicidad** → revisar:

| # | Ruta | Placement | Qué ver |
|---|------|-----------|---------|
| 1 | `/` | home bridge | Banner horizontal bajo hero |
| 2 | `/posts/music-player-english/` | in-article | Native in-article |
| 3 | mismo post | mid-article | Tras 2º H2 (reading ≥2 min) |
| 4 | mismo post | sidebar | 300×250 desktop |
| 5 | mismo post | footer | Horizontal al final |
| 6 | `/tabs/intelligence/` | in-feed | Cada 6 entradas |

DevTools → inspecciona `<ins data-ad-slot="…">` y confirma slot ID correcto.

Si `data-ad-status="unfilled"` → normal con poco tráfico; si nunca carga script → revisar consent.

---

## 3. Policy center (T26e) · ~3 min

[AdSense → Policy center](https://adsense.google.com/)

- [ ] Sin violaciones activas
- [ ] Sitio `ccamilocristian.github.io` aprobado
- [ ] **Auto ads = OFF** (evita duplicar unidades manuales)
- [ ] Blocking controls razonables (no bloquear demasiadas categorías)

Tras **T25c** filtro Singapore: menos riesgo de invalid traffic.

---

## 4. Decisión densidad (T26f) · registrada

**Mantener configuración actual:**

- Home: **1** placement (bridge)
- Post EN: hasta **4** (in-article, mid, sidebar desktop, footer)
- Intelligence: in-feed cada 6

Rationale: tráfico bajo (~114 imp/mes); reducir slots no sube RPM con este volumen. Reevaluar cuando EN indexe y pageviews >500/mes.

---

## 5. Meta (T26j)

Objetivo interno: **1.000 pageviews/mes** antes de esperar RPM estable. Depende de T24 indexación + T25c filtro bots.
