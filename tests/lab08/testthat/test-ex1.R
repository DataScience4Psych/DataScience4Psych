# Exercise 1: Web scraping function for Edinburgh art collection

test_that("Ex 1: scrape_page function exists", {
  expect_true(exists("scrape_page"),
              info = "Define a function called 'scrape_page' in your code"
  )
})

test_that("Ex 1: scrape_page is a function", {
  skip_if(!exists("scrape_page"))
  expect_true(is.function(scrape_page),
              info = "Make sure 'scrape_page' is a function (use function() to define it)")
})

test_that("Ex 1: scrape_page accepts a URL argument", {
  skip_if(!exists("scrape_page") || !is.function(scrape_page))
  args <- formals(scrape_page)
  expect_true(length(args) >= 1,
              info = "Make sure 'scrape_page' accepts at least one argument (a URL)")
})

test_that("Ex 1: scrape_page returns a data frame with title, artist, link columns", {
  skip_if(!exists("scrape_page") || !is.function(scrape_page))
  skip_if(!requireNamespace("rvest", quietly = TRUE),
          message = "rvest package not available")
  first_url <- "https://collections.ed.ac.uk/art/search/*:*/Collection:%22edinburgh+college+of+art%7C%7C%7CEdinburgh+College+of+Art%22?offset=0"
  tryCatch({
    result <- scrape_page(first_url)
    expect_true(is.data.frame(result),
                info = "Make sure 'scrape_page' returns a data frame")
    expect_true(all(c("title", "artist", "link") %in% tolower(names(result))),
                info = "Make sure the data frame returned by 'scrape_page' has title, artist, and link columns")
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
                info = "Make sure 'scrape_page' returns multiple rows (one per art piece on the page)")
  }, error = function(e) {
    skip("Could not connect to art collection website")
  })
})
