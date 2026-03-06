# Exercises 4-10: Simpson's paradox (Whickham smoking data)

test_that("Ex 4: Rmd loads Whickham data", {
  skip_if(length(.rmd_content) == 0)
  potential_answers <- c(
    "data\\(Whickham\\)",
    "Whickham",
    "mosaicData"
  )
  pattern <- paste0("(", paste(potential_answers, collapse = "|"), ")")
  answer_in_rmd <- stringr::str_detect(.rmd_content, pattern) |> any()
  expect_equal(answer_in_rmd, TRUE,
    info = "Ex 4: Load the Whickham dataset using data(Whickham) from the mosaicData package"
  )
})

test_that("Ex 4: Whickham has expected variables", {
  skip_if(!requireNamespace("mosaicData", quietly = TRUE))
  data("Whickham", package = "mosaicData", envir = environment())
  whick <- get("Whickham", envir = environment())
  expected_vars <- c("outcome", "smoker", "age")
  expect_true(
    all(expected_vars %in% names(whick)),
    label = paste("Whickham should have columns:", paste(expected_vars, collapse = ", "))
  )
})

test_that("Ex 5 & 6: Rmd reports Whickham dimensions and variable types", {
  skip_if(length(.rmd_content) == 0)
  potential_answers <- c(
    "nrow\\(Whickham\\)",
    "ncol\\(Whickham\\)",
    "dim\\(Whickham\\)",
    "glimpse\\(Whickham\\)",
    "str\\(Whickham\\)"
  )
  pattern <- paste0("(", paste(potential_answers, collapse = "|"), ")")
  answer_in_rmd <- stringr::str_detect(.rmd_content, pattern) |> any()
  expect_equal(answer_in_rmd, TRUE,
    info = "Ex 5/6: Report the number of observations and variable types for Whickham"
  )
})

test_that("Ex 8: Rmd visualizes relationship between smoking and health outcome", {
  skip_if(length(.rmd_content) == 0)
  potential_answers <- c(
    "outcome",
    "smoker"
  )
  pattern <- paste0("(", paste(potential_answers, collapse = "|"), ")")
  answer_in_rmd <- stringr::str_detect(.rmd_content, pattern) |> any()
  expect_equal(answer_in_rmd, TRUE,
    info = "Ex 8: Create a visualization of smoking status vs health outcome"
  )
})

test_that("Ex 9: Rmd creates age_cat variable", {
  skip_if(length(.rmd_content) == 0)
  answer_in_rmd <- stringr::str_detect(.rmd_content, "age_cat") |> any()
  expect_equal(answer_in_rmd, TRUE,
    info = "Ex 9: Create an age_cat variable to categorize age groups"
  )
})

test_that("Ex 10: Rmd creates faceted plot by age_cat (reveals Simpson's paradox)", {
  skip_if(length(.rmd_content) == 0)
  potential_answers <- c(
    "facet_wrap.*age_cat",
    "facet_grid.*age_cat"
  )
  pattern <- paste0("(", paste(potential_answers, collapse = "|"), ")")
  answer_in_rmd <- stringr::str_detect(.rmd_content, pattern) |> any()
  expect_equal(answer_in_rmd, TRUE,
    info = "Ex 10: Facet your visualization by age_cat to reveal Simpson's paradox"
  )
})
