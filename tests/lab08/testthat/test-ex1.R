# Exercise 1: Fix scraped URLs using str_replace()

test_that("Ex 1: Rmd uses str_replace to fix URLs", {
  skip_if(length(.rmd_content) == 0)
  potential_answers <- c(
    "str_replace",
    "gsub",
    "sub\\("
  )
  pattern <- paste0("(", paste(potential_answers, collapse = "|"), ")")
  answer_in_rmd <- stringr::str_detect(.rmd_content, pattern) |> any()
  expect_equal(answer_in_rmd, TRUE,
    info = "Ex 1: Use str_replace() to fix the scraped URLs"
  )
})

test_that("Ex 1: Rmd uses rvest to scrape HTML content", {
  skip_if(length(.rmd_content) == 0)
  potential_answers <- c(
    "library\\(rvest\\)",
    "rvest::",
    "read_html",
    "html_nodes"
  )
  pattern <- paste0("(", paste(potential_answers, collapse = "|"), ")")
  answer_in_rmd <- stringr::str_detect(.rmd_content, pattern) |> any()
  expect_equal(answer_in_rmd, TRUE,
    info = "Ex 1: Use the rvest package to scrape the Edinburgh art collection page"
  )
})

test_that("Ex 2: Rmd scrapes artist names", {
  skip_if(length(.rmd_content) == 0)
  potential_answers <- c(
    "artist",
    "html_text",
    "html_attr"
  )
  pattern <- paste0("(", paste(potential_answers, collapse = "|"), ")")
  answer_in_rmd <- stringr::str_detect(.rmd_content, pattern) |> any()
  expect_equal(answer_in_rmd, TRUE,
    info = "Ex 2: Scrape artist names from the art collection page"
  )
})

test_that("Ex 3: Rmd organizes data into a tibble", {
  skip_if(length(.rmd_content) == 0)
  potential_answers <- c(
    "tibble\\(",
    "data\\.frame\\(",
    "data_frame\\("
  )
  pattern <- paste0("(", paste(potential_answers, collapse = "|"), ")")
  answer_in_rmd <- stringr::str_detect(.rmd_content, pattern) |> any()
  expect_equal(answer_in_rmd, TRUE,
    info = "Ex 3: Organize scraped data (title, link, artist) into a tibble"
  )
})
