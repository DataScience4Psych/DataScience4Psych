# Exercise 10: Beyond accuracy — confusion matrix (Super Stretch)

test_that("Ex 10: cv_confusion data frame exists", {
  expect_true(exists("cv_confusion"),
    info = "Create cv_confusion with per-fold accuracy, sensitivity, and specificity"
  )
})

test_that("Ex 10: cv_confusion has accuracy, sensitivity, and specificity columns", {
  skip_if(!exists("cv_confusion"), message = "cv_confusion not found")
  expect_true("accuracy" %in% names(cv_confusion),
    info = "cv_confusion should have an accuracy column"
  )
  expect_true("sensitivity" %in% names(cv_confusion),
    info = "cv_confusion should have a sensitivity column"
  )
  expect_true("specificity" %in% names(cv_confusion),
    info = "cv_confusion should have a specificity column"
  )
})

test_that("Ex 10: cv_confusion has 10 rows (one per fold)", {
  skip_if(!exists("cv_confusion"), message = "cv_confusion not found")
  expect_equal(nrow(cv_confusion), 10L,
    info = "cv_confusion should have one row per fold (10 folds)"
  )
})

test_that("Ex 10: cv_confusion sensitivity values are between 0 and 1", {
  skip_if(!exists("cv_confusion"), message = "cv_confusion not found")
  skip_if(!"sensitivity" %in% names(cv_confusion))
  expect_true(all(cv_confusion$sensitivity >= 0 & cv_confusion$sensitivity <= 1, na.rm = TRUE),
    info = "Sensitivity values should be between 0 and 1 (TP / (TP + FN))"
  )
})

test_that("Ex 10: cv_confusion specificity values are between 0 and 1", {
  skip_if(!exists("cv_confusion"), message = "cv_confusion not found")
  skip_if(!"specificity" %in% names(cv_confusion))
  expect_true(all(cv_confusion$specificity >= 0 & cv_confusion$specificity <= 1, na.rm = TRUE),
    info = "Specificity values should be between 0 and 1 (TN / (TN + FP))"
  )
})

test_that("Ex 10: mean sensitivity is reasonable (> 50%)", {
  skip_if(!exists("cv_confusion"), message = "cv_confusion not found")
  skip_if(!"sensitivity" %in% names(cv_confusion))
  val <- mean(cv_confusion$sensitivity, na.rm = TRUE)
  expect_true(val > 0.50,
    info = sprintf("Mean sensitivity should be > 50%%, got %.1f%%", val * 100)
  )
})

test_that("Ex 10: mean specificity is reasonable (> 50%)", {
  skip_if(!exists("cv_confusion"), message = "cv_confusion not found")
  skip_if(!"specificity" %in% names(cv_confusion))
  val <- mean(cv_confusion$specificity, na.rm = TRUE)
  expect_true(val > 0.50,
    info = sprintf("Mean specificity should be > 50%%, got %.1f%%", val * 100)
  )
})

test_that("Ex 10: Rmd contains confusion matrix code (TP, FP, TN, FN)", {
  skip_if(length(.rmd_content) == 0)
  potential_answers <- c(
    "TP\\s*<-", "FP\\s*<-", "TN\\s*<-", "FN\\s*<-",
    "sensitivity", "specificity",
    "confusion.*matrix|confusionMatrix"
  )
  pattern <- paste0("(", paste(potential_answers, collapse = "|"), ")")
  answer_in_rmd <- stringr::str_detect(.rmd_content, pattern) |> any()
  expect_equal(answer_in_rmd, TRUE,
    info = "Include confusion matrix code (TP, FP, TN, FN, sensitivity, specificity) in your Rmd (Exercise 10)"
  )
})

test_that("Ex 10: Rmd discusses sensitivity vs specificity trade-off", {
  skip_if(length(.rmd_content) == 0)
  potential_answers <- c(
    "sensitivity", "specificity",
    "false.*positive|false.*negative",
    "FP|FN",
    "cost.*asym|asym.*cost",
    "trade.*off|tradeoff"
  )
  pattern <- paste0("(", paste(potential_answers, collapse = "|"), ")")
  answer_in_rmd <- stringr::str_detect(.rmd_content, pattern) |> any()
  expect_equal(answer_in_rmd, TRUE,
    info = "Discuss the sensitivity/specificity trade-off in your Rmd (Exercise 10)"
  )
})
