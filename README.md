# Cristian Camilo Moreno Narvaez

Portfolio and intelligence hub — data engineering, ML, BI, and economics-grounded decision work.

Built with [Jekyll](https://jekyllrb.com/) on [Chirpy v2](https://github.com/cotes2020/jekyll-theme-chirpy), extended with a **Stitch "Calm Technical" dashboard** shell (7 primary surfaces).

**Live site:** [https://ccamilocristian.github.io/](https://ccamilocristian.github.io/)

**Design & evolution compass:** [`README_UX_EVOLUTION.md`](README_UX_EVOLUTION.md) · **Task queue:** [`BACKLOG.md`](BACKLOG.md)

---

## Requisitos previos

- **Ruby** 3.x
- **Bundler** (`gem install bundler`)
- **Git**

---

## Desarrollo local

```bash
git clone https://github.com/ccamilocristian/ccamilocristian.github.io.git
cd ccamilocristian.github.io
bundle install
bundle exec jekyll serve
```

Abre [http://127.0.0.1:4000/](http://127.0.0.1:4000/)

---

## Comandos útiles

| Comando | Descripción |
|---------|-------------|
| `bundle exec jekyll serve` | Servidor local con recarga |
| `bundle exec jekyll serve --livereload` | Recarga del navegador |
| `bundle exec jekyll build` | Build estático → `_site/` |
| `bundle exec jekyll clean` | Limpia caché de build |
| `bash tools/run.sh` | Servidor vía script del tema |
| `bash tools/stitch-sync.sh --summary` | Sync tokens Stitch → `.stitch/` |

---

## Estructura principal

| Ruta | Contenido |
|------|-----------|
| `_layouts/` + `_includes/` | Shell Stitch + legacy Chirpy |
| `_data/` | YAML — nav, profile, skills, copy de tabs |
| `tabs/` | Páginas estáticas (Profile, Intelligence, Stack, …) |
| `_posts/` | 14 posts publicados (EN); pares ES en `post_pairs.yml` |
| `categories/`, `tags/` | Stubs Chirpy para archivos (plugin `jekyll-archives` no en Gemfile) |
| `assets/css/tokens/` | Design tokens `--ds-*` |
| `assets/css/_addon/stitch-*.scss` | Estilos por superficie |
| `docs/` | Specs de diseño (excluidos del build Jekyll) |
| `.stitch/` | Exports Stitch locales (gitignored) |

---

## Despliegue

Push a la rama principal de `ccamilocristian.github.io` → GitHub Pages publica automáticamente.
