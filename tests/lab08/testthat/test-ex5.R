# Exercise 5: Writing the scrape_page function

test_that("Ex 5: scrape_page function is defined in the Rmd", {
  skip_if(length(.rmd_content) == 0 & length(.r_script_content) == 0)
  potential_answers <- c(
    "scrape_page\\s*<-\\s*function",
    "function\\(url\\)"
  )
  pattern <- paste0("(", paste(potential_answers, collapse = "|"), ")")
  answer_in_rmd <- stringr::str_detect(.rmd_content, pattern) |> any()
  answer_in_rscript <- stringr::str_detect(.r_script_content, pattern) |> any()
  answer_in_r <- answer_in_rmd | answer_in_rscript
  expect_equal(answer_in_r, TRUE,
    info = "Define the scrape_page function (e.g., scrape_page <- function(url) { ... }) for Exercise 5"
  )
})

test_that("Ex 5: scrape_page function exists in the environment", {
  expect_true(exists("scrape_page"),
    info = "Define a function called 'scrape_page' in your code for Exercise 5"
  )
})

test_that("Ex 5: scrape_page is a function", {
  skip_if(!exists("scrape_page"))
  expect_true(is.function(scrape_page),
    info = "Make sure 'scrape_page' is defined using function() for Exercise 5"
  )
})

test_that("Ex 5: scrape_page accepts a url argument", {
  skip_if(!exists("scrape_page") || !is.function(scrape_page))
  args <- formals(scrape_page)
  expect_true(length(args) >= 1,
    info = "scrape_page should accept at least one argument (a URL) for Exercise 5"
  )
})

test_that("Ex 5: scrape_page body references title, artist, and link extraction", {
  skip_if(!exists("scrape_page") || !is.function(scrape_page))
  body_text <- paste(deparse(body(scrape_page)), collapse = " ")
  has_title <- grepl("title|h3|html_text", body_text, ignore.case = TRUE)
  has_link <- grepl("link|href|html_attr", body_text, ignore.case = TRUE)
  expect_true(has_title && has_link,
    info = "scrape_page should extract title, artist, and link info from a page"
  )
})
