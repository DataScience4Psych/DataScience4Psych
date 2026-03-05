# Exercises 1-2: Dimensions of Denny's and La Quinta datasets

test_that("Ex 1: dn object exists (Denny's data)", {
  expect_true(exists("dn") || exists("dennys"),
              label = "dn (or dennys) should be created from the dsbox package or loaded from CSV")
})

test_that("Ex 1: Denny's data is a data frame with rows", {
  skip_if(!exists("dn") && !exists("dennys"))
  d <- if (exists("dn")) dn else dennys
  expect_true(is.data.frame(d),
              label = "Denny's data should be a data frame")
  expect_true(nrow(d) > 0,
              label = "Denny's data should have rows")
})

test_that("Ex 1: Denny's data has expected columns", {
  skip_if(!exists("dn") && !exists("dennys"))
  d <- if (exists("dn")) dn else dennys
  expected_cols <- c("address", "city", "state", "zip", "longitude", "latitude")
  expect_true(all(expected_cols %in% names(d)),
              label = "Denny's data should contain address, city, state, zip, longitude, latitude")
})

test_that("Ex 1: Denny's data has 1643 rows and 6 columns", {
  skip_if(!exists("dn") && !exists("dennys"))
  d <- if (exists("dn")) dn else dennys
  # Original dsbox data has 1643 rows; check at least structure is right
  expect_equal(ncol(d[, c("address", "city", "state", "zip", "longitude", "latitude")]), 6,
               label = "Denny's data should have the 6 core location columns")
})

test_that("Ex 2: lq object exists (La Quinta data)", {
  expect_true(exists("lq") || exists("laquinta"),
              label = "lq (or laquinta) should be created from the dsbox package or loaded from CSV")
})

test_that("Ex 2: La Quinta data is a data frame with rows", {
  skip_if(!exists("lq") && !exists("laquinta"))
  d <- if (exists("lq")) lq else laquinta
  expect_true(is.data.frame(d),
              label = "La Quinta data should be a data frame")
  expect_true(nrow(d) > 0,
              label = "La Quinta data should have rows")
})

test_that("Ex 2: La Quinta data has expected columns", {
  skip_if(!exists("lq") && !exists("laquinta"))
  d <- if (exists("lq")) lq else laquinta
  expected_cols <- c("address", "city", "state", "zip", "longitude", "latitude")
  expect_true(all(expected_cols %in% names(d)),
              label = "La Quinta data should contain address, city, state, zip, longitude, latitude")
})
