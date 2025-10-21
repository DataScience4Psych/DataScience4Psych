# Contributing to DataScience4Psych

Howdy :wave:! The guidelines below outline how to propose a change to DataScience4Psych. They are based on [shinysurveys](https://github.com/jdtrat/shinysurveys), which in turn, are based on the `tidyverse` contribution guidelines. If you have any additional questions, please [open an issue](https://github.com//DataScience4Psych/DataScience4Psych/issues).
## Fixing typos

You can fix typos, spelling mistakes, or grammatical errors in the documentation directly using the GitHub web interface, as long as the changes are made in the *source* file. This generally means you'll need to edit .Rmd files.

**Automated Spellchecking**: This repository includes automated spellchecking via GitHub Actions. When you submit a pull request that modifies `.Rmd` or `.md` files, the spellchecker will automatically run. If you encounter spellcheck errors:
- Fix genuine typos in the source files
- For valid domain-specific terms (R packages, technical jargon, proper nouns), add them to `_typos.toml` configuration file
- See [SPELLCHECK.md](../SPELLCHECK.md) for detailed instructions on using the spellchecker locally

## Bigger changes

If you want to make a bigger change, it's a good idea to first file an [issue](https://github.com/DataScience4Psych/DataScience4Psych/issues). If you've found a bug, please file an issue that illustrates the bug with a minimal [reprex](https://reprex.tidyverse.org) (this will also help you write a unit test, if needed).

### Pull request process

-   Fork the package and clone onto your computer. If you haven't done this before, we recommend using `usethis::create_from_github("DataScience4Psych/DataScience4Psych", fork = TRUE)`.

-   Install all development dependencies with `devtools::install_dev_deps()`, and then make sure the package passes R CMD check by running `devtools::check()`. If R CMD check doesn't pass cleanly, it's a good idea to ask for help before continuing.

-   Create a Git branch for your pull request (PR). We recommend using `usethis::pr_init("brief-description-of-change")`.

-   Make your changes, commit to git, and then create a PR by running `usethis::pr_push()`, and following the prompts in your browser. The title of your PR should briefly describe the change. The body of your PR should contain `Fixes #issue-number`.
<!--
-   For user-facing changes, add a bullet to the top of `NEWS.md` (i.e. just below the first header). Follow the style described in <https://style.tidyverse.org/news.html>.
-->
### Code style

-   New code should follow the tidyverse [style guide](https://style.tidyverse.org). You can use the [styler](https://CRAN.R-project.org/package=styler) package to apply these styles, but please don't restyle code that has nothing to do with your PR.
<!--
-   We use [roxygen2](https://cran.r-project.org/package=roxygen2), with [Markdown syntax](https://cran.r-project.org/web/packages/roxygen2/vignettes/rd-formatting.html), for documentation.

-   We use [testthat](https://cran.r-project.org/package=testthat) for unit tests. Contributions with test cases included are easier to accept.
-->
## Code of Conduct

Please note that the shinysurveys project is released with a [Contributor Code of Conduct](CODE_OF_CONDUCT.md). By contributing to this project, you agree to abide by its terms.
