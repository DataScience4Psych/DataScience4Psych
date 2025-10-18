# GitHub Copilot Instructions for DataScience4Psych

## Repository Overview

This repository contains the course materials for **Data Science for Psychologists (DS4P)**, a graduate-level quantitative methods course at Wake Forest University. The course introduces data science principles including data wrangling, modeling, visualization, and communication, with a focus on psychological methods and open science practices.

## Project Type and Technology Stack

- **Type**: Educational content - R bookdown project
- **Language**: R, RMarkdown
- **Build System**: bookdown
- **Output**: HTML book/website deployed to GitHub Pages
- **Dependencies**: See `DESCRIPTION` file for R package dependencies

## Repository Structure

```
.
├── .github/               # GitHub configuration and workflows
├── admin/                 # Administrative files
├── assets/               # Static assets (CSS, images, etc.)
├── data/                 # Course datasets
├── docs/                 # Build output (HTML book)
├── img/                  # Image files
├── *.Rmd                 # RMarkdown chapter files (numbered)
├── index.Rmd             # Book index/homepage
├── _bookdown.yml         # Bookdown configuration
├── _output.yml           # Output format configuration
├── book.bib              # Bibliography
└── DESCRIPTION           # R package dependencies
```

## File Naming Conventions

- Chapter files are numbered: `0000_front.Rmd`, `0101_welcome.Rmd`, etc.
- First two digits indicate major section/module
- Second two digits indicate chapter within that section
- Use `.Rmd` extension for active content
- Use `.Xmd` extension for draft/inactive content

## Building the Book

To build the book locally:

```r
# Install dependencies
devtools::install_dev_deps()

# Build the book
bookdown::render_book("index.Rmd", "bookdown::gitbook")
```

The output will be generated in the `docs/` directory.

## Code Style

- Follow the [tidyverse style guide](https://style.tidyverse.org)
- Use `tidyverse` packages and conventions
- Emphasize readable, educational code suitable for beginners
- Include clear comments explaining concepts for students
- Use the `styler` package to format code, but don't restyle unrelated code

## Content Guidelines

- **Audience**: Graduate students with no prior R or coding experience
- **Tone**: Educational, welcoming, and encouraging for beginners
- **Focus**: Exploratory data analysis and visualization, not confirmatory analysis
- **Tools**: Emphasize tidyverse ecosystem
- **Reproducibility**: All code should be reproducible and well-documented

## Common Tasks

### Adding a New Chapter
1. Create a new `.Rmd` file with appropriate numbering
2. Use existing chapter files as templates
3. Include YAML header if needed
4. Add chapter to the book by ensuring it's in the correct directory

### Modifying Existing Content
- Edit the corresponding `.Rmd` file
- Preserve existing code chunks and their options
- Test that code runs without errors
- Rebuild the book to verify changes

### Working with R Code Chunks
- Use meaningful chunk labels
- Set appropriate chunk options (`echo`, `eval`, `warning`, `message`)
- Include comments for educational purposes
- Ensure code is beginner-friendly

## Testing

While there's no formal test suite for content, you should:
1. Build the book locally to check for errors
2. Review rendered output in `docs/` directory
3. Verify all code chunks execute without errors
4. Check that links and references work correctly

## Dependencies

- R package dependencies are listed in `DESCRIPTION`
- Install with: `devtools::install_dev_deps()`
- Common packages: `tidyverse`, `bookdown`, `knitr`, `rmarkdown`

## Contributing

- See `.github/CONTRIBUTING.md` for detailed contribution guidelines
- For typos/small fixes: Edit directly via GitHub web interface
- For larger changes: Open an issue first to discuss
- Use meaningful commit messages
- Reference related issues in PR descriptions

## Continuous Integration

- GitHub Actions workflow builds PDF drafts when `.md` files change
- The main book is built and deployed via GitHub Pages
- Check workflow status in the Actions tab

## Documentation

- Course website: https://datascience4psych.github.io/DataScience4Psych
- Course materials emphasize R for Data Science (Wickham & Grolemund)
- Attribution page provides detailed credits

## Important Notes

- This is a living document - some sections are still under construction
- The course emphasizes replication and reproducibility
- Content should be useful for both academic and industry applications
- Focus on practical, skill-based learning
- Content is licensed under Creative Commons Attribution-ShareAlike 4.0

## Getting Help

- Open an issue for bugs or questions
- Tag @smasongarrison for maintainer attention
- Check existing issues before creating new ones
- Be respectful and follow the code of conduct
