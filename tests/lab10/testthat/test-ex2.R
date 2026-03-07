# Part 2: Simple linear regression - beauty as a predictor

test_that("Ex 2: m_bty object exists", {
  expect_true(exists("m_bty"),
              info = "Create m_bty using lm(score ~ bty_avg, data = evals)")
})

test_that("Ex 2: m_bty is a linear model", {
  skip_if(!exists("m_bty"))
  expect_s3_class(m_bty, "lm")
})

test_that("Ex 2: m_bty has 2 coefficients (intercept + bty_avg)", {
  skip_if(!exists("m_bty"))
  expect_equal(length(coef(m_bty)), 2,
               info = "Ensure m_bty has 2 coefficients: intercept and bty_avg")
})

test_that("Ex 2: m_bty uses bty_avg as predictor", {
  skip_if(!exists("m_bty"))
  predictor_names <- names(coef(m_bty))
  expect_true("bty_avg" %in% predictor_names,
              info = "Include bty_avg as the predictor in your m_bty model")
})

test_that("Ex 2: m_bty has positive slope for bty_avg", {
  skip_if(!exists("m_bty"))
  slope <- coef(m_bty)["bty_avg"]
  expect_true(slope > 0,
              info = "The bty_avg coefficient should be positive (higher beauty -> higher score)")
})

test_that("Ex 2: R-squared for m_bty is small (around 0.03)", {
  skip_if(!exists("m_bty"))
  r_sq <- summary(m_bty)$r.squared
  expect_true(r_sq > 0.01 && r_sq < 0.10,
              info = sprintf("R-squared for beauty alone should be modest (0.01-0.10), got %.4f", r_sq))
})

test_that("Ex 2: m_bty was fit on all 463 evals observations", {
  skip_if(!exists("m_bty"))
  expect_equal(nobs(m_bty), 463,
               info = "Fit m_bty on all 463 observations in the evals dataset")
})

test_that("Ex 2: Rmd Exercise 2 reports model slope or uses summary/coef code", {
  skip_if(length(.rmd_content) == 0)
  skip_if(!exists("m_bty"))
  solution_slope <- coef(m_bty)["bty_avg"]
  slope_patterns <- c(sprintf("%.4f", solution_slope), sprintf("%.3f", solution_slope),
                      sprintf("%.2f", solution_slope))
  potential_answers <- c(slope_patterns, "summary\\(", "coef\\(", "tidy\\(")
  pattern <- paste0("(", paste(potential_answers, collapse = "|"), ")")
  answer_in_rmd <- stringr::str_detect(.rmd_content, pattern) |> any()
  expect_equal(answer_in_rmd, TRUE,
               info = sprintf("Report the bty_avg slope (%.4f) or use summary()/coef()/tidy() in your Rmd", solution_slope))
})
