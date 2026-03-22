# Source shared test helper
if (file.exists("tests/shared-helper-load.R")) {
  source("tests/shared-helper-load.R")
}

# Helper: find the scraped art data frame.
# Checks 'uoe_art' first, then common alternative names students use.
# Called in tests only when 'uoe_art' is not already present.
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
