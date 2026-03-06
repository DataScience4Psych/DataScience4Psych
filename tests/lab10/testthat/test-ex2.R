# Part 2: Simple linear regression - beauty as a predictor

test_that("Ex 2: m_bty object exists", {
  expect_true(exists("m_bty"),
              label = "m_bty should be created as lm(score ~ bty_avg, data = evals)")
})

test_that("Ex 2: m_bty is a linear model", {
  skip_if(!exists("m_bty"))
  expect_s3_class(m_bty, "lm")
})

test_that("Ex 2: m_bty has 2 coefficients (intercept + bty_avg)", {
  skip_if(!exists("m_bty"))
  expect_equal(length(coef(m_bty)), 2,
               label = "m_bty should have 2 coefficients: intercept and bty_avg")
})

test_that("Ex 2: m_bty uses bty_avg as predictor", {
  skip_if(!exists("m_bty"))
  predictor_names <- names(coef(m_bty))
  expect_true("bty_avg" %in% predictor_names,
              label = "m_bty should include bty_avg as a predictor")
})

test_that("Ex 2: m_bty has positive slope for bty_avg", {
  skip_if(!exists("m_bty"))
  slope <- coef(m_bty)["bty_avg"]
  expect_true(slope > 0,
              label = "The bty_avg coefficient should be positive (higher beauty -> higher score)")
})

test_that("Ex 2: R-squared for m_bty is small (around 0.03)", {
  skip_if(!exists("m_bty"))
  r_sq <- summary(m_bty)$r.squared
  expect_true(r_sq > 0.01 && r_sq < 0.10,
              label = sprintf("R-squared for beauty alone should be modest (0.01-0.10), got %.4f", r_sq))
})

test_that("Ex 2: m_bty was fit on all 463 evals observations", {
  skip_if(!exists("m_bty"))
  expect_equal(nobs(m_bty), 463,
               label = "m_bty should be fit on all 463 observations in evals")
})

test_that("Ex 2: Rmd Exercise 2 reports model slope or uses summary/coef code", {
  skip_if(length(.rmd_content) == 0)
  skip_if(!exists("m_bty"))
  section <- .find_ex_section(.rmd_content, "2", "3")
  skip_if(is.null(section), "Could not locate Exercise 2 section in Rmd")
  solution_slope <- coef(m_bty)["bty_avg"]
  slope_patterns <- c(sprintf("%.4f", solution_slope), sprintf("%.3f", solution_slope),
                      sprintf("%.2f", solution_slope))
  has_value <- any(sapply(slope_patterns, function(p) any(grepl(p, section, fixed = TRUE))))
  has_code <- any(grepl("summary\\(|coef\\(|tidy\\(", section))
  expect_true(has_value || has_code,
              label = sprintf("Exercise 2 should report the bty_avg slope (%.4f) or use summary()/coef()", solution_slope))
})
