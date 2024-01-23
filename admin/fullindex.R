# Libraries
library(tidyverse)

# Functions
make_full <- function(myurl, gituser = "datascience4psych", myrepo = "DataScience4Psych") {
  paste0("https://", gituser, ".github.io/", myrepo, "/", myurl)
}

make_hyperlink <- function(myurl, mytext = myurl) {
  paste0('<a href="', myurl, '">', mytext, "</a>")
}

# File paths
df_web <- list.files(path = "docs/", pattern = "\\.html$", recursive = TRUE)

# Exclude 'workshop' subfolder from slides
df_slides <- list.files(path = "E:\\Dropbox\\Lab\\Teaching\\DS4P\\slides\\slides", pattern = "\\.html$", recursive = TRUE) %>%
  grep(pattern = "workshop", x = ., value = TRUE, invert = TRUE)

# Combine and label data
df_docs <- c(df_web, df_slides)
domain <- c(rep("DataScience4Psych", length(df_web)),
            rep("slides", length(df_slides)))

# Data frame creation with vectorized operations
df <- tibble(
  title = basename(df_docs) %>%
    str_remove(".html") %>%
    str_replace_all("[-.]", ""),
  link = make_full(df_docs, myrepo = domain)
) %>%
  mutate(title = if_else(link == "https://datascience4psych.github.io/slides/d13_goodviz/d13b_moreggplot.html",
                         "d13b_moreggplot", title))

# Save to CSV
write_csv(df, "admin/csv/ds4p_urls.csv")
