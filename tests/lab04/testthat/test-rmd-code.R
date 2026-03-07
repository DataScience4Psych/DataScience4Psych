# Rmd code-presence checks: verify student wrote R code, not just prose

test_that("Rmd file exists in working directory", {
  expect_true(length(.rmd_files) > 0,
              info = "Submit an Rmd file in the working directory")
})

test_that("Rmd contains a minimum number of R code chunks", {
  skip_if(length(.rmd_content) == 0)
  chunk_starts <- stringr::str_detect(.rmd_content, "^```\\{r")
  expect_true(sum(chunk_starts) >= 5,
              info = sprintf("Include at least 5 R code chunks in your Rmd file, found %d", sum(chunk_starts)))
})

test_that("R code chunks contain actual code (not all empty)", {
  skip_if(length(.rmd_content) == 0)
  chunk_starts <- grep("^```\\{r", .rmd_content)
  chunk_ends <- grep("^```$", .rmd_content)
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
              info = sprintf("Add actual R code to at least 2 code chunks, found %d non-empty", non_empty))
})

# Per-exercise checks (exercises 1, 5, 6, 9 match existing test files)

test_that("Exercise 1 section contains R code", {
  skip_if(length(.rmd_content) == 0)
  potential_answers <- c("^```\\{r", "`r\\s+[^`]+`")
  pattern <- paste0("(", paste(potential_answers, collapse = "|"), ")")
  answer_in_rmd <- stringr::str_detect(.rmd_content, pattern) |> any()
  expect_equal(answer_in_rmd, TRUE,
               info = "Add R code for Exercise 1 in your Rmd file (code chunk or inline R expression)")
})

test_that("Exercise 1 uses inline R code", {
  skip_if(length(.rmd_content) == 0)
  potential_answers <- c("`r\\s+[^`]+`")
  pattern <- paste0("(", paste(potential_answers, collapse = "|"), ")")
  answer_in_rmd <- stringr::str_detect(.rmd_content, pattern) |> any()
  expect_equal(answer_in_rmd, TRUE,
               info = "Use inline R code in your Rmd file (e.g., `r nrow(data)`) to report results dynamically")
})

test_that("Exercise 5 section contains R code", {
  skip_if(length(.rmd_content) == 0)
  potential_answers <- c("^```\\{r", "`r\\s+[^`]+`", "filter", "state")
  pattern <- paste0("(", paste(potential_answers, collapse = "|"), ")")
  answer_in_rmd <- stringr::str_detect(.rmd_content, pattern) |> any()
  expect_equal(answer_in_rmd, TRUE,
               info = "Add R code for Exercise 5 in your Rmd file (code chunk or inline R expression)")
})

test_that("Exercise 6 section contains R code", {
  skip_if(length(.rmd_content) == 0)
  potential_answers <- c("^```\\{r", "`r\\s+[^`]+`", "mutate", "country")
  pattern <- paste0("(", paste(potential_answers, collapse = "|"), ")")
  answer_in_rmd <- stringr::str_detect(.rmd_content, pattern) |> any()
  expect_equal(answer_in_rmd, TRUE,
               info = "Add R code for Exercise 6 in your Rmd file (code chunk or inline R expression)")
})

test_that("Exercise 9 section contains R code", {
  skip_if(length(.rmd_content) == 0)
  potential_answers <- c("^```\\{r", "`r\\s+[^`]+`", "count", "table", "state")
  pattern <- paste0("(", paste(potential_answers, collapse = "|"), ")")
  answer_in_rmd <- stringr::str_detect(.rmd_content, pattern) |> any()
  expect_equal(answer_in_rmd, TRUE,
               info = "Add R code for Exercise 9 in your Rmd file (code chunk or inline R expression)")
})
