# Content pipeline — historial Outside-In

_Registro de ideas de posts generadas en conversación / pipeline Outside-In. Los archivos en `docs/` no se publican en el sitio._

**Última sync:** 2026-07-19 (metrics + presence batch)  
**Posts EN publicados:** 16 (incl. MCP + RAG)  
**Refresh 19-jul:** `convertidor-english` — título/meta + sección IPC/ES queries + internal links (parche mientras llega E1)

---

## Cómo usar este doc

| Estado | Significado |
|--------|-------------|
| **Publicado** | En `_posts/`, live en GitHub Pages |
| **Borrador** | Archivo en `_drafts/` listo para revisar |
| **Esqueleto** | Idea + outline en chat; **sin archivo en repo** |
| **Refresh** | Mejora de post existente, no entrada nueva |

Cuando un post pase a publicado: mover fila a § Publicado y borrar de § Pendiente.

---

## Metodología (Outside-In, jun 2026)

Pipeline acordado en chat: señal externa (HN, arXiv, GSC, GA4) + hueco de competencia + alineación con pilares del portfolio (Economics, ML, Vision Lab, DE).

**Voz al escribir:** `.cursor/rules/redactor.md` — calm technical, Python 3, partes A/B/C + copy-paste, sin plantilla SEO vacía.

**Artefactos por post (referencia MCP + RAG):**
- Hero PNG + 1–2 infografías (`assets/img/<slug>/`)
- Mermaid opcional (`mermaid: true` en front matter)
- `<details>` para troubleshooting / prompts
- Enlace cruzado a posts relacionados del sitio

**Research reutilizable (Economics / cualquier post):**
1. MCP `get_top_keywords` (GSC) — validar queries antes/después
2. MCP `get_ga4_page_performance` (GA4) — retención en posts legacy
3. Python 3 + pandas + datos públicos (Banrep/DANE)
4. Publicar EN → redirect ES → solicitar indexación (T24)
5. Re-medir GSC/GA4 a 30 días

---

## Publicado (lote boom + pipeline)

| Fecha | Slug | Título corto | Pilar | URL |
|-------|------|--------------|-------|-----|
| 2026-06-27 | `mcp-bigquery-server-python-english` | MCP + BigQuery (Cursor, Claude, Codex) | ML / DE | [/posts/mcp-bigquery-server-python-english/](https://ccamilocristian.github.io/posts/mcp-bigquery-server-python-english/) |
| 2026-06-28 | `local-rag-ollama-python-english` | RAG local Ollama + ChromaDB | ML | [/posts/local-rag-ollama-python-english/](https://ccamilocristian.github.io/posts/local-rag-ollama-python-english/) |

**Tesis de tráfico (cumplida):**
- MCP: boom agents/MCP; competencia superficial; repo ya usa MCP en `tools/`.
- RAG: ola tutoriales *local RAG python ollama*; gap = evaluación + $0 API + scripts reproducibles.

**Infra añadida con RAG:** `_includes/mermaid-loader.html`, estilos acordeón en `stitch-post.scss`.

---

## Economics — lote tráfico (GSC validado, jun 2026)

Prioridad acordada: **dos posts nuevos solo Economics**, orientados a tráfico orgánico en nicho inflación/crédito Colombia + LATAM. Señal cruzada con API GSC (90 días, 2026-06-28).

### Señal GSC (economics cluster)

| Query / página | Impresiones | Clics | Pos. | Notas |
|----------------|-------------|-------|------|-------|
| `calculadora de inflacion colombia` | **203** | 0 | 10.1 | Aterriza en `/posts/convertidor-IPC/` (ES) |
| Variantes IPC / indexación | ~15+ | 0 | 10–60 | mismo cluster |
| `/posts/liquidador-intereses/` | 61 | 3 | **5.1** | Crédito / cuotas |
| `calculadora valor presente colombia` | 2 | 0 | 36.0 | Alineado con crédito real |
| Geo dominante | COL, MEX, ESP | — | — | Inflación LATAM |

**Diagnóstico:** Google ya te posiciona en Economics; URLs ES legacy + EN desconocidas → **0 clics** en el query más fuerte.

---

## Pendiente — posts nuevos

### E1. Colombia CPI indexation engine ⭐ Economics / tráfico

| Campo | Valor |
|-------|-------|
| **Estado** | Esqueleto (refinado jun 2026) |
| **Pilar** | Economics |
| **Prioridad** | **Máxima** — quick win SEO |
| **Archivo sugerido** | `_posts/2026-XX-XX-colombia-cpi-indexation-engine-english.md` |
| **Título (draft)** | Colombia CPI indexation in Python — monthly IPC, audit trail, and real peso values (2003–2026) |
| **Señal GSC** | 203 imp, pos 10.1, 0 clics en *calculadora de inflacion colombia*; variantes *como indexar valor ipc*, *calculadora ipc colombia* |
| **Señal GA4** | [`convertidor-english`](/posts/convertidor-english/) ~0s retención — reemplazar, no parchear |
| **Artefacto** | Script Python: IPC mensual Banrep/DANE → `index_value()` + export CSV audit trail; infografía nominal → real |
| **Herramientas** | MCP GSC keywords, MCP GA4, Python/pandas, Economics Lens, T24 indexación EN |
| **Gap vs competencia** | Calculadoras web opacas; tú = código reproducible + trazabilidad |
| **Reemplaza** | Sustituye lógica de [`convertidor-english`](/posts/convertidor-english/) (2003–2020); redirect ES `convertidor-IPC` → EN |
| **Enlaces sitio** | STEP, consumer theory, Economics Lens |

### E2. Real cost of credit (Fisher + amortization) ⭐ Economics / tráfico

| Campo | Valor |
|-------|-------|
| **Estado** | Esqueleto (nuevo jun 2026) |
| **Pilar** | Economics / finanzas personales |
| **Prioridad** | **Alta** — publicar **después** de E1 (reusa serie IPC) |
| **Archivo sugerido** | `_posts/2026-XX-XX-real-cost-of-credit-colombia-english.md` |
| **Título (draft)** | Real cost of credit in Colombia — Fisher equation, amortization, and CPI-adjusted payments in Python |
| **Señal GSC** | `/posts/liquidador-intereses/` pos 5.1 (61 imp); [`loan-simulator-english`](/posts/loan-simulator-english/) unknown to Google |
| **Señal GA4** | liquidador ~14s retención (baseline) |
| **Artefacto** | Part A: cuota fija (`numpy_financial`); Part B: tasa real Fisher \(r \approx i - \pi\); Part C: tabla cuota nominal vs carga real + gráfico |
| **Herramientas** | MCP GSC/GA4 pre-post, Python, serie IPC de E1, internal linking |
| **Gap vs competencia** | Simuladores solo nominales; pocos muestran cuota en **pesos reales** con código |
| **Enlaces sitio** | E1 (IPC), [`loan-simulator-english`](/posts/loan-simulator-english/), Economics Lens |
| **Opcional** | MCP BigQuery — persistir amortización + IPC (stretch DE, no obligatorio) |

### Otros pendientes (Outside-In, jun 2026)

Generados en sesión Outside-In. **No hay `_drafts/*.md` todavía.**

#### 3. Warehouse lag → model calibration

| Campo | Valor |
|-------|-------|
| **Estado** | Esqueleto |
| **Pilar** | Machine Learning + Data Engineering |
| **Archivo sugerido** | `_posts/2026-XX-XX-warehouse-lag-calibration-english.md` (nombre por confirmar) |
| **Título (draft)** | (sin título final — pilar B del batch Outside-In) |
| **Señal** | HN: replicación warehouse, lag; arXiv: calibration drift, conformal prediction |
| **Gap vs competencia** | Posts de monitoring genéricos sin lag de replicación BigQuery |
| **Enlaces sitio** | MCP post (read path), ICFES (load path) |
| **Prioridad sugerida** | Media — más DE, audiencia narrower |

#### 4. SAHI in production

| Campo | Valor |
|-------|-------|
| **Estado** | Esqueleto |
| **Pilar** | Vision Lab / Computer Vision |
| **Archivo sugerido** | `_posts/2026-07-05-sahi-sliced-inference-production-english.md` |
| **Título (draft)** | SAHI in Production — Slice Geometry, Merge Logic, and Latency Budgets for Small-Object Detection |
| **Señal** | Pedido explícito; ancla Vision Lab Phase 2 (benchmarks latencia/precisión) |
| **Gap vs competencia** | Tutoriales de instalación sin costo de inferencia por slice ni merge logic |
| **Referencia** | Akyon et al., IEEE ICIP 2022 |
| **Prioridad sugerida** | **Alta** — diferenciador CV del portfolio |

#### 5. Optuna en experimentos ML

| Campo | Valor |
|-------|-------|
| **Estado** | Esqueleto |
| **Pilar** | Machine Learning |
| **Archivo sugerido** | `_posts/2026-XX-XX-optuna-ml-experiments-english.md` (nombre por confirmar) |
| **Título (draft)** | (outline en chat — persistencia de estudios en producción, TPE) |
| **Señal** | Pedido explícito; conecta con rigor econométrico / experimentación |
| **Gap vs competencia** | Quickstarts sin persistencia de estudios ni patrones prod |
| **Referencia** | Akiba et al., KDD 2019 (TPE) |
| **Prioridad sugerida** | Media-alta |

---

## Pendiente — refresh (no posts nuevos)

| Post existente | Acción | Señal |
|----------------|--------|-------|
| [`convertidor-english`](/posts/convertidor-english/) | **Absorbido por E1** (CPI indexation) o redirect | GA4 0s; GSC 203 imp en ES legacy |
| [`music-player-english`](/posts/music-player-english/) | Refresh SEO / contenido | GSC: ~43 imp, pos ~8.9 (*reproductor música*) |
| [`loan-simulator-english`](/posts/loan-simulator-english/) | Enlazar desde E2; no reescribir solo | GSC: URL unknown; liquidador ES pos 5.1 |

---

## Orden de publicación sugerido

1. **E1** CPI indexation engine (Economics — 203 imp GSC)
2. **E2** Real cost of credit (Economics — cluster liquidador/loan)
3. SAHI (Vision Lab)
4. Optuna (ML)
5. Warehouse lag / calibration (DE, enlaza MCP + ICFES)
6. Refresh: music-player

Calendario: **un push por post** (o `published: false` hasta fecha objetivo), mismo ritmo que MCP → RAG.

---

## Changelog

| Fecha | Evento |
|-------|--------|
| 2026-06-27 | Pipeline Outside-In: esqueletos CPI, warehouse, SAHI, Optuna, MCP, RAG |
| 2026-06-27 | Publicado MCP BigQuery + diagrama |
| 2026-06-28 | Publicado RAG Ollama + 3 infografías + Mermaid infra |
| 2026-06-28 | Creado este doc (`CONTENT_PIPELINE.md`) |
| 2026-06-28 | Economics batch: E1 CPI + E2 crédito real; GSC 203 imp validado; herramientas MCP |

---

## Referencias

- [`BACKLOG.md`](../BACKLOG.md) — tareas técnicas del sitio
- [`README_UX_EVOLUTION.md`](../README_UX_EVOLUTION.md) — pilares y política de contenido
- [`.cursor/rules/redactor.md`](../.cursor/rules/redactor.md) — voz y formato de tutoriales
