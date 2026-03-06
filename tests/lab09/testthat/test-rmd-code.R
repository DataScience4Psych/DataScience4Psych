# Rmd code-presence checks: verify student wrote R code, not just prose

test_that("Rmd file exists in working directory", {
  expect_true(length(.rmd_files) > 0,
              info = "Submit an Rmd file in your working directory")
})

test_that("Rmd contains a minimum number of R code chunks", {
  skip_if(length(.rmd_content) == 0)
  chunk_starts <- stringr::str_detect(.rmd_content, "^```\\{r") |> which()
  expect_true(length(chunk_starts) >= 5,
              info = sprintf("Include at least 5 R code chunks in your Rmd, found %d", length(chunk_starts)))
})

test_that("R code chunks contain actual code (not all empty)", {
  skip_if(length(.rmd_content) == 0)
  chunk_starts <- stringr::str_detect(.rmd_content, "^```\\{r") |> which()
  chunk_ends <- stringr::str_detect(.rmd_content, "^```$") |> which()
  skip_if(length(chunk_starts) == 0, "No code chunks found")
  non_empty <- 0
  for (i in seq_along(chunk_starts)) {
    end_candidates <- chunk_ends[chunk_ends > chunk_starts[i]]
    if (length(end_candidates) == 0) next
    end_line <- end_candidates[1]
    if (end_line - chunk_starts[i] > 1) {
      chunk_body <- .rmd_content[(chunk_starts[i] + 1):(end_line - 1)]
      code_lines <- chunk_body[!stringr::str_detect(chunk_body, "^\\s*$") & !stringr::str_detect(chunk_body, "^\\s*#")]
      if (length(code_lines) > 0) non_empty <- non_empty + 1
    }
  }
  expect_true(non_empty >= 2,
              info = sprintf("Write actual R code in at least 2 code chunks, found %d non-empty", non_empty))
})

# Per-exercise checks

test_that("Exercise 1 uses inline R code", {
  skip_if(length(.rmd_content) == 0)
  potential_answers <- c("`r\\s+[^`]+`", "compas", "read_csv", "clean_names", "nrow\\(|ncol\\(|dim\\(|glimpse\\(")
  pattern <- paste0("(", paste(potential_answers, collapse = "|"), ")")
  answer_in_rmd <- stringr::str_detect(.rmd_content, pattern) |> any()
  expect_equal(answer_in_rmd, TRUE,
               info = "Include inline R code or exploration code for Exercise 1 in your Rmd")
})

test_that("Exercise 3 section contains R code", {
  skip_if(length(.rmd_content) == 0)
  potential_answers <- c("ggplot", "geom_histogram|geom_bar|geom_density", "decile_score", "^```\\{r")
  pattern <- paste0("(", paste(potential_answers, collapse = "|"), ")")
  answer_in_rmd <- stringr::str_detect(.rmd_content, pattern) |> any()
  expect_equal(answer_in_rmd, TRUE,
               info = "Include R code for Exercise 3 in your Rmd (e.g., visualizing risk score distribution)")
})

test_that("Exercise 5 section contains R code", {
  skip_if(length(.rmd_content) == 0)
  potential_answers <- c("two_year_recid", "recidiv", "classification", "TP|TN|FP|FN", "case_when|ifelse|if_else")
  pattern <- paste0("(", paste(potential_answers, collapse = "|"), ")")
  answer_in_rmd <- stringr::str_detect(.rmd_content, pattern) |> any()
  expect_equal(answer_in_rmd, TRUE,
               info = "Include R code for Exercise 5 in your Rmd (e.g., analyzing recidivism and classification)")
})

test_that("Exercise 8 section contains R code", {
  skip_if(length(.rmd_content) == 0)
  potential_answers <- c("race", "African|Caucasian", "group_by", "decile_score", "mean\\(")
  pattern <- paste0("(", paste(potential_answers, collapse = "|"), ")")
  answer_in_rmd <- stringr::str_detect(.rmd_content, pattern) |> any()
  expect_equal(answer_in_rmd, TRUE,
               info = "Include R code for Exercise 8 in your Rmd (e.g., comparing risk scores across racial groups)")
})

test_that("Exercise 10 section contains R code", {
  skip_if(length(.rmd_content) == 0)
  potential_answers <- c("false.*positive|fp_rate", "non_recidiv", "race", "African|Caucasian", "mean\\(.*decile_score")
  pattern <- paste0("(", paste(potential_answers, collapse = "|"), ")")
  answer_in_rmd <- stringr::str_detect(.rmd_content, pattern) |> any()
  expect_equal(answer_in_rmd, TRUE,
               info = "Include R code for Exercise 10 in your Rmd (e.g., analyzing false positive rates by race)")
})
