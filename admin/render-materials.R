# down/load missing packages ----------------------------------------------------------------

if (!require("pacman")) install.packages("pacman")
library(pacman)
pacman::p_load(BiocManager,
               bookdown,
               coronavirus,
               datasauRus,
               devtools,
               dichromat,
               discord,
               dsbox,
               DT,
               fivethirtyeight,
               fs,
               gapminder,
               gender,
               geonames,
               ggbeeswarm,
               ggrepel,
               ggridges,
               git2r,
               glue,
               gridExtra,
               gt,
               here,
               hexbin,
               htmltools,
               httr,
               knitr,
               manipulateWidget,
               maps,
               mosaicData,
               NlsyLinks,
               osfr,
               openintro,
               patchwork,
               performance,
               rafalib,
               RColorBrewer,
               rebird,
               rmarkdown,
               rplos,
               rvest,
               skimr,
               see,
               testthat,
               tidyverse,
               tufte,
               usethis,
               uuid,
               viridis,
               vroom,
               webshot,
               xaringan,
               xfun,
               xml2
)


if (!require("emo")) devtools::install_github("hadley/emo")
if (!requireNamespace("BiocManager", quietly = TRUE)) install.packages("BiocManager")
if (!require("Biobase")) BiocManager::install("Biobase")
if (!require("SpikeInSubset")) BiocManager::install("SpikeInSubset")
if (!require("spida2"))  devtools::install_github('gmonette/spida2')
if (!require("p3d"))  install.packages("p3d", repos = "http://R-Forge.R-project.org")
if (!require("dsbox")) devtools::install_github("rstudio-education/dsbox")
# if (!require("genderdata")) install.packages("genderdata", repos = "https://dev.ropensci.org", type = "source")

# xaringan ---------------------------------------------------------------------

xaringans <- dir_info(recurse = 3, glob = "*.Rmd") %>%
  filter(str_detect(path, "Slides")) %>%
  filter(!str_detect(path, "setup")) %>%
  pull(path)
walk(xaringans, render)

