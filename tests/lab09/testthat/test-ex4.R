# Exercises 8-11: Racial disparities in COMPAS scores

test_that("Ex 8: Rmd compares decile_score distribution between Black and white defendants", {
  skip_if(length(.rmd_content) == 0)
  has_race <- stringr::str_detect(.rmd_content, "race") |> any()
  has_score <- stringr::str_detect(.rmd_content, "decile_score") |> any()
  expect_true(has_race && has_score,
    label = "Ex 8: Compare decile_score distributions by race"
  )
})

test_that("Ex 9: Rmd calculates high-risk percentage by race", {
  skip_if(length(.rmd_content) == 0)
  potential_answers <- c(
    "decile_score\\s*>=\\s*7",
    "high.risk",
    "group_by.*race"
  )
  pattern <- paste0("(", paste(potential_answers, collapse = "|"), ")")
  answer_in_rmd <- stringr::str_detect(.rmd_content, pattern) |> any()
  expect_equal(answer_in_rmd, TRUE,
    info = "Ex 9: Calculate the percentage of defendants classified as high risk (decile_score >= 7) by race"
  )
})

test_that("Ex 9: Black defendants are more often classified as high risk than white defendants in COMPAS", {
  skip_if(!exists("compas"))
  skip_if(!all(c("race", "decile_score") %in% names(compas)))
  rate_by_race <- compas |>
    dplyr::filter(race %in% c("African-American", "Caucasian")) |>
    dplyr::group_by(race) |>
    dplyr::summarize(high_risk_rate = mean(decile_score >= 7, na.rm = TRUE))
  aa_rate <- rate_by_race$high_risk_rate[rate_by_race$race == "African-American"]
  ca_rate <- rate_by_race$high_risk_rate[rate_by_race$race == "Caucasian"]
  expect_gt(aa_rate, ca_rate,
    label = "African-American defendants should have a higher high-risk classification rate than Caucasian defendants"
  )
})

test_that("Ex 10: Rmd calculates false positive rate by race", {
  skip_if(length(.rmd_content) == 0)
  potential_answers <- c(
    "false.positive",
    "False.Positive",
    "FPR",
    "non_recidiv"
  )
  pattern <- paste0("(", paste(potential_answers, collapse = "|"), ")")
  answer_in_rmd <- stringr::str_detect(.rmd_content, pattern) |> any()
  expect_equal(answer_in_rmd, TRUE,
    info = "Ex 10: Calculate false positive rates separately for Black and white defendants"
  )
})
