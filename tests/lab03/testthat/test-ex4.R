# Exercises 4-5: born_country_us variable and visualization

test_that("Ex 4: born_country_us variable is created", {
  skip_if(!exists("nobel_living"))
  expect_true("born_country_us" %in% names(nobel_living),
              label = "nobel_living should have a born_country_us variable")
})

test_that("Ex 4: born_country_us has only USA and Other values", {
  skip_if(!exists("nobel_living") || !"born_country_us" %in% names(nobel_living))
  expect_true(all(nobel_living$born_country_us %in% c("USA", "Other")),
              label = "born_country_us should only contain 'USA' and 'Other'")
})

test_that("Ex 4: some US-based winners were born outside the US", {
  skip_if(!exists("nobel_living_science"))
  skip_if(!"country_us" %in% names(nobel_living_science))
  skip_if(!"born_country_us" %in% names(nobel_living_science))
  us_based_foreign_born <- nobel_living_science %>%
    dplyr::filter(country_us == "USA", born_country_us == "Other")
  expect_true(nrow(us_based_foreign_born) > 0,
              label = "There should be US-based laureates who were born outside the US")
})
