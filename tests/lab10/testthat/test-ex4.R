# Part 4: Multiple linear regression

test_that("Part 4 Ex 1: m_bty_gen model exists", {
  expect_true(exists("m_bty_gen"),
              label = "m_bty_gen should be a model of score ~ bty_avg + gender")
})

test_that("Part 4 Ex 1: m_bty_gen is a linear model with 2 predictors", {
  skip_if(!exists("m_bty_gen"))
  expect_s3_class(m_bty_gen, "lm")
  # Should have intercept + bty_avg + gendermale = 3 coefficients
  expect_equal(length(coef(m_bty_gen)), 3,
               label = "m_bty_gen should have 3 coefficients (intercept + bty_avg + gender)")
})

test_that("Part 4 Ex 3: adjusted R-squared for m_bty_gen is slightly higher than m_bty", {
  skip_if(!exists("m_bty") || !exists("m_bty_gen"))
  r2_bty <- summary(m_bty)$adj.r.squared
  r2_bty_gen <- summary(m_bty_gen)$adj.r.squared
  expect_true(r2_bty_gen >= r2_bty,
              label = "Adding gender should not decrease adjusted R-squared")
})
