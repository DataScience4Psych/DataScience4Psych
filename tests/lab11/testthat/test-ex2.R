# Exercise 2: Logistic regression model and predictions

test_that("Ex 2: logistic regression model object exists", {
  has_model <- exists("model") || exists("logit_model") || exists("titanic_model") ||
               exists("glm_model") || exists("mod") || exists("fit")
  expect_true(has_model,
              info = "Create a logistic regression model object (e.g., model, logit_model, titanic_model)")
})

test_that("Ex 2: logistic model is a glm object with binomial family", {
  m <- NULL
  for (nm in c("model", "logit_model", "titanic_model", "glm_model", "mod", "fit")) {
    if (exists(nm) && inherits(get(nm), "glm")) { m <- get(nm); break }
  }
  skip_if(is.null(m), message = "No glm model object found")
  expect_s3_class(m, "glm")
  expect_equal(m$family$family, "binomial",
               info = "Use family = binomial for logistic regression in your glm() call")
})

test_that("Ex 2: logistic model includes Pclass, Sex, and Age as predictors", {
  m <- NULL
  for (nm in c("model", "logit_model", "titanic_model", "glm_model", "mod", "fit")) {
    if (exists(nm) && inherits(get(nm), "glm")) { m <- get(nm); break }
  }
  skip_if(is.null(m), message = "No glm model object found")
  model_terms <- attr(terms(m), "term.labels")
  expect_true("Pclass" %in% model_terms,
              info = "Include Pclass as a predictor in your logistic regression model")
  expect_true("Sex" %in% model_terms,
              info = "Include Sex as a predictor in your logistic regression model")
  expect_true("Age" %in% model_terms,
              info = "Include Age as a predictor in your logistic regression model")
})

test_that("Ex 2: predicted probabilities are between 0 and 1", {
  m <- NULL
  for (nm in c("model", "logit_model", "titanic_model", "glm_model", "mod", "fit")) {
    if (exists(nm) && inherits(get(nm), "glm")) { m <- get(nm); break }
  }
  skip_if(is.null(m), message = "No glm model object found")
  preds <- predict(m, type = "response")
  expect_true(all(preds >= 0 & preds <= 1),
              info = "Use predict(model, type = 'response') to get probabilities between 0 and 1")
})

test_that("Ex 2: females have higher predicted survival probability than males", {
  m <- NULL
  for (nm in c("model", "logit_model", "titanic_model", "glm_model", "mod", "fit")) {
    if (exists(nm) && inherits(get(nm), "glm")) { m <- get(nm); break }
  }
  skip_if(is.null(m), message = "No glm model object found")
  d <- m$model
  skip_if(!"Sex" %in% names(d), message = "Sex not found in model data")
  d$pred <- predict(m, type = "response")
  avg_female <- mean(d$pred[d$Sex == "female"], na.rm = TRUE)
  avg_male <- mean(d$pred[d$Sex == "male"], na.rm = TRUE)
  expect_true(avg_female > avg_male,
              info = "Check that your model shows females have higher predicted survival probability than males")
})
