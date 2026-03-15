# Per-exercise Rmd content checks

test_that("Exercise 1 section contains R code (apparent accuracy)", {
  skip_if(length(.rmd_content) == 0)
  potential_answers <- c("^```\\{r", "`r\\s+[^`]+`", "titanic3", "m_apparent", "glm\\(")
  pattern <- paste0("(", paste(potential_answers, collapse = "|"), ")")
  answer_in_rmd <- stringr::str_detect(.rmd_content, pattern) |> any()
  expect_equal(answer_in_rmd, TRUE,
    info = "Include R code for Exercise 1 in your Rmd (e.g., loading titanic3 and fitting m_apparent)"
  )
})

test_that("Exercise 2 section contains train/test split code", {
  skip_if(length(.rmd_content) == 0)
  potential_answers <- c("m_split", "titanic_train", "titanic_test",
                         "acc_train", "acc_test", "newdata\\s*=")
  pattern <- paste0("(", paste(potential_answers, collapse = "|"), ")")
  answer_in_rmd <- stringr::str_detect(.rmd_content, pattern) |> any()
  expect_equal(answer_in_rmd, TRUE,
    info = "Include train/test split code in your Rmd for Exercise 2 (e.g., m_split, acc_train, acc_test)"
  )
})

test_that("Exercise 3 section contains cross-validation code", {
  skip_if(length(.rmd_content) == 0)
  potential_answers <- c("titanic_cv", "cv_results", "cv_mean", "cv_sd",
                         "for.*fold|fold.*for", "filter\\(fold")
  pattern <- paste0("(", paste(potential_answers, collapse = "|"), ")")
  answer_in_rmd <- stringr::str_detect(.rmd_content, pattern) |> any()
  expect_equal(answer_in_rmd, TRUE,
    info = "Include cross-validation code in your Rmd for Exercise 3 (e.g., cv_results, cv_mean)"
  )
})

test_that("Exercise 4 section contains cutoff analysis code", {
  skip_if(length(.rmd_content) == 0)
  potential_answers <- c("cutoff", "cutoffs", "0\\.3", "0\\.5", "0\\.7",
                         "cutoff_results")
  pattern <- paste0("(", paste(potential_answers, collapse = "|"), ")")
  answer_in_rmd <- stringr::str_detect(.rmd_content, pattern) |> any()
  expect_equal(answer_in_rmd, TRUE,
    info = "Include cutoff analysis code in your Rmd for Exercise 4 (evaluating multiple probability cutoffs)"
  )
})

test_that("Exercise 6 section defines candidate model formulas", {
  skip_if(length(.rmd_content) == 0)
  potential_answers <- c("f_base", "f_expanded", "survived\\s*~\\s*sex.*pclass",
                         "candidate.*model|model.*candidate")
  pattern <- paste0("(", paste(potential_answers, collapse = "|"), ")")
  answer_in_rmd <- stringr::str_detect(.rmd_content, pattern) |> any()
  expect_equal(answer_in_rmd, TRUE,
    info = "Define f_base and f_expanded formula objects in your Rmd for Exercise 6"
  )
})

test_that("Exercise 7 section contains CV comparison code", {
  skip_if(length(.rmd_content) == 0)
  potential_answers <- c("cv_df", "cv_glm_accuracy", "cv_base", "cv_exp",
                         "summary_table", "listwise")
  pattern <- paste0("(", paste(potential_answers, collapse = "|"), ")")
  answer_in_rmd <- stringr::str_detect(.rmd_content, pattern) |> any()
  expect_equal(answer_in_rmd, TRUE,
    info = "Include CV comparison code in your Rmd for Exercise 7 (cv_df, cv_glm_accuracy, cv_base, cv_exp)"
  )
})

test_that("Exercise 8 section discusses missingness impact", {
  skip_if(length(.rmd_content) == 0)
  potential_answers <- c("missingness|missing", "listwise.*deletion|deletion.*listwise",
                         "n_all", "n_kept", "prop_kept", "is\\.na")
  pattern <- paste0("(", paste(potential_answers, collapse = "|"), ")")
  answer_in_rmd <- stringr::str_detect(.rmd_content, pattern) |> any()
  expect_equal(answer_in_rmd, TRUE,
    info = "Include missingness analysis in your Rmd for Exercise 8"
  )
})

test_that("Exercise 9 section contains within-fold imputation code", {
  skip_if(length(.rmd_content) == 0)
  potential_answers <- c("cv_imp", "impute|imputation", "mu\\s*<-\\s*mean",
                         "leakage", "within.*fold|fold.*mean")
  pattern <- paste0("(", paste(potential_answers, collapse = "|"), ")")
  answer_in_rmd <- stringr::str_detect(.rmd_content, pattern) |> any()
  expect_equal(answer_in_rmd, TRUE,
    info = "Include within-fold imputation code in your Rmd for Exercise 9 (cv_imp)"
  )
})

test_that("Exercise 10 section contains confusion matrix code", {
  skip_if(length(.rmd_content) == 0)
  potential_answers <- c("cv_confusion", "TP\\s*<-", "FP\\s*<-",
                         "sensitivity", "specificity",
                         "confusion.*matrix|confusionMatrix")
  pattern <- paste0("(", paste(potential_answers, collapse = "|"), ")")
  answer_in_rmd <- stringr::str_detect(.rmd_content, pattern) |> any()
  expect_equal(answer_in_rmd, TRUE,
    info = "Include confusion matrix code in your Rmd for Exercise 10 (cv_confusion, TP, FP, sensitivity, specificity)"
  )
})
