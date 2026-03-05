# Exercise 7: Minimum distances per Denny's location

test_that("Ex 7: dn_lq_ak has distance and address columns needed for grouping", {
  skip_if(!exists("dn_lq_ak"))
  expect_true("distance" %in% names(dn_lq_ak),
              label = "dn_lq_ak needs a 'distance' column to compute minimum distances")
  expect_true("address.x" %in% names(dn_lq_ak),
              label = "dn_lq_ak needs 'address.x' to group by Denny's location")
})

test_that("Ex 7: minimum distances can be calculated for each Denny's", {
  skip_if(!exists("dn_lq_ak"))
  skip_if(!"distance" %in% names(dn_lq_ak))
  skip_if(!"address.x" %in% names(dn_lq_ak))
  min_dists <- tapply(dn_lq_ak$distance, dn_lq_ak$address.x, min)
  expect_equal(length(min_dists), 3,
               label = "Should have one minimum distance per Denny's location (3 total)")
})

test_that("Ex 7: all minimum distances are non-negative", {
  skip_if(!exists("dn_lq_ak"))
  skip_if(!"distance" %in% names(dn_lq_ak))
  skip_if(!"address.x" %in% names(dn_lq_ak))
  min_dists <- tapply(dn_lq_ak$distance, dn_lq_ak$address.x, min)
  expect_true(all(min_dists >= 0),
              label = "All minimum distances should be non-negative")
})

test_that("Ex 7: minimum distances are less than maximum distances", {
  skip_if(!exists("dn_lq_ak"))
  skip_if(!"distance" %in% names(dn_lq_ak))
  skip_if(!"address.x" %in% names(dn_lq_ak))
  min_dists <- tapply(dn_lq_ak$distance, dn_lq_ak$address.x, min)
  max_dists <- tapply(dn_lq_ak$distance, dn_lq_ak$address.x, max)
  # With 2 La Quintas, min should be <= max for each Denny's
  expect_true(all(min_dists <= max_dists),
              label = "Minimum distance should be less than or equal to maximum distance for each Denny's")
})
