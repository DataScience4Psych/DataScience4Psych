# Exercise 8 & 9: Scrape all pages and save uoe_art data frame

test_that("Ex 8: Rmd uses map_dfr or map to scrape all pages", {
  skip_if(length(.rmd_content) == 0)
  potential_answers <- c(
    "map_dfr",
    "map_df",
    "purrr::map",
    "lapply",
    "map\\("
  )
  pattern <- paste0("(", paste(potential_answers, collapse = "|"), ")")
  answer_in_rmd <- stringr::str_detect(.rmd_content, pattern) |> any()
  expect_equal(answer_in_rmd, TRUE,
    info = "Ex 8: Use map_dfr() or similar to scrape all pages"
  )
})

test_that("Ex 8: uoe_art data frame exists", {
  expect_true(exists("uoe_art"),
    label = "uoe_art should be created by scraping all pages of the art collection"
  )
})

test_that("Ex 8: uoe_art has title, link, and artist columns", {
  skip_if(!exists("uoe_art"))
  expected_cols <- c("title", "link", "artist")
  expect_true(
    all(expected_cols %in% names(uoe_art)),
    label = paste("uoe_art should have columns:", paste(expected_cols, collapse = ", "))
  )
})

test_that("Ex 9: Rmd saves uoe_art to data folder", {
  skip_if(length(.rmd_content) == 0)
  potential_answers <- c(
    "write_csv.*uoe_art",
    "write\\.csv.*uoe_art",
    "saveRDS.*uoe_art",
    "save.*uoe_art"
  )
  pattern <- paste0("(", paste(potential_answers, collapse = "|"), ")")
  answer_in_rmd <- stringr::str_detect(.rmd_content, pattern) |> any()
  expect_equal(answer_in_rmd, TRUE,
    info = "Ex 9: Save the uoe_art data frame to the data/ folder"
  )
})
