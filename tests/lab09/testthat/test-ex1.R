# Exercise 1-2: Loading and exploring the COMPAS dataset

test_that("Ex 1: compas object exists", {
  expect_true(exists("compas"),
              label = "compas should be created by reading data/compas-scores-two-years.csv with clean_names()"
  )
})

test_that("Ex 1: compas is a data frame", {
  skip_if(!exists("compas"))
  expect_true(is.data.frame(compas),
              label = "compas should be a data frame")
})

test_that("Ex 1: compas column names are clean (snake_case from clean_names())", {
  skip_if(!exists("compas"))
  has_clean_names <- !any(grepl("[A-Z ]", names(compas)))
  expect_true(has_clean_names,
              label = "compas column names should be in snake_case (from janitor::clean_names())")
})

test_that("Ex 1: compas has expected key columns", {
  skip_if(!exists("compas"))
  expected_cols <- c("sex", "race", "age", "decile_score", "two_year_recid")
  present <- expected_cols %in% names(compas)
  expect_true(all(present),
              label = paste("compas should have columns:",
                           paste(expected_cols[!present], collapse = ", ")))
})

test_that("Ex 1: compas has a substantial number of rows (>5000)", {
  skip_if(!exists("compas"))
  expect_true(nrow(compas) > 5000,
              label = "compas should have thousands of defendant records")
})

test_that("Ex 1: compas has id column for unique defendants", {
  skip_if(!exists("compas"))
  expect_true("id" %in% names(compas),
              label = "compas should have an id column identifying defendants")
})
