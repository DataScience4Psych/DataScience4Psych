# Exercise 5: Filter Denny's for non-US locations

test_that("Ex 5: Denny's has no locations outside the US", {
  skip_if(!exists("dn") && !exists("dennys"))
  skip_if(!file.exists("data/states.csv"), message = "data/states.csv not found")
  d <- if (exists("dn")) dn else dennys
  states <- read.csv("data/states.csv")
  outside_us <- d %>%
    dplyr::filter(!(state %in% states$abbreviation))
  expect_equal(nrow(outside_us), 0,
               label = "All Denny's locations should be in US states")
})
