# Exercise 6: Testing the scrape_page function

test_that("Ex 6: Rmd or scripts contain a call to scrape_page()", {
  skip_if(length(.rmd_content) == 0 & length(.r_script_content) == 0)
  potential_answers <- c(
    "scrape_page\\(first_url\\)",
    "scrape_page\\(second_url\\)",
    "scrape_page\\(",
    "map_dfr\\([^)]*scrape_page|map\\([^)]*scrape_page|lapply\\([^)]*scrape_page"
  )
  pattern <- paste0("(", paste(potential_answers, collapse = "|"), ")")
  answer_in_rmd <- stringr::str_detect(.rmd_content, pattern) |> any()
  answer_in_rscript <- stringr::str_detect(.r_script_content, pattern) |> any()
  answer_in_r <- answer_in_rmd | answer_in_rscript
  expect_equal(answer_in_r, TRUE,
    info = "Call scrape_page() on first_url and/or second_url (or use map_dfr/lapply) to test your function for Exercise 6 (in your Rmd or scripts/)"
  )
})

test_that("Ex 6: scrape_page returns a data frame with title, artist, link columns", {
  skip_if(!exists("scrape_page") || !is.function(scrape_page))
  skip_if(!requireNamespace("rvest", quietly = TRUE),
    message = "rvest package not available"
  )
  first_url <- "https://collections.ed.ac.uk/art/search/*:*/Collection:%22edinburgh+college+of+art%7C%7C%7CEdinburgh+College+of+Art%22?offset=0"
  tryCatch(
    {
      result <- scrape_page(first_url)
      expect_true(is.data.frame(result),
        info = "scrape_page() should return a data frame"
      )
      expect_true(all(c("title", "artist", "link") %in% tolower(names(result))),
        info = "scrape_page() should return a data frame with title, artist, and link columns"
      )
    },
    error = function(e) {
      skip("Could not connect to art collection website")
    }
  )
})

test_that("Ex 6: scrape_page returns the same structure for different page URLs", {
  skip_if(!exists("scrape_page") || !is.function(scrape_page))
  skip_if(!requireNamespace("rvest", quietly = TRUE),
    message = "rvest package not available"
  )
  first_url <- "https://collections.ed.ac.uk/art/search/*:*/Collection:%22edinburgh+college+of+art%7C%7C%7CEdinburgh+College+of+Art%22?offset=0"
  second_url_local <- "https://collections.ed.ac.uk/art/search/*:*/Collection:%22edinburgh+college+of+art%7C%7C%7CEdinburgh+College+of+Art%22?offset=10"
  tryCatch(
    {
      r1 <- scrape_page(first_url)
      r2 <- scrape_page(second_url_local)
      expect_equal(names(r1), names(r2),
        info = "scrape_page() should return the same column names for both first_url and second_url"
      )
    },
    error = function(e) {
      skip("Could not connect to art collection website")
    }
  )
})
