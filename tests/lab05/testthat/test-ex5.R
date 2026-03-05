# Exercise 5-6: Haversine function and distance calculations

test_that("Ex 5: haversine function exists", {
  expect_true(exists("haversine") && is.function(haversine),
              label = "haversine function should be defined")
})

test_that("Ex 5: haversine returns correct distance for known coordinates", {
  skip_if(!exists("haversine") || !is.function(haversine))
  # Approximate distance from New York to Los Angeles is ~3944 km
  d <- haversine(-74.006, 40.7128, -118.2437, 34.0522)
  expect_true(d > 3900 && d < 4000,
              label = sprintf("NY to LA distance should be ~3944 km, got %.1f", d))
})

test_that("Ex 6: distance variable exists in dn_lq_ak", {
  skip_if(!exists("dn_lq_ak"))
  expect_true("distance" %in% names(dn_lq_ak),
              label = "dn_lq_ak should have a 'distance' variable")
})

test_that("Ex 6: all distances are positive", {
  skip_if(!exists("dn_lq_ak") || !"distance" %in% names(dn_lq_ak))
  expect_true(all(dn_lq_ak$distance >= 0),
              label = "All distances should be non-negative")
})
