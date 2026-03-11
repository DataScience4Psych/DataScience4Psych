# Per-exercise checks

test_that("Exercise 1 section contains R code", {
  skip_if(length(.rmd_content) == 0)
  potential_answers <- c("^```\\{r", "`r\\s+[^`]+`", "staff", "pivot_longer", "read_csv", "instructional")
  pattern <- paste0("(", paste(potential_answers, collapse = "|"), ")")
  answer_in_rmd <- stringr::str_detect(.rmd_content, pattern) |> any()
  expect_equal(answer_in_rmd, TRUE,
    info = "Include R code for Exercise 1 in your Rmd (e.g., reading staff data and using pivot_longer)"
  )
})

test_that("Exercise 3 section contains R code", {
  skip_if(length(.rmd_content) == 0)
  potential_answers <- c("fisheries", "ggplot", "geom_", "read_csv", "country")
  pattern <- paste0("(", paste(potential_answers, collapse = "|"), ")")
  answer_in_rmd <- stringr::str_detect(.rmd_content, pattern) |> any()
  expect_equal(answer_in_rmd, TRUE,
    info = "Include R code for Exercise 3 in your Rmd (e.g., reading fisheries data and creating a visualization)"
  )
})

test_that("Exercise 4 section contains R code", {
  skip_if(length(.rmd_content) == 0)
  potential_answers <- c("Whickham", "mosaicData", "smoker", "outcome", "ggplot|geom_|table\\(")
  pattern <- paste0("(", paste(potential_answers, collapse = "|"), ")")
  answer_in_rmd <- stringr::str_detect(.rmd_content, pattern) |> any()
  expect_equal(answer_in_rmd, TRUE,
    info = "Include R code for Exercise 4 in your Rmd (e.g., loading and exploring Whickham data)"
  )
})
