# Exercise 3: Model accuracy and cross-validation

test_that("Ex 3: in-sample accuracy object exists", {
  has_accuracy <- exists("accuracy") || exists("in_sample_accuracy") ||
                  exists("train_accuracy") || exists("acc")
  # Also accept if we can derive from a model
  if (!has_accuracy) {
    for (nm in c("model", "logit_model", "titanic_model", "glm_model", "mod", "fit")) {
      if (exists(nm) && inherits(get(nm), "glm")) { has_accuracy <- TRUE; break }
    }
  }
  expect_true(has_accuracy,
              info = "Create an in-sample accuracy object (e.g., accuracy, in_sample_accuracy, train_accuracy)")
})

test_that("Ex 3: in-sample accuracy is reasonable (> 70% and < 100%)", {
  acc_val <- NULL
  for (nm in c("accuracy", "in_sample_accuracy", "train_accuracy", "acc")) {
    if (exists(nm)) { acc_val <- get(nm); break }
  }
  # If no explicit accuracy object, derive from model
  if (is.null(acc_val)) {
    m <- NULL
    for (nm in c("model", "logit_model", "titanic_model", "glm_model", "mod", "fit")) {
      if (exists(nm) && inherits(get(nm), "glm")) { m <- get(nm); break }
    }
    skip_if(is.null(m), message = "No accuracy object or glm model found")
    preds <- ifelse(predict(m, type = "response") >= 0.5, 1, 0)
    acc_val <- mean(preds == m$model[[1]])
  }
  # Handle both proportion (0-1) and percentage (0-100) forms
  if (acc_val > 1) acc_val <- acc_val / 100
  expect_true(acc_val > 0.7,
              info = sprintf("Ensure your in-sample accuracy is above 70%%, got %.1f%%", acc_val * 100))
  expect_true(acc_val < 1.0,
              info = "Ensure your in-sample accuracy is not perfect (should be < 100%%)")
})

test_that("Ex 3: cross-validation results object exists", {
  has_cv <- exists("cv_accuracy") || exists("cv_results") || exists("cv_acc") ||
            exists("out_of_sample_accuracy") || exists("test_accuracy")
  expect_true(has_cv,
              info = "Create a cross-validation accuracy object (e.g., cv_accuracy, cv_results)")
})

test_that("Ex 3: out-of-sample accuracy is lower than in-sample accuracy", {
  # Find in-sample accuracy
  in_acc <- NULL
  for (nm in c("accuracy", "in_sample_accuracy", "train_accuracy", "acc")) {
    if (exists(nm)) { in_acc <- get(nm); break }
  }
  # Find out-of-sample accuracy
  out_acc <- NULL
  for (nm in c("cv_accuracy", "cv_acc", "out_of_sample_accuracy", "test_accuracy")) {
    if (exists(nm)) { out_acc <- get(nm); break }
  }
  skip_if(is.null(in_acc) || is.null(out_acc),
          message = "Need both in-sample and out-of-sample accuracy to compare")
  # Normalize to proportion scale
  if (in_acc > 1) in_acc <- in_acc / 100
  if (out_acc > 1) out_acc <- out_acc / 100
  expect_true(out_acc <= in_acc,
              info = sprintf("Ensure your out-of-sample accuracy (%.1f%%) is <= in-sample accuracy (%.1f%%)",
                              out_acc * 100, in_acc * 100))
})

test_that("Ex 3: out-of-sample accuracy is still reasonable (> 60%)", {
  out_acc <- NULL
  for (nm in c("cv_accuracy", "cv_acc", "out_of_sample_accuracy", "test_accuracy")) {
    if (exists(nm)) { out_acc <- get(nm); break }
  }
  skip_if(is.null(out_acc), message = "No cross-validation accuracy object found")
  if (out_acc > 1) out_acc <- out_acc / 100
  expect_true(out_acc > 0.6,
              info = sprintf("Ensure your out-of-sample accuracy is above 60%%, got %.1f%%", out_acc * 100))
})
