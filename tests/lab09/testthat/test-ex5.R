# Exercise 5-7: Risk scores, recidivism, and classification

test_that("Ex 5: two_year_recid column exists and is binary (0 or 1)", {
  skip_if(!exists("compas") || !"two_year_recid" %in% names(compas))
  vals <- unique(compas$two_year_recid[!is.na(compas$two_year_recid)])
  expect_true(all(vals %in% c(0, 1)),
              info ="two_year_recid should be binary (0 or 1)")
})

test_that("Ex 5: both recidivism outcomes are present", {
  skip_if(!exists("compas") || !"two_year_recid" %in% names(compas))
  expect_true(0 %in% compas$two_year_recid && 1 %in% compas$two_year_recid,
              info ="two_year_recid should contain both 0 (no) and 1 (yes) values")
})

test_that("Ex 6: compas has a classification column (TP, TN, FP, FN)", {
  skip_if(!exists("compas"))
  has_classification <- "classification" %in% names(compas)
  expect_true(has_classification,
              info ="compas should have a classification column created using decile_score >= 7 (high risk) and <= 4 (low risk)"
  )
})

test_that("Ex 6: classification column contains all four categories", {
  skip_if(!exists("compas") || !"classification" %in% names(compas))
  class_vals <- unique(compas$classification)
  expect_true("TP" %in% class_vals,
              info ="classification should include TP (True Positive: high risk & recidivated)")
  expect_true("TN" %in% class_vals,
              info ="classification should include TN (True Negative: low risk & did not recidivate)")
  expect_true("FP" %in% class_vals,
              info ="classification should include FP (False Positive: high risk & did not recidivate)")
  expect_true("FN" %in% class_vals,
              info ="classification should include FN (False Negative: low risk & recidivated)")
})

test_that("Ex 6: classification is consistent with decile_score and two_year_recid", {
  skip_if(!exists("compas"))
  skip_if(!all(c("classification", "decile_score", "two_year_recid") %in% names(compas)))
  # Check a sample of TP cases: should have high score and recidivated
  tp_rows <- compas %>% dplyr::filter(classification == "TP")
  if (nrow(tp_rows) > 0) {
    expect_true(all(tp_rows$decile_score >= 7),
                info ="TP cases should have decile_score >= 7")
    expect_true(all(tp_rows$two_year_recid == 1),
                info ="TP cases should have two_year_recid == 1")
  }
  # Check TN cases: should have low score and did not recidivate
  tn_rows <- compas %>% dplyr::filter(classification == "TN")
  if (nrow(tn_rows) > 0) {
    expect_true(all(tn_rows$decile_score <= 4),
                info ="TN cases should have decile_score <= 4")
    expect_true(all(tn_rows$two_year_recid == 0),
                info ="TN cases should have two_year_recid == 0")
  }
})
