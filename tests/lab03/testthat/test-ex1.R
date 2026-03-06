# Exercise 1: Get to know the Nobel data

test_that("Ex 1: nobel object exists", {
  expect_true(exists("nobel"),
              label = "nobel should be created by reading data/nobel.csv")
})

test_that("Ex 1: nobel is a data frame", {
  skip_if(!exists("nobel"))
  expect_true(is.data.frame(nobel),
              label = "nobel should be a data frame")
})

test_that("Ex 1: nobel has 935 rows", {
  skip_if(!exists("nobel"))
  expect_equal(nrow(nobel), 935,
               label = "nobel should have 935 observations")
})

test_that("Ex 1: nobel has 26 columns", {
  skip_if(!exists("nobel"))
  expect_equal(ncol(nobel), 26,
               label = "nobel should have 26 variables")
})

test_that("Ex 1: nobel has expected key variables", {
  skip_if(!exists("nobel"))
  expected_cols <- c("id", "firstname", "surname", "year", "category",
                     "country", "gender", "born_country", "died_date",
                     "born_date", "born_country_code")
  expect_true(all(expected_cols %in% names(nobel)),
              label = "nobel should contain key variables like id, firstname, surname, year, category, country, gender, born_country, died_date")
})

test_that("Ex 1: nobel has at least 6 prize categories", {
  skip_if(!exists("nobel"))
  n_cats <- length(unique(nobel$category))
  expect_true(n_cats >= 6,
              label = "There should be at least 6 prize categories")
})
