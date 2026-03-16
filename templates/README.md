# Chapter Templates

Rich exemplar templates for creating new chapters in the DS4P bookdown. Each template is a fully fleshed-out example demonstrating every pattern used by the best chapters in the course.

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

- **Lab**: Progressive scaffolding, `include=FALSE` + `ref.label` for hidden solutions, nested `<details>` hints, emoji commit checkpoints, stretch tasks
- **Module**: `# (PART)` headers, video/slide embedding, metadata CSV loading, module materials list
- **Lecture**: Dual HTML/LaTeX video embedding, inline activities, extensive code examples with narrative
- **Deep Dive**: Learning goals, comprehensive examples, common pitfalls, further reading
- **Activity (Wrapper)**: External repo links, `include_url()` previews, collapsible alternatives
- **Activity (Self-contained)**: Fill-in-the-blank code, inline hints, commit checkpoints
- **Special**: Tables, embedded media, community contribution invitations
- **Chunk Reference**: Annotated catalog of every chunk option and pattern — setup, video/slide/tweet embedding, images (basic/margin/fullwidth/captioned/alt-text/sized), DT tables, Shiny apps, student workspaces, fill-in-the-blank, hidden solutions via `ref.label`, nested `<details>` hints, API-gated conditional eval, caching, `results='asis'`, child includes, bibliography generation, session info, inline R, and a complete options cheat sheet
