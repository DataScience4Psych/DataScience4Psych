# Exercise 8-11: Racial disparities in COMPAS scores

test_that("Ex 8: Black defendants have higher average risk scores than white", {
  skip_if(!exists("compas"))
  skip_if(!all(c("race", "decile_score") %in% names(compas)))
  means <- compas %>%
    dplyr::filter(race %in% c("African-American", "Caucasian")) %>%
    dplyr::group_by(race) %>%
    dplyr::summarize(mean_score = mean(decile_score, na.rm = TRUE), .groups = "drop")
  skip_if(nrow(means) < 2)
  black_mean <- means$mean_score[means$race == "African-American"]
  white_mean <- means$mean_score[means$race == "Caucasian"]
  expect_true(black_mean > white_mean,
              label = "Black defendants should have higher average COMPAS scores")
})

test_that("Ex 9: higher proportion of Black defendants classified as high risk", {
  skip_if(!exists("compas"))
  skip_if(!all(c("race", "decile_score") %in% names(compas)))
  high_risk <- compas %>%
    dplyr::filter(race %in% c("African-American", "Caucasian")) %>%
    dplyr::group_by(race) %>%
    dplyr::summarize(pct_high = mean(decile_score >= 7, na.rm = TRUE), .groups = "drop")
  skip_if(nrow(high_risk) < 2)
  black_pct <- high_risk$pct_high[high_risk$race == "African-American"]
  white_pct <- high_risk$pct_high[high_risk$race == "Caucasian"]
  expect_true(black_pct > white_pct,
              label = "A higher proportion of Black defendants should be classified as high risk")
})
