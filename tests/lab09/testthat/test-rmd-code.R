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

test_that("Exercise 2 section contains unique defendant analysis", {
  skip_if(length(.rmd_content) == 0)
  potential_answers <- c("n_distinct", "unique\\(", "duplicated\\(", "length\\(unique", "distinct\\(")
  pattern <- paste0("(", paste(potential_answers, collapse = "|"), ")")
  answer_in_rmd <- stringr::str_detect(.rmd_content, pattern) |> any()
  expect_equal(answer_in_rmd, TRUE,
    info = "Include code to count unique defendants (e.g., n_distinct(compas$id)) in your Rmd for Exercise 2"
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

test_that("Exercise 4 section contains demographic visualization code", {
  skip_if(length(.rmd_content) == 0)
  potential_answers <- c("ggplot", "geom_bar|geom_col|geom_histogram", "race", "sex|gender")
  pattern <- paste0("(", paste(potential_answers, collapse = "|"), ")")
  answer_in_rmd <- stringr::str_detect(.rmd_content, pattern) |> any()
  expect_equal(answer_in_rmd, TRUE,
    info = "Include code creating demographic visualizations (race, sex) in your Rmd for Exercise 4"
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

test_that("Exercise 6 section contains accuracy calculation code", {
  skip_if(length(.rmd_content) == 0)
  potential_answers <- c("accuracy", "TP|TN|FP|FN", "classification", "correct\\b", "mean\\(.*classif")
  pattern <- paste0("(", paste(potential_answers, collapse = "|"), ")")
  answer_in_rmd <- stringr::str_detect(.rmd_content, pattern) |> any()
  expect_equal(answer_in_rmd, TRUE,
    info = "Include code calculating overall COMPAS accuracy in your Rmd for Exercise 6"
  )
})

test_that("Exercise 7 section contains risk score comparison by race", {
  skip_if(length(.rmd_content) == 0)
  potential_answers <- c(
    "ggplot", "geom_histogram|geom_density|geom_boxplot|geom_violin",
    "race", "decile_score", "fill\\s*=|color\\s*="
  )
  pattern <- paste0("(", paste(potential_answers, collapse = "|"), ")")
  answer_in_rmd <- stringr::str_detect(.rmd_content, pattern) |> any()
  expect_equal(answer_in_rmd, TRUE,
    info = "Include code visualizing risk score distributions by race in your Rmd for Exercise 7"
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

test_that("Exercise 9 section contains group-level accuracy metrics code", {
  skip_if(length(.rmd_content) == 0)
  potential_answers <- c(
    "group_by.*race", "race.*group_by", "filter.*race", "African|Caucasian",
    "accuracy|TP|FP|TN|FN|classification"
  )
  pattern <- paste0("(", paste(potential_answers, collapse = "|"), ")")
  answer_in_rmd <- stringr::str_detect(.rmd_content, pattern) |> any()
  expect_equal(answer_in_rmd, TRUE,
    info = "Include code calculating accuracy metrics by race in your Rmd for Exercise 9"
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

test_that("Exercise 11 section contains fairness debate discussion", {
  skip_if(length(.rmd_content) == 0)
  potential_answers <- c(
    "[Pp]ro[Pp]ublica", "[Nn]orthpointe", "calibrat", "error\\.rate|error rate",
    "false.positive|false.negative", "fairness|fair", "disparit"
  )
  pattern <- paste0("(", paste(potential_answers, collapse = "|"), ")")
  answer_in_rmd <- stringr::str_detect(.rmd_content, pattern) |> any()
  expect_equal(answer_in_rmd, TRUE,
    info = "Discuss the ProPublica vs. Northpointe fairness debate in your Rmd for Exercise 11"
  )
})
