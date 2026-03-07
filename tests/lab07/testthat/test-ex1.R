# Exercise 1: Load and explore the Kansas COVID-19 mask mandate data

test_that("Ex 1: df object exists", {
  expect_true(exists("df"),
              info = "Create a data frame called 'df' by reading the Kansas COVID rolling average data"
  )
})

test_that("Ex 1: df is a data frame", {
  skip_if(!exists("df"))
  expect_true(is.data.frame(df),
              info = "Make sure 'df' is a data frame")
})

test_that("Ex 1: df has date column", {
  skip_if(!exists("df"))
  expect_true("date" %in% names(df),
              info = "Make sure your data frame 'df' has a column named 'date'")
})

test_that("Ex 1: df has mask_mandate column", {
  skip_if(!exists("df"))
  expect_true("mask_mandate" %in% names(df),
              info = "Make sure your data frame 'df' has a column named 'mask_mandate'")
})

test_that("Ex 1: df has rolling_avg column", {
  skip_if(!exists("df"))
  expect_true("rolling_avg" %in% names(df),
              info = "Make sure your data frame 'df' has a column named 'rolling_avg'")
})

test_that("Ex 1: df has exactly 2 mask_mandate groups", {
  skip_if(!exists("df") || !"mask_mandate" %in% names(df))
  n_groups <- dplyr::n_distinct(df$mask_mandate)
  expect_equal(n_groups, 2,
               info = "Your 'df' should have exactly 2 mask mandate groups (mask vs no mask)")
})

test_that("Ex 1: df has multiple dates (time series data)", {
  skip_if(!exists("df") || !"date" %in% names(df))
  n_dates <- dplyr::n_distinct(df$date)
  expect_true(n_dates > 10,
              info = "Your 'df' should contain multiple dates for a time series")
})

test_that("Ex 1: rolling_avg values are numeric", {
  skip_if(!exists("df") || !"rolling_avg" %in% names(df))
  expect_true(is.numeric(df$rolling_avg),
              info = "Make sure 'rolling_avg' is numeric")
})

test_that("Ex 1: rolling_avg values are non-negative", {
  skip_if(!exists("df") || !"rolling_avg" %in% names(df))
  expect_true(all(df$rolling_avg >= 0, na.rm = TRUE),
              info = "Check that 'rolling_avg' values are non-negative (case rates should be >= 0)")
})
