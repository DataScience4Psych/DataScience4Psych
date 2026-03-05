# Exercise 1-2: Dimensions of Denny's and La Quinta datasets

test_that("Ex 1: dennys data is available", {
  skip_if(!exists("dn") && !exists("dennys"),
          message = "Neither dn nor dennys object found")
  d <- if (exists("dn")) dn else dennys
  expect_true(nrow(d) > 0, label = "Denny's data should have rows")
})

test_that("Ex 1: dennys has expected columns", {
  skip_if(!exists("dn") && !exists("dennys"))
  d <- if (exists("dn")) dn else dennys
  expected_cols <- c("address", "city", "state", "zip", "longitude", "latitude")
  expect_true(all(expected_cols %in% names(d)),
              label = "Denny's data should contain address, city, state, zip, longitude, latitude")
})

test_that("Ex 2: laquinta data is available", {
  skip_if(!exists("lq") && !exists("laquinta"),
          message = "Neither lq nor laquinta object found")
  d <- if (exists("lq")) lq else laquinta
  expect_true(nrow(d) > 0, label = "La Quinta data should have rows")
})

test_that("Ex 2: laquinta has expected columns", {
  skip_if(!exists("lq") && !exists("laquinta"))
  d <- if (exists("lq")) lq else laquinta
  expected_cols <- c("address", "city", "state", "zip", "longitude", "latitude")
  expect_true(all(expected_cols %in% names(d)),
              label = "La Quinta data should contain address, city, state, zip, longitude, latitude")
})
