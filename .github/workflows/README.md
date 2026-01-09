# GitHub Actions Workflows

This directory contains GitHub Actions workflows for automating various tasks in this repository.

## bookdown.yml - Automatic Book Building and Deployment

This workflow automatically rebuilds and deploys the bookdown book whenever changes are pushed to the `main` branch.

### When does it run?

The workflow triggers on:
- **Push to main branch** when any of these files change:
  - `.Rmd` files (any chapter or content file)
  - `.yml` or `.yaml` configuration files
  - `DESCRIPTION` file (package dependencies)
  - `book.bib` or `packages.bib` (bibliography files)
  - `common.R` (shared R code)
  - Files in `assets/`, `data/`, or `img/` directories
  - The workflow file itself
- **Manual trigger** via the GitHub Actions UI (workflow_dispatch)

### What does it do?

1. **Setup**: Checks out the repository, installs R, pandoc, and system dependencies
2. **Dependencies**: Installs all R packages listed in the `DESCRIPTION` file with caching for faster builds
3. **Build**: Runs `bookdown::render_book()` to generate the HTML book in the `docs/` directory
4. **Deploy**: Publishes the `docs/` directory to the `gh-pages` branch, which GitHub Pages serves

### Benefits

- **No local builds needed**: You no longer need to run `bookdown::render_book()` locally
- **Consistency**: The book is always built in the same environment
- **Time-saving**: Just push your `.Rmd` changes and the book rebuilds automatically
- **Version control**: The `gh-pages` branch maintains the deployment history

### Monitoring

You can monitor workflow runs:
1. Go to the "Actions" tab in the GitHub repository
2. Click on "Build and Deploy Bookdown"
3. View logs for any run to see details or debug issues

### Notes

- The workflow uses R package caching to speed up subsequent builds
- If the build fails, check the workflow logs in the Actions tab
- The deployed site is available at: https://datascience4psych.github.io/DataScience4Psych

## draft-pdf.yml - JOSS/JOSE Paper PDF Generation

This workflow generates a PDF of academic papers in the `admin/jose/` directory when `.md` files change.
