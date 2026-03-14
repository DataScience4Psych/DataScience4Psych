# Exercise 1: Download raw data from USAFacts URLs

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
