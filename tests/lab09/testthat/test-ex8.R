# Exercise 8-11: Racial disparities in COMPAS scores

test_that("Ex 8: Black defendants have higher average risk scores than white defendants", {
  skip_if(!exists("compas"))
  skip_if(!all(c("race", "decile_score") %in% names(compas)))
  means <- compas %>%
    dplyr::filter(race %in% c("African-American", "Caucasian")) %>%
    dplyr::group_by(race) %>%
    dplyr::summarize(mean_score = mean(decile_score, na.rm = TRUE), .groups = "drop")
  skip_if(nrow(means) < 2,
          message = "Could not find both African-American and Caucasian groups")
  black_mean <- means$mean_score[means$race == "African-American"]
  white_mean <- means$mean_score[means$race == "Caucasian"]
  expect_true(black_mean > white_mean,
              label = "Black defendants should have higher average COMPAS scores than white defendants")
})

test_that("Ex 9: higher proportion of Black defendants classified as high risk", {
  skip_if(!exists("compas"))
  skip_if(!all(c("race", "decile_score") %in% names(compas)))
  high_risk <- compas %>%
    dplyr::filter(race %in% c("African-American", "Caucasian")) %>%
    dplyr::group_by(race) %>%
    dplyr::summarize(pct_high = mean(decile_score >= 7, na.rm = TRUE), .groups = "drop")
  skip_if(nrow(high_risk) < 2,
          message = "Could not find both African-American and Caucasian groups")
  black_pct <- high_risk$pct_high[high_risk$race == "African-American"]
  white_pct <- high_risk$pct_high[high_risk$race == "Caucasian"]
  expect_true(black_pct > white_pct,
              label = "A higher proportion of Black defendants should be classified as high risk")
})

test_that("Ex 10: non_recidivists object exists", {
  expect_true(exists("non_recidivists"),
              label = "non_recidivists should be created by filtering compas where two_year_recid == 0"
  )
})

test_that("Ex 10: non_recidivists contains only defendants who did not recidivate", {
  skip_if(!exists("non_recidivists"))
  skip_if(!"two_year_recid" %in% names(non_recidivists))
  expect_true(all(non_recidivists$two_year_recid == 0),
              label = "non_recidivists should only contain rows where two_year_recid == 0")
})

test_that("Ex 10: non_recidivists has fewer rows than compas", {
  skip_if(!exists("non_recidivists") || !exists("compas"))
  expect_true(nrow(non_recidivists) < nrow(compas),
              label = "non_recidivists should be a subset of compas (fewer rows)")
  expect_true(nrow(non_recidivists) > 0,
              label = "non_recidivists should not be empty")
})

test_that("Ex 10: non_recidivists has race and decile_score for disparity analysis", {
  skip_if(!exists("non_recidivists"))
  expect_true(all(c("race", "decile_score") %in% names(non_recidivists)),
              label = "non_recidivists should have race and decile_score columns for false positive rate analysis")
})

test_that("Ex 10: false positive rate is higher for Black non-recidivists", {
  skip_if(!exists("non_recidivists"))
  skip_if(!all(c("race", "decile_score") %in% names(non_recidivists)))
  fp_rates <- non_recidivists %>%
    dplyr::filter(race %in% c("African-American", "Caucasian")) %>%
    dplyr::group_by(race) %>%
    dplyr::summarize(fp_rate = mean(decile_score >= 7, na.rm = TRUE), .groups = "drop")
  skip_if(nrow(fp_rates) < 2,
          message = "Could not find both racial groups in non_recidivists")
  black_fp <- fp_rates$fp_rate[fp_rates$race == "African-American"]
  white_fp <- fp_rates$fp_rate[fp_rates$race == "Caucasian"]
  expect_true(black_fp > white_fp,
              label = "Black non-recidivists should have a higher false positive rate (incorrectly labeled high risk)")
})
