# Exercise 1: Load Kansas COVID data and reconstruct misleading visualization

test_that("Ex 1: Rmd loads kansas_grouped_rolling_avg.csv", {
  skip_if(length(.rmd_content) == 0)
  potential_answers <- c(
    "kansas_grouped_rolling_avg",
    "kansas"
  )
  pattern <- paste0("(", paste(potential_answers, collapse = "|"), ")")
  answer_in_rmd <- stringr::str_detect(.rmd_content, pattern) |> any()
  expect_equal(answer_in_rmd, TRUE,
    info = "Ex 1: Load the kansas_grouped_rolling_avg.csv dataset"
  )
})

test_that("Ex 1: df or kansas data frame exists", {
  has_df <- exists("df")
  has_kansas <- exists("kansas")
  expect_true(
    has_df || has_kansas,
    label = "Load the Kansas COVID data into a data frame (e.g., df)"
  )
})

test_that("Ex 1: df has expected variables (date, rolling_avg, mask_mandate)", {
  skip_if(!exists("df"))
  expected_vars <- c("date", "rolling_avg", "mask_mandate")
  expect_true(
    all(expected_vars %in% names(df)),
    label = paste("df should contain columns:", paste(expected_vars, collapse = ", "))
  )
})

test_that("Ex 1: Rmd reconstructs the line plot", {
  skip_if(length(.rmd_content) == 0)
  answer_in_rmd <- stringr::str_detect(.rmd_content, "geom_line") |> any()
  expect_equal(answer_in_rmd, TRUE,
    info = "Ex 1: Use geom_line() to reconstruct the Kansas COVID line plot"
  )
})
