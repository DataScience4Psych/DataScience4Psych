

# Per-exercise checks

test_that("Exercise 1 section contains R code", {
  skip_if(length(.rmd_content) == 0)
  potential_answers <- c("^```\\{r", "`r\\s+[^`]+`")
  pattern <- paste0("(", paste(potential_answers, collapse = "|"), ")")
  has_code <- stringr::str_detect(.rmd_content, pattern) |> any()
  expect_true(has_code,
              info = "Include R code (code chunk or inline R expression) for Exercise 1 in your Rmd file")
})

test_that("Exercise 1 uses inline R code", {
  skip_if(length(.rmd_content) == 0)
  potential_answers <- c("`r\\s+[^`]+`")
  pattern <- paste0("(", paste(potential_answers, collapse = "|"), ")")
  has_inline <- stringr::str_detect(.rmd_content, pattern) |> any()
  expect_true(has_inline,
              info = "Use inline R code in your Rmd file (e.g., `r nrow(data)`)")
})

test_that("Exercise 2 section contains R code", {
  skip_if(length(.rmd_content) == 0)
  potential_answers <- c("^```\\{r", "`r\\s+[^`]+`")
  pattern <- paste0("(", paste(potential_answers, collapse = "|"), ")")
  has_code <- stringr::str_detect(.rmd_content, pattern) |> any()
  expect_true(has_code,
              info = "Include R code (code chunk or inline R expression) for Exercise 2 in your Rmd file")
})

test_that("Exercise 2 uses inline R code", {
  skip_if(length(.rmd_content) == 0)
  potential_answers <- c("`r\\s+[^`]+`")
  pattern <- paste0("(", paste(potential_answers, collapse = "|"), ")")
  has_inline <- stringr::str_detect(.rmd_content, pattern) |> any()
  expect_true(has_inline,
              info = "Use inline R code for Exercise 2 in your Rmd file (e.g., `r nrow(data)`)")
})

test_that("Exercise 3 section contains R code", {
  skip_if(length(.rmd_content) == 0)
  potential_answers <- c("^```\\{r", "`r\\s+[^`]+`")
  pattern <- paste0("(", paste(potential_answers, collapse = "|"), ")")
  has_code <- stringr::str_detect(.rmd_content, pattern) |> any()
  expect_true(has_code,
              info = "Include R code (code chunk or inline R expression) for Exercise 3 in your Rmd file")
})

test_that("Exercise 4 section contains R code", {
  skip_if(length(.rmd_content) == 0)
  potential_answers <- c("^```\\{r", "`r\\s+[^`]+`")
  pattern <- paste0("(", paste(potential_answers, collapse = "|"), ")")
  has_code <- stringr::str_detect(.rmd_content, pattern) |> any()
  expect_true(has_code,
              info = "Include R code (code chunk or inline R expression) for Exercise 4 in your Rmd file")
})

test_that("Exercise 5 section contains R code", {
  skip_if(length(.rmd_content) == 0)
  potential_answers <- c("^```\\{r", "`r\\s+[^`]+`")
  pattern <- paste0("(", paste(potential_answers, collapse = "|"), ")")
  has_code <- stringr::str_detect(.rmd_content, pattern) |> any()
  expect_true(has_code,
              info = "Include R code (code chunk or inline R expression) for Exercise 5 in your Rmd file")
})

test_that("Exercise 6 section contains R code", {
  skip_if(length(.rmd_content) == 0)
  potential_answers <- c("^```\\{r", "`r\\s+[^`]+`")
  pattern <- paste0("(", paste(potential_answers, collapse = "|"), ")")
  has_code <- stringr::str_detect(.rmd_content, pattern) |> any()
  expect_true(has_code,
              info = "Include R code (code chunk or inline R expression) for Exercise 6 in your Rmd file")
})
