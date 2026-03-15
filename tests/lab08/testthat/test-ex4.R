# Exercise 4: Scraping the next page

test_that("Ex 4: second_url is defined", {
  expect_true(exists("second_url"),
    info = "Define 'second_url' as the URL for the second page (offset=10)"
  )
})

test_that("Ex 4: second_url contains offset=10", {
  skip_if(!exists("second_url"))
  expect_true(grepl("offset=10", second_url),
    info = "second_url should point to the second page — check that it contains 'offset=10'"
  )
})

test_that("Ex 4: second_ten object exists", {
  skip_if(!exists("second_ten"),
    message = "second_ten not found; scrape the second page and save the results as 'second_ten'"
  )
  expect_true(is.data.frame(second_ten),
    info = "Make sure 'second_ten' is a data frame or tibble"
  )
})

test_that("Ex 4: second_ten has title, artist, and link columns", {
  skip_if(!exists("second_ten"))
  expect_true(all(c("title", "artist", "link") %in% tolower(names(second_ten))),
    info = "Make sure 'second_ten' has title, artist, and link columns (same structure as first_ten)"
  )
})

test_that("Ex 4: second_ten has exactly 10 rows", {
  skip_if(!exists("second_ten"))
  expect_equal(nrow(second_ten), 10,
    info = "second_ten should contain 10 art pieces from the second page"
  )
})

test_that("Ex 4: second_ten and first_ten contain different art pieces", {
  skip_if(!exists("second_ten") || !exists("first_ten"))
  ft_names <- tolower(names(first_ten))
  st_names <- tolower(names(second_ten))
  skip_if(!"title" %in% ft_names || !"title" %in% st_names)
  ft_title_col <- names(first_ten)[ft_names == "title"][1]
  st_title_col <- names(second_ten)[st_names == "title"][1]
  ft_titles <- first_ten[[ft_title_col]]
  st_titles <- second_ten[[st_title_col]]
  expect_true(length(intersect(ft_titles, st_titles)) < 5,
    info = "first_ten and second_ten should contain different art pieces (from different pages)"
  )
})
