# Exercises 7-8: URL list construction and iteration over all pages

test_that("Ex 7: urls object exists", {
  expect_true(exists("urls"),
    info = "Create a 'urls' vector of all page URLs using paste0() and seq()"
  )
})

test_that("Ex 7: urls is a character vector", {
  skip_if(!exists("urls"))
  expect_true(is.character(urls),
    info = "urls should be a character vector of page URLs"
  )
})

test_that("Ex 7: urls has multiple entries (at least 10)", {
  skip_if(!exists("urls"))
  expect_true(length(urls) >= 10,
    info = "urls should contain at least 10 page URLs (the collection spans many pages)"
  )
})

test_that("Ex 7: urls entries contain the 'offset=' pattern", {
  skip_if(!exists("urls"))
  expect_true(all(grepl("offset=", urls)),
    info = "Each URL in 'urls' should contain 'offset=' to specify the page offset — use seq() and paste0()"
  )
})

test_that("Ex 7: urls entries are full URLs starting with https://", {
  skip_if(!exists("urls"))
  expect_true(all(grepl("^https?://", urls)),
    info = "Each entry in 'urls' should be a complete URL starting with 'https://'"
  )
})

test_that("Ex 7: urls starts at offset=0 (first page)", {
  skip_if(!exists("urls"))
  expect_true(any(grepl("offset=0$", urls) | grepl("offset=0[^0-9]", urls)),
    info = "The 'urls' vector should include the first page (offset=0)"
  )
})

test_that("Ex 7: urls offsets are multiples of 10", {
  skip_if(!exists("urls"))
  offset_matches <- stringr::str_match(urls, "offset=(\\d+)")
  offsets <- as.integer(offset_matches[, 2])
  offsets <- offsets[!is.na(offsets)]
  skip_if(length(offsets) == 0, message = "Could not extract offsets from urls")
  expect_true(all(offsets %% 10 == 0),
    info = "Each URL offset should be a multiple of 10 (pages display 10 pieces each)"
  )
})

test_that("Ex 7: Rmd contains code to construct urls using paste0() and seq()", {
  skip_if(length(.rmd_content) == 0)
  potential_answers <- c("paste0\\(", "seq\\(", "urls\\s*<-", "root")
  pattern <- paste0("(", paste(potential_answers, collapse = "|"), ")")
  answer_in_rmd <- stringr::str_detect(.rmd_content, pattern) |> any()
  expect_equal(answer_in_rmd, TRUE,
    info = "Include code to build the 'urls' vector (e.g., paste0(root, seq(0, ..., by=10))) for Exercise 7"
  )
})

test_that("Ex 8: uoe_art was created by iterating over multiple pages", {
  skip_if(!exists("uoe_art"))
  expect_true(nrow(uoe_art) >= 100,
    info = "uoe_art should contain art pieces from many pages — use map_dfr(urls, scrape_page)"
  )
})

test_that("Ex 8: Rmd contains map or iteration code for scraping all pages", {
  skip_if(length(.rmd_content) == 0)
  potential_answers <- c(
    "map_dfr|map_df\\b|map\\(",
    "purrr",
    "lapply",
    "scrape_page"
  )
  pattern <- paste0("(", paste(potential_answers, collapse = "|"), ")")
  answer_in_rmd <- stringr::str_detect(.rmd_content, pattern) |> any()
  expect_equal(answer_in_rmd, TRUE,
    info = "Include iteration code (e.g., map_dfr(urls, scrape_page)) in your Rmd for Exercise 8"
  )
})

test_that("Ex 9: Rmd contains write_csv or write.csv to save uoe_art", {
  skip_if(length(.rmd_content) == 0)
  potential_answers <- c(
    "write_csv\\(", "write\\.csv\\(", "saveRDS\\(",
    "save\\(.*uoe_art"
  )
  pattern <- paste0("(", paste(potential_answers, collapse = "|"), ")")
  answer_in_rmd <- stringr::str_detect(.rmd_content, pattern) |> any()
  expect_equal(answer_in_rmd, TRUE,
    info = "Use write_csv() to save 'uoe_art' to the data folder for Exercise 9"
  )
})
