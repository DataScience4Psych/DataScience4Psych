# down/load missing packages ----------------------------------------------------------------

if (!require("pacman")) install.packages("pacman")
library(pacman)
pacman::p_load(coronavirus,
               devtools,
               discord,
               datasauRus,
               fivethirtyeight,
               fs,
               gapminder,
               ggbeeswarm,
               ggrepel,
               ggridges,
               here,
               hexbin,
               gt,
 #              maps,
               NlsyLinks,
               patchwork,
               rmarkdown,
               skimr,dsbox,
 tufte,
               tidyverse,
               uuid,
#               vroom,
               xaringan,
webshot,
manipulateWidget
              )

if (!require("spida2"))  devtools::install_github('gmonette/spida2')
if (!require("p3d"))  install.packages("p3d", repos = "http://R-Forge.R-project.org")
devtools::install_github("rstudio-education/dsbox")
# xaringan ---------------------------------------------------------------------

xaringans <- dir_info(recurse = 3, glob = "*.Rmd") %>%
  filter(str_detect(path, "Slides")) %>%
  filter(!str_detect(path, "setup")) %>%
  pull(path)
walk(xaringans, render)
