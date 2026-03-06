# Exercises 4-5: born_country_us variable and visualization

test_that("Ex 4: born_country_us variable exists in nobel_living", {
  skip_if(!exists("nobel_living"))
  expect_true("born_country_us" %in% names(nobel_living),
              info = "Add a born_country_us variable to nobel_living with values 'USA' or 'Other'")
})

test_that("Ex 4: born_country_us has only 'USA' and 'Other' values", {
  skip_if(!exists("nobel_living"))
  skip_if(!"born_country_us" %in% names(nobel_living))
  expect_true(all(nobel_living$born_country_us %in% c("USA", "Other")),
              info = "Make sure born_country_us only contains the values 'USA' and 'Other'")
})

test_that("Ex 4: born_country_us correctly identifies US-born laureates", {
  skip_if(!exists("nobel_living"))
  skip_if(!"born_country_us" %in% names(nobel_living))
  skip_if(!"born_country" %in% names(nobel_living))
  usa_born <- nobel_living$born_country == "USA"
  expect_true(all(nobel_living$born_country_us[usa_born] == "USA"),
              info = "Make sure laureates born in USA have born_country_us == 'USA'")
  expect_true(all(nobel_living$born_country_us[!usa_born] == "Other"),
              info = "Make sure laureates born outside USA have born_country_us == 'Other'")
})

test_that("Ex 4: born_country_us also exists in nobel_living_science", {
  skip_if(!exists("nobel_living_science"))
  expect_true("born_country_us" %in% names(nobel_living_science),
              info = "Make sure nobel_living_science also has the born_country_us variable")
})

test_that("Ex 5: some US-based science winners were born outside the US", {
  skip_if(!exists("nobel_living_science"))
  skip_if(!"country_us" %in% names(nobel_living_science))
  skip_if(!"born_country_us" %in% names(nobel_living_science))
  us_based_foreign_born <- nobel_living_science[
    nobel_living_science$country_us == "USA" &
      nobel_living_science$born_country_us == "Other", ]
  expect_true(nrow(us_based_foreign_born) > 0,
              info = "Check your filters — there should be US-based laureates who were born outside the US (immigrants)")
})
