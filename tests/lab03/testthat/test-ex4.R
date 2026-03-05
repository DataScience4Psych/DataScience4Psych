# Exercises 4-5: born_country_us variable and visualization

test_that("Ex 4: born_country_us variable exists in nobel_living", {
  skip_if(!exists("nobel_living"))
  expect_true("born_country_us" %in% names(nobel_living),
              label = "nobel_living should have a born_country_us variable ('USA' or 'Other')")
})

test_that("Ex 4: born_country_us has only 'USA' and 'Other' values", {
  skip_if(!exists("nobel_living"))
  skip_if(!"born_country_us" %in% names(nobel_living))
  expect_true(all(nobel_living$born_country_us %in% c("USA", "Other")),
              label = "born_country_us should only contain 'USA' and 'Other'")
})

test_that("Ex 4: born_country_us correctly identifies US-born laureates", {
  skip_if(!exists("nobel_living"))
  skip_if(!"born_country_us" %in% names(nobel_living))
  skip_if(!"born_country" %in% names(nobel_living))
  usa_born <- nobel_living$born_country == "USA"
  expect_true(all(nobel_living$born_country_us[usa_born] == "USA"),
              label = "Laureates born in USA should have born_country_us == 'USA'")
  expect_true(all(nobel_living$born_country_us[!usa_born] == "Other"),
              label = "Laureates born outside USA should have born_country_us == 'Other'")
})

test_that("Ex 4: born_country_us also exists in nobel_living_science", {
  skip_if(!exists("nobel_living_science"))
  expect_true("born_country_us" %in% names(nobel_living_science),
              label = "nobel_living_science should also have born_country_us")
})

test_that("Ex 5: some US-based science winners were born outside the US", {
  skip_if(!exists("nobel_living_science"))
  skip_if(!"country_us" %in% names(nobel_living_science))
  skip_if(!"born_country_us" %in% names(nobel_living_science))
  us_based_foreign_born <- nobel_living_science[
    nobel_living_science$country_us == "USA" &
      nobel_living_science$born_country_us == "Other", ]
  expect_true(nrow(us_based_foreign_born) > 0,
              label = "There should be US-based laureates who were born outside the US (immigrants)")
})
