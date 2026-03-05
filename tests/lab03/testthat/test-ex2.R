# Exercise 2: Create nobel_living data frame

test_that("Ex 2: nobel_living object exists", {
  expect_true(exists("nobel_living"),
              label = "nobel_living should be created by filtering nobel")
})

test_that("Ex 2: nobel_living excludes deceased laureates", {
  skip_if(!exists("nobel_living"))
  expect_true(all(is.na(nobel_living$died_date)),
              label = "nobel_living should only include laureates who are still alive")
})

test_that("Ex 2: nobel_living excludes organizations", {
  skip_if(!exists("nobel_living"))
  expect_true(all(nobel_living$gender != "org"),
              label = "nobel_living should exclude organizations (gender == 'org')")
})

test_that("Ex 2: nobel_living has no missing country values", {
  skip_if(!exists("nobel_living"))
  expect_true(all(!is.na(nobel_living$country)),
              label = "nobel_living should not contain NA values for country")
})
