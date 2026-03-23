# Rmd code-presence checks: verify student wrote R code, not just prose


test_that("Rmd file contains headers", {
  potential_headers <- c("output: ","author: ","date: ","title: ")
  pattern <- paste0("(", paste(potential_headers, collapse = "|"), ")")


  headers <- which(stringr::str_detect(.rmd_content, pattern))
  expect_true(
    length(headers) >= 3,
    info = sprintf(
      "Include at least 3 headers in your Rmd file — found %d",
      length(headers)
    )
  )
})

test_that("Rmd file contains custom header elements", {
  skip_if(length(.rmd_content) == 0)
  potential_headers <- c("Insert your name here", "Insert date here")
  pattern <- paste0("(", paste(potential_headers, collapse = "|"), ")")

  headers <- which(stringr::str_detect(.rmd_content, pattern))
  expect_true(
    length(headers) == 0,
    info = sprintf(
      "Don't forget to update your header — found %d that need updating",
      length(headers)
    )
  )
})


test_that("Rmd contains a minimum number of R code chunks", {
  skip_if(length(.rmd_content) == 0)
  chunk_starts <- which(stringr::str_detect(.rmd_content, "^```\\{r"))
  expect_true(
    length(chunk_starts) >= 3,
    info = sprintf(
      "Include at least 3 R code chunks in your Rmd file — found %d",
      length(chunk_starts)
    )
  )
})

test_that("R code chunks contain actual code (not all empty)", {
  skip_if(length(.rmd_content) == 0)
  chunk_starts <- which(stringr::str_detect(.rmd_content, "^```\\{r"))
  chunk_ends <- which(stringr::str_detect(.rmd_content, "^```$"))
  skip_if(length(chunk_starts) == 0, "No code chunks found")
  non_empty <- 0
  for (i in seq_along(chunk_starts)) {
    end_candidates <- chunk_ends[chunk_ends > chunk_starts[i]]
    if (length(end_candidates) == 0) {
      next
    }
    end_line <- end_candidates[1]
    if (end_line - chunk_starts[i] > 1) {
      chunk_body <- .rmd_content[(chunk_starts[i] + 1):(end_line - 1)]
      code_lines <- chunk_body[!stringr::str_detect(chunk_body, "^\\s*$") &
        !stringr::str_detect(chunk_body, "^\\s*#")]
      if (length(code_lines) > 0) {
        non_empty <- non_empty + 1
      }
    }
  }
  expect_true(
    non_empty >= 2,
    info = sprintf(
      "Make sure at least 2 code chunks contain actual R code — found %d non-empty",
      non_empty
    )
  )
})
