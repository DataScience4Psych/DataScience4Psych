# Part 3: Categorical predictors - gender and rank

test_that("Ex 3: m_gen object exists", {
  expect_true(exists("m_gen"),
              label = "m_gen should be created as lm(score ~ gender, data = evals)")
})

test_that("Ex 3: m_gen is a linear model", {
  skip_if(!exists("m_gen"))
  expect_s3_class(m_gen, "lm")
})

test_that("Ex 3: m_gen has 2 coefficients (intercept + gender)", {
  skip_if(!exists("m_gen"))
  expect_equal(length(coef(m_gen)), 2,
               label = "m_gen should have 2 coefficients: intercept and one gender level")
})

test_that("Ex 3: m_gen uses gender as predictor", {
  skip_if(!exists("m_gen"))
  model_terms <- attr(terms(m_gen), "term.labels")
  expect_true("gender" %in% model_terms,
              label = "m_gen should use gender as its predictor variable")
})

test_that("Ex 3: rank_relevel variable is created in evals", {
  skip_if(!exists("evals"))
  expect_true("rank_relevel" %in% names(evals),
              label = "evals should have a rank_relevel column created by releveling rank")
})

test_that("Ex 3: rank_relevel is a factor with tenure track as reference", {
  skip_if(!exists("evals"))
  skip_if(!"rank_relevel" %in% names(evals))
  expect_true(is.factor(evals$rank_relevel),
              label = "rank_relevel should be a factor")
  expect_equal(levels(evals$rank_relevel)[1], "tenure track",
               label = "The reference level of rank_relevel should be 'tenure track'")
})

test_that("Ex 3: rank_relevel has same values as rank (just releveled)", {
  skip_if(!exists("evals"))
  skip_if(!all(c("rank", "rank_relevel") %in% names(evals)))
  expect_equal(sort(unique(as.character(evals$rank))),
               sort(unique(as.character(evals$rank_relevel))),
               label = "rank_relevel should contain the same unique values as rank")
})

test_that("Ex 3: tenure_eligible variable is created in evals", {
  skip_if(!exists("evals"))
  expect_true("tenure_eligible" %in% names(evals),
              label = "evals should have a tenure_eligible column")
})

test_that("Ex 3: tenure_eligible has two levels", {
  skip_if(!exists("evals"))
  skip_if(!"tenure_eligible" %in% names(evals))
  n_unique <- length(unique(evals$tenure_eligible))
  expect_equal(n_unique, 2,
               label = "tenure_eligible should have exactly 2 unique values (yes/no or eligible/not)")
})
