# Exercises 9-12: State-level analysis, bind_rows, and visualization

test_that("Ex 9: can count Denny's per state", {
  skip_if(!exists("dn") && !exists("dennys"))
  d <- if (exists("dn")) dn else dennys
  state_counts <- as.data.frame(table(d$state))
  expect_true(nrow(state_counts) > 0,
              label = "Denny's state counts should have rows")
  expect_true("CA" %in% d$state,
              label = "California should appear in Denny's locations")
})

test_that("Ex 9: can count La Quinta per state", {
  skip_if(!exists("lq") && !exists("laquinta"))
  d <- if (exists("lq")) lq else laquinta
  state_counts <- as.data.frame(table(d$state))
  expect_true(nrow(state_counts) > 0,
              label = "La Quinta state counts should have rows")
  expect_true("TX" %in% d$state,
              label = "Texas should appear in La Quinta locations")
})

test_that("Ex 10-11: dn_lq combined data frame exists", {
  expect_true(exists("dn_lq"),
              label = "dn_lq should be created by bind_rows of dn and lq with establishment variable")
})

test_that("Ex 10-11: dn_lq has establishment variable", {
  skip_if(!exists("dn_lq"))
  expect_true("establishment" %in% names(dn_lq),
              label = "dn_lq should have an 'establishment' column distinguishing Denny's from La Quinta")
})

test_that("Ex 10-11: dn_lq has both Denny's and La Quinta", {
  skip_if(!exists("dn_lq"))
  skip_if(!"establishment" %in% names(dn_lq))
  establishments <- unique(dn_lq$establishment)
  expect_true(length(establishments) == 2,
              label = "dn_lq should contain exactly two types of establishments")
})

test_that("Ex 10-11: dn_lq has longitude and latitude for plotting", {
  skip_if(!exists("dn_lq"))
  expect_true(all(c("longitude", "latitude") %in% names(dn_lq)),
              label = "dn_lq should have longitude and latitude columns for scatter plots")
})

test_that("Ex 11-12: dn_lq contains NC observations for filtering", {
  skip_if(!exists("dn_lq"))
  nc_rows <- dn_lq[dn_lq$state == "NC", ]
  expect_true(nrow(nc_rows) > 0,
              label = "dn_lq should contain North Carolina observations for Exercise 11")
})

test_that("Ex 12: dn_lq contains TX observations for filtering", {
  skip_if(!exists("dn_lq"))
  tx_rows <- dn_lq[dn_lq$state == "TX", ]
  expect_true(nrow(tx_rows) > 0,
              label = "dn_lq should contain Texas observations for Exercise 12")
})
