# Exercise 9: Accuracy metrics by racial group

test_that("Ex 9: compas has required columns for group-level accuracy analysis", {
  skip_if(!exists("compas"))
  expected_cols <- c("race", "decile_score", "two_year_recid")
  present <- expected_cols %in% names(compas)
  expect_true(all(present),
              info = paste("compas should have columns:",
                           paste(expected_cols[!present], collapse = ", ")))
})

test_that("Ex 9: classification column exists before computing group metrics", {
  skip_if(!exists("compas"))
  expect_true("classification" %in% names(compas),
              info = "compas should have a classification column (TP/TN/FP/FN) for group-level accuracy analysis")
})

test_that("Ex 9: TP rate is computable for African-American and Caucasian subgroups", {
  skip_if(!exists("compas"))
  skip_if(!all(c("race", "classification") %in% names(compas)))
  for (grp in c("African-American", "Caucasian")) {
    sub <- compas[compas$race == grp & !is.na(compas$classification), ]
    skip_if(nrow(sub) == 0,
            message = sprintf("No rows for race group '%s'", grp))
    tp <- sum(sub$classification == "TP")
    fn <- sum(sub$classification == "FN")
    skip_if(tp + fn == 0,
            message = sprintf("No positive cases in '%s' group", grp))
    tpr <- tp / (tp + fn)
    expect_true(tpr >= 0 && tpr <= 1,
                info = sprintf("TPR for %s should be between 0 and 1 (got %.2f)", grp, tpr))
  }
})

test_that("Ex 9: False positive rate is higher for African-American non-recidivists", {
  skip_if(!exists("compas"))
  skip_if(!all(c("race", "classification") %in% names(compas)))
  aa_sub <- compas[compas$race == "African-American" & !is.na(compas$classification), ]
  cau_sub <- compas[compas$race == "Caucasian" & !is.na(compas$classification), ]
  aa_fp <- sum(aa_sub$classification == "FP")
  aa_tn <- sum(aa_sub$classification == "TN")
  cau_fp <- sum(cau_sub$classification == "FP")
  cau_tn <- sum(cau_sub$classification == "TN")
  skip_if(aa_fp + aa_tn == 0 || cau_fp + cau_tn == 0,
          message = "Cannot compute FPR for one or both racial groups")
  aa_fpr <- aa_fp / (aa_fp + aa_tn)
  cau_fpr <- cau_fp / (cau_fp + cau_tn)
  expect_true(aa_fpr > cau_fpr,
              info = sprintf(
                "African-American defendants should have a higher false positive rate than Caucasian defendants (AA: %.2f, Caucasian: %.2f)",
                aa_fpr, cau_fpr
              ))
})

test_that("Ex 9: Rmd Exercise 9 contains group-level accuracy metrics code", {
  skip_if(length(.rmd_content) == 0)
  potential_answers <- c("group_by.*race", "race.*group_by", "filter.*race", "African|Caucasian",
                         "accuracy|TP|FP|TN|FN", "classification")
  pattern <- paste0("(", paste(potential_answers, collapse = "|"), ")")
  answer_in_rmd <- stringr::str_detect(.rmd_content, pattern) |> any()
  expect_equal(answer_in_rmd, TRUE,
               info = "Include code calculating accuracy metrics (TP, TN, FP, FN) separately by race in your Rmd")
})
