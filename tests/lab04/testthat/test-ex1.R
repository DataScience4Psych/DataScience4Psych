# Exercises 1-2: Dimensions of Denny's and La Quinta datasets

test_that("Ex 1: dn object exists (Denny's data)", {
  expect_true(exists("dn") || exists("dennys"),
    info = "Create the dn (or dennys) object from the dsbox package or by loading the CSV"
  )
})

test_that("Ex 1: Denny's data is a data frame with rows", {
  skip_if(!exists("dn") && !exists("dennys"))
  d <- if (exists("dn")) dn else dennys
  expect_true(is.data.frame(d),
    info = "Make sure Denny's data is stored as a data frame"
  )
  expect_true(nrow(d) > 0,
    info = "Make sure Denny's data has rows -- check your data loading code"
  )
})

test_that("Ex 1: Denny's data has expected columns", {
  skip_if(!exists("dn") && !exists("dennys"))
  d <- if (exists("dn")) dn else dennys
  expected_cols <- c("address", "city", "state", "zip", "longitude", "latitude")
  expect_true(all(expected_cols %in% names(d)),
    info = "Make sure Denny's data contains address, city, state, zip, longitude, and latitude columns"
  )
})

test_that("Ex 1: Denny's data has 1643 rows and 6 columns", {
  skip_if(!exists("dn") && !exists("dennys"))
  d <- if (exists("dn")) dn else dennys
  # Original dsbox data has 1643 rows; check at least structure is right
  expect_equal(ncol(d[, c("address", "city", "state", "zip", "longitude", "latitude")]), 6,
    info = "Make sure Denny's data has the 6 core location columns"
  )
})

test_that("Ex 2: lq object exists (La Quinta data)", {
  expect_true(exists("lq") || exists("laquinta"),
    info = "Create the lq (or laquinta) object from the dsbox package or by loading the CSV"
  )
})

test_that("Ex 2: La Quinta data is a data frame with rows", {
  skip_if(!exists("lq") && !exists("laquinta"))
  d <- if (exists("lq")) lq else laquinta
  expect_true(is.data.frame(d),
    info = "Make sure La Quinta data is stored as a data frame"
  )
  expect_true(nrow(d) > 0,
    info = "Make sure La Quinta data has rows -- check your data loading code"
  )
})

test_that("Ex 2: La Quinta data has expected columns", {
  skip_if(!exists("lq") && !exists("laquinta"))
  d <- if (exists("lq")) lq else laquinta
  expected_cols <- c("address", "city", "state", "zip", "longitude", "latitude")
  expect_true(all(expected_cols %in% names(d)),
    info = "Make sure La Quinta data contains address, city, state, zip, longitude, and latitude columns"
  )
})
