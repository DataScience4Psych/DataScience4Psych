# Exercise 3: Cross-validation across timelines

test_that("Ex 3: titanic_cv dataset with fold variable exists", {
  expect_true(exists("titanic_cv"),
              info = "Create titanic_cv by filtering titanic3 to complete cases and assigning fold numbers (1–10)")
})

test_that("Ex 3: titanic_cv has a fold column with 10 folds", {
  skip_if(!exists("titanic_cv"), message = "titanic_cv not found")
  expect_true("fold" %in% names(titanic_cv),
              info = "titanic_cv should have a fold column")
  n_folds <- length(unique(titanic_cv$fold))
  expect_equal(n_folds, 10L,
               info = "titanic_cv should have exactly 10 folds")
})

test_that("Ex 3: titanic_cv folds are roughly balanced", {
  skip_if(!exists("titanic_cv"), message = "titanic_cv not found")
  skip_if(!"fold" %in% names(titanic_cv))
  fold_sizes <- table(titanic_cv$fold)
  max_size <- max(fold_sizes)
  min_size <- min(fold_sizes)
  expect_true(max_size - min_size <= 10,
              info = "Folds should be roughly equal-sized (use rep(1:10, length.out = n()))")
})

test_that("Ex 3: cv_results data frame exists with fold and accuracy columns", {
  expect_true(exists("cv_results"),
              info = "Create cv_results data frame with at least fold and accuracy columns from the CV loop")
})

test_that("Ex 3: cv_results has 10 rows (one per fold)", {
  skip_if(!exists("cv_results"), message = "cv_results not found")
  expect_equal(nrow(cv_results), 10L,
               info = "cv_results should have one row per fold (10 folds)")
})

test_that("Ex 3: cv_results accuracy values are all between 0 and 1", {
  skip_if(!exists("cv_results"), message = "cv_results not found")
  skip_if(!"accuracy" %in% names(cv_results))
  expect_true(all(cv_results$accuracy >= 0 & cv_results$accuracy <= 1, na.rm = TRUE),
              info = "All fold accuracies in cv_results should be between 0 and 1")
})

test_that("Ex 3: cv_mean (mean CV accuracy) exists and is reasonable", {
  skip_if(!exists("cv_results"), message = "cv_results not found")
  has_cv_mean <- exists("cv_mean")
  if (!has_cv_mean) skip("cv_mean not found")
  val <- cv_mean
  if (val > 1) val <- val / 100
  expect_true(val > 0.65,
              info = sprintf("cv_mean should be above 65%%, got %.1f%%", val * 100))
  expect_true(val < 1.0,
              info = "cv_mean should not be perfect (< 100%%)")
})

test_that("Ex 3: cv_sd (SD of CV accuracy) exists and is positive", {
  skip_if(!exists("cv_results"), message = "cv_results not found")
  has_cv_sd <- exists("cv_sd")
  if (!has_cv_sd) skip("cv_sd not found")
  expect_true(is.numeric(cv_sd),
              info = "cv_sd should be a numeric value")
  expect_true(cv_sd > 0,
              info = "cv_sd should be positive — some fold-to-fold variability is expected")
})


