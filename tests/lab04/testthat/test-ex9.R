# Exercises 9-12: State-level analysis, bind_rows, and visualization

test_that("Ex 9: Rmd Exercise 9 contains state counting code", {
  skip_if(length(.rmd_content) == 0)
  section <- .find_ex_section(.rmd_content, "9", "10")
  skip_if(is.null(section), "Could not locate Exercise 9 section in Rmd")
  has_count <- any(grepl("count|table|tally|n\\(\\)|group_by", section))
  has_state <- any(grepl("state", section))
  expect_true(has_count && has_state,
              label = "Exercise 9 should contain code to count locations by state")
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
