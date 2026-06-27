# Auditoría Google AdSense — ccamilocristian.github.io

**Fecha:** 2026-06-27  
**Cuenta:** `pub-2402437399062384` (`ca-pub-2402437399062384`)  
**Estado cuenta:** READY (desde 2021-04-27)  
**Zona horaria:** America/Bogota

> **Nota sobre “Google Ads”:** este sitio **monetiza con AdSense** (editor/publisher), no con **Google Ads** (anunciante). No hay API ni campañas de Google Ads configuradas. En GA4 aparece **1 sesión** `google/cpc` — probable anomalía, no un canal activo.

---

## Resumen ejecutivo

| Área | Calificación | Hallazgo principal |
|------|--------------|-------------------|
| Cuenta AdSense | 9/10 | Activa, OAuth OK, API responde |
| Ingresos | 2/10 | **$0.02 USD / 30 días** — 114 impresiones, **0 clics** |
| RPM | 3/10 | **$0.11** page RPM — por debajo de media sector |
| Implementación código | 8/10 | 6 slots, loader diferido, consent gate, anti-CLS |
| Dashboard ↔ código | 5/10 | API reporta 2 ad units; repo define **6 slot IDs** |
| Consent / GDPR | 6/10 | Ads bloqueados hasta aceptar — correcto legalmente; reduce impresiones |
| Reporting por URL | 1/10 | Dimensión `PAGE_URL` vacía (volumen bajo) |

---

## 1. Métricas globales (30 días)

| Métrica | Valor |
|---------|-------|
| Ingresos estimados | **$0.02 USD** |
| Impresiones | **114** |
| Clics | **0** |
| Page RPM | **$0.11** |
| Ad requests RPM | **$0.02** |
| CTR | **0%** |

### Por día (días con actividad)

| Fecha | Impresiones | Ingresos |
|-------|-------------|----------|
| 2026-06-02 | 20 | $0.00 |
| 2026-06-20 | 12 | $0.00 |
| 2026-06-07 | 12 | $0.00 |
| 2026-06-16 | 11 | $0.00 |
| Resto | 1–10/día | $0.00 |

Ingreso concentrado en pocos días; la mayoría de días **$0.00** con impresiones.

---

## 2. Desglose por dimensión

### Dominio

| Dominio | Ingresos | Impresiones | RPM |
|---------|----------|-------------|-----|
| ccamilocristian.github.io | $0.02 | 114 | $0.11 |

### Plataforma

| Plataforma | Ingresos | Impresiones |
|------------|----------|-------------|
| Desktop | $0.01 | 60 |
| High-end mobile | $0.01 | 47 |
| Tablets | $0.00 | 7 |

### País (top)

| País | Ingresos | Impresiones |
|------|----------|-------------|
| Colombia | $0.01 | 28 |
| Spain | $0.00 | 29 |
| UAE | $0.00 | 12 |
| Argentina | $0.00 | 12 |
| Singapore | $0.00 | 7 |

España tiene más impresiones que Colombia pero $0 ingresos — revisar categoría de contenido o fill rate.

### Unidades de anuncio (dashboard AdSense)

| Ad unit (nombre en AdSense) | Ingresos | Impresiones | Clics |
|-----------------------------|----------|-------------|-------|
| horizontal ad | $0.01 | 45 | 0 |
| articulo | $0.00 | 16 | 0 |

### Por URL (`PAGE_URL`)

**Sin datos** — con este volumen AdSense no desglosa por URL. Usar dominio + ad units hasta crecer tráfico.

---

## 3. Implementación en el repo

### Cliente y slots (`_data/site_ops.yml`)

| Placement | Slot ID | Activo | Dónde se renderiza |
|-----------|---------|--------|-------------------|
| in_article | `6874018777` | ✅ | `_includes/adsense-post-ad.html` |
| post_footer | `8047040393` | ✅ | `_includes/adsense-post-footer.html` |
| sidebar | `9362724975` | ✅ | `_includes/adsense-sidebar.html` |
| mid_article | `6813985623` | ✅ | `_includes/adsense-mid-article.html` |
| home_bridge | `5343588914` | ✅ | `_includes/adsense-home-bridge.html` |
| in_feed | `9226993605` | ✅ | `tabs/intelligence.md` (cada 6 posts) |

### Comportamiento técnico

| Feature | Estado | Archivo |
|---------|--------|---------|
| Loader diferido (`requestIdleCallback`) | ✅ | `adsense-loader.html` |
| Consent gate (`advertisement`) | ✅ | `consent-gate.js` |
| Anti-CLS min-heights | ✅ | `adsense-unit.html` |
| Collapse unfilled slots | ✅ | `adsense-unit.html` |
| Solo en post/home/intelligence | ✅ | `head.html` |
| `stitch_routes` gate | ✅ | includes verifican `stitch_dashboard` |

### Rutas con ads habilitados

- **Home** — home bridge
- **Posts** — in-article, mid-article, sidebar, footer
- **Intelligence tab** — in-feed cada 6 entradas
- **Profile, Stack, etc.** — sin ads (correcto para portfolio)

---

## 4. Cruce GA4 ↔ AdSense

| Métrica | GA4 (30d) | AdSense (30d) |
|---------|-----------|---------------|
| Evento `ad_impression` | 102 | — |
| Impresiones ads | — | 114 |

Cohorte similar (~90% alineado). Diferencia por consent, timing de carga diferida y usuarios que no aceptan cookies de ads.

---

## 5. Problemas detectados

### Críticos

| # | Problema | Impacto |
|---|----------|---------|
| A1 | **0 clics en 114 impresiones** | Sin ingresos escalables |
| A2 | **6 slots en código vs 2 ad units en API** | Posible desalineación dashboard ↔ implementación |
| A3 | Consent bloquea ads por defecto | Menos impresiones (correcto legal, malo para revenue) |

### Importantes

| # | Problema | Impacto |
|---|----------|---------|
| A4 | Tráfico bot (Singapore 65% en GA4) | Impresiones de baja calidad / invalid traffic risk |
| A5 | RPM $0.11 muy bajo | Nicho técnico + geo mix + sin clics |
| A6 | España: 29 imp, $0 | Fill rate o CPC bajo en esa geo |
| A7 | Sin reporting por URL | No saber qué post monetiza mejor |

### Menores

| # | Problema |
|---|----------|
| A8 | `horizontal ad` / `articulo` nombres genéricos en dashboard |
| A9 | Mid-article solo si `reading_time >= 4` — muchos posts cortos no lo muestran |
| A10 | Sidebar solo desktop (`stitch_dashboard` layout) |

---

## 6. Verificaciones manuales en AdSense dashboard

Checklist para esta semana:

- [ ] **Ads → By ad unit** — confirmar que existen unidades para los 6 slot IDs del repo
- [ ] **Sites** — `ccamilocristian.github.io` aprobado sin violaciones
- [ ] **Policy center** — sin advertencias activas
- [ ] **Blocking controls** — categorías bloqueadas no excesivas
- [ ] **Auto ads** — OFF si usas solo unidades manuales (evitar duplicados)
- [ ] **Payment** — umbral de pago y datos fiscales al día

---

## 7. Plan de acción (tareas T26)

| ID | Prioridad | Tarea |
|----|-----------|-------|
| T26a | **Alta** | Auditar dashboard: mapear 6 slot IDs ↔ ad units reales |
| T26b | **Alta** | Renombrar ad units en AdSense (`in-article`, `footer`, etc.) |
| T26c | **Alta** | QA visual: verificar cada placement carga tras aceptar cookies |
| T26d | **Alta** | Completar T21 GTM consent — ads solo tras `ad_storage` granted |
| T26e | Media | Revisar Policy + invalid traffic (bots Singapore) |
| T26f | Media | Test A/B: reducir placements en home vs post (menos dilución) |
| T26g | Media | Priorizar ads en posts con tráfico (`reproductor-musica` / EN equivalent) |
| T26h | Media | Cuando EN indexe: mover focus de ads a slugs EN |
| T26i | Baja | Evaluar Auto ads complementario (solo si manual underperforms) |
| T26j | Baja | Meta interna: 1.000 pageviews/mes antes de esperar RPM estable |

---

## 8. Google Ads (publicidad) — no aplica

| Pregunta | Respuesta |
|----------|-----------|
| ¿Hay cuenta Google Ads? | No configurada en repo ni MCP |
| ¿Hay campañas activas? | No evidencia; 1 sesión `cpc` en GA4 |
| ¿Se necesita API Google Ads? | Solo si planeas promocionar el sitio con ads de pago |

Si en el futuro quieres **promocionar** el portfolio con Google Ads, sería un proyecto separado (T27+): cuenta Ads, conversiones GA4, landing EN, presupuesto.

---

## Referencias

- OAuth: `camilololo902@gmail.com`
- IDs: `~/mcp_servers/.env`
- GA4: [`GA4_AUDIT_2026-06-27.md`](GA4_AUDIT_2026-06-27.md)
- GSC: [`GSC_AUDIT_2026-06-27.md`](GSC_AUDIT_2026-06-27.md)
