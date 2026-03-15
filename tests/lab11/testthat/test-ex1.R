# Exercise 1: Apparent accuracy (fitting a model on full data)

test_that("Ex 1: titanic3 data object exists", {
  expect_true(exists("titanic3"),
              info = "Load the titanic3 dataset (e.g., library(titanic); data(titanic3) or titanic::titanic3)")
})

test_that("Ex 1: titanic3 is a data frame with sufficient rows", {
  skip_if(!exists("titanic3"), message = "titanic3 not found")
  expect_true(is.data.frame(titanic3),
              info = "titanic3 should be a data frame")
  expect_true(nrow(titanic3) >= 1300,
              info = "titanic3 should have at least 1300 rows")
})

test_that("Ex 1: titanic3 has survived, sex, and pclass columns", {
  skip_if(!exists("titanic3"), message = "titanic3 not found")
  expected <- c("survived", "sex", "pclass")
  expect_true(all(expected %in% names(titanic3)),
              info = "titanic3 should contain survived, sex, and pclass columns")
})

test_that("Ex 1: titanic3$survived is binary (0 or 1)", {
  skip_if(!exists("titanic3"), message = "titanic3 not found")
  skip_if(!"survived" %in% names(titanic3))
  vals <- unique(titanic3$survived[!is.na(titanic3$survived)])
  expect_true(all(vals %in% c(0, 1)),
              info = "survived should be coded as 0 (perished) or 1 (survived)")
})

test_that("Ex 1: m_apparent model object exists", {
  expect_true(exists("m_apparent"),
              info = "Create m_apparent using glm(survived ~ sex + pclass, data = titanic3, family = binomial)")
})

test_that("Ex 1: m_apparent is a binomial glm", {
  skip_if(!exists("m_apparent"), message = "m_apparent not found")
  expect_s3_class(m_apparent, "glm")
  expect_equal(m_apparent$family$family, "binomial",
               info = "Use family = binomial in your glm() call for logistic regression")
})

test_that("Ex 1: m_apparent uses sex and pclass as predictors", {
  skip_if(!exists("m_apparent"), message = "m_apparent not found")
  model_terms <- attr(terms(m_apparent), "term.labels")
  expect_true("sex" %in% model_terms,
              info = "Include sex as a predictor in m_apparent")
  expect_true("pclass" %in% model_terms,
              info = "Include pclass as a predictor in m_apparent")
})

test_that("Ex 1: p_apparent predicted probabilities exist and are valid", {
  skip_if(!exists("m_apparent"), message = "m_apparent not found")
  has_preds <- exists("p_apparent")
  if (!has_preds) skip("p_apparent not found")
  expect_true(is.numeric(p_apparent),
              info = "p_apparent should be a numeric vector of predicted probabilities")
  expect_true(all(p_apparent >= 0 & p_apparent <= 1, na.rm = TRUE),
              info = "p_apparent values should be between 0 and 1 (use type = 'response')")
})

test_that("Ex 1: yhat_apparent classified predictions exist (0/1 values)", {
  skip_if(!exists("p_apparent"), message = "p_apparent not found")
  has_yhat <- exists("yhat_apparent")
  if (!has_yhat) skip("yhat_apparent not found")
  vals <- unique(yhat_apparent[!is.na(yhat_apparent)])
  expect_true(all(vals %in% c(0, 1)),
              info = "yhat_apparent should contain only 0 and 1 (classify using a 0.5 cutoff)")
})

test_that("Ex 1: acc_apparent exists and is a reasonable accuracy (> 70%, < 100%)", {
  skip_if(!exists("m_apparent"), message = "m_apparent not found")
  has_acc <- exists("acc_apparent")
  if (!has_acc) skip("acc_apparent not found")
  acc <- acc_apparent
  if (acc > 1) acc <- acc / 100
  expect_true(acc > 0.70,
              info = sprintf("acc_apparent should be above 70%%, got %.1f%%", acc * 100))
  expect_true(acc < 1.0,
              info = "acc_apparent should not be perfect (< 100%%) — this is apparent accuracy, not truth")
})


