# Exercise 1: Fit logistic regression model on full Titanic data

test_that("Ex 1: titanic3 or titanic_train data exists", {
  skip_if(length(.rmd_content) == 0)
  potential_answers <- c(
    "titanic3",
    "titanic_train",
    "library\\(titanic\\)"
  )
  pattern <- paste0("(", paste(potential_answers, collapse = "|"), ")")
  answer_in_rmd <- stringr::str_detect(.rmd_content, pattern) |> any()
  expect_equal(answer_in_rmd, TRUE,
    info = "Make sure to load the Titanic dataset in your Rmd"
  )
})

test_that("Ex 1.1: m_apparent model exists", {
  expect_true(exists("m_apparent"),
    label = "m_apparent should be a logistic regression model predicting survival"
  )
})

test_that("Ex 1.1: m_apparent is a generalized linear model (logistic regression)", {
  skip_if(!exists("m_apparent"))
  expect_s3_class(m_apparent, "glm")
  expect_equal(m_apparent$family$family, "binomial",
    info = "m_apparent should use binomial family (logistic regression)"
  )
})

test_that("Ex 1.1: m_apparent predicts survived from sex and pclass", {
  skip_if(!exists("m_apparent"))
  model_vars <- names(coef(m_apparent))
  expect_true(
    any(grepl("sex|pclass", model_vars)),
    label = "m_apparent should include sex and pclass as predictors"
  )
})

test_that("Ex 1.3: acc_apparent exists and is a reasonable accuracy value", {
  skip_if(!exists("acc_apparent"))
  expect_true(
    is.numeric(acc_apparent) && acc_apparent > 0.5 && acc_apparent < 1,
    label = sprintf(
      "acc_apparent should be a numeric accuracy between 0.5 and 1, got %s",
      acc_apparent
    )
  )
})
