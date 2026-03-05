# Exercises on cross-validation

test_that("Ex: in-sample accuracy can be calculated", {
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
  preds <- ifelse(predict(model, type = "response") >= 0.5, 1, 0)
  accuracy <- mean(preds == d_clean$Survived)
  expect_true(accuracy > 0.7,
              label = "In-sample accuracy should be reasonable (> 70%)")
  expect_true(accuracy < 1.0,
              label = "In-sample accuracy should not be perfect (< 100%)")
})
