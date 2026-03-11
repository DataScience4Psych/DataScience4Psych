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
