# Exercise 2: Train/test split

test_that("Ex 2: titanic_train data object exists", {
  expect_true(exists("titanic_train"),
              info = "Load titanic_train (from the titanic package) for training the model")
})

test_that("Ex 2: titanic_test data object exists", {
  expect_true(exists("titanic_test"),
              info = "Load titanic_test (from the titanic package) for evaluating the model")
})

test_that("Ex 2: m_split model object exists", {
  expect_true(exists("m_split"),
              info = "Create m_split by fitting glm(survived ~ sex + pclass, data = titanic_train, family = binomial)")
})

test_that("Ex 2: m_split is a binomial glm trained on titanic_train", {
  skip_if(!exists("m_split"), message = "m_split not found")
  expect_s3_class(m_split, "glm")
  expect_equal(m_split$family$family, "binomial",
               info = "Use family = binomial in your glm() call for m_split")
})

test_that("Ex 2: m_split uses sex and pclass as predictors", {
  skip_if(!exists("m_split"), message = "m_split not found")
  model_terms <- attr(terms(m_split), "term.labels")
  expect_true("sex" %in% model_terms,
              info = "Include sex as a predictor in m_split")
  expect_true("pclass" %in% model_terms,
              info = "Include pclass as a predictor in m_split")
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

test_that("Ex 2: females have higher predicted survival probability than males on test set", {
  skip_if(!exists("m_split"), message = "m_split not found")
  skip_if(!exists("titanic_test"), message = "titanic_test not found")
  skip_if(!"sex" %in% names(titanic_test), message = "sex column not found in titanic_test")
  preds <- predict(m_split, newdata = titanic_test, type = "response")
  avg_female <- mean(preds[titanic_test$sex == "female"], na.rm = TRUE)
  avg_male <- mean(preds[titanic_test$sex == "male"], na.rm = TRUE)
  expect_true(avg_female > avg_male,
              info = "Your model should predict higher survival probability for females than males")
})
