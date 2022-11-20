#libraries

install.packages(c("devtools",
                   "tidyverse",
                   "rmarkdown",
                   "bookdown",
                   "discord",
                   "vembedr",
                   "datasauRus",
                   "DT",
                   "car",
                   "latticeExtra",
                   "manipulateWidget",
                   "shiny",
                   "rgl","BGmisc"))
devtools::install_github("gadenbuie/tweetrmd")
devtools::install_github('gmonette/spida2')
install.packages("p3d", repos = "http://R-Forge.R-project.org")

install.packages("tufte")
devtools::install_github("rstudio-education/dsbox")

install.packages("rafalib")

if (!requireNamespace("BiocManager", quietly = TRUE)) install.packages("BiocManager")
BiocManager::install("Biobase")
BiocManager::install("SpikeInSubset")
install.packages("pacman")
devtools::install_github("hadley/emo")
install.packages("openintro")
install.packages("ggridges")
