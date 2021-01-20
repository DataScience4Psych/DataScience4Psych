# down/load missing packages ----------------------------------------------------------------

if (!require("pacman")) install.packages("pacman")
library(pacman)
pacman::p_load(coronavirus,
               devtools,
               discord,
               fivethirtyeight,
               fs,
               ggbeeswarm,
               ggrepel,
               ggridges,
               here,
               hexbin,
 #              maps,
               NlsyLinks,
               patchwork,
               rmarkdown,
               skimr,
               tidyverse,
               uuid,
#               vroom,
               xaringan
              )



# xaringan ---------------------------------------------------------------------

xaringans <- dir_info(recurse = 3, glob = "*.Rmd") %>%
  filter(str_detect(path, "Slides")) %>%
  filter(!str_detect(path, "setup")) %>%
  pull(path)
walk(xaringans, render)
