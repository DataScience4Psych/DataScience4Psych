# Exercise 1: Loading and exploring Titanic data

test_that("Ex 1: Titanic data object exists", {
  has_data <- exists("titanic") || exists("titanic_train") || exists("titanic_data")
  expect_true(has_data,
              label = "A Titanic data object (titanic, titanic_train, or titanic_data) should exist")
})

test_that("Ex 1: Titanic data is a data frame", {
  d <- NULL
  if (exists("titanic_train")) d <- titanic_train
  else if (exists("titanic")) d <- titanic
  else if (exists("titanic_data")) d <- titanic_data
  skip_if(is.null(d), message = "No Titanic data object found")
  expect_true(is.data.frame(d),
              label = "Titanic data should be a data frame")
})

test_that("Ex 1: Titanic data has Survived variable", {
  d <- NULL
  if (exists("titanic_train")) d <- titanic_train
  else if (exists("titanic")) d <- titanic
  else if (exists("titanic_data")) d <- titanic_data
  skip_if(is.null(d), message = "No Titanic data object found")
  expect_true("Survived" %in% names(d),
              label = "Titanic data should have a Survived column")
})

test_that("Ex 1: Survived is binary (0 or 1)", {
  d <- NULL
  if (exists("titanic_train")) d <- titanic_train
  else if (exists("titanic")) d <- titanic
  else if (exists("titanic_data")) d <- titanic_data
  skip_if(is.null(d), message = "No Titanic data object found")
  skip_if(!"Survived" %in% names(d))
  vals <- unique(d$Survived[!is.na(d$Survived)])
  expect_true(all(vals %in% c(0, 1)),
              label = "Survived should be binary (0 or 1)")
})

test_that("Ex 1: Titanic data has key predictor variables", {
  d <- NULL
  if (exists("titanic_train")) d <- titanic_train
  else if (exists("titanic")) d <- titanic
  else if (exists("titanic_data")) d <- titanic_data
  skip_if(is.null(d), message = "No Titanic data object found")
  expected <- c("Pclass", "Sex", "Age")
  expect_true(all(expected %in% names(d)),
              label = "Titanic data should have Pclass, Sex, and Age columns")
})

test_that("Ex 1: Titanic data has a reasonable number of observations", {
  d <- NULL
  if (exists("titanic_train")) d <- titanic_train
  else if (exists("titanic")) d <- titanic
  else if (exists("titanic_data")) d <- titanic_data
  skip_if(is.null(d), message = "No Titanic data object found")
  expect_true(nrow(d) >= 600,
              label = "Titanic data should have at least 600 observations")
})
