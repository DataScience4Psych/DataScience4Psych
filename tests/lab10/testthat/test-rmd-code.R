# Per-exercise checks

test_that("Exercise 1 section contains R code", {
  skip_if(length(.rmd_content) == 0)
  potential_answers <- c("^```\\{r", "`r\\s+[^`]+`")
  pattern <- paste0("(", paste(potential_answers, collapse = "|"), ")")
  answer_in_rmd <- stringr::str_detect(.rmd_content, pattern) |> any()
  expect_equal(answer_in_rmd, TRUE,
    info = "Include R code (a code chunk or inline R expression) for Exercise 1 in your Rmd"
  )
})

test_that("Exercise 2 section contains R code", {
  skip_if(length(.rmd_content) == 0)
  potential_answers <- c("m_bty", "lm\\(.*score.*bty_avg", "summary\\(", "coef\\(")
  pattern <- paste0("(", paste(potential_answers, collapse = "|"), ")")
  answer_in_rmd <- stringr::str_detect(.rmd_content, pattern) |> any()
  expect_equal(answer_in_rmd, TRUE,
    info = "Include R code for Exercise 2 in your Rmd (e.g., fitting m_bty model)"
  )
})

test_that("Exercise 3 section contains R code", {
  skip_if(length(.rmd_content) == 0)
  potential_answers <- c("m_gen", "lm\\(.*score.*gender", "rank_relevel", "relevel\\(", "tenure_eligible")
  pattern <- paste0("(", paste(potential_answers, collapse = "|"), ")")
  answer_in_rmd <- stringr::str_detect(.rmd_content, pattern) |> any()
  expect_equal(answer_in_rmd, TRUE,
    info = "Include R code for Exercise 3 in your Rmd (e.g., fitting m_gen model or creating rank_relevel)"
  )
})

test_that("Exercise 4 section contains R code", {
  skip_if(length(.rmd_content) == 0)
  potential_answers <- c("m_bty_gen", "m_bty_rank", "lm\\(.*score.*bty_avg.*gender", "lm\\(.*score.*bty_avg.*rank")
  pattern <- paste0("(", paste(potential_answers, collapse = "|"), ")")
  answer_in_rmd <- stringr::str_detect(.rmd_content, pattern) |> any()
  expect_equal(answer_in_rmd, TRUE,
    info = "Include R code for Exercise 4 in your Rmd (e.g., fitting m_bty_gen or m_bty_rank models)"
  )
})

test_that("Exercise 5 section contains full-model R code", {
  skip_if(length(.rmd_content) == 0)
  potential_answers <- c("m_full", "full_model", "model_full",
                         "lm\\(score\\s*~\\s*rank.*bty_avg", "lm\\(score\\s*~\\s*bty_avg.*rank",
                         "cls_perc_eval.*cls_students", "cls_students.*cls_perc_eval")
  pattern <- paste0("(", paste(potential_answers, collapse = "|"), ")")
  answer_in_rmd <- stringr::str_detect(.rmd_content, pattern) |> any()
  expect_equal(answer_in_rmd, TRUE,
    info = "Include R code for Exercise 5 in your Rmd (e.g., fitting the full model or the best backward-selection model)"
  )
})

test_that("Exercise 5 section contains backward-selection or best-model R code", {
  skip_if(length(.rmd_content) == 0)
  potential_answers <- c("m_best", "best_model", "m_final", "final_model",
                         "backward", "step\\(", "adj.*r.squared", "adjusted.*r")
  pattern <- paste0("(", paste(potential_answers, collapse = "|"), ")")
  answer_in_rmd <- stringr::str_detect(.rmd_content, pattern) |> any()
  expect_equal(answer_in_rmd, TRUE,
    info = "Include R code for backward selection (or the final best model) in your Exercise 5 Rmd"
  )
})
