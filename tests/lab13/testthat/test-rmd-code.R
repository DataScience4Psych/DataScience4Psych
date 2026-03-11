# Per-exercise checks

test_that("Exercise 1 section contains R code", {
  skip_if(length(.rmd_content) == 0)
  potential_answers <- c("^```\\{r", "`r\\s+[^`]+`", "df_colonists", "rnorm|runif|sample", "tibble|data\\.frame")
  pattern <- paste0("(", paste(potential_answers, collapse = "|"), ")")
  answer_in_rmd <- stringr::str_detect(.rmd_content, pattern) |> any()
  expect_equal(answer_in_rmd, TRUE,
    info = "Include R code for Exercise 1 in your Rmd (e.g., simulating colonist attributes)"
  )
})

test_that("Exercise 2 section contains R code", {
  skip_if(length(.rmd_content) == 0)
  potential_answers <- c("technical_skills", "problem_solving", "cor\\(", "rnorm", "mutate\\(")
  pattern <- paste0("(", paste(potential_answers, collapse = "|"), ")")
  answer_in_rmd <- stringr::str_detect(.rmd_content, pattern) |> any()
  expect_equal(answer_in_rmd, TRUE,
    info = "Include R code for Exercise 2 in your Rmd (e.g., adding correlated attributes)"
  )
})

test_that("Exercise 3 section contains R code", {
  skip_if(length(.rmd_content) == 0)
  potential_answers <- c("mvrnorm", "MASS", "resilience|agreeableness", "EX|ES|AG|CO|OP", "Big.*Five|personality")
  pattern <- paste0("(", paste(potential_answers, collapse = "|"), ")")
  answer_in_rmd <- stringr::str_detect(.rmd_content, pattern) |> any()
  expect_equal(answer_in_rmd, TRUE,
    info = "Include R code for Exercise 3 in your Rmd (e.g., using mvrnorm for Big Five traits)"
  )
})
