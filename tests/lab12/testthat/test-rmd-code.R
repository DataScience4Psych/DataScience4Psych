# Rmd code-presence checks: verify student wrote R code, not just prose

test_that("Rmd file exists in working directory", {
  expect_true(length(.rmd_files) > 0,
              label = "No Rmd file found — student must submit an Rmd file")
})

test_that("Rmd contains a minimum number of R code chunks", {
  skip_if(length(.rmd_content) == 0)
  chunk_starts <- grep("^```\\{r", .rmd_content)
  expect_true(length(chunk_starts) >= 4,
              label = sprintf("Rmd should have at least 4 R code chunks, found %d", length(chunk_starts)))
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
      code_lines <- chunk_body[!grepl("^\\s*$", chunk_body) & !grepl("^\\s*#", chunk_body)]
      if (length(code_lines) > 0) non_empty <- non_empty + 1
    }
  }
  expect_true(non_empty >= 2,
              label = sprintf("At least 2 code chunks should contain actual R code, found %d non-empty", non_empty))
})

# Per-exercise checks

test_that("Exercise 1 section contains R code", {
  skip_if(length(.rmd_content) == 0)
  section <- .find_ex_section(.rmd_content, "1", "2")
  skip_if(is.null(section), "Could not locate Exercise 1 section in Rmd")
  has_chunk <- any(grepl("^```\\{r", section))
  has_inline <- any(grepl("`r\\s+[^`]+`", section))
  expect_true(has_chunk || has_inline,
              label = "Exercise 1 should contain R code (code chunk or inline R expression)")
})

test_that("Exercise 2 section contains R code", {
  skip_if(length(.rmd_content) == 0)
  section <- .find_ex_section(.rmd_content, "2", "3")
  skip_if(is.null(section), "Could not locate Exercise 2 section in Rmd")
  has_chunk <- any(grepl("^```\\{r", section))
  has_inline <- any(grepl("`r\\s+[^`]+`", section))
  expect_true(has_chunk || has_inline,
              label = "Exercise 2 should contain R code (code chunk or inline R expression)")
})

test_that("Exercise 5 section contains R code", {
  skip_if(length(.rmd_content) == 0)
  section <- .find_ex_section(.rmd_content, "5", "6")
  skip_if(is.null(section), "Could not locate Exercise 5 section in Rmd")
  has_chunk <- any(grepl("^```\\{r", section))
  has_inline <- any(grepl("`r\\s+[^`]+`", section))
  expect_true(has_chunk || has_inline,
              label = "Exercise 5 should contain R code (code chunk or inline R expression)")
})

test_that("Exercise 11 section contains R code", {
  skip_if(length(.rmd_content) == 0)
  section <- .find_ex_section(.rmd_content, "11", "12")
  skip_if(is.null(section), "Could not locate Exercise 11 section in Rmd")
  has_chunk <- any(grepl("^```\\{r", section))
  has_inline <- any(grepl("`r\\s+[^`]+`", section))
  expect_true(has_chunk || has_inline,
              label = "Exercise 11 should contain R code (code chunk or inline R expression)")
})
