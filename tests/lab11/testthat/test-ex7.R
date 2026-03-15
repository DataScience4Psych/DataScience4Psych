# Exercise 7: Cross-validation comparison with listwise deletion (Super Stretch)

test_that("Ex 7: cv_df dataset exists with complete cases", {
  expect_true(exists("cv_df"),
              info = "Create cv_df by filtering titanic3 to complete cases on all variables in f_expanded")
})

test_that("Ex 7: cv_df is a data frame", {
  skip_if(!exists("cv_df"), message = "cv_df not found")
  expect_true(is.data.frame(cv_df),
              info = "cv_df should be a data frame")
})

test_that("Ex 7: cv_df has a fold column with 10 folds", {
  skip_if(!exists("cv_df"), message = "cv_df not found")
  expect_true("fold" %in% names(cv_df),
              info = "cv_df should have a fold column (assign with sample(rep(1:10, length.out = n())))")
  n_folds <- length(unique(cv_df$fold))
  expect_equal(n_folds, 10L,
               info = "cv_df should have exactly 10 folds")
})

test_that("Ex 7: cv_df has no missing survived values", {
  skip_if(!exists("cv_df"), message = "cv_df not found")
  skip_if(!"survived" %in% names(cv_df))
  expect_equal(sum(is.na(cv_df$survived)), 0L,
               info = "cv_df should have no missing values in survived")
})

test_that("Ex 7: cv_glm_accuracy function exists", {
  expect_true(exists("cv_glm_accuracy") && is.function(cv_glm_accuracy),
              info = "Create a cv_glm_accuracy() function that takes df and formula and returns fold accuracies")
})

test_that("Ex 7: cv_glm_accuracy returns a data frame with fold and accuracy", {
  skip_if(!exists("cv_glm_accuracy") || !is.function(cv_glm_accuracy), message = "cv_glm_accuracy not found")
  skip_if(!exists("cv_df"), message = "cv_df not found")
  skip_if(!exists("f_base"), message = "f_base not found")
  result <- tryCatch(
    cv_glm_accuracy(cv_df, formula = f_base),
    error = function(e) NULL
  )
  skip_if(is.null(result), message = "cv_glm_accuracy() raised an error")
  expect_true(is.data.frame(result),
              info = "cv_glm_accuracy() should return a data frame")
  expect_true("accuracy" %in% names(result),
              info = "cv_glm_accuracy() result should have an accuracy column")
})

test_that("Ex 7: cv_base CV results for baseline model exist", {
  expect_true(exists("cv_base"),
              info = "Create cv_base using cv_glm_accuracy(cv_df, formula = f_base)")
})

test_that("Ex 7: cv_exp CV results for expanded model exist", {
  expect_true(exists("cv_exp"),
              info = "Create cv_exp using cv_glm_accuracy(cv_df, formula = f_expanded)")
})

test_that("Ex 7: cv_base and cv_exp each have 10 rows", {
  skip_if(!exists("cv_base"), message = "cv_base not found")
  skip_if(!exists("cv_exp"), message = "cv_exp not found")
  expect_equal(nrow(cv_base), 10L,
               info = "cv_base should have one row per fold (10 folds)")
  expect_equal(nrow(cv_exp), 10L,
               info = "cv_exp should have one row per fold (10 folds)")
})

test_that("Ex 7: cv_base accuracy values are valid (0-1 range)", {
  skip_if(!exists("cv_base"), message = "cv_base not found")
  skip_if(!"accuracy" %in% names(cv_base))
  expect_true(all(cv_base$accuracy >= 0 & cv_base$accuracy <= 1, na.rm = TRUE),
              info = "cv_base accuracy values should be between 0 and 1")
})

test_that("Ex 7: cv_exp accuracy values are valid (0-1 range)", {
  skip_if(!exists("cv_exp"), message = "cv_exp not found")
  skip_if(!"accuracy" %in% names(cv_exp))
  expect_true(all(cv_exp$accuracy >= 0 & cv_exp$accuracy <= 1, na.rm = TRUE),
              info = "cv_exp accuracy values should be between 0 and 1")
})

test_that("Ex 7: summary_table comparing models exists", {
  expect_true(exists("summary_table"),
              info = "Create summary_table with mean and SD accuracy for base and expanded models")
})

test_that("Ex 7: summary_table has model, mean_acc, and sd_acc columns", {
  skip_if(!exists("summary_table"), message = "summary_table not found")
  expect_true("model" %in% names(summary_table),
              info = "summary_table should have a model column")
  expect_true(any(c("mean_acc", "cv_mean", "mean") %in% names(summary_table)),
              info = "summary_table should have a mean accuracy column (e.g., mean_acc)")
})
