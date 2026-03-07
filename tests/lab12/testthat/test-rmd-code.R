# Rmd code-presence checks: verify student wrote R code, not just prose

test_that("Rmd file exists in working directory", {
  expect_true(length(.rmd_files) > 0,
              info = "Submit an Rmd file in your working directory")
})

test_that("Rmd contains a minimum number of R code chunks", {
  skip_if(length(.rmd_content) == 0)
  chunk_starts <- stringr::str_detect(.rmd_content, "^```\\{r") |> which()
  expect_true(length(chunk_starts) >= 4,
              info = sprintf("Include at least 4 R code chunks in your Rmd, found %d", length(chunk_starts)))
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

test_that("Exercise 1 section contains R code", {
  skip_if(length(.rmd_content) == 0)
  potential_answers <- c("^```\\{r", "`r\\s+[^`]+`", "ncbirths", "openintro", "nrow\\(|dim\\(|glimpse\\(|str\\(")
  pattern <- paste0("(", paste(potential_answers, collapse = "|"), ")")
  answer_in_rmd <- stringr::str_detect(.rmd_content, pattern) |> any()
  expect_equal(answer_in_rmd, TRUE,
               info = "Include R code for Exercise 1 in your Rmd (e.g., exploring ncbirths data)")
})

test_that("Exercise 2 section contains R code", {
  skip_if(length(.rmd_content) == 0)
  potential_answers <- c("ncbirths_white", "whitemom", "filter\\(", "mean\\(.*weight", "white")
  pattern <- paste0("(", paste(potential_answers, collapse = "|"), ")")
  answer_in_rmd <- stringr::str_detect(.rmd_content, pattern) |> any()
  expect_equal(answer_in_rmd, TRUE,
               info = "Include R code for Exercise 2 in your Rmd (e.g., filtering for white mothers)")
})

test_that("Exercise 5 section contains R code", {
  skip_if(length(.rmd_content) == 0)
  potential_answers <- c("geom_boxplot|boxplot|geom_violin", "ggplot", "habit", "weight", "smoker|nonsmoker")
  pattern <- paste0("(", paste(potential_answers, collapse = "|"), ")")
  answer_in_rmd <- stringr::str_detect(.rmd_content, pattern) |> any()
  expect_equal(answer_in_rmd, TRUE,
               info = "Include R code for Exercise 5 in your Rmd (e.g., creating a boxplot of weight by habit)")
})

test_that("Exercise 11 section contains R code", {
  skip_if(length(.rmd_content) == 0)
  potential_answers <- c("mature", "mage", "lowbirthweight", "geom_|ggplot", "inference\\(|t\\.test|bootstrap")
  pattern <- paste0("(", paste(potential_answers, collapse = "|"), ")")
  answer_in_rmd <- stringr::str_detect(.rmd_content, pattern) |> any()
  expect_equal(answer_in_rmd, TRUE,
               info = "Include R code for Exercise 11 in your Rmd (e.g., analyzing mature mothers)")
})
