# Source shared test helper
if (file.exists("tests/shared-helper-load.R")) {
  source("tests/shared-helper-load.R")
}

# Helper: find the scraped art data frame regardless of what variable name the
# student used.  Tries 'uoe_art' first, then common alternatives.
# Returns the data frame, or NULL if none is found.
# This intentionally does NOT assign anything to the global environment so that
# tests which check existence of 'uoe_art' by name still fail correctly when the
# student never created such an object.
.find_art_df <- function() {
  for (.nm in c("uoe_art", "auto", "art", "uoe", "artwork")) {
    if (exists(.nm, envir = .GlobalEnv, inherits = FALSE)) {
      obj <- get(.nm, envir = .GlobalEnv, inherits = FALSE)
      if (is.data.frame(obj) &&
        all(c("title", "artist") %in% tolower(names(obj)))) {
        return(obj)
      }
    }
  }
  NULL
}
