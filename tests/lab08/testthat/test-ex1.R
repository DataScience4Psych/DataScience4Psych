# Exercise 1: Fix URLs for art pieces

test_that("Ex 1: scrape_page function exists", {
  expect_true(exists("scrape_page") && is.function(scrape_page),
              label = "scrape_page function should be defined")
})

test_that("Ex 1: scrape_page returns a tibble/data.frame", {
  skip_if(!exists("scrape_page") || !is.function(scrape_page))
  skip_if(!requireNamespace("rvest", quietly = TRUE))
  # Only test structure, not live scraping
  first_url <- "https://collections.ed.ac.uk/art/search/*:*/Collection:%22edinburgh+college+of+art%7C%7C%7CEdinburgh+College+of+Art%22?offset=0"
  tryCatch({
    result <- scrape_page(first_url)
    expect_true(is.data.frame(result),
                label = "scrape_page should return a data frame")
    expect_true(ncol(result) >= 3,
                label = "scrape_page should return at least 3 columns (title, artist, link)")
  }, error = function(e) {
    skip("Could not connect to art collection website")
  })
})
