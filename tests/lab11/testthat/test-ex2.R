# Exercise 2: Logistic regression model and predictions

test_that("Ex 2: logistic regression model object exists", {
  has_model <- exists("model") || exists("logit_model") || exists("titanic_model") ||
               exists("glm_model") || exists("mod") || exists("fit") ||
               exists("m_apparent") || exists("m_split")
  expect_true(has_model,
              info = "Create a logistic regression model object (e.g., m_apparent, m_split, model, or logit_model)")
})

test_that("Ex 2: logistic model is a glm object with binomial family", {
  m <- NULL
  for (nm in c("m_apparent", "m_split", "model", "logit_model", "titanic_model", "glm_model", "mod", "fit")) {
    if (exists(nm) && inherits(get(nm), "glm")) { m <- get(nm); break }
  }
  skip_if(is.null(m), message = "No glm model object found")
  expect_s3_class(m, "glm")
  expect_equal(m$family$family, "binomial",
               info = "Use family = binomial for logistic regression in your glm() call")
})

test_that("Ex 2: logistic model includes sex and pclass as predictors", {
  m <- NULL
  for (nm in c("m_apparent", "m_split", "model", "logit_model", "titanic_model", "glm_model", "mod", "fit")) {
    if (exists(nm) && inherits(get(nm), "glm")) { m <- get(nm); break }
  }
  skip_if(is.null(m), message = "No glm model object found")
  model_terms <- tolower(attr(terms(m), "term.labels"))
  expect_true("sex" %in% model_terms,
              info = "Include sex as a predictor in your logistic regression model")
  expect_true("pclass" %in% model_terms,
              info = "Include pclass as a predictor in your logistic regression model")
})

test_that("Ex 2: predicted probabilities are between 0 and 1", {
  m <- NULL
  for (nm in c("m_apparent", "m_split", "model", "logit_model", "titanic_model", "glm_model", "mod", "fit")) {
    if (exists(nm) && inherits(get(nm), "glm")) { m <- get(nm); break }
  }
  skip_if(is.null(m), message = "No glm model object found")
  preds <- predict(m, type = "response")
  expect_true(all(preds >= 0 & preds <= 1),
              info = "Use predict(model, type = 'response') to get probabilities between 0 and 1")
})

test_that("Ex 2: females have higher predicted survival probability than males", {
  m <- NULL
  for (nm in c("m_apparent", "m_split", "model", "logit_model", "titanic_model", "glm_model", "mod", "fit")) {
    if (exists(nm) && inherits(get(nm), "glm")) { m <- get(nm); break }
  }
  skip_if(is.null(m), message = "No glm model object found")
  d <- m$model
  sex_col <- names(d)[tolower(names(d)) == "sex"][1]
  skip_if(is.na(sex_col), message = "sex not found in model data")
  d$pred <- predict(m, type = "response")
  avg_female <- mean(d$pred[tolower(d[[sex_col]]) == "female"], na.rm = TRUE)
  avg_male <- mean(d$pred[tolower(d[[sex_col]]) == "male"], na.rm = TRUE)
  expect_true(avg_female > avg_male,
              info = "Check that your model shows females have higher predicted survival probability than males")
})

# Lab-specific checks: train/test split objects expected by the lab instructions

test_that("Ex 2: titanic_train data object exists", {
  expect_true(exists("titanic_train"),
              info = "Load titanic_train (from the titanic package) for training the split model")
})

test_that("Ex 2: titanic_test data object exists", {
  expect_true(exists("titanic_test"),
              info = "Load titanic_test (from the titanic package) for evaluating the split model")
})

test_that("Ex 2: m_split model object exists", {
  expect_true(exists("m_split"),
              info = "Create m_split by fitting glm(survived ~ sex + pclass, data = titanic_train, family = binomial)")
})

test_that("Ex 2: m_split is a binomial glm", {
  skip_if(!exists("m_split"), message = "m_split not found")
  expect_s3_class(m_split, "glm")
  expect_equal(m_split$family$family, "binomial",
               info = "Use family = binomial in your glm() call for m_split")
})

test_that("Ex 2: acc_train (training accuracy) exists and is reasonable", {
  skip_if(!exists("m_split"), message = "m_split not found")
  has_acc <- exists("acc_train")
  if (!has_acc) skip("acc_train not found")
  acc <- acc_train
  if (acc > 1) acc <- acc / 100
  expect_true(acc > 0.70,
              info = sprintf("acc_train should be above 70%%, got %.1f%%", acc * 100))
  expect_true(acc < 1.0,
              info = "acc_train should not be perfect (< 100%%)")
})

test_that("Ex 2: p_test predicted probabilities on test set exist and are valid", {
  skip_if(!exists("m_split"), message = "m_split not found")
  has_ptest <- exists("p_test")
  if (!has_ptest) skip("p_test not found")
  expect_true(is.numeric(p_test),
              info = "p_test should be a numeric vector")
  expect_true(all(p_test >= 0 & p_test <= 1, na.rm = TRUE),
              info = "p_test values should be between 0 and 1 (use predict with type = 'response')")
})

test_that("Ex 2: acc_test (test accuracy) exists and is reasonable", {
  has_acc <- exists("acc_test")
  if (!has_acc) skip("acc_test not found")
  acc <- acc_test
  skip_if(is.nan(acc) || is.na(acc), message = "acc_test is NaN/NA — check that titanic_test has a survived column")
  if (acc > 1) acc <- acc / 100
  expect_true(acc > 0.60,
              info = sprintf("acc_test should be above 60%%, got %.1f%%", acc * 100))
  expect_true(acc < 1.0,
              info = "acc_test should not be perfect (< 100%%)")
})

test_that("Ex 2: training accuracy is not lower than test accuracy by more than 5%", {
  skip_if(!exists("acc_train"), message = "acc_train not found")
  skip_if(!exists("acc_test"), message = "acc_test not found")
  tr <- acc_train
  te <- acc_test
  if (is.nan(tr) || is.na(tr) || is.nan(te) || is.na(te)) skip("acc_train or acc_test is NA/NaN")
  if (tr > 1) tr <- tr / 100
  if (te > 1) te <- te / 100
  expect_true(tr >= te - 0.05,
              info = sprintf(
                "acc_train (%.1f%%) should not be more than 5%% below acc_test (%.1f%%) — training accuracy is usually at least as high",
                tr * 100, te * 100
              ))
})

