# Source shared test helper
if (file.exists("tests/shared-helper-load.R")) {
  source("tests/shared-helper-load.R")
}

# Some students name the scraped art data frame something other than 'uoe_art'
# (e.g. 'auto').  Alias whichever in-memory data frame has the expected columns
# so that object-based tests can find it.  We deliberately do NOT fall back to
# loading the committed CSV here, because tests that check whether the student's
# source code creates the dataset would pass spuriously if we pre-populated it.
if (!exists("uoe_art")) {
  for (.art_name in c("auto", "art", "uoe", "artwork")) {
    if (exists(.art_name) && is.data.frame(get(.art_name)) &&
      all(c("title", "artist") %in% tolower(names(get(.art_name))))) {
      uoe_art <- get(.art_name)
      break
    }
  }
}
