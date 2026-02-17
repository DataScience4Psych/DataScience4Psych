# CLAUDE.md — Project Guide for AI Assistants

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

**Data Science for Psychologists (DS4P)** — a graduate-level course at Wake Forest University by S. Mason Garrison. This is an R bookdown project that generates an HTML textbook deployed to GitHub Pages at https://datascience4psych.github.io/DataScience4Psych.

## Tech Stack

- **Language**: R, R Markdown (.Rmd)
- **Build system**: bookdown (renders to HTML gitbook, PDF via XeLaTeX, EPUB)
- **Core framework**: tidyverse
- **Output directory**: `docs/` (generated — never edit by hand)
- **Dependencies**: 100+ R packages listed in `DESCRIPTION` (CRAN + GitHub remotes)
- **CI/CD**: GitHub Actions (`.github/workflows/bookdown.yml`)
- **License**: CC-BY-SA 4.0

## Build Commands

```r
# Install dependencies
devtools::install_dev_deps()

# Build HTML book
bookdown::render_book("index.Rmd", "bookdown::gitbook")
```

Output goes to `docs/`. Each chapter knits in a fresh R session (`new_session: true` in `_bookdown.yml`), with `common.R` sourced automatically for shared setup.

## Repository Structure

- `XXYY_topic.Rmd` — Numbered chapter files (80+). XX = major section (00–18), YY = chapter within section
- `index.Rmd` — Book entry point/homepage
- `common.R` — Shared setup: libraries, knitr options, helper functions (loaded by every chapter)
- `_bookdown.yml` / `_output.yml` — Bookdown and output format configuration
- `DESCRIPTION` — R package dependencies
- `book.bib` — Bibliography
- `admin/` — Admin scripts, CSV data, JOSE/JOSS paper, URL checker
- `assets/` — CSS (style.css, toc.css, fonts.css), logo, favicon
- `data/` — Course datasets (.csv, .RData, .xls)
- `docs/` — Generated build output (DO NOT EDIT)
- `img/` — Images used in chapters
- `.Xmd` files — Draft/inactive chapters (excluded from build)

## Code Style and Linting

- Follow the [tidyverse style guide](https://style.tidyverse.org)
- Use `styler` for formatting; only restyle code you're changing
- **Linter config** (`.lintr`):
  - Max line length: 220 characters
  - Allowed naming: `snake_case`, `symbols`, `camelCase`
  - Cyclomatic complexity limit: 30
  - Commented code linter: disabled
- Knitr chunk defaults: `comment = "#>"`, `collapse = TRUE`

## Content Guidelines

- **Audience**: Graduate/undergrad students with no prior R or coding experience
- **Tone**: Educational, welcoming, encouraging
- **Focus**: Exploratory data analysis and visualization (not confirmatory analysis)
- **Tools**: Emphasize tidyverse ecosystem throughout
- **Reproducibility**: All code must be reproducible and well-documented
- **Code chunks**: Use meaningful labels, set appropriate options (`echo`, `eval`, `warning`, `message`), keep code beginner-friendly
- Code must be reproducible; use meaningful chunk labels and appropriate chunk options

## Helper Functions (common.R)

- `slide_url(df_url, title, slide)` — construct slide URLs from CSV data
- `try_include_tweet(tweet_url)` — safely embed tweets
- `embed_youtube_alt(youtube_id)` — embed YouTube with fallback for non-HTML output
- `sample_no_surprises(x)` — safe single-element sampling

## Verification

No formal test suite. To verify changes:
1. Build the book locally and confirm no errors
2. Check that all R code chunks execute without errors
3. Review rendered output in `docs/`

## CI/CD Pipeline

GitHub Actions workflow triggers on push to `main` when `.Rmd`, `.yml`, or `DESCRIPTION` files change. It builds the book and deploys to the `website` branch. Some chapters require environment secrets: `EBIRD_API_KEY`, `GEONAMES_USERNAME`, `OMBD_API_KEY`, `OPENAI_API_KEY`.

## Common Tasks

### Adding a new chapter
1. Create `XXYY_topic.Rmd` with proper numbering
2. Use existing chapters as templates
3. Ensure code chunks source `common.R` setup (handled by bookdown `new_session: true`)

### Editing existing content
1. Edit the `.Rmd` file directly
2. Preserve existing chunk labels and options
3. Test that code runs, then rebuild the book

### Working with helper functions
Key helpers defined in `common.R`:
- `slide_url(df_url, title, slide)` — construct slide URLs from CSV data
- `try_include_tweet(tweet_url)` — safely embed tweets
- `embed_youtube_alt(youtube_id)` — embed YouTube with fallback for non-HTML output
- `sample_no_surprises(x)` — safe single-element sampling


## Contributing

- Typos/small fixes: edit `.Rmd` files directly
- Larger changes: open an issue first
- Follow `.github/CONTRIBUTING.md` for PR process
- Maintainer: @smasongarrison

## Important Reminders

- This is a living document — some sections are under active development
- Never edit files in `docs/` directly; they are generated output
- The `data/` directory contains course datasets; keep data files small and documented
- Some chapters depend on external API keys (eBird, GeoNames, OMDB, OpenAI) — these may fail locally without the keys set
- Packages installed from GitHub remotes are listed in the `Remotes:` field of `DESCRIPTION`
