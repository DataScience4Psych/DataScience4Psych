# Exercise 2: Create nobel_living filtered data frame

test_that("Ex 2: nobel_living object exists", {
  expect_true(exists("nobel_living"),
    label = "nobel_living should be created by filtering the Nobel dataset"
  )
})

test_that("Ex 2: nobel_living contains only living laureates (no died_date)", {
  skip_if(!exists("nobel_living"))
  expect_true(
    all(is.na(nobel_living$died_date)),
    label = "nobel_living should only contain rows where died_date is NA (still living)"
  )
})

test_that("Ex 2: nobel_living excludes organizations", {
  skip_if(!exists("nobel_living"))
  expect_false(
    any(nobel_living$gender == "org", na.rm = TRUE),
    label = "nobel_living should exclude organizations (gender != 'org')"
  )
})

test_that("Ex 2: nobel_living has country available for all rows", {
  skip_if(!exists("nobel_living"))
  expect_false(
    any(is.na(nobel_living$country)),
    label = "nobel_living should only contain rows where country is not NA"
  )
})

test_that("Ex 2: Rmd confirms expected number of rows using inline code", {
  skip_if(length(.rmd_content) == 0)
  potential_answers <- c(
    "nrow\\(nobel_living\\)",
    "`r nrow\\(nobel_living\\)`"
  )
  pattern <- paste0("(", paste(potential_answers, collapse = "|"), ")")
  answer_in_rmd <- stringr::str_detect(.rmd_content, pattern) |> any()
  expect_equal(answer_in_rmd, TRUE,
    info = "Ex 2: Confirm the number of rows in nobel_living using inline code"
  )
})
