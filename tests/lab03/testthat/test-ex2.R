# Exercise 2: Create nobel_living data frame

test_that("Ex 2: nobel_living object exists", {
  expect_true(exists("nobel_living"),
    info = "Create the nobel_living object by filtering nobel for living laureates"
  )
})

test_that("Ex 2: nobel_living is a data frame", {
  skip_if(!exists("nobel_living"))
  expect_true(is.data.frame(nobel_living),
    info = "Make sure nobel_living is a data frame"
  )
})

test_that("Ex 2: nobel_living excludes deceased laureates (died_date is NA)", {
  skip_if(!exists("nobel_living"))
  expect_true(all(is.na(nobel_living$died_date)),
    info = "Filter nobel_living to only include laureates who are still alive (died_date is NA)"
  )
})

test_that("Ex 2: nobel_living excludes organizations (gender != 'org')", {
  skip_if(!exists("nobel_living"))
  expect_true(all(nobel_living$gender != "org"),
    info = "Filter nobel_living to exclude organizations (gender != 'org')"
  )
})

test_that("Ex 2: nobel_living has no missing country values", {
  skip_if(!exists("nobel_living"))
  expect_true(all(!is.na(nobel_living$country)),
    info = "Filter nobel_living so it does not contain NA values for country"
  )
})

test_that("Ex 2: nobel_living has fewer rows than nobel", {
  skip_if(!exists("nobel_living") || !exists("nobel"))
  expect_true(nrow(nobel_living) < nrow(nobel),
    info = "Make sure nobel_living has fewer rows than the full nobel dataset after filtering"
  )
})
