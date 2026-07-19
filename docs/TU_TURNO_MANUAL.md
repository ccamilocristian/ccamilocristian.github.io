# Tu turno — checklist manual (~25 min)

_Bot ejecutó batch 2026-06-27. Esto solo tú puedes hacer en UI._

---

## 1. GSC — Indexación (T24) · ~15 min · **prioridad máxima**

[Inspección de URLs](https://search.google.com/search-console/inspect)

Para cada URL: pegar → **Probar URL publicada** (debe ser 200) → **Solicitar indexación**.

**Ya indexadas (no repetir):**
- `https://ccamilocristian.github.io/posts/optimation-consumer-english/`
- `https://ccamilocristian.github.io/tabs/intelligence/`

**Solicitar ahora (13):** ver [`T24_GSC_INDEX_NOW.md`](T24_GSC_INDEX_NOW.md)

---

## 2. GA4 — Filtro Singapore (T25c) · ~3 min · **prioridad alta**

La API no expone `dataFilters` en esta propiedad (404). Hazlo en UI:

1. [GA4 Admin](https://analytics.google.com/) → propiedad **Pagina Personal**
2. **Admin** → **Configuración de datos** → **Filtros de datos**
3. **Crear filtro** → Nombre: `Exclude Singapore bot traffic`
4. Tipo: **Excluir** → Dimensión: **País** → **Singapur**
5. **Crear** (afecta datos **nuevos** desde ahora)

---

## 3. GA4 — Enlace GSC (T25d) · ✅ hecho

---

## 4. Consent QA + anti-duplicado GTM (T25b + T26d) · ~8 min

### 4a — Pausar Google Tag en GTM (evitar page_view ×2)

El sitio vuelve a enviar `page_view` por **gtag directo**. En GTM Live:

1. [GTM](https://tagmanager.google.com/) → `GTM-K8J9KSB8`
2. Tags → **Google Tag** / `G-4FK52MWLPP` → **Pause**
3. Dejar activos: `outbound_click`, `site_search`
4. **Submit → Publish**

### 4b — QA incógnito

Ventana **incógnito** → `https://ccamilocristian.github.io/`

| Paso | Esperado |
|------|----------|
| Sin interactuar / rechazar | Network: hit `g/collect` (cookieless) o Realtime con usuario limitado |
| Aceptar analytics | [GA4 Realtime](https://analytics.google.com/) muestra `page_view` |
| Aceptar ads | DevTools Network: `adsbygoogle.js` carga |

CookieYes → **Google Consent Mode v2 = ON**

---

## 5. GSC — Sitemap (T23d) · ~1 min · vigilar

Bot reenvió sitemap (`lastSubmitted` 2026-06-27). Google aún no lo reprocesó:

| Campo | Valor actual |
|-------|----------------|
| `lastDownloaded` | 2024-10-16 |
| `isPending` | true |
| URLs enviadas | 73 |

Solo vigilar en GSC → **Sitemaps** hasta que `lastDownloaded` se actualice.

---

## 6. Bing (T23f) · ~5 min · opcional esta semana

1. [Bing Webmaster](https://www.bing.com/webmasters) → agregar sitio
2. Verificar (meta tag o archivo HTML)
3. Enviar sitemap: `https://ccamilocristian.github.io/sitemap.xml`

IndexNow ya pingueó 18 URLs ✅

---

## 7. AdSense (T26b–e) · ~15 min

Guía: [`T26_ADSENSE_MANUAL.md`](T26_ADSENSE_MANUAL.md)

- [ ] Renombrar 6 ad units (§1)
- [ ] QA visual tras consent ads (§2)
- [ ] Policy center + Auto ads OFF (§3)
- [ ] Archivar legacy `bloque` / `articulo`

---

## Hecho por el bot (no repetir)

| Tarea | Resultado |
|-------|-----------|
| T24 inspección | 2/15 indexadas, 13 pendientes UI |
| T23d sitemap | Reenviado API; sigue `isPending` |
| IndexNow | 18 URLs ping |
| GTM | Live **v6**, 3 tags OK |
| Script | `tools/seo-batch.py` para re-ejecutar lecturas |

Re-ejecutar lecturas: `uv run --with google-api-python-client --with google-auth python tools/seo-batch.py`
