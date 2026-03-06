# Exercise 1: Filter Denny's and La Quinta data for Alaska

test_that("Ex 1: dn_ak data frame exists", {
  expect_true(exists("dn_ak"),
    label = "dn_ak should be created by filtering Denny's for Alaska (state == 'AK')"
  )
})

test_that("Ex 1: dn_ak contains only Alaska observations", {
  skip_if(!exists("dn_ak"))
  expect_true(
    all(dn_ak$state == "AK"),
    label = "dn_ak should only contain rows where state == 'AK'"
  )
})

test_that("Ex 1: dn_ak has 3 rows", {
  skip_if(!exists("dn_ak"))
  expect_equal(nrow(dn_ak), 3,
    info = "There should be exactly 3 Denny's locations in Alaska"
  )
})

test_that("Ex 1: lq_ak data frame exists", {
  expect_true(exists("lq_ak"),
    label = "lq_ak should be created by filtering La Quinta for Alaska (state == 'AK')"
  )
})

test_that("Ex 1: lq_ak contains only Alaska observations", {
  skip_if(!exists("lq_ak"))
  expect_true(
    all(lq_ak$state == "AK"),
    label = "lq_ak should only contain rows where state == 'AK'"
  )
})

test_that("Ex 1: lq_ak has 2 rows", {
  skip_if(!exists("lq_ak"))
  expect_equal(nrow(lq_ak), 2,
    info = "There should be exactly 2 La Quinta locations in Alaska"
  )
})
