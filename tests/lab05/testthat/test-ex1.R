# Exercise 1: Filter for Alaska

test_that("Ex 1: dn_ak object exists", {
  expect_true(exists("dn_ak"),
    info = "Create dn_ak by filtering Denny's data for Alaska (state == 'AK')"
  )
})

test_that("Ex 1: dn_ak is a data frame", {
  skip_if(!exists("dn_ak"))
  expect_true(is.data.frame(dn_ak),
    info = "Make sure dn_ak is stored as a data frame"
  )
})

test_that("Ex 1: dn_ak contains only Alaska locations", {
  skip_if(!exists("dn_ak"))
  expect_true(all(dn_ak$state == "AK"),
    info = "Filter dn_ak so it only contains Alaska (AK) locations"
  )
})

test_that("Ex 1: dn_ak has 3 Denny's locations", {
  skip_if(!exists("dn_ak"))
  expect_equal(nrow(dn_ak), 3,
    info = "There should be 3 Denny's locations in Alaska -- check your filter"
  )
})

test_that("Ex 1: lq_ak object exists", {
  expect_true(exists("lq_ak"),
    info = "Create lq_ak by filtering La Quinta data for Alaska (state == 'AK')"
  )
})

test_that("Ex 1: lq_ak is a data frame", {
  skip_if(!exists("lq_ak"))
  expect_true(is.data.frame(lq_ak),
    info = "Make sure lq_ak is stored as a data frame"
  )
})

test_that("Ex 1: lq_ak contains only Alaska locations", {
  skip_if(!exists("lq_ak"))
  expect_true(all(lq_ak$state == "AK"),
    info = "Filter lq_ak so it only contains Alaska (AK) locations"
  )
})

test_that("Ex 1: lq_ak has 2 La Quinta locations", {
  skip_if(!exists("lq_ak"))
  expect_equal(nrow(lq_ak), 2,
    info = "There should be 2 La Quinta locations in Alaska -- check your filter"
  )
})
