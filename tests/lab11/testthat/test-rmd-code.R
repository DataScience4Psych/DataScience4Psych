# Per-exercise checks

test_that("Exercise 1 section contains R code", {
  skip_if(length(.rmd_content) == 0)
  potential_answers <- c("^```\\{r", "`r\\s+[^`]+`", "titanic", "read_csv", "read\\.csv")
  pattern <- paste0("(", paste(potential_answers, collapse = "|"), ")")
  answer_in_rmd <- stringr::str_detect(.rmd_content, pattern) |> any()
  expect_equal(answer_in_rmd, TRUE,
    info = "Include R code (a code chunk or inline R expression) for Exercise 1 in your Rmd"
  )
})

test_that("Exercise 2 section contains R code", {
  skip_if(length(.rmd_content) == 0)
  potential_answers <- c("glm\\(", "binomial", "logit", "predict\\(", "summary\\(")
  pattern <- paste0("(", paste(potential_answers, collapse = "|"), ")")
  answer_in_rmd <- stringr::str_detect(.rmd_content, pattern) |> any()
  expect_equal(answer_in_rmd, TRUE,
    info = "Include R code for Exercise 2 in your Rmd (e.g., fitting a logistic regression with glm())"
  )
})

test_that("Exercise 3 section contains R code", {
  skip_if(length(.rmd_content) == 0)
  potential_answers <- c("accuracy", "cv", "cross.*valid", "predict\\(", "confusionMatrix", "mean\\(")
  pattern <- paste0("(", paste(potential_answers, collapse = "|"), ")")
  answer_in_rmd <- stringr::str_detect(.rmd_content, pattern) |> any()
  expect_equal(answer_in_rmd, TRUE,
    info = "Include R code for Exercise 3 in your Rmd (e.g., computing accuracy or cross-validation)"
  )
})
