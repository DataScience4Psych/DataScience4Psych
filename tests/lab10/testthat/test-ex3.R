# Part 3, Exercises 1-4: Linear regression with categorical predictors

test_that("Ex 3.1: m_gen model exists", {
  expect_true(exists("m_gen"),
    label = "m_gen should be a linear model predicting score from gender"
  )
})

test_that("Ex 3.1: m_gen is a linear model with gender predictor", {
  skip_if(!exists("m_gen"))
  expect_s3_class(m_gen, "lm")
  expect_true(
    "gendermale" %in% names(coef(m_gen)),
    label = "m_gen should have gendermale as a coefficient (female is the reference level)"
  )
})

test_that("Ex 3.2: Rmd creates rank_relevel variable with tenure track as baseline", {
  skip_if(length(.rmd_content) == 0)
  potential_answers <- c(
    "rank_relevel",
    "relevel.*tenure track",
    "fct_relevel.*tenure"
  )
  pattern <- paste0("(", paste(potential_answers, collapse = "|"), ")")
  answer_in_rmd <- stringr::str_detect(.rmd_content, pattern) |> any()
  expect_equal(answer_in_rmd, TRUE,
    info = "Ex 3.2: Create rank_relevel with 'tenure track' as the baseline level"
  )
})

test_that("Ex 3.2: Rmd creates tenure_eligible variable", {
  skip_if(length(.rmd_content) == 0)
  answer_in_rmd <- stringr::str_detect(.rmd_content, "tenure_eligible") |> any()
  expect_equal(answer_in_rmd, TRUE,
    info = "Ex 3.2: Create tenure_eligible variable (teaching = 'no', others = 'yes')"
  )
})

test_that("Ex 3.4: Rmd reports R-squared for rank model", {
  skip_if(length(.rmd_content) == 0)
  potential_answers <- c(
    "R.squared",
    "r.squared",
    "glance\\(",
    "summary\\(m_"
  )
  pattern <- paste0("(", paste(potential_answers, collapse = "|"), ")")
  answer_in_rmd <- stringr::str_detect(.rmd_content, pattern) |> any()
  expect_equal(answer_in_rmd, TRUE,
    info = "Ex 3.4: Report the R-squared value for the rank model"
  )
})
