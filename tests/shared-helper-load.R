# Shared test helper — sourced by each lab's helper-load.R
# Tries to source the student's Rmd so their objects are available for testing.
suppressPackageStartupMessages({
#  library(dplyr)
 # library(ggplot2)
#  library(datasauRus)
  library(stringr)
})
# Find student Rmd in repo root (exclude common non-student filenames)
.student_dir <- Sys.getenv("STUDENT_CODE_DIR", unset = ".")
.rmd_files <- list.files(.student_dir, pattern = "\\.Rmd$", ignore.case = TRUE)
#.rmd_files <- .rmd_files[!grepl("template|solution|example", .rmd_files, ignore.case = TRUE)]
.rmd_content <- if (length(.rmd_files) > 0) {
  tryCatch(
    readLines(file.path(.student_dir, .rmd_files[1]), warn = FALSE),
    error = function(e) character(0)
  )
} else {
  warning("No Rmd file found. Ensure your Rmd is in the repo root and not named with 'template', 'solution', or 'example'.")
  character(0)
}
if (length(.rmd_files) > 0 && requireNamespace("knitr", quietly = TRUE)) {
  .r_tmp <- tempfile(fileext = ".R")
  tryCatch({
    suppressMessages(
      knitr::purl(file.path(.student_dir, .rmd_files[1]), output = .r_tmp, quiet = TRUE, documentation = 0)
    )
    grDevices::pdf(NULL)
    suppressMessages(suppressWarnings(
      source(.r_tmp, local = FALSE, echo = FALSE)
    ))
    grDevices::dev.off()
  }, error = function(e) invisible(NULL))
} else {
  warning("knitr package not available. Cannot source Rmd content.")
}
