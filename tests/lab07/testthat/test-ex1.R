# Exercise 1: Load and explore the Kansas COVID-19 mask mandate data

test_that("Ex 1: Kansas rolling average data can be loaded", {
  # Check multiple possible file locations
  found <- file.exists("data/kansas_grouped_rolling_avg.csv") ||
           file.exists("kansas_grouped_rolling_avg.csv")
  skip_if(!found, message = "kansas_grouped_rolling_avg.csv not found")
  f <- if (file.exists("data/kansas_grouped_rolling_avg.csv")) {
    "data/kansas_grouped_rolling_avg.csv"
  } else {
    "kansas_grouped_rolling_avg.csv"
  }
  df <- readr::read_csv(f, show_col_types = FALSE)
  expect_true(nrow(df) > 0)
})

test_that("Ex 1: df object exists", {
  expect_true(exists("df"),
              label = "df should be created by reading the Kansas COVID data")
})

test_that("Ex 1: df has expected columns", {
  skip_if(!exists("df"))
  expect_true(all(c("date", "mask_mandate", "rolling_avg") %in% names(df)),
              label = "df should have date, mask_mandate, and rolling_avg columns")
})

test_that("Ex 1: df has both mask and no-mask groups", {
  skip_if(!exists("df") || !"mask_mandate" %in% names(df))
  n_groups <- dplyr::n_distinct(df$mask_mandate)
  expect_equal(n_groups, 2,
               label = "There should be exactly 2 mask mandate groups")
})
