# Exercise 3: Create country_us variable and nobel_living_science

test_that("Ex 3: country_us variable exists in nobel_living", {
  skip_if(!exists("nobel_living"))
  expect_true("country_us" %in% names(nobel_living),
              label = "nobel_living should have a country_us variable ('USA' or 'Other')")
})

test_that("Ex 3: country_us has only 'USA' and 'Other' values", {
  skip_if(!exists("nobel_living"))
  skip_if(!"country_us" %in% names(nobel_living))
  expect_true(all(nobel_living$country_us %in% c("USA", "Other")),
              label = "country_us should only contain 'USA' and 'Other'")
})

test_that("Ex 3: country_us correctly identifies USA laureates", {
  skip_if(!exists("nobel_living"))
  skip_if(!"country_us" %in% names(nobel_living))
  usa_rows <- nobel_living$country == "USA"
  expect_true(all(nobel_living$country_us[usa_rows] == "USA"),
              label = "Laureates with country == 'USA' should have country_us == 'USA'")
  expect_true(all(nobel_living$country_us[!usa_rows] == "Other"),
              label = "Laureates with country != 'USA' should have country_us == 'Other'")
})

test_that("Ex 3: nobel_living_science object exists", {
  expect_true(exists("nobel_living_science"),
              label = "nobel_living_science should be created by filtering for science categories")
})

test_that("Ex 3: nobel_living_science is a data frame", {
  skip_if(!exists("nobel_living_science"))
  expect_true(is.data.frame(nobel_living_science),
              label = "nobel_living_science should be a data frame")
})

test_that("Ex 3: nobel_living_science contains only Physics, Medicine, Chemistry, Economics", {
  skip_if(!exists("nobel_living_science"))
  valid_cats <- c("Physics", "Medicine", "Chemistry", "Economics")
  expect_true(all(nobel_living_science$category %in% valid_cats),
              label = "nobel_living_science should only contain Physics, Medicine, Chemistry, Economics")
})

test_that("Ex 3: nobel_living_science has country_us variable", {
  skip_if(!exists("nobel_living_science"))
  expect_true("country_us" %in% names(nobel_living_science),
              label = "nobel_living_science should inherit the country_us variable")
})

test_that("Ex 3: majority of living science laureates were US-based", {
  skip_if(!exists("nobel_living_science"))
  skip_if(!"country_us" %in% names(nobel_living_science))
  us_count <- sum(nobel_living_science$country_us == "USA")
  other_count <- sum(nobel_living_science$country_us == "Other")
  expect_true(us_count > other_count,
              label = "More living science laureates should be US-based than Other")
})
