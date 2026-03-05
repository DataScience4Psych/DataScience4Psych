# Exercise 3: Faceted bar plot of laureates by category and country_us

test_that("Ex 3: nobel_living_science object exists", {
  expect_true(exists("nobel_living_science") || exists("nobel_living"),
              label = "nobel_living_science should be created by filtering for science categories")
})

test_that("Ex 3: country_us variable is created", {
  skip_if(!exists("nobel_living"))
  expect_true("country_us" %in% names(nobel_living),
              label = "nobel_living should have a country_us variable")
})

test_that("Ex 3: country_us has only USA and Other values", {
  skip_if(!exists("nobel_living") || !"country_us" %in% names(nobel_living))
  expect_true(all(nobel_living$country_us %in% c("USA", "Other")),
              label = "country_us should only contain 'USA' and 'Other'")
})

test_that("Ex 3: science categories are correctly filtered", {
  skip_if(!exists("nobel_living_science"))
  valid_cats <- c("Physics", "Medicine", "Chemistry", "Economics")
  expect_true(all(nobel_living_science$category %in% valid_cats),
              label = "nobel_living_science should only contain Physics, Medicine, Chemistry, Economics")
})

test_that("Ex 3: majority of living science laureates were US-based", {
  skip_if(!exists("nobel_living_science") || !"country_us" %in% names(nobel_living_science))
  us_count <- sum(nobel_living_science$country_us == "USA")
  other_count <- sum(nobel_living_science$country_us == "Other")
  expect_true(us_count > other_count,
              label = "More living science laureates should be US-based than Other")
})
