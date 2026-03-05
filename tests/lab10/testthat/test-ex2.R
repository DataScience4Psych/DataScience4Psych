# Part 2: Beauty as a predictor - linear model

test_that("Part 2 Ex 1: m_bty model exists", {
  expect_true(exists("m_bty"),
              label = "m_bty should be a linear model predicting score by bty_avg")
})

test_that("Part 2 Ex 1: m_bty is a linear model", {
  skip_if(!exists("m_bty"))
  expect_s3_class(m_bty, "lm")
})

test_that("Part 2 Ex 1: m_bty has positive slope for bty_avg", {
  skip_if(!exists("m_bty"))
  slope <- coef(m_bty)["bty_avg"]
  expect_true(slope > 0,
              label = "The beauty coefficient should be positive")
})

test_that("Part 2 Ex 3: R-squared for beauty model is small", {
  skip_if(!exists("m_bty"))
  r_sq <- summary(m_bty)$r.squared
  expect_true(r_sq < 0.1,
              label = "R-squared for beauty alone should be modest (< 0.1)")
})
