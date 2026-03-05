# Loaded automatically by testthat before running any test files.
# Tries to source the student's Rmd so their objects are available for testing.

suppressPackageStartupMessages({
  library(dplyr)
  library(ggplot2)
})

# Find student Rmd in repo root (exclude common non-student filenames)
.rmd_files <- list.files(".", pattern = "\\.Rmd$", ignore.case = TRUE)
.rmd_files <- .rmd_files[!grepl("template|solution|example", .rmd_files, ignore.case = TRUE)]

if (length(.rmd_files) > 0 && requireNamespace("knitr", quietly = TRUE)) {
  .r_tmp <- tempfile(fileext = ".R")
  tryCatch({
    suppressMessages(
      knitr::purl(.rmd_files[1], output = .r_tmp, quiet = TRUE, documentation = 0)
    )
    grDevices::pdf(NULL)
    suppressMessages(suppressWarnings(
      source(.r_tmp, local = FALSE, echo = FALSE)
    ))
    grDevices::dev.off()
  }, error = function(e) invisible(NULL))
}
