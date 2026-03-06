# Exercise 1: COMPAS dataset dimensions

test_that("Ex 1: compas object exists in student environment", {
  skip_if(length(.rmd_content) == 0)
  potential_answers <- c(
    "read_csv.*compas",
    "compas\\s*<-",
    "compas-scores"
  )
  pattern <- paste0("(", paste(potential_answers, collapse = "|"), ")")
  answer_in_rmd <- stringr::str_detect(.rmd_content, pattern) |> any()
  expect_equal(answer_in_rmd, TRUE,
    info = "Make sure to load the COMPAS dataset in your Rmd"
  )
})

test_that("Ex 1: compas has more than 7000 rows", {
  skip_if(!exists("compas"))
  expect_gt(nrow(compas), 7000,
    label = "The COMPAS dataset should have more than 7000 rows"
  )
})

test_that("Ex 1: compas has expected variables", {
  skip_if(!exists("compas"))
  expected_vars <- c("id", "decile_score", "two_year_recid", "race", "sex", "age_cat", "priors_count")
  expect_true(
    all(expected_vars %in% names(compas)),
    label = paste("compas should contain columns:", paste(expected_vars, collapse = ", "))
  )
})

test_that("Ex 1: Rmd reports COMPAS dimensions using inline code", {
  skip_if(length(.rmd_content) == 0)
  potential_answers <- c(
    "nrow\\(compas\\)",
    "ncol\\(compas\\)",
    "dim\\(compas\\)"
  )
  pattern <- paste0("(", paste(potential_answers, collapse = "|"), ")")
  answer_in_rmd <- stringr::str_detect(.rmd_content, pattern) |> any()
  expect_equal(answer_in_rmd, TRUE,
    info = "Ex 1: Report the COMPAS dataset dimensions using inline code"
  )
})
