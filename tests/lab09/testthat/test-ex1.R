# Exercise 1-2: Exploring the COMPAS dataset

test_that("Ex 1: compas data is loaded", {
  expect_true(exists("compas"),
              label = "compas should be loaded from CSV")
})

test_that("Ex 1: compas has expected key variables", {
  skip_if(!exists("compas"))
  expected_cols <- c("sex", "race", "age", "decile_score", "two_year_recid")
  present <- expected_cols %in% names(compas)
  expect_true(all(present),
              label = paste("compas should have columns:",
                           paste(expected_cols[!present], collapse = ", ")))
})

test_that("Ex 2: compas has unique defendants", {
  skip_if(!exists("compas"))
  # Check that id column exists and count unique
  skip_if(!"id" %in% names(compas))
  n_unique <- dplyr::n_distinct(compas$id)
  expect_true(n_unique > 0,
              label = "There should be unique defendants in the dataset")
})
