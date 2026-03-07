# Exercise 3: Create country_us variable and nobel_living_science

test_that("Ex 3: country_us variable exists in nobel_living", {
  skip_if(!exists("nobel_living"))
  expect_true("country_us" %in% names(nobel_living),
              info = "Add a country_us variable to nobel_living with values 'USA' or 'Other'")
})

test_that("Ex 3: country_us has only 'USA' and 'Other' values", {
  skip_if(!exists("nobel_living"))
  skip_if(!"country_us" %in% names(nobel_living))
  expect_true(all(nobel_living$country_us %in% c("USA", "Other")),
              info = "Make sure country_us only contains the values 'USA' and 'Other'")
})

test_that("Ex 3: country_us correctly identifies USA laureates", {
  skip_if(!exists("nobel_living"))
  skip_if(!"country_us" %in% names(nobel_living))
  usa_rows <- nobel_living$country == "USA"
  expect_true(all(nobel_living$country_us[usa_rows] == "USA"),
              info = "Make sure laureates with country == 'USA' have country_us == 'USA'")
  expect_true(all(nobel_living$country_us[!usa_rows] == "Other"),
              info = "Make sure laureates with country != 'USA' have country_us == 'Other'")
})

test_that("Ex 3: nobel_living_science object exists", {
  expect_true(exists("nobel_living_science"),
              info = "Create the nobel_living_science object by filtering for science categories")
})

test_that("Ex 3: nobel_living_science is a data frame", {
  skip_if(!exists("nobel_living_science"))
  expect_true(is.data.frame(nobel_living_science),
              info = "Make sure nobel_living_science is a data frame")
})

test_that("Ex 3: nobel_living_science contains only Physics, Medicine, Chemistry, Economics", {
  skip_if(!exists("nobel_living_science"))
  valid_cats <- c("Physics", "Medicine", "Chemistry", "Economics")
  expect_true(all(nobel_living_science$category %in% valid_cats),
              info = "Filter nobel_living_science to only contain Physics, Medicine, Chemistry, and Economics categories")
})

test_that("Ex 3: nobel_living_science has country_us variable", {
  skip_if(!exists("nobel_living_science"))
  expect_true("country_us" %in% names(nobel_living_science),
              info = "Make sure nobel_living_science inherits the country_us variable")
})

test_that("Ex 3: majority of living science laureates were US-based", {
  skip_if(!exists("nobel_living_science"))
  skip_if(!"country_us" %in% names(nobel_living_science))
  us_count <- sum(nobel_living_science$country_us == "USA")
  other_count <- sum(nobel_living_science$country_us == "Other")
  expect_true(us_count > other_count,
              info = "Check your filters — more living science laureates should be US-based than Other")
})
