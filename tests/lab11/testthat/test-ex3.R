# Exercise 3: Cross validation

test_that("Ex 3: Rmd implements cross validation with folds", {
  skip_if(length(.rmd_content) == 0)
  potential_answers <- c(
    "fold",
    "cross.valid",
    "cv_",
    "k.fold"
  )
  pattern <- paste0("(", paste(potential_answers, collapse = "|"), ")")
  answer_in_rmd <- stringr::str_detect(.rmd_content, pattern) |> any()
  expect_equal(answer_in_rmd, TRUE,
    info = "Ex 3: Implement cross validation using folds"
  )
})

test_that("Ex 3: cv_mean exists and is a plausible cross-validated accuracy", {
  skip_if(!exists("cv_mean"))
  expect_true(
    is.numeric(cv_mean) && cv_mean > 0.4 && cv_mean < 1,
    label = sprintf(
      "cv_mean should be a numeric cross-validated accuracy between 0.4 and 1, got %s",
      cv_mean
    )
  )
})

test_that("Ex 3: cv_mean is lower than acc_apparent (CV is less optimistic)", {
  skip_if(!exists("cv_mean") || !exists("acc_apparent"))
  expect_true(
    cv_mean <= acc_apparent,
    label = sprintf(
      "cv_mean (%.3f) should be <= acc_apparent (%.3f) — CV accuracy is typically less optimistic",
      cv_mean, acc_apparent
    )
  )
})

test_that("Ex 3: Rmd explains why CV mean is lower than apparent accuracy", {
  skip_if(length(.rmd_content) == 0)
  potential_answers <- c(
    "cv_mean",
    "cross.valid",
    "overfit"
  )
  pattern <- paste0("(", paste(potential_answers, collapse = "|"), ")")
  answer_in_rmd <- stringr::str_detect(.rmd_content, pattern) |> any()
  expect_equal(answer_in_rmd, TRUE,
    info = "Ex 3: Explain why cross-validated accuracy is typically lower than apparent accuracy"
  )
})
