# Exercise 5 & 6: Define and test scrape_page function

test_that("Ex 5: scrape_page function exists", {
  expect_true(exists("scrape_page") && is.function(scrape_page),
    label = "scrape_page function should be defined"
  )
})

test_that("Ex 5: Rmd defines scrape_page function", {
  skip_if(length(.rmd_content) == 0)
  answer_in_rmd <- stringr::str_detect(.rmd_content, "scrape_page") |> any()
  expect_equal(answer_in_rmd, TRUE,
    info = "Ex 5: Define a scrape_page() function that takes a URL and returns a tibble"
  )
})

test_that("Ex 4: second_ten data frame exists from second page", {
  skip_if(!exists("second_ten"))
  expect_true(is.data.frame(second_ten),
    label = "second_ten should be a data frame of art pieces from the second page"
  )
})

test_that("Ex 4: second_ten has the expected columns", {
  skip_if(!exists("second_ten"))
  expected_cols <- c("title", "link", "artist")
  found_cols <- intersect(expected_cols, names(second_ten))
  expect_gt(length(found_cols), 0,
    label = "second_ten should have title, link, and/or artist columns"
  )
})
