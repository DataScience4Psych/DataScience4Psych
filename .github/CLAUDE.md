# CLAUDE.md — Project Guide for AI Assistants

## Project Overview

**Data Science for Psychologists (DS4P)** — a graduate-level course at Wake Forest University by S. Mason Garrison. This is an R bookdown project that generates an HTML textbook deployed to GitHub Pages at https://datascience4psych.github.io/DataScience4Psych.

## Tech Stack

- **Language**: R, R Markdown (.Rmd)
- **Build system**: bookdown (renders to HTML gitbook, PDF via XeLaTeX, EPUB)
- **Core framework**: tidyverse
- **Output directory**: `docs/`
- **Dependencies**: 100+ R packages listed in `DESCRIPTION`
- **CI/CD**: GitHub Actions (`.github/workflows/bookdown.yml`)
- **License**: CC-BY-SA 4.0

## Repository Structure

```
*.Rmd              # Numbered chapter files (80+), e.g. 0101_welcome.Rmd
index.Rmd          # Book homepage/entry point
common.R           # Shared setup loaded by all chapters (libraries, knitr opts, helpers)
_bookdown.yml      # Bookdown config (output dir, GitHub links)
_output.yml        # Output format settings
DESCRIPTION        # R package dependencies
book.bib           # Bibliography
admin/             # Admin scripts, templates, CSV data, JOSE paper
assets/            # CSS, fonts, logo, favicon
data/              # Course datasets (.csv, .RData)
docs/              # Generated build output (do NOT edit by hand)
img/               # Images used in chapters
.github/           # Workflows, CONTRIBUTING.md, copilot-instructions.md
```

## File Naming Conventions

- Chapters: `XXYY_topic.Rmd` where XX = major section, YY = chapter number
  - Example: `0301_tools.Rmd` = Section 3, Chapter 1
- `.Rmd` = active content; `.Xmd` = draft/inactive content
- Data files go in `data/`; images in `img/`

## Building the Book

```r
# Install dependencies
devtools::install_dev_deps()

# Build HTML book
bookdown::render_book("index.Rmd", "bookdown::gitbook")
```

Output goes to `docs/`. The `common.R` file is sourced by every chapter and sets up shared libraries (tidyverse, knitr, vembedr, tweetrmd, etc.), knitr chunk options, and helper functions.

## Code Style and Linting

- Follow the [tidyverse style guide](https://style.tidyverse.org)
- Use `styler` for formatting; don't restyle unrelated code
- **Linter config** (`.lintr`):
  - Max line length: 220 characters
  - Allowed naming: `snake_case`, `symbols`, `camelCase`
  - Cyclomatic complexity limit: 30
  - Commented code linter: disabled
- Knitr chunk options default: `comment = "#>"`, `collapse = TRUE`

## Content Guidelines

- **Audience**: Graduate students with no prior R or coding experience
- **Tone**: Educational, welcoming, encouraging
- **Focus**: Exploratory data analysis and visualization (not confirmatory analysis)
- **Tools**: Emphasize tidyverse ecosystem throughout
- **Reproducibility**: All code must be reproducible and well-documented
- **Code chunks**: Use meaningful labels, set appropriate options (`echo`, `eval`, `warning`, `message`), keep code beginner-friendly

## Testing and Verification

There is no formal test suite. To verify changes:

1. Build the book locally and confirm no errors
2. Check that all R code chunks execute without errors
3. Review rendered output in `docs/`
4. Verify links and cross-references work

## CI/CD Pipeline

The GitHub Actions workflow (`.github/workflows/bookdown.yml`):
- Triggers on push to `main` when `.Rmd`, `.yml`, or `DESCRIPTION` files change
- Installs system libs, R packages (with caching), and builds with `bookdown::render_book`
- Uses environment secrets: `EBIRD_API_KEY`, `GEONAMES_USERNAME`, `OMBD_API_KEY`, `OPENAI_API_KEY`
- Deploys built `docs/` to the `website` branch via GitHub Pages

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
- Larger changes: open an issue first to discuss
- Follow the PR process in `.github/CONTRIBUTING.md`
- Use `devtools::check()` to verify before submitting
- Maintainer: @smasongarrison

## Important Reminders

- This is a living document — some sections are under active development
- Never edit files in `docs/` directly; they are generated output
- The `data/` directory contains course datasets; keep data files small and documented
- Some chapters depend on external API keys (eBird, GeoNames, OMDB, OpenAI) — these may fail locally without the keys set
- Packages installed from GitHub remotes are listed in the `Remotes:` field of `DESCRIPTION`
