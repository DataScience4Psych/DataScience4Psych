# Exercise 4: Filter dates and compute daily new cases (Ex 5 in lab)
# Note: test files for lab07 use internal numbering (test-ex4 = lab Exercise 5).
# This follows the established convention where test-ex1=lab Ex 3, test-ex2=lab Ex 4, test-ex3=lab Ex 7.

test_that("Ex 4: Rmd uses lag() to compute daily new cases", {
  skip_if(length(.rmd_content) == 0)
  expect_true(
    any(stringr::str_detect(.rmd_content, "\\blag\\s*\\(")),
    info = "Use lag() inside mutate() to compute daily_new_cases as the difference between consecutive cumulative counts"
  )
})

test_that("Ex 4: Rmd filters dates to the study window (starting July 5, 2020)", {
  skip_if(length(.rmd_content) == 0)
  # Check for the specific July 5, 2020 date in any common R date format
  date_patterns <- c(
    "2020-07-05",       # ISO format
    "20200705",         # compact format inside ymd()
    "07-05-2020",       # US format
    "\"2020\",\\s*7,\\s*5" # ymd(2020, 7, 5) style
  )
  pattern <- paste0("(", paste(date_patterns, collapse = "|"), ")")
  expect_true(
    any(stringr::str_detect(.rmd_content, pattern)),
    info = "Filter cases to dates starting July 5, 2020 — include that specific date (e.g., '2020-07-05') in your Rmd"
  )
})

test_that("Ex 4: an object with a daily_new_cases column exists", {
  result <- .find_obj_with_col("daily_new_cases")
  expect_true(!is.null(result),
              info = "Create a data frame with a 'daily_new_cases' column using lag() on cumulative_cases")
})

test_that("Ex 4: daily_new_cases column is numeric", {
  result <- .find_obj_with_col("daily_new_cases")
  skip_if(is.null(result))
  expect_true(is.numeric(result$obj$daily_new_cases),
              info = "daily_new_cases should be a numeric column")
})

test_that("Ex 4: daily_new_cases has no NA values after filtering", {
  result <- .find_obj_with_col("daily_new_cases")
  skip_if(is.null(result))
  n_na <- sum(is.na(result$obj$daily_new_cases))
  expect_equal(n_na, 0L,
               info = "After removing NA rows (first day per county), daily_new_cases should have no missing values")
})

test_that("Ex 4: daily_new_cases values are non-negative", {
  result <- .find_obj_with_col("daily_new_cases")
  skip_if(is.null(result))
  expect_true(all(result$obj$daily_new_cases >= 0, na.rm = TRUE),
              info = "daily_new_cases should be non-negative (cumulative counts never decrease)")
})

test_that("Ex 4: data with daily_new_cases covers the study window dates", {
  result <- .find_obj_with_col("daily_new_cases")
  skip_if(is.null(result))
  skip_if(!"date" %in% names(result$obj))
  min_date <- min(result$obj$date, na.rm = TRUE)
  max_date <- max(result$obj$date, na.rm = TRUE)
  expect_true(min_date >= as.Date("2020-07-01"),
              info = sprintf("Dates should start on or after July 1, 2020 — found %s", min_date))
  expect_true(max_date <= as.Date("2020-08-10"),
              info = sprintf("Dates should end on or before August 10, 2020 — found %s", max_date))
})

test_that("Ex 4: data with daily_new_cases has multiple Kansas counties", {
  result <- .find_obj_with_col("daily_new_cases")
  skip_if(is.null(result))
  skip_if(!"countyFIPS" %in% names(result$obj))
  n_counties <- dplyr::n_distinct(result$obj$countyFIPS)
  expect_true(n_counties > 50,
              info = sprintf("Expected data for most of Kansas's 105 counties — found %d", n_counties))
})
