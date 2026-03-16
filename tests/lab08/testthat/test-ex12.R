# Exercise 12: Visualising the distribution of years with a histogram

test_that("Ex 12: Rmd contains histogram code for years", {
  skip_if(length(.rmd_content) == 0 & length(.r_script_content) == 0)
  potential_answers <- c(
    "geom_histogram", "hist\\(",
    "ggplot\\(.*aes.*year|aes\\(.*year"
  )
  pattern <- paste0("(", paste(potential_answers, collapse = "|"), ")")
  answer_in_rmd <- stringr::str_detect(.rmd_content, pattern) |> any()
  answer_in_rscript <- stringr::str_detect(.r_script_content, pattern) |> any()
  answer_in_r <- answer_in_rmd | answer_in_rscript
  expect_equal(answer_in_r, TRUE,
    info = "Create a histogram of years using ggplot2 (e.g., geom_histogram()) for Exercise 12"
  )
})

test_that("Ex 12: year column has non-NA values to visualise", {
  skip_if(!exists("uoe_art") || !"year" %in% names(uoe_art))
  n_valid <- sum(!is.na(uoe_art$year))
  expect_true(n_valid > 10,
    info = "There should be enough non-NA year values to produce a meaningful histogram"
  )
})
