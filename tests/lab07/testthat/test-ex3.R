# Exercise 3: Mask Mandate Analysis (lab Exercises 7–9)
# Note: test files for lab07 use internal numbering — test-ex3 covers the rolling average (lab Ex 7)
# and the resulting visualization output that students produce in lab Exercises 7–9.

test_that("both mask mandate groups have data across multiple dates", {
  skip_if(!exists("df"))
  skip_if(!all(c("date", "mask_mandate") %in% names(df)))
  group_counts <- df %>%
    dplyr::group_by(mask_mandate) %>%
    dplyr::summarize(n_dates = dplyr::n_distinct(date), .groups = "drop")
  expect_true(all(group_counts$n_dates > 5),
    info = "Make sure each mask mandate group has data across many dates"
  )
})

test_that("mask counties show lower rolling average by end of period", {
  skip_if(!exists("df"))
  skip_if(!all(c("date", "mask_mandate", "rolling_avg") %in% names(df)))
  last_date <- max(df$date, na.rm = TRUE)
  last_vals <- df %>%
    dplyr::filter(date == last_date)
  skip_if(nrow(last_vals) < 2,
    message = "Could not find both groups on the last date"
  )
  mask_val <- last_vals$rolling_avg[stringr::str_detect(last_vals$mask_mandate, "[Mm]ask") &
    !stringr::str_detect(last_vals$mask_mandate, "[Nn]o")]
  nomask_val <- last_vals$rolling_avg[stringr::str_detect(last_vals$mask_mandate, "[Nn]o")]
  skip_if(length(mask_val) == 0 || length(nomask_val) == 0,
    message = "Could not identify mask vs no-mask groups"
  )
  expect_true(mask_val[1] < nomask_val[1],
    info = "Mask mandate counties should show lower case rates by end of period — check your plot reflects this"
  )
})

test_that("Ex 3: df object exists", {
  expect_true(exists("df"),
              info = "Create a data frame called 'df' (or similar) containing the grouped rolling average by mask mandate status")
})

test_that("Ex 3: df has exactly three expected columns", {
  skip_if(!exists("df"))
  expect_true(all(c("date", "rolling_avg", "mask_mandate") %in% names(df)),
              info = "df should have columns: date, rolling_avg, and mask_mandate")
})

test_that("Ex 3: df date column is Date type", {
  skip_if(!exists("df") || !"date" %in% names(df))
  expect_true(inherits(df$date, "Date"),
              info = "The date column in df should be a proper Date type")
})

test_that("Ex 3: df contains exactly two mask mandate groups", {
  skip_if(!exists("df") || !"mask_mandate" %in% names(df))
  n_groups <- dplyr::n_distinct(df$mask_mandate)
  expect_equal(n_groups, 2,
               info = "df should have exactly two groups in mask_mandate (Mask and No Mask)")
})

test_that("Ex 3: df dates fall within the study window (July 12 – August 3, 2020)", {
  skip_if(!exists("df") || !"date" %in% names(df))
  min_date <- min(df$date, na.rm = TRUE)
  max_date <- max(df$date, na.rm = TRUE)
  expect_true(min_date >= as.Date("2020-07-01"),
              info = sprintf("Earliest date should be on or after July 1, 2020 — found %s", min_date))
  expect_true(max_date <= as.Date("2020-08-10"),
              info = sprintf("Latest date should be on or before August 10, 2020 — found %s", max_date))
})

test_that("Ex 3: df rolling_avg column is numeric", {
  skip_if(!exists("df") || !"rolling_avg" %in% names(df))
  expect_true(is.numeric(df$rolling_avg),
              info = "rolling_avg should be a numeric column")
})

test_that("Ex 3: df has no NA values in rolling_avg", {
  skip_if(!exists("df") || !"rolling_avg" %in% names(df))
  expect_true(sum(is.na(df$rolling_avg)) == 0,
              info = "After filtering, df should have no NA values in rolling_avg — did you drop NAs?")
})

test_that("Ex 3: df rolling_avg values are positive", {
  skip_if(!exists("df") || !"rolling_avg" %in% names(df))
  expect_true(all(df$rolling_avg > 0, na.rm = TRUE),
              info = "rolling_avg values should be positive (cases per 100K population)")
})

test_that("Ex 3: df rolling_avg values are in a plausible range (0–500 per 100K)", {
  skip_if(!exists("df") || !"rolling_avg" %in% names(df))
  expect_true(all(df$rolling_avg < 500, na.rm = TRUE),
              info = "rolling_avg should be less than 500 per 100K — check your per-100K calculation")
})
