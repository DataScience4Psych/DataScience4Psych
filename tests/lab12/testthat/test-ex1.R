# Exercise 1: Explore ncbirths data

test_that("Ex 1: ncbirths object exists", {
  expect_true(exists("ncbirths"),
              label = "ncbirths should be loaded from the openintro package")
})

test_that("Ex 1: ncbirths has 1000 observations", {
  skip_if(!exists("ncbirths"))
  expect_equal(nrow(ncbirths), 1000,
               label = "ncbirths should have 1000 observations")
})

test_that("Ex 1: ncbirths has 13 variables", {
  skip_if(!exists("ncbirths"))
  expect_true(ncol(ncbirths) >= 13,
              label = "ncbirths should have at least 13 variables")
})

test_that("Ex 1: ncbirths has expected key variables", {
  skip_if(!exists("ncbirths"))
  expected <- c("weight", "habit", "mage", "whitemom", "mature", "lowbirthweight")
  expect_true(all(expected %in% names(ncbirths)),
              label = "ncbirths should have weight, habit, mage, whitemom, mature, lowbirthweight columns")
})

test_that("Ex 1: ncbirths weight variable is numeric", {
  skip_if(!exists("ncbirths"))
  skip_if(!"weight" %in% names(ncbirths))
  expect_true(is.numeric(ncbirths$weight),
              label = "weight should be a numeric variable")
})
