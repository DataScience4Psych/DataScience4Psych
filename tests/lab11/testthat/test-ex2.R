# Exercises on logistic regression and prediction

test_that("Ex: logistic regression model can be fit", {
  skip_if(!requireNamespace("titanic", quietly = TRUE) &&
          !exists("titanic_train"))
  if (exists("titanic_train")) {
    d <- titanic_train
  } else {
    data("titanic_train", package = "titanic")
    d <- titanic_train
  }
  d_clean <- d %>%
    dplyr::filter(!is.na(Age), !is.na(Pclass), !is.na(Sex))
  model <- glm(Survived ~ Pclass + Sex + Age,
               data = d_clean, family = binomial())
  expect_s3_class(model, "glm")
})

test_that("Ex: predicted probabilities are between 0 and 1", {
  skip_if(!requireNamespace("titanic", quietly = TRUE) &&
          !exists("titanic_train"))
  if (exists("titanic_train")) {
    d <- titanic_train
  } else {
    data("titanic_train", package = "titanic")
    d <- titanic_train
  }
  d_clean <- d %>%
    dplyr::filter(!is.na(Age), !is.na(Pclass), !is.na(Sex))
  model <- glm(Survived ~ Pclass + Sex + Age,
               data = d_clean, family = binomial())
  preds <- predict(model, type = "response")
  expect_true(all(preds >= 0 & preds <= 1),
              label = "Predicted probabilities should be between 0 and 1")
})

test_that("Ex: females have higher predicted survival probability", {
  skip_if(!requireNamespace("titanic", quietly = TRUE) &&
          !exists("titanic_train"))
  if (exists("titanic_train")) {
    d <- titanic_train
  } else {
    data("titanic_train", package = "titanic")
    d <- titanic_train
  }
  d_clean <- d %>%
    dplyr::filter(!is.na(Age), !is.na(Pclass), !is.na(Sex))
  model <- glm(Survived ~ Pclass + Sex + Age,
               data = d_clean, family = binomial())
  d_clean$pred <- predict(model, type = "response")
  avg_female <- mean(d_clean$pred[d_clean$Sex == "female"])
  avg_male <- mean(d_clean$pred[d_clean$Sex == "male"])
  expect_true(avg_female > avg_male,
              label = "Females should have higher average predicted survival probability")
})
