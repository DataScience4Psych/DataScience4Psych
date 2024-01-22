# Conditional Libraries Installation

# Function to conditionally install a package
install_if_missing <- function(package) {
  if (!require(package, character.only = TRUE)) {
    install.packages(package)
  }
}

# Function to conditionally install a package from GitHub
install_github_if_missing <- function(repo) {
  package <- unlist(strsplit(repo, "/"))[2]
  if (!require(package, character.only = TRUE)) {
    devtools::install_github(repo)
  }
}

# Function to conditionally install a package from R-Forge
install_rforge_if_missing <- function(package, repo = "http://R-Forge.R-project.org") {
  if (!require(package, character.only = TRUE)) {
    install.packages(package, repos = repo)
  }
}

# Function to conditionally install a package from Bioconductor
install_bioc_if_missing <- function(package) {
  if (!requireNamespace(package, quietly = TRUE)) {
    BiocManager::install(package)
  }
}



# CRAN Packages
cran_packages <- c(
  "devtools", "tidyverse", "rmarkdown", "bookdown", "discord",
  "vembedr", "datasauRus", "DT", "gt", "car", "latticeExtra",
  "manipulateWidget", "shiny", "rgl", "BGmisc", "leaflet",
  "mosaicData", "performance", "see", "plotly", "RefManageR",
  "tufte", "rafalib", "openintro", "ggridges", "robotstxt",
  "tidymodels", "pacman", "gapminder"
)

# Install CRAN packages if missing
lapply(cran_packages, install_if_missing)

# GitHub Packages
github_packages <- c(
  "gadenbuie/tweetrmd",
  "gmonette/spida2",
  "rstudio-education/dsbox",
  "crsh/citr",
  "hadley/emo"
)

# Install GitHub packages if missing
lapply(github_packages, install_github_if_missing)


# R-Forge Packages
r_forge_packages <- c("p3d")

lapply(r_forge_packages, install_rforge_if_missing)



# Bioconductor Packages
bioc_packages <- c("Biobase", "SpikeInSubset")

# Ensure BiocManager is installed
if (!requireNamespace("BiocManager", quietly = TRUE)) {
  install.packages("BiocManager")
}

# Install Bioconductor packages if missing
lapply(bioc_packages, install_bioc_if_missing)
