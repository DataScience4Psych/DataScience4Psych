# Exercise 1: Download raw data from USAFacts URLs (lab Exercise 3)
# Note: test files for lab07 use internal numbering — test-ex1 covers lab Exercise 3 (data acquisition).

test_that("Ex 1: cases_raw object exists", {
  expect_true(exists("cases_raw"),
              info = "Create a data frame called 'cases_raw' by reading the USAFacts COVID confirmed cases CSV from its URL"
  )
})

test_that("Ex 1: cases_raw is a data frame", {
  skip_if(!exists("cases_raw"))
  expect_true(is.data.frame(cases_raw),
              info = "Make sure 'cases_raw' is a data frame")
})

test_that("Ex 1: cases_raw has expected identifier columns", {
  skip_if(!exists("cases_raw"))
  expect_true(all(c("countyFIPS", "State") %in% names(cases_raw)),
              info = "Make sure 'cases_raw' has countyFIPS and State columns")
})

test_that("Ex 1: cases_raw has County Name column", {
  skip_if(!exists("cases_raw"))
  expect_true("County Name" %in% names(cases_raw),
              info = "Make sure 'cases_raw' has a 'County Name' column")
})

test_that("Ex 1: cases_raw covers all US counties (many rows)", {
  skip_if(!exists("cases_raw"))
  expect_true(nrow(cases_raw) > 3000,
              info = "cases_raw should cover all US counties — expected more than 3000 rows")
})

test_that("Ex 1: cases_raw is in wide format with many date columns", {
  skip_if(!exists("cases_raw"))
  # Wide format: identifier columns + one column per date
  expect_true(ncol(cases_raw) > 100,
              info = "cases_raw should be in wide format with one column per date — expected more than 100 columns total")
})

test_that("Ex 1: cases_raw countyFIPS column is numeric or integer", {
  skip_if(!exists("cases_raw") || !"countyFIPS" %in% names(cases_raw))
  expect_true(is.numeric(cases_raw$countyFIPS) || is.integer(cases_raw$countyFIPS),
              info = "countyFIPS should be a numeric or integer column (FIPS codes)")
})

test_that("Ex 1: pop_raw object exists", {
  expect_true(exists("pop_raw"),
              info = "Create a data frame called 'pop_raw' by reading the USAFacts population CSV from its URL"
  )
})

test_that("Ex 1: pop_raw is a data frame", {
  skip_if(!exists("pop_raw"))
  expect_true(is.data.frame(pop_raw),
              info = "Make sure 'pop_raw' is a data frame")
})

test_that("Ex 1: pop_raw has population column", {
  skip_if(!exists("pop_raw"))
  expect_true("population" %in% names(pop_raw),
              info = "Make sure 'pop_raw' has a column named 'population'")
})

test_that("Ex 1: pop_raw has countyFIPS and State columns", {
  skip_if(!exists("pop_raw"))
  expect_true(all(c("countyFIPS", "State") %in% names(pop_raw)),
              info = "Make sure 'pop_raw' has countyFIPS and State columns for joining")
})

test_that("Ex 1: pop_raw has County Name column", {
  skip_if(!exists("pop_raw"))
  expect_true("County Name" %in% names(pop_raw),
              info = "Make sure 'pop_raw' has a 'County Name' column")
})

test_that("Ex 1: pop_raw covers all US counties (many rows)", {
  skip_if(!exists("pop_raw"))
  expect_true(nrow(pop_raw) > 3000,
              info = "pop_raw should cover all US counties — expected more than 3000 rows")
})

test_that("Ex 1: pop_raw population column is numeric", {
  skip_if(!exists("pop_raw") || !"population" %in% names(pop_raw))
  expect_true(is.numeric(pop_raw$population),
              info = "population column in pop_raw should be numeric")
})

test_that("Ex 1: pop_raw population values are positive", {
  skip_if(!exists("pop_raw") || !"population" %in% names(pop_raw))
  pop_vals <- pop_raw$population[!is.na(pop_raw$population) & pop_raw$population > 0]
  expect_true(length(pop_vals) > 3000,
              info = "Most population values in pop_raw should be positive (more than 3000 counties with positive population)")
})
