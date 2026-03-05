# Exercise 5: Filter Denny's for non-US locations

test_that("Ex 5: dn object exists for filtering", {
  expect_true(exists("dn") || exists("dennys"),
              label = "dn (or dennys) must exist to check for non-US locations")
})

test_that("Ex 5: Denny's has no locations outside the US", {
  skip_if(!exists("dn") && !exists("dennys"))
  d <- if (exists("dn")) dn else dennys
  # Use state.abb from base R as reference for US state abbreviations plus DC
  us_abbrevs <- c(state.abb, "DC")
  outside_us <- d[!(d$state %in% us_abbrevs), ]
  expect_equal(nrow(outside_us), 0,
               label = "All Denny's locations should be in US states (filtering by state abbreviation)")
})
