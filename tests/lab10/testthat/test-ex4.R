# Part 4: Multiple linear regression

test_that("Ex 4: m_bty_gen object exists", {
  expect_true(exists("m_bty_gen"),
              info = "Create m_bty_gen using lm(score ~ bty_avg + gender, data = evals)")
})

test_that("Ex 4: m_bty_gen is a linear model", {
  skip_if(!exists("m_bty_gen"))
  expect_s3_class(m_bty_gen, "lm")
})

test_that("Ex 4: m_bty_gen has 3 coefficients (intercept + bty_avg + gender)", {
  skip_if(!exists("m_bty_gen"))
  expect_equal(length(coef(m_bty_gen)), 3,
               info = "Ensure m_bty_gen has 3 coefficients: intercept, bty_avg, and gender")
})

test_that("Ex 4: m_bty_gen uses both bty_avg and gender as predictors", {
  skip_if(!exists("m_bty_gen"))
  model_terms <- attr(terms(m_bty_gen), "term.labels")
  expect_true("bty_avg" %in% model_terms,
              info = "Include bty_avg as a predictor in m_bty_gen")
  expect_true("gender" %in% model_terms,
              info = "Include gender as a predictor in m_bty_gen")
})

test_that("Ex 4: adjusted R-squared for m_bty_gen >= m_bty", {
  skip_if(!exists("m_bty") || !exists("m_bty_gen"))
  r2_bty <- summary(m_bty)$adj.r.squared
  r2_bty_gen <- summary(m_bty_gen)$adj.r.squared
  expect_true(r2_bty_gen >= r2_bty,
              info = "Adding gender should not decrease adjusted R-squared compared to m_bty")
})

test_that("Ex 4: m_bty_rank object exists", {
  expect_true(exists("m_bty_rank"),
              info = "Create m_bty_rank using lm(score ~ bty_avg + rank, data = evals)")
})

test_that("Ex 4: m_bty_rank is a linear model", {
  skip_if(!exists("m_bty_rank"))
  expect_s3_class(m_bty_rank, "lm")
})

test_that("Ex 4: m_bty_rank has 4 coefficients (intercept + bty_avg + 2 rank levels)", {
  skip_if(!exists("m_bty_rank"))
  expect_equal(length(coef(m_bty_rank)), 4,
               info = "Ensure m_bty_rank has 4 coefficients: intercept, bty_avg, and 2 rank dummies")
})

test_that("Ex 4: m_bty_rank uses both bty_avg and rank as predictors", {
  skip_if(!exists("m_bty_rank"))
  model_terms <- attr(terms(m_bty_rank), "term.labels")
  expect_true("bty_avg" %in% model_terms,
              info = "Include bty_avg as a predictor in m_bty_rank")
  expect_true("rank" %in% model_terms,
              info = "Include rank as a predictor in m_bty_rank")
})
