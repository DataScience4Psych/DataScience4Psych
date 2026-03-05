# Exercise 3: Fisheries visualization

test_that("Ex 3: fisheries data can be loaded", {
  skip_if(!file.exists("data/fisheries.csv"),
          message = "data/fisheries.csv not found")
  fisheries <- readr::read_csv("data/fisheries.csv", show_col_types = FALSE)
  expect_true(nrow(fisheries) > 0)
})

test_that("Ex 3: fisheries has country column", {
  skip_if(!file.exists("data/fisheries.csv"))
  fisheries <- readr::read_csv("data/fisheries.csv", show_col_types = FALSE)
  expect_true("country" %in% names(fisheries),
              label = "fisheries should have a country column")
})
