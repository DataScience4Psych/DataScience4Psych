# Exercise 1: Filter for Alaska

test_that("Ex 1: dn_ak object exists", {
  expect_true(exists("dn_ak"),
              label = "dn_ak should be created by filtering dennys for Alaska")
})

test_that("Ex 1: dn_ak contains only Alaska locations", {
  skip_if(!exists("dn_ak"))
  expect_true(all(dn_ak$state == "AK"),
              label = "dn_ak should only contain Alaska (AK) locations")
})

test_that("Ex 1: dn_ak has 3 Denny's locations", {
  skip_if(!exists("dn_ak"))
  expect_equal(nrow(dn_ak), 3,
               label = "There should be 3 Denny's locations in Alaska")
})

test_that("Ex 1: lq_ak object exists", {
  expect_true(exists("lq_ak"),
              label = "lq_ak should be created by filtering laquinta for Alaska")
})

test_that("Ex 1: lq_ak contains only Alaska locations", {
  skip_if(!exists("lq_ak"))
  expect_true(all(lq_ak$state == "AK"),
              label = "lq_ak should only contain Alaska (AK) locations")
})

test_that("Ex 1: lq_ak has 2 La Quinta locations", {
  skip_if(!exists("lq_ak"))
  expect_equal(nrow(lq_ak), 2,
               label = "There should be 2 La Quinta locations in Alaska")
})
