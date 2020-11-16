


# Class Description:

Data Science for Psychologists (DSP) focuses on the basic principles of data science and links them to psychological methods and open science practices. Data science focuses on exploratory analyses and description, rather than confirmatory analyses and prediction. We'll work our way thru Wickham and Grolemund's R for Data Science text (http://r4ds.had.co.nz/) and develop expertise in tidyverse (https://www.tidyverse.org/). This class emphasizes replication and reproducibility. DSP is a more practical skilled-based class and should be useful to students aiming for academia as well as those interested in industry. 

Both versions of this class cover the same five areas:
Reproducibility;
Replication;
Robust Methods;
Visualization (if anyone can come up with a word that starts with R...); and
R, but with different emphases.

In either class, students will have a portfolio on OSF or Github that highlights some of the skills they've developed throughout the course




# Credits
This book is adapted from a minimal example of a book based on R Markdown and **bookdown** (https://github.com/rstudio/bookdown). Please see the page "[Get Started](https://bookdown.org/yihui/bookdown/get-started.html)" at https://bookdown.org/yihui/bookdown/ for how to compile this example into HTML. You may generate a copy of the book in `bookdown::pdf_book` format by calling `bookdown::render_book('index.Rmd', 'bookdown::pdf_book')`. More detailed instructions are available here https://bookdown.org/yihui/bookdown/build-the-book.html.


This bookdown book is a *work in progress*. We'll update this `README` and the repo status when ready! :rocket:

# Requirements to preview the site locally 

Install the required packages.

## Option 1: Use renv for a project-specific library

This is how we work locally and on Travis-CI, where the public product is actually built and deployed.

The [renv package](https://rstudio.github.io/renv/index.html) uses a [snapshot and restore](https://environments.rstudio.com/snapshot.html) strategy to create **r**eproducible **env**vironments for R projects. A project that uses renv has
its own project-specific library that is separate from your personal library of packages. This helps contributors ensure we're all using the same version of packages and that the public site is also being built from these versions.

1. Get a local copy of the website source.
   * Users of devtools/usethis can do:
     ```r
     usethis::create_from_github("rstudio-education/stat545")
     ```
     Note that `usethis::create_from_github()` works best when it can find a
     GitHub personal access token and usethis (git2r, really) is configured
     correctly for your preferred transport protocol (SSH vs HTTPS).
     [Setup advice](https://usethis.r-lib.org/articles/articles/usethis-setup.html).
   * Otherwise, use your favorite method to fork and clone or download the
     repo as a ZIP file and unpack.
1. Start R in your new `stat545/` directory. Expect to see some renv startup
   along these lines:
   ```
   Failed to find installation of renv -- attempting to bootstrap...
   * Downloading renv 0.7.0-50 ... Done!
   * Installing renv 0.7.0-50 ... Done!
   Successfully installed and loaded renv 0.7.0-50.
   * Project '~/tmp/stat545' loaded. [renv 0.7.0-50]
   ```
1. Run `renv::restore()`. This will print out "The following package(s) will be
   installed" followed by a long list of packages. Respond "yes". renv will
   build the project-specific library containing packages at the correct
   versions.
1. You should now be able to render the site in all the usual ways for bookdown,
   such as `bookdown::render_book()` or *Addins > Preview Book*.
    
## Option 2: Use pak or similar

If the renv infrastructure is confusing to you, use `renv::deactivate()` to remove it. You could then use your favorite method of package installation to make sure you've got the necessary packages (although there's no guarantee that you're using the same version as we are).

Here's one way to install the needed packages (only the ones that you don't already have) using the [pak package](https://pak.r-lib.org/index.html).

```r
pkg_list <- c("bookdown", "devtools", "dichromat", "DT", "fs", "gapminder",
              "gender", "geonames", "git2r", "glue", "gridExtra",  "htmltools",
              "httr", "knitr", "RColorBrewer", "rebird", "rmarkdown", "rplos", 
              "rvest", "testthat", "tidyverse", "usethis", "viridis", "xfun", 
              "xml2", "ropensci/genderdata", "rstudio/gt")

# install.packages("pak")
pak::pkg_install(pkg_list)
```

This is nice because it can install from CRAN and, in the case of packages like `rstudio/gt`, also from GitHub.

<!--TODO: Change pkg_list to not be static, maybe use renv::dependencies(path = "DESCRIPTION")?-->

Note: the package list above is currently static, so consider that it may not be up to date.

## OMDb API key

One file, 37_diy-web-data.Rmd, accesses the Open Movie Database API, which requires a key. The site will render without this, without rendering this file. Set up an OMDb key to render this file.

1. Request an API key [here](https://www.omdbapi.com/apikey.aspx).
1. Check your email and follow the instructions to activate your key
1. Add the API key to your `.Renviron` file. First, open your .`Renviron` file with the usethis package:
  
    ```r
    library(usethis)
    edit_r_environ()
    ```
    
    Next, add `OMDB_API_KEY=<your-key>` on a new line, replacing `<your-key>` with your OMDb key. (Make sure to have your `.Renviron` file end on a new line!)
