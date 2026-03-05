# Exercise 6: Frequency table of immigrant Nobel laureates' birth countries

test_that("Ex 6: can identify immigrant Nobel laureates", {
  skip_if(!exists("nobel_living_science"))
  skip_if(!"country_us" %in% names(nobel_living_science))
  skip_if(!"born_country_us" %in% names(nobel_living_science))
  immigrants <- nobel_living_science %>%
    dplyr::filter(country_us == "USA", born_country_us == "Other")
  expect_true(nrow(immigrants) > 0)
})

test_that("Ex 6: birth country frequency table can be constructed", {
  skip_if(!exists("nobel_living_science"))
  skip_if(!"country_us" %in% names(nobel_living_science))
  skip_if(!"born_country_us" %in% names(nobel_living_science))
  freq_table <- nobel_living_science %>%
    dplyr::filter(country_us == "USA", born_country_us == "Other") %>%
    dplyr::count(born_country, sort = TRUE)
  expect_true(nrow(freq_table) > 0)
  expect_true("n" %in% names(freq_table))
})
