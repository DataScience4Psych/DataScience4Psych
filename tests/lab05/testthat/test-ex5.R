# Exercises 5-6: Haversine function and distance calculations

test_that("Ex 5: haversine function exists", {
  expect_true(exists("haversine") && is.function(haversine),
              label = "haversine function should be defined")
})

test_that("Ex 5: haversine function accepts the expected arguments", {
  skip_if(!exists("haversine") || !is.function(haversine))
  args <- names(formals(haversine))
  expect_true(length(args) >= 4,
              label = "haversine should accept at least 4 arguments (long1, lat1, long2, lat2)")
})

test_that("Ex 5: haversine returns correct distance for known coordinates", {
  skip_if(!exists("haversine") || !is.function(haversine))
  # Approximate distance from New York to Los Angeles is ~3944 km
  d <- haversine(-74.006, 40.7128, -118.2437, 34.0522)
  expect_true(d > 3900 && d < 4000,
              label = sprintf("NY to LA distance should be ~3944 km, got %.1f", d))
})

test_that("Ex 5: haversine returns 0 for same location", {
  skip_if(!exists("haversine") || !is.function(haversine))
  d <- haversine(-100, 40, -100, 40)
  expect_equal(d, 0,
               label = "Distance between a point and itself should be 0")
})

test_that("Ex 6: distance variable exists in dn_lq_ak", {
  skip_if(!exists("dn_lq_ak"))
  expect_true("distance" %in% names(dn_lq_ak),
              label = "dn_lq_ak should have a 'distance' variable computed using haversine")
})

test_that("Ex 6: distance variable has 6 values (one per pairing)", {
  skip_if(!exists("dn_lq_ak"))
  skip_if(!"distance" %in% names(dn_lq_ak))
  expect_equal(length(dn_lq_ak$distance), 6,
               label = "distance should have 6 values matching the 6 pairings")
})

test_that("Ex 6: all distances are non-negative", {
  skip_if(!exists("dn_lq_ak"))
  skip_if(!"distance" %in% names(dn_lq_ak))
  expect_true(all(dn_lq_ak$distance >= 0),
              label = "All distances should be non-negative")
})

test_that("Ex 6: distances are in a reasonable range for Alaska", {
  skip_if(!exists("dn_lq_ak"))
  skip_if(!"distance" %in% names(dn_lq_ak))
  # Alaska is large; distances between locations could be up to ~1500 km
  expect_true(all(dn_lq_ak$distance < 2000),
              label = "Distances in Alaska should be less than 2000 km")
})
