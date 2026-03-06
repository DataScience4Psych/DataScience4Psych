# Part 4 & 5: Multiple linear regression and model selection

test_that("Ex 4.1: m_bty_gen model exists", {
  expect_true(exists("m_bty_gen"),
    label = "m_bty_gen should be a linear model predicting score from bty_avg + gender"
  )
})

test_that("Ex 4.1: m_bty_gen includes both bty_avg and gender", {
  skip_if(!exists("m_bty_gen"))
  expect_true(
    "bty_avg" %in% names(coef(m_bty_gen)) &&
      "gendermale" %in% names(coef(m_bty_gen)),
    label = "m_bty_gen should have both bty_avg and gendermale as coefficients"
  )
})

test_that("Ex 4.4: m_bty_rank model exists", {
  expect_true(exists("m_bty_rank"),
    label = "m_bty_rank should be a linear model predicting score from bty_avg + rank"
  )
})

test_that("Ex 5.4: Rmd fits a full model with multiple predictors", {
  skip_if(length(.rmd_content) == 0)
  potential_answers <- c(
    "cls_perc_eval",
    "cls_students",
    "ethnicity",
    "language"
  )
  pattern <- paste0("(", paste(potential_answers, collapse = "|"), ")")
  answer_in_rmd <- stringr::str_detect(.rmd_content, pattern) |> any()
  expect_equal(answer_in_rmd, TRUE,
    info = "Ex 5.4/5.5: Fit a full model using multiple predictors (e.g., cls_perc_eval, ethnicity, language)"
  )
})

test_that("Ex 5.5: Rmd performs backward selection for best model", {
  skip_if(length(.rmd_content) == 0)
  potential_answers <- c(
    "backward",
    "adj.*R",
    "adjusted.*R",
    "step\\("
  )
  pattern <- paste0("(", paste(potential_answers, collapse = "|"), ")")
  answer_in_rmd <- stringr::str_detect(.rmd_content, pattern) |> any()
  expect_equal(answer_in_rmd, TRUE,
    info = "Ex 5.5: Perform backward selection using adjusted R-squared as the criterion"
  )
})
