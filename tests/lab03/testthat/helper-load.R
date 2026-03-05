# Loaded automatically by testthat before running any test files.
# Tries to source the student's Rmd so their objects are available for testing.

suppressPackageStartupMessages({
  library(dplyr)
  library(ggplot2)
  library(readr)
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

# Store Rmd content for code-presence testing
.rmd_content <- if (length(.rmd_files) > 0) {
  tryCatch(readLines(.rmd_files[1], warn = FALSE), error = function(e) character(0))
} else {
  character(0)
}

# Utility: find exercise section in Rmd between exercise n and next_n markers
.find_ex_section <- function(content, n, next_n = NULL) {
  pat <- sprintf("^#{1,4}\\s*[Ee]xercise\\s*%s\\b", n)
  idx <- grep(pat, content)
  if (length(idx) == 0) {
    pat <- sprintf("^%s\\.\\s", n)
    idx <- grep(pat, content)
  }
  if (length(idx) == 0) return(NULL)
  start <- idx[1]
  if (!is.null(next_n)) {
    npat <- sprintf("^#{1,4}\\s*[Ee]xercise\\s*%s\\b", next_n)
    nidx <- grep(npat, content)
    nidx <- nidx[nidx > start]
    if (length(nidx) == 0) {
      npat <- sprintf("^%s\\.\\s", next_n)
      nidx <- grep(npat, content)
      nidx <- nidx[nidx > start]
    }
    end <- if (length(nidx) > 0) nidx[1] - 1 else length(content)
  } else {
    end <- length(content)
  }
  content[start:min(end, length(content))]
}
