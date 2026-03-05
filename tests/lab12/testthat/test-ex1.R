# Exercise 1: Explore ncbirths data

test_that("Ex 1: ncbirths data is available from openintro", {
  skip_if(!requireNamespace("openintro", quietly = TRUE),
          message = "openintro package not available")
  data("ncbirths", package = "openintro")
  expect_true(nrow(ncbirths) > 0)
})

test_that("Ex 1: ncbirths has 1000 observations", {
  skip_if(!requireNamespace("openintro", quietly = TRUE))
  data("ncbirths", package = "openintro")
  expect_equal(nrow(ncbirths), 1000)
})

test_that("Ex 1: ncbirths has 13 variables", {
  skip_if(!requireNamespace("openintro", quietly = TRUE))
  data("ncbirths", package = "openintro")
  expect_equal(ncol(ncbirths), 13)
})

test_that("Ex 1: ncbirths has expected key variables", {
  skip_if(!requireNamespace("openintro", quietly = TRUE))
  data("ncbirths", package = "openintro")
  expected <- c("weight", "habit", "mage", "whitemom", "mature", "lowbirthweight")
  expect_true(all(expected %in% names(ncbirths)),
              label = "ncbirths should have weight, habit, mage, whitemom, mature, lowbirthweight")
})
