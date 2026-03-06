
# Loaded automatically by testthat before running any test files.
# Tries to source the student's Rmd so their objects are available for testing.

suppressPackageStartupMessages({
#  library(dplyr)
 # library(ggplot2)
#  library(datasauRus)
  library(stringr)
})
if ( file.exists("tests/shared-helper-load.R")) {
source("tests/shared-helper-load.R")
}
# Source shared test helper
#.shared_helper <- normalizePath(file.path(dirname(sys.frame(1)$ofile), "..", "..", "shared-helper-load.R"), mustWork = FALSE)
#if (file.exists(.shared_helper)) source(.shared_helper, local = FALSE)

