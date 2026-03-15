# Exercise 6: Overall accuracy of the COMPAS algorithm

test_that("Ex 6: classification column exists for accuracy calculation", {
  skip_if(!exists("compas"))
  expect_true("classification" %in% names(compas),
              info = "compas should have a classification column (TP/TN/FP/FN) before computing accuracy")
})

test_that("Ex 6: overall accuracy can be computed from classification column", {
  skip_if(!exists("compas"))
  skip_if(!"classification" %in% names(compas))
  correct <- sum(compas$classification %in% c("TP", "TN"), na.rm = TRUE)
  total <- sum(!is.na(compas$classification))
  skip_if(total == 0, message = "No non-NA classification values found")
  accuracy <- correct / total
  expect_true(accuracy > 0.5,
              info = "Overall COMPAS accuracy should be above 50% — check your classification column")
  expect_true(accuracy < 1.0,
              info = "Overall COMPAS accuracy should be below 100% — the algorithm makes errors")
})

test_that("Ex 6: Rmd Exercise 6 contains accuracy calculation code", {
  skip_if(length(.rmd_content) == 0)
  potential_answers <- c("accuracy", "TP|TN|FP|FN", "classification", "correct\\b", "mean\\(.*classif")
  pattern <- paste0("(", paste(potential_answers, collapse = "|"), ")")
  answer_in_rmd <- stringr::str_detect(.rmd_content, pattern) |> any()
  expect_equal(answer_in_rmd, TRUE,
               info = "Include code calculating the overall accuracy of COMPAS (e.g., proportion of TP and TN) in your Rmd")
})

test_that("Ex 6: Rmd Exercise 6 reports a numeric accuracy value or summary", {
  skip_if(length(.rmd_content) == 0)
  skip_if(!exists("compas"))
  skip_if(!"classification" %in% names(compas))
  correct <- sum(compas$classification %in% c("TP", "TN"), na.rm = TRUE)
  total <- sum(!is.na(compas$classification))
  skip_if(total == 0, message = "No non-NA classification values found")
  solution_acc <- correct / total
  acc_pct <- round(solution_acc * 100, 1)
  acc_patterns <- c(
    sprintf("%.4f", solution_acc),
    sprintf("%.3f", solution_acc),
    sprintf("%.2f", solution_acc),
    sprintf("%.1f", acc_pct)
  )
  potential_answers <- c(acc_patterns, "accuracy", "sum\\(.*TP|TN", "mean\\(")
  pattern <- paste0("(", paste(potential_answers, collapse = "|"), ")")
  answer_in_rmd <- stringr::str_detect(.rmd_content, pattern) |> any()
  expect_equal(answer_in_rmd, TRUE,
               info = sprintf("Report the accuracy value (~%.1f%%) or use summary code in your Rmd", acc_pct))
})
