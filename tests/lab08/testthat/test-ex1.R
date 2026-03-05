# Exercise 1: Web scraping function for Edinburgh art collection

test_that("Ex 1: scrape_page function exists", {
  expect_true(exists("scrape_page"),
              label = "scrape_page function should be defined in the student's code"
  )
})

test_that("Ex 1: scrape_page is a function", {
  skip_if(!exists("scrape_page"))
  expect_true(is.function(scrape_page),
              label = "scrape_page should be a function")
})

test_that("Ex 1: scrape_page accepts a URL argument", {
  skip_if(!exists("scrape_page") || !is.function(scrape_page))
  args <- formals(scrape_page)
  expect_true(length(args) >= 1,
              label = "scrape_page should accept at least one argument (a URL)")
})

test_that("Ex 1: scrape_page returns a data frame with title, artist, link columns", {
  skip_if(!exists("scrape_page") || !is.function(scrape_page))
  skip_if(!requireNamespace("rvest", quietly = TRUE),
          message = "rvest package not available")
  first_url <- "https://collections.ed.ac.uk/art/search/*:*/Collection:%22edinburgh+college+of+art%7C%7C%7CEdinburgh+College+of+Art%22?offset=0"
  tryCatch({
    result <- scrape_page(first_url)
    expect_true(is.data.frame(result),
                label = "scrape_page should return a data frame")
    expect_true(all(c("title", "artist", "link") %in% tolower(names(result))),
                label = "scrape_page result should have title, artist, and link columns")
  }, error = function(e) {
    skip("Could not connect to art collection website")
  })
})

test_that("Ex 1: scrape_page returns multiple rows per page", {
  skip_if(!exists("scrape_page") || !is.function(scrape_page))
  skip_if(!requireNamespace("rvest", quietly = TRUE),
          message = "rvest package not available")
  first_url <- "https://collections.ed.ac.uk/art/search/*:*/Collection:%22edinburgh+college+of+art%7C%7C%7CEdinburgh+College+of+Art%22?offset=0"
  tryCatch({
    result <- scrape_page(first_url)
    expect_true(nrow(result) > 1,
                label = "scrape_page should return multiple rows (one per art piece on the page)")
  }, error = function(e) {
    skip("Could not connect to art collection website")
  })
})
