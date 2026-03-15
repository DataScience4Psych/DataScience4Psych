# Exercise 9: Simple imputation without leakage (Super Stretch)

test_that("Ex 9: cv_imp CV results with imputation exist", {
  expect_true(exists("cv_imp"),
              info = "Create cv_imp by running CV with within-fold mean imputation for missing predictors")
})

test_that("Ex 9: cv_imp is a data frame with fold and accuracy columns", {
  skip_if(!exists("cv_imp"), message = "cv_imp not found")
  expect_true(is.data.frame(cv_imp),
              info = "cv_imp should be a data frame")
  expect_true("accuracy" %in% names(cv_imp),
              info = "cv_imp should have an accuracy column")
})

test_that("Ex 9: cv_imp has 10 rows (one per fold)", {
  skip_if(!exists("cv_imp"), message = "cv_imp not found")
  expect_equal(nrow(cv_imp), 10L,
               info = "cv_imp should have one row per fold (10 folds)")
})

test_that("Ex 9: cv_imp accuracy values are valid (0-1 range)", {
  skip_if(!exists("cv_imp"), message = "cv_imp not found")
  skip_if(!"accuracy" %in% names(cv_imp))
  expect_true(all(cv_imp$accuracy >= 0 & cv_imp$accuracy <= 1, na.rm = TRUE),
              info = "cv_imp accuracy values should be between 0 and 1")
})

test_that("Ex 9: cv_imp mean accuracy is reasonable (> 65%)", {
  skip_if(!exists("cv_imp"), message = "cv_imp not found")
  skip_if(!"accuracy" %in% names(cv_imp))
  val <- mean(cv_imp$accuracy, na.rm = TRUE)
  expect_true(val > 0.65,
              info = sprintf("Mean accuracy in cv_imp should be > 65%%, got %.1f%%", val * 100))
})

test_that("Ex 9: Rmd contains within-fold imputation code (no leakage)", {
  skip_if(length(.rmd_content) == 0)
  potential_answers <- c("mu\\s*<-\\s*mean.*train", "train_j.*age.*na",
                         "is\\.na.*train_j|train_j.*is\\.na",
                         "impute|imputation|leakage",
                         "mean.*na\\.rm.*TRUE.*train|train.*mean.*na\\.rm")
  pattern <- paste0("(", paste(potential_answers, collapse = "|"), ")")
  answer_in_rmd <- stringr::str_detect(.rmd_content, pattern) |> any()
  expect_equal(answer_in_rmd, TRUE,
               info = "Include within-fold mean imputation code in your Rmd (Exercise 9) — impute using the training fold mean only")
})
