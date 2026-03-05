# Exercise 1-2: Loading and exploring Titanic data

test_that("Ex 1: Titanic data is available", {
  has_data <- exists("titanic") || exists("titanic_train") ||
              (requireNamespace("titanic", quietly = TRUE))
  expect_true(has_data,
              label = "Titanic data should be available (from titanic package or loaded)")
})

test_that("Ex 1: Titanic data has Survived variable", {
  skip_if(!requireNamespace("titanic", quietly = TRUE) &&
          !exists("titanic") && !exists("titanic_train"))
  if (exists("titanic_train")) {
    d <- titanic_train
  } else if (exists("titanic")) {
    d <- titanic
  } else {
    data("titanic_train", package = "titanic")
    d <- titanic_train
  }
  expect_true("Survived" %in% names(d),
              label = "Data should have a Survived column")
})

test_that("Ex 1: Survived is binary (0 or 1)", {
  skip_if(!requireNamespace("titanic", quietly = TRUE) &&
          !exists("titanic_train"))
  if (exists("titanic_train")) {
    d <- titanic_train
  } else {
    data("titanic_train", package = "titanic")
    d <- titanic_train
  }
  vals <- unique(d$Survived[!is.na(d$Survived)])
  expect_true(all(vals %in% c(0, 1)),
              label = "Survived should be binary (0 or 1)")
})
