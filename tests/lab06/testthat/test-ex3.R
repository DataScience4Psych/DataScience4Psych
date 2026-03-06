# Exercise 3: Fisheries visualization

test_that("Ex 3: fisheries object exists", {
  expect_true(exists("fisheries"),
              info ="fisheries should be created by reading data/fisheries.csv"
  )
})

test_that("Ex 3: fisheries is a data frame", {
  skip_if(!exists("fisheries"))
  expect_true(is.data.frame(fisheries),
              info ="fisheries should be a data frame")
})

test_that("Ex 3: fisheries has country column", {
  skip_if(!exists("fisheries"))
  expect_true("country" %in% names(fisheries),
              info ="fisheries should have a country column")
})

test_that("Ex 3: fisheries has multiple rows of data", {
  skip_if(!exists("fisheries"))
  expect_true(nrow(fisheries) > 1,
              info ="fisheries should have multiple rows of data")
})

test_that("Ex 3: fisheries has numeric columns for fish production", {
  skip_if(!exists("fisheries"))
  # At least one column besides country should be numeric
  numeric_cols <- sapply(fisheries, is.numeric)
  expect_true(sum(numeric_cols) >= 1,
              info ="fisheries should have at least one numeric column for fish production values")
})
