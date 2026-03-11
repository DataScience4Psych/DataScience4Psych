# Per-exercise checks

test_that("Exercise 1 uses inline R code", {
  skip_if(length(.rmd_content) == 0)
  potential_answers <- c("`r\\s+[^`]+`", "compas", "read_csv", "clean_names", "nrow\\(|ncol\\(|dim\\(|glimpse\\(")
  pattern <- paste0("(", paste(potential_answers, collapse = "|"), ")")
  answer_in_rmd <- stringr::str_detect(.rmd_content, pattern) |> any()
  expect_equal(answer_in_rmd, TRUE,
    info = "Include inline R code or exploration code for Exercise 1 in your Rmd"
  )
})

test_that("Exercise 3 section contains R code", {
  skip_if(length(.rmd_content) == 0)
  potential_answers <- c("ggplot", "geom_histogram|geom_bar|geom_density", "decile_score", "^```\\{r")
  pattern <- paste0("(", paste(potential_answers, collapse = "|"), ")")
  answer_in_rmd <- stringr::str_detect(.rmd_content, pattern) |> any()
  expect_equal(answer_in_rmd, TRUE,
    info = "Include R code for Exercise 3 in your Rmd (e.g., visualizing risk score distribution)"
  )
})

test_that("Exercise 5 section contains R code", {
  skip_if(length(.rmd_content) == 0)
  potential_answers <- c("two_year_recid", "recidiv", "classification", "TP|TN|FP|FN", "case_when|ifelse|if_else")
  pattern <- paste0("(", paste(potential_answers, collapse = "|"), ")")
  answer_in_rmd <- stringr::str_detect(.rmd_content, pattern) |> any()
  expect_equal(answer_in_rmd, TRUE,
    info = "Include R code for Exercise 5 in your Rmd (e.g., analyzing recidivism and classification)"
  )
})

test_that("Exercise 8 section contains R code", {
  skip_if(length(.rmd_content) == 0)
  potential_answers <- c("race", "African|Caucasian", "group_by", "decile_score", "mean\\(")
  pattern <- paste0("(", paste(potential_answers, collapse = "|"), ")")
  answer_in_rmd <- stringr::str_detect(.rmd_content, pattern) |> any()
  expect_equal(answer_in_rmd, TRUE,
    info = "Include R code for Exercise 8 in your Rmd (e.g., comparing risk scores across racial groups)"
  )
})

test_that("Exercise 10 section contains R code", {
  skip_if(length(.rmd_content) == 0)
  potential_answers <- c("false.*positive|fp_rate", "non_recidiv", "race", "African|Caucasian", "mean\\(.*decile_score")
  pattern <- paste0("(", paste(potential_answers, collapse = "|"), ")")
  answer_in_rmd <- stringr::str_detect(.rmd_content, pattern) |> any()
  expect_equal(answer_in_rmd, TRUE,
    info = "Include R code for Exercise 10 in your Rmd (e.g., analyzing false positive rates by race)"
  )
})
