# Exercise 2: Filter to Kansas and pivot to long format

test_that("Ex 2: kansas_cases object exists", {
  expect_true(exists("kansas_cases"),
              info = "Create a data frame called 'kansas_cases' by filtering and pivoting the cases data"
  )
})

test_that("Ex 2: kansas_cases is a data frame", {
  skip_if(!exists("kansas_cases"))
  expect_true(is.data.frame(kansas_cases),
              info = "Make sure 'kansas_cases' is a data frame")
})

test_that("Ex 2: kansas_cases has expected columns after pivot", {
  skip_if(!exists("kansas_cases"))
  expect_true(all(c("countyFIPS", "date", "cumulative_cases") %in% names(kansas_cases)),
              info = "After pivot_longer, 'kansas_cases' should have countyFIPS, date, and cumulative_cases columns")
})

test_that("Ex 2: kansas_cases date column is Date type", {
  skip_if(!exists("kansas_cases") || !"date" %in% names(kansas_cases))
  expect_true(inherits(kansas_cases$date, "Date"),
              info = "Make sure the 'date' column is a proper Date type (use lubridate::ymd())")
})

test_that("Ex 2: kansas_cases contains only Kansas data", {
  skip_if(!exists("kansas_cases"))
  if ("State" %in% names(kansas_cases)) {
    expect_true(all(kansas_cases$State == "KS"),
                info = "Make sure you filtered to only Kansas (State == 'KS')")
  }
})

test_that("Ex 2: kansas_cases has multiple counties", {
  skip_if(!exists("kansas_cases") || !"countyFIPS" %in% names(kansas_cases))
  n_counties <- dplyr::n_distinct(kansas_cases$countyFIPS)
  expect_true(n_counties > 50,
              info = "Kansas has 105 counties — make sure you have data for many of them")
})
