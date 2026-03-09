# Exercise 5: Faceted plot of all datasets; group_by summary of all correlations

test_that("Ex 5: Rmd Exercise 5 contains group_by or summarize code", {
  skip_if(length(.rmd_content) == 0)
  potential_answers <- c("group_by", "summar")
  pattern <- paste0("(", paste(potential_answers, collapse = "|"), ")")
  answer_in_rmd <- stringr::str_detect(.rmd_content, pattern) |> any()
  expect_equal(answer_in_rmd, TRUE,
               info = "Make sure to include group_by and/or summarize code in your Rmd file for Exercise 5")
})

test_that("Ex 5: Rmd Exercise 5 contains facet_wrap code", {
  skip_if(length(.rmd_content) == 0)
  potential_answers <- c("facet_wrap")
  pattern <- paste0("(", paste(potential_answers, collapse = "|"), ")")
  answer_in_rmd <- stringr::str_detect(.rmd_content, pattern) |> any()
  expect_equal(answer_in_rmd, TRUE,
               info = "Make sure to include facet_wrap code for the faceted plot in your Rmd file for Exercise 5")
})

test_that("Ex 5: Rmd Exercise 5 contains correlation code", {
  skip_if(length(.rmd_content) == 0)
  potential_answers <- c("\\bcor\\b")
  pattern <- paste0("(", paste(potential_answers, collapse = "|"), ")")
  answer_in_rmd <- stringr::str_detect(.rmd_content, pattern) |> any()
  expect_equal(answer_in_rmd, TRUE,
               info = "Make sure to compute correlations using cor() in your Rmd file for Exercise 5")
})
