# Chapter Templates

Rich exemplar templates for creating new chapters in the DS4P bookdown. Each template is a fully fleshed-out example demonstrating every pattern used by the best chapters in the course. Every chunk type used in the codebase appears naturally in at least one template.

## Template Inventory

| Template | Use For | Based On |
|----------|---------|----------|
| `template_lab.Rmd` | Lab assignments (single-file deep format) | Lab 13 Mars simulation |
| `template_module.Rmd` | Module wrapper/hub pages with `# (PART)` | Module 01 Welcome |
| `template_lec.Rmd` | Lecture chapters (video + slides + code) | LEC: Hands on Data Wrangling |
| `template_deepdive.Rmd` | RDD/ODD deep-dive notes (text + code heavy) | ODD: Simulation Notes |
| `template_act_wrapper.Rmd` | Activities linking to external GitHub repos | ACT: UN Voting |
| `template_act_selfcontained.Rmd` | Activities with inline exercises | Hybrid of ACT + light LAB |
| `template_special.Rmd` | Structural pages (resources, front matter) | Resources, Front Matter |
| `template_chunk_reference.Rmd` | **Reference**: every chunk type with annotations | All chapters |
## How to Use

1. Copy the relevant template to the project root
2. Rename following the `XXYY_topic.Rmd` convention (e.g., `0512_lab_penguins.Rmd`)
3. Replace placeholder content with your actual content
4. Update cross-reference anchors (`{#labXX}` -> `{#lab12}`)
5. Update chunk label prefixes to be unique (e.g., `lecXX-` -> `lec12-`)
6. Add the new file to `_bookdown.yml` if needed

## Key Patterns Demonstrated

- **Lab**: Progressive scaffolding (`error=TRUE` workspace → `eval=FALSE` fill-in-the-blank → open-ended), `include=FALSE` + `ref.label` for hidden solutions, nested `<details>` hints, emoji commit checkpoints, DT interactive table for model results, `include_graphics` with `fig.alt`, `fig.cap` for captioned figures, `out.width` sizing, inline R, stretch tasks
- **Module**: `# (PART)` headers, dual HTML/LaTeX video embedding (`knitr::is_html_output()`/`is_latex_output()`), slide embedding from CSV (`slide_url()`), `include_url()` previews, tweet embedding (`try_include_tweet()`), Shiny app embedding (`include_app()`), margin images (`fig.margin`), `eval=FALSE` demo code, `sample_no_surprises()` filler video, child includes, inline R
- **Lecture**: Dual video chunks, slide embedding (CSV and direct URL), `include_url()` for activity previews, `include_graphics` with `fig.cap` and `out.width`, API-gated conditional eval (`eval = variable`, `cache=TRUE`, `error=TRUE`), `results='asis'` for dynamic markdown, inline R, tweet embedding
- **Deep Dive**: DT interactive table, `include_graphics` with `fig.alt` and `out.width`, `cache=TRUE` for expensive computation, custom plot dimensions (`fig.width`, `fig.height`), `fig.cap` for cross-referenceable figures, comprehensive code examples with narrative, common pitfalls, further reading
- **Activity (Wrapper)**: External repo links, slide embedding from CSV, `include_url()` previews, collapsible `<details>` alternatives
- **Activity (Self-contained)**: `eval=FALSE` fill-in-the-blank with `___` placeholders, `fig.fullwidth=TRUE` plots, single-level `<details>` hints, inline R, emoji commit checkpoints
- **Special**: DT interactive tables (filterable, searchable), `results='asis'` for dynamic content, `include_graphics` with `fig.fullwidth` and `fig.alt`, combined HTML/LaTeX video (single-chunk `if/else`), `fig.width`/`fig.height` custom dimensions, bibliography generation (`knitr::write_bib()`), session info colophon, child includes (multiple), inline R
- **Chunk Reference**: Annotated catalog of every chunk option and pattern — setup, video/slide/tweet embedding, images (basic/margin/fullwidth/captioned/alt-text/sized), DT tables, Shiny apps, student workspaces, fill-in-the-blank, hidden solutions via `ref.label`, nested `<details>` hints, API-gated conditional eval, caching, `results='asis'`, child includes, bibliography generation, session info, inline R, and a complete options cheat sheet

## Chunk Type Cross-Reference

| Chunk Type | Lab | Module | Lecture | Deep Dive | Act (Wrap) | Act (Self) | Special |
|------------|:---:|:------:|:-------:|:---------:|:----------:|:----------:|:-------:|
| Setup (`include=FALSE`) | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ |
| Package loading (`message=FALSE`) | ✓ | | ✓ | | | ✓ | |
| Data glimpse | ✓ | | ✓ | | | ✓ | |
| Video — dual HTML/LaTeX | | ✓ | ✓ | | | | |
| Video — combined if/else | | | | | | | ✓ |
| Slide embed (CSV) | | ✓ | ✓ | | ✓ | | |
| Slide embed (direct URL) | | ✓ | | | | | |
| Tweet embed | | ✓ | ✓ | | | | ✓ |
| Shiny app embed | | ✓ | | | | | |
| `include_url()` preview | | ✓ | ✓ | | ✓ | | |
| `include_graphics` (basic) | | | ✓ | ✓ | | | |
| `include_graphics` (`fig.margin`) | | ✓ | | | | | |
| `include_graphics` (`fig.fullwidth`) | | | | | | | ✓ |
| `include_graphics` (`fig.cap`) | | | ✓ | ✓ | | | |
| `include_graphics` (`fig.alt`) | ✓ | | | ✓ | | | ✓ |
| `include_graphics` (`out.width`) | ✓ | | ✓ | ✓ | | | |
| Plot (`fig.width`/`fig.height`) | | | | ✓ | | | ✓ |
| Plot (`fig.fullwidth`) | | | | | | ✓ | |
| DT interactive table | ✓ | | | ✓ | | | ✓ |
| Student workspace (`error=TRUE`) | ✓ | | | | | | |
| Fill-in-the-blank (`eval=FALSE`) | ✓ | ✓ | | | | ✓ | |
| Hidden solution (`include=FALSE`) | ✓ | | | | | | |
| `ref.label` display | ✓ | | | | | | |
| Nested `<details>` hints | ✓ | | | | | | |
| Single `<details>` hints/alternatives | ✓ | | | | ✓ | ✓ | |
| API-gated (`eval=variable`) | | | ✓ | | | | |
| Cached (`cache=TRUE`) | | | ✓ | ✓ | | | |
| Raw output (`results='asis'`) | | | ✓ | | | | ✓ |
| Inline R (`` `r expr` ``) | ✓ | ✓ | ✓ | | | ✓ | ✓ |
| Child include | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ |
| Bibliography generation | | | | | | | ✓ |
| Session info / colophon | | | | | | | ✓ |
| Emoji commit checkpoints | ✓ | | | | | ✓ | |
