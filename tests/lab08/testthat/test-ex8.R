# Exercise 8: Mapping scrape_page over all URLs to build uoe_art

test_that("Ex 8: uoe_art was created by iterating over multiple pages", {
  .art <- if (exists("uoe_art")) uoe_art else .find_art_df()
  skip_if(is.null(.art))
  expect_true(nrow(.art) >= 100,
    info = "uoe_art should contain art pieces from many pages — use map_dfr(urls, scrape_page)"
  )
})

test_that("Ex 8: Rmd or scripts contain map or iteration code for scraping all pages", {
  skip_if(length(.rmd_content) == 0 & length(.r_script_content) == 0)
  potential_answers <- c(
    "map_dfr|map_df\\b|map\\(",
    "purrr",
    "lapply",
    "scrape_page"
  )
  pattern <- paste0("(", paste(potential_answers, collapse = "|"), ")")
  answer_in_rmd <- stringr::str_detect(.rmd_content, pattern) |> any()
  answer_in_rscript <- stringr::str_detect(.r_script_content, pattern) |> any()
  answer_in_r <- answer_in_rmd | answer_in_rscript
  expect_equal(answer_in_r, TRUE,
    info = "Include iteration code (e.g., map_dfr(urls, scrape_page)) in your Rmd or scripts/ for Exercise 8"
  )
})

test_that("Ex 8: uoe_art has title, artist, and link columns", {
  .art <- if (exists("uoe_art")) uoe_art else .find_art_df()
  skip_if(is.null(.art))
  expect_true(all(c("title", "artist", "link") %in% names(.art)),
    info = "uoe_art should have title, artist, and link columns — same structure as a single page result"
  )
})

test_that("Ex 9: Rmd or scripts contain write_csv or write.csv to save uoe_art", {
  skip_if(length(.rmd_content) == 0 & length(.r_script_content) == 0)
  potential_answers <- c(
    "write_csv\\(", "write\\.csv\\(", "saveRDS\\(",
    "save\\(.*uoe_art"
  )
  pattern <- paste0("(", paste(potential_answers, collapse = "|"), ")")
  answer_in_rmd <- stringr::str_detect(.rmd_content, pattern) |> any()
  answer_in_rscript <- stringr::str_detect(.r_script_content, pattern) |> any()
  answer_in_r <- answer_in_rmd | answer_in_rscript
  expect_equal(answer_in_r, TRUE,
    info = "Use write_csv() to save the art data to the data folder for Exercise 9 (in your Rmd or scripts/)"
  )
})
