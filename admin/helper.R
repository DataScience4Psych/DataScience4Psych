install.packages(c("bookdown", "devtools", "dichromat", "DT", "fs", "gapminder", "gender", "geonames", "git2r", "glue", "gridExtra", "htmltools", "httr", "knitr", "RColorBrewer", "rebird", "rmarkdown", "rplos", "rvest", "testthat", "tidyverse", "usethis", "viridis", "xfun", "xml2", "ropensci/genderdata", "rstudio/gt"))
install.packages("gt")
install.packages(c("tidyverse", "discord"))
install.packages("osfr")
install.packages("genderdata", repos = "https://dev.ropensci.org", type = "source")

usethis::use_github_action(url = "https://raw.githubusercontent.com/ropenscilabs/actions_sandbox/master/.github/workflows/deploy_bookdown.yml")
