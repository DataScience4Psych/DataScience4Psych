# Part 3: Categorical predictors - gender and rank

test_that("Ex 3: m_gen object exists", {
  expect_true(exists("m_gen"),
              info = "Create m_gen using lm(score ~ gender, data = evals)")
})

test_that("Ex 3: m_gen is a linear model", {
  skip_if(!exists("m_gen"))
  expect_s3_class(m_gen, "lm")
})

test_that("Ex 3: m_gen has 2 coefficients (intercept + gender)", {
  skip_if(!exists("m_gen"))
  expect_equal(length(coef(m_gen)), 2,
               info = "Ensure m_gen has 2 coefficients: intercept and one gender level")
})

test_that("Ex 3: m_gen uses gender as predictor", {
  skip_if(!exists("m_gen"))
  model_terms <- attr(terms(m_gen), "term.labels")
  expect_true("gender" %in% model_terms,
              info = "Use gender as the predictor variable in your m_gen model")
})

test_that("Ex 3: rank_relevel variable is created in evals", {
  skip_if(!exists("evals"))
  expect_true("rank_relevel" %in% names(evals),
              info = "Create a rank_relevel column in evals by releveling the rank variable")
})

test_that("Ex 3: rank_relevel is a factor with tenure track as reference", {
  skip_if(!exists("evals"))
  skip_if(!"rank_relevel" %in% names(evals))
  expect_true(is.factor(evals$rank_relevel),
              info = "Ensure rank_relevel is a factor variable")
  expect_equal(levels(evals$rank_relevel)[1], "tenure track",
               info = "Set 'tenure track' as the reference level of rank_relevel")
})

test_that("Ex 3: rank_relevel has same values as rank (just releveled)", {
  skip_if(!exists("evals"))
  skip_if(!all(c("rank", "rank_relevel") %in% names(evals)))
  expect_equal(sort(unique(as.character(evals$rank))),
               sort(unique(as.character(evals$rank_relevel))),
               info = "Ensure rank_relevel contains the same unique values as rank")
})

test_that("Ex 3: tenure_eligible variable is created in evals", {
  skip_if(!exists("evals"))
  expect_true("tenure_eligible" %in% names(evals),
              info = "Create a tenure_eligible column in evals")
})

test_that("Ex 3: tenure_eligible has two levels", {
  skip_if(!exists("evals"))
  skip_if(!"tenure_eligible" %in% names(evals))
  n_unique <- length(unique(evals$tenure_eligible))
  expect_equal(n_unique, 2,
               info = "Ensure tenure_eligible has exactly 2 unique values (yes/no or eligible/not)")
})
