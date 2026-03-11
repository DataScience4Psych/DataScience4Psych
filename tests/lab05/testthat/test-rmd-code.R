# Per-exercise checks

test_that("Exercise 1 section contains R code", {
  skip_if(length(.rmd_content) == 0)
  potential_answers <- c("^```\\{r", "`r\\s+[^`]+`", "dn_ak", "lq_ak", "filter\\(", "state.*==.*AK")
  pattern <- paste0("(", paste(potential_answers, collapse = "|"), ")")
  answer_in_rmd <- stringr::str_detect(.rmd_content, pattern) |> any()
  expect_equal(answer_in_rmd, TRUE,
    info = "Include R code for Exercise 1 in your Rmd (e.g., filtering for Alaska)"
  )
})

test_that("Exercise 2 section contains R code", {
  skip_if(length(.rmd_content) == 0)
  potential_answers <- c("nrow\\(", "pairing", "\\*", "full_join", "dn_lq_ak")
  pattern <- paste0("(", paste(potential_answers, collapse = "|"), ")")
  answer_in_rmd <- stringr::str_detect(.rmd_content, pattern) |> any()
  expect_equal(answer_in_rmd, TRUE,
    info = "Include R code for Exercise 2 in your Rmd (e.g., computing pairings with nrow())"
  )
})

test_that("Exercise 5 section contains R code", {
  skip_if(length(.rmd_content) == 0)
  potential_answers <- c("haversine", "function\\(", "acos|asin|atan2", "6371", "distance")
  pattern <- paste0("(", paste(potential_answers, collapse = "|"), ")")
  answer_in_rmd <- stringr::str_detect(.rmd_content, pattern) |> any()
  expect_equal(answer_in_rmd, TRUE,
    info = "Include R code for Exercise 5 in your Rmd (e.g., defining the haversine function)"
  )
})

test_that("Exercise 7 section contains R code", {
  skip_if(length(.rmd_content) == 0)
  potential_answers <- c("min\\(", "summarize|summarise", "slice_min", "group_by", "closest|min_dist")
  pattern <- paste0("(", paste(potential_answers, collapse = "|"), ")")
  answer_in_rmd <- stringr::str_detect(.rmd_content, pattern) |> any()
  expect_equal(answer_in_rmd, TRUE,
    info = "Include R code for Exercise 7 in your Rmd (e.g., computing minimum distances)"
  )
})
