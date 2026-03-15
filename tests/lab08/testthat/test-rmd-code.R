# Per-exercise Rmd content checks for lab 8

test_that("Exercise 1 contains URL-fixing or scraping code", {
  skip_if(length(.rmd_content) == 0 & length(.r_script_content) == 0)
  potential_answers <- c(
    "str_replace\\(", "read_html\\(", "html_nodes\\(",
    "first_url", "^```\\{r"
  )
  pattern <- paste0("(", paste(potential_answers, collapse = "|"), ")")
  answer_in_rmd <- stringr::str_detect(.rmd_content, pattern) |> any()
  expect_equal(answer_in_rmd, TRUE,
    info = "Include R code for Exercise 1 (e.g., str_replace() to fix relative links, or read_html())"
  )
})

test_that("Exercise 2 contains artist-scraping code", {
  skip_if(length(.rmd_content) == 0 & length(.r_script_content) == 0)
  potential_answers <- c(
    "\\.iteminfo", "artist", "html_nodes\\(|html_node\\(|html_elements\\(",
    "html_text\\(|html_attr\\("
  )
  pattern <- paste0("(", paste(potential_answers, collapse = "|"), ")")
  answer_in_rmd <- stringr::str_detect(.rmd_content, pattern) |> any()
  expect_equal(answer_in_rmd, TRUE,
    info = "Include code to scrape artist names with rvest for Exercise 2"
  )
})

test_that("Exercise 3 contains tibble construction code", {
  skip_if(length(.rmd_content) == 0 & length(.r_script_content) == 0)
  potential_answers <- c(
    "tibble\\(", "data\\.frame\\(",
    "first_ten", "title.*artist.*link|artist.*link.*title"
  )
  pattern <- paste0("(", paste(potential_answers, collapse = "|"), ")")
  answer_in_rmd <- stringr::str_detect(.rmd_content, pattern) |> any()
  expect_equal(answer_in_rmd, TRUE,
    info = "Include code to create a tibble with title, artist, and link columns for Exercise 3"
  )
})

test_that("Exercise 4 references a second page URL", {
  skip_if(length(.rmd_content) == 0 & length(.r_script_content) == 0)
  potential_answers <- c(
    "second_url", "offset=10", "second_ten"
  )
  pattern <- paste0("(", paste(potential_answers, collapse = "|"), ")")
  answer_in_rmd <- stringr::str_detect(.rmd_content, pattern) |> any()
  expect_equal(answer_in_rmd, TRUE,
    info = "Define second_url (offset=10) and scrape second_ten in your Rmd for Exercise 4"
  )
})

test_that("Exercise 5 defines the scrape_page function", {
  skip_if(length(.rmd_content) == 0 & length(.r_script_content) == 0)
  potential_answers <- c(
    "scrape_page\\s*<-\\s*function",
    "function\\(url\\)",
    "scrape_page"
  )
  pattern <- paste0("(", paste(potential_answers, collapse = "|"), ")")
  answer_in_rmd <- stringr::str_detect(.rmd_content, pattern) |> any()
  expect_equal(answer_in_rmd, TRUE,
    info = "Define the scrape_page function in your Rmd for Exercise 5"
  )
})

test_that("Exercise 6 tests scrape_page with first_url and second_url", {
  skip_if(length(.rmd_content) == 0 & length(.r_script_content) == 0)
  potential_answers <- c(
    "scrape_page\\(first_url\\)",
    "scrape_page\\(second_url\\)",
    "scrape_page\\("
  )
  pattern <- paste0("(", paste(potential_answers, collapse = "|"), ")")
  answer_in_rmd <- stringr::str_detect(.rmd_content, pattern) |> any()
  expect_equal(answer_in_rmd, TRUE,
    info = "Call scrape_page() to test your function on first_url and/or second_url for Exercise 6"
  )
})

test_that("Exercise 7 contains URL list construction code", {
  skip_if(length(.rmd_content) == 0 & length(.r_script_content) == 0)
  potential_answers <- c(
    "paste0\\(", "seq\\(", "urls\\s*<-", "root"
  )
  pattern <- paste0("(", paste(potential_answers, collapse = "|"), ")")
  answer_in_rmd <- stringr::str_detect(.rmd_content, pattern) |> any()
  expect_equal(answer_in_rmd, TRUE,
    info = "Build the 'urls' vector with paste0() and seq() for Exercise 7"
  )
})

test_that("Exercise 8 contains map iteration to build uoe_art", {
   skip_if(length(.rmd_content) == 0 & length(.r_script_content) == 0)
  potential_answers <- c(
    "map_dfr|map_df\\b|map\\(",
    "purrr",
    "lapply",
    "uoe_art"
  )
  pattern <- paste0("(", paste(potential_answers, collapse = "|"), ")")
  answer_in_rmd <- stringr::str_detect(.rmd_content, pattern) |> any()
  expect_equal(answer_in_rmd, TRUE,
    info = "Use map_dfr(urls, scrape_page) to scrape all pages into uoe_art for Exercise 8"
  )
})

test_that("Exercise 9 contains write_csv or equivalent to save uoe_art", {
  skip_if(length(.rmd_content) == 0 & length(.r_script_content) == 0)
  potential_answers <- c(
    "write_csv\\(", "write\\.csv\\(",
    "saveRDS\\(", "save\\("
  )
  pattern <- paste0("(", paste(potential_answers, collapse = "|"), ")")
  answer_in_rmd <- stringr::str_detect(.rmd_content, pattern) |> any()
  expect_equal(answer_in_rmd, TRUE,
    info = "Save uoe_art to the data folder using write_csv() for Exercise 9"
  )
})

test_that("Exercise 10 contains separate() and year-extraction code", {
  skip_if(length(.rmd_content) == 0 & length(.r_script_content) == 0)
  potential_answers <- c(
    "separate\\(", "str_extract\\(", "str_remove\\(",
    "as\\.numeric\\(", "parse_number\\("
  )
  pattern <- paste0("(", paste(potential_answers, collapse = "|"), ")")
  answer_in_rmd <- stringr::str_detect(.rmd_content, pattern) |> any()
  expect_equal(answer_in_rmd, TRUE,
    info = "Use separate() to split title/date and str_extract() to capture year for Exercise 10"
  )
})

test_that("Exercise 11 contains skim() to report missing values", {
  skip_if(length(.rmd_content) == 0 & length(.r_script_content) == 0)
  potential_answers <- c(
    "skim\\(", "skimr",
    "summary\\(.*uoe_art", "glimpse\\("
  )
  pattern <- paste0("(", paste(potential_answers, collapse = "|"), ")")
  answer_in_rmd <- stringr::str_detect(.rmd_content, pattern) |> any()
  expect_equal(answer_in_rmd, TRUE,
    info = "Use skim() to print a summary reporting how many pieces have missing artist or year for Exercise 11"
  )
})

test_that("Exercise 12 contains a histogram of years", {
  skip_if(length(.rmd_content) == 0 & length(.r_script_content) == 0)
  potential_answers <- c(
    "geom_histogram", "hist\\(",
    "ggplot\\(.*aes.*year|aes\\(.*year"
  )
  pattern <- paste0("(", paste(potential_answers, collapse = "|"), ")")
  answer_in_rmd <- stringr::str_detect(.rmd_content, pattern) |> any()
  expect_equal(answer_in_rmd, TRUE,
    info = "Create a histogram of years using ggplot2 (geom_histogram()) for Exercise 12"
  )
})

test_that("Exercise 13 contains year-correction code", {
  skip_if(length(.rmd_content) == 0 & length(.r_script_content) == 0)
  potential_answers <- c(
    "mutate\\(",
    "if_else\\(|ifelse\\(|case_when\\("
  )
  pattern <- paste0("(", paste(potential_answers, collapse = "|"), ")")
  answer_in_rmd <- stringr::str_detect(.rmd_content, pattern) |> any()
  expect_equal(answer_in_rmd, TRUE,
    info = "Use mutate() with if_else() or case_when() to correct the out-of-range year for Exercise 13"
  )
})

test_that("Exercise 14 contains code to identify the most common artist", {
  skip_if(length(.rmd_content) == 0 & length(.r_script_content) == 0)
  potential_answers <- c(
    "count\\(", "n_distinct", "group_by.*artist|artist.*group_by",
    "sort.*artist|arrange.*artist"
  )
  pattern <- paste0("(", paste(potential_answers, collapse = "|"), ")")
  answer_in_rmd <- stringr::str_detect(.rmd_content, pattern) |> any()
  expect_equal(answer_in_rmd, TRUE,
    info = "Use count() or group_by()/summarise() to find the most frequently featured artist for Exercise 14"
  )
})

test_that("Exercise 15 contains str_detect or filter code for 'child' in title", {
  skip_if(length(.rmd_content) == 0 & length(.r_script_content) == 0)
  potential_answers <- c(
    "str_detect\\(", "grepl\\(",
    "child", "filter\\("
  )
  pattern <- paste0("(", paste(potential_answers, collapse = "|"), ")")
  answer_in_rmd <- stringr::str_detect(.rmd_content, pattern) |> any()
  expect_equal(answer_in_rmd, TRUE,
    info = "Use filter() with str_detect() to find art pieces with 'child' in the title for Exercise 15"
  )
})
