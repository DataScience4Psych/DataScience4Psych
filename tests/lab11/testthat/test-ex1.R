# Exercise 1: Loading and exploring Titanic data

test_that("Ex 1: Titanic data object exists", {
  has_data <- exists("titanic") || exists("titanic_train") || exists("titanic_data") || exists("titanic3")
  expect_true(has_data,
    info = "Load a Titanic data object (e.g., titanic3, titanic_train, or titanic_data)"
  )
})

test_that("Ex 1: Titanic data is a data frame", {
  d <- NULL
  if (exists("titanic3")) {
    d <- titanic3
  } else if (exists("titanic_train")) {
    d <- titanic_train
  } else if (exists("titanic")) {
    d <- titanic
  } else if (exists("titanic_data")) d <- titanic_data
  skip_if(is.null(d), message = "No Titanic data object found")
  expect_true(is.data.frame(d),
    info = "Ensure your Titanic data object is a data frame"
  )
})

test_that("Ex 1: Titanic data has Survived variable (any case)", {
  d <- NULL
  if (exists("titanic3")) {
    d <- titanic3
  } else if (exists("titanic_train")) {
    d <- titanic_train
  } else if (exists("titanic")) {
    d <- titanic
  } else if (exists("titanic_data")) d <- titanic_data
  skip_if(is.null(d), message = "No Titanic data object found")
  has_survived <- "survived" %in% tolower(names(d))
  expect_true(has_survived,
    info = "Ensure your Titanic data has a survived column (lowercase or uppercase)"
  )
})

test_that("Ex 1: Survived is binary (0 or 1)", {
  d <- NULL
  if (exists("titanic3")) {
    d <- titanic3
  } else if (exists("titanic_train")) {
    d <- titanic_train
  } else if (exists("titanic")) {
    d <- titanic
  } else if (exists("titanic_data")) d <- titanic_data
  skip_if(is.null(d), message = "No Titanic data object found")
  surv_col <- names(d)[tolower(names(d)) == "survived"][1]
  skip_if(is.na(surv_col))
  vals <- unique(d[[surv_col]][!is.na(d[[surv_col]])])
  expect_true(all(vals %in% c(0, 1)),
    info = "Ensure Survived is coded as binary (0 or 1)"
  )
})

test_that("Ex 1: Titanic data has key predictor variables", {
  d <- NULL
  if (exists("titanic3")) {
    d <- titanic3
  } else if (exists("titanic_train")) {
    d <- titanic_train
  } else if (exists("titanic")) {
    d <- titanic
  } else if (exists("titanic_data")) d <- titanic_data
  skip_if(is.null(d), message = "No Titanic data object found")
  lower_names <- tolower(names(d))
  expect_true(all(c("pclass", "sex") %in% lower_names),
    info = "Ensure your Titanic data has pclass and sex columns"
  )
})

test_that("Ex 1: Titanic data has a reasonable number of observations", {
  d <- NULL
  if (exists("titanic3")) {
    d <- titanic3
  } else if (exists("titanic_train")) {
    d <- titanic_train
  } else if (exists("titanic")) {
    d <- titanic
  } else if (exists("titanic_data")) d <- titanic_data
  skip_if(is.null(d), message = "No Titanic data object found")
  expect_true(nrow(d) >= 600,
    info = "Ensure your Titanic data has at least 600 observations"
  )
})

# Lab-specific checks: objects expected by the lab instructions

test_that("Ex 1: titanic3 data object exists", {
  expect_true(exists("titanic3"),
    info = "Load the titanic3 dataset (from data/titanic3.xls via read_excel)"
  )
})

test_that("Ex 1: m_apparent model object exists", {
  expect_true(exists("m_apparent"),
    info = "Create m_apparent using glm(survived ~ sex + pclass, data = titanic3, family = binomial)"
  )
})

test_that("Ex 1: m_apparent is a binomial glm", {
  skip_if(!exists("m_apparent"), message = "m_apparent not found")
  expect_s3_class(m_apparent, "glm")
  expect_equal(m_apparent$family$family, "binomial",
    info = "Use family = binomial in your glm() call for logistic regression"
  )
})

test_that("Ex 1: m_apparent uses sex and pclass as predictors", {
  skip_if(!exists("m_apparent"), message = "m_apparent not found")
  model_terms <- attr(terms(m_apparent), "term.labels")
  expect_true("sex" %in% model_terms,
    info = "Include sex as a predictor in m_apparent"
  )
  expect_true("pclass" %in% model_terms,
    info = "Include pclass as a predictor in m_apparent"
  )
})

test_that("Ex 1: p_apparent predicted probabilities exist and are valid", {
  skip_if(!exists("m_apparent"), message = "m_apparent not found")
  has_preds <- exists("p_apparent")
  if (!has_preds) skip("p_apparent not found")
  expect_true(is.numeric(p_apparent),
    info = "p_apparent should be a numeric vector of predicted probabilities"
  )
  expect_true(all(p_apparent >= 0 & p_apparent <= 1, na.rm = TRUE),
    info = "p_apparent values should be between 0 and 1 (use type = 'response')"
  )
})

test_that("Ex 1: yhat_apparent classified predictions exist (0/1 values)", {
  skip_if(!exists("p_apparent"), message = "p_apparent not found")
  has_yhat <- exists("yhat_apparent")
  if (!has_yhat) skip("yhat_apparent not found")
  vals <- unique(yhat_apparent[!is.na(yhat_apparent)])
  expect_true(all(vals %in% c(0, 1)),
    info = "yhat_apparent should contain only 0 and 1 (classify using a 0.5 cutoff)"
  )
})

test_that("Ex 1: acc_apparent exists and is a reasonable accuracy (> 70%, < 100%)", {
  skip_if(!exists("m_apparent"), message = "m_apparent not found")
  has_acc <- exists("acc_apparent")
  if (!has_acc) skip("acc_apparent not found")
  acc <- acc_apparent
  if (acc > 1) acc <- acc / 100
  expect_true(acc > 0.70,
    info = sprintf("acc_apparent should be above 70%%, got %.1f%%", acc * 100)
  )
  expect_true(acc < 1.0,
    info = "acc_apparent should not be perfect (< 100%%) — this is apparent accuracy, not truth"
  )
})
