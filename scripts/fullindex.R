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
  grep(pattern = "workshop", x = ., value = TRUE, invert = TRUE) %>%
  grep(pattern = "backup", x = ., value = TRUE, invert = TRUE)

# Combine and label data
df_docs <- c(df_web, df_slides)
domain <- c(
  rep("DataScience4Psych", length(df_web)),
  rep("slides", length(df_slides))
)

# Data frame creation with vectorized operations
df <- tibble(
  title = basename(df_docs) %>%
    str_remove(".html") %>%
    str_replace_all("[-.]", ""),
  link = make_full(df_docs, myrepo = domain)
) %>%
  filter(!title %in% c(
    "d00_APS/d00_aps",
    "d00_APS/d00_teaser",
    "d23_multiple/d23_multiple_files/figure-html/widgets/widget_plotly-plot",
    "setup",
    "workshop/archive/h1",
    "index"
  )) %>%
  filter(!str_detect(link, "alt/")) %>%
  filter(!str_detect(link, "z?d?00_template")) %>%
  filter(!str_detect(link, "d?00_APS")) %>%
  filter(!str_detect(link, "00_ASU")) %>%
  filter(!str_detect(link, "backup")) %>%
  filter(!str_detect(link, "figure-html")) %>%
  filter(!str_detect(link, "widgets")) %>%
  filter(!str_detect(link, "archive")) %>%
  mutate(
    title =
      case_when(
        link == "https://datascience4psych.github.io/slides/d13_goodviz/d13b_moreggplot.html" ~ "d13b_moreggplot",
        TRUE ~ title
      )
  ) %>% # also point to same slide if odd or lec is not specified in title
  group_by(title) %>%
  slice(1) %>%
  ungroup()

df_noprefix <- df %>%
  mutate(title = str_remove(title, "d\\d{2}[_-]")) %>%
  mutate(title = str_remove(title, "^[or]dd")) %>%
  mutate(title = str_remove(title, "^lec"))

df_combined <- rbind(df, df_noprefix) %>%
  group_by(title) %>%
  slice(1) %>%
  ungroup()


# Save to CSV
write_csv(df_combined, "metadata/ds4p_urls.csv")
