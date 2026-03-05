# Exercise 6-8: Add country variable and filter

test_that("Ex 6: dn has a country variable", {
  skip_if(!exists("dn"))
  expect_true("country" %in% names(dn),
              label = "dn should have a 'country' variable after mutate")
})

test_that("Ex 6: all Denny's locations are United States", {
  skip_if(!exists("dn") || !"country" %in% names(dn))
  expect_true(all(dn$country == "United States"),
              label = "All Denny's should be 'United States'")
})

test_that("Ex 7-8: La Quinta has locations outside the US", {
  skip_if(!exists("lq") && !exists("laquinta"))
  skip_if(!file.exists("data/states.csv"))
  d <- if (exists("lq")) lq else laquinta
  states <- read.csv("data/states.csv")
  outside_us <- d %>%
    dplyr::filter(!(state %in% states$abbreviation))
  expect_true(nrow(outside_us) > 0,
              label = "La Quinta should have locations outside the US")
})
