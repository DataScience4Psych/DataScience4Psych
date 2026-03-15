# Per-exercise checks

test_that("Exercise 1 section contains R code", {
  skip_if(length(.rmd_content) == 0)
  potential_answers <- c("^```\\{r", "`r\\s+[^`]+`")
  pattern <- paste0("(", paste(potential_answers, collapse = "|"), ")")
  answer_in_rmd <- stringr::str_detect(.rmd_content, pattern) |> any()
  expect_equal(answer_in_rmd, TRUE,
    info = "Include R code for Exercise 1 (a code chunk or inline R expression)"
  )
})

test_that("Exercise 2 section contains R code", {
  skip_if(length(.rmd_content) == 0)
  potential_answers <- c("^```\\{r", "`r\\s+[^`]+`")
  pattern <- paste0("(", paste(potential_answers, collapse = "|"), ")")
  answer_in_rmd <- stringr::str_detect(.rmd_content, pattern) |> any()
  expect_equal(answer_in_rmd, TRUE,
    info = "Include R code for Exercise 2 (a code chunk or inline R expression)"
  )
})

test_that("Exercise 3 section: Rmd reads data from USAFacts URLs or local CSV", {
  skip_if(length(.rmd_content) == 0)
  potential_answers <- c("read_csv", "usafacts", "covid_confirmed", "cases_raw", "pop_raw")
  pattern <- paste0("(", paste(potential_answers, collapse = "|"), ")")
  answer_in_rmd <- stringr::str_detect(.rmd_content, pattern) |> any()
  expect_equal(answer_in_rmd, TRUE,
    info = "Exercise 3 should read USAFacts data (read_csv with the URL or a local csv) and create cases_raw and pop_raw"
  )
})

test_that("Exercise 4 section: Rmd uses pivot_longer and lubridate", {
  skip_if(length(.rmd_content) == 0)
  potential_answers <- c("pivot_longer", "ymd\\s*\\(", "lubridate", "kansas_cases")
  pattern <- paste0("(", paste(potential_answers, collapse = "|"), ")")
  answer_in_rmd <- stringr::str_detect(.rmd_content, pattern) |> any()
  expect_equal(answer_in_rmd, TRUE,
    info = "Exercise 4 should reshape the data with pivot_longer() and parse dates with lubridate::ymd()"
  )
})

test_that("Exercise 5 section: Rmd computes daily new cases with lag()", {
  skip_if(length(.rmd_content) == 0)
  potential_answers <- c("\\blag\\s*\\(", "daily_new_cases", "cumulative_cases")
  pattern <- paste0("(", paste(potential_answers, collapse = "|"), ")")
  answer_in_rmd <- stringr::str_detect(.rmd_content, pattern) |> any()
  expect_equal(answer_in_rmd, TRUE,
    info = "Exercise 5 should compute daily_new_cases using lag() on cumulative_cases"
  )
})

test_that("Exercise 6 section: Rmd uses str_remove() and left_join()", {
  skip_if(length(.rmd_content) == 0)
  potential_answers <- c("str_remove\\s*\\(", "left_join\\s*\\(", "mask_mandate")
  pattern <- paste0("(", paste(potential_answers, collapse = "|"), ")")
  answer_in_rmd <- stringr::str_detect(.rmd_content, pattern) |> any()
  expect_equal(answer_in_rmd, TRUE,
    info = "Exercise 6 should use str_remove() to clean county names, create a mask_mandate column, and use left_join() for population"
  )
})

test_that("Exercise 7 section: Rmd computes rolling average with rollmean or zoo", {
  skip_if(length(.rmd_content) == 0)
  potential_answers <- c("rollmean\\s*\\(", "zoo::", "rolling_avg", "per_100k", "100000")
  pattern <- paste0("(", paste(potential_answers, collapse = "|"), ")")
  answer_in_rmd <- stringr::str_detect(.rmd_content, pattern) |> any()
  expect_equal(answer_in_rmd, TRUE,
    info = "Exercise 7 should compute a 7-day rolling average using zoo::rollmean() and calculate per-100K rates"
  )
})

test_that("Exercise 8 section: Rmd contains a ggplot visualization", {
  skip_if(length(.rmd_content) == 0)
  potential_answers <- c("ggplot\\s*\\(", "geom_line\\s*\\(", "geom_point\\s*\\(", "geom_bar\\s*\\(")
  pattern <- paste0("(", paste(potential_answers, collapse = "|"), ")")
  answer_in_rmd <- stringr::str_detect(.rmd_content, pattern) |> any()
  expect_equal(answer_in_rmd, TRUE,
    info = "Exercise 8 should create a ggplot visualization reconstructing the misleading chart"
  )
})

test_that("Exercise 9 section: Rmd contains an improved ggplot visualization", {
  skip_if(length(.rmd_content) == 0)
  # Must have at least two ggplot() calls for exercises 8 and 9
  n_ggplot_calls <- sum(stringr::str_detect(.rmd_content, "ggplot\\s*\\("))
  expect_true(n_ggplot_calls >= 2,
    info = "Exercise 9 should create a second improved visualization — make sure you have at least two ggplot() calls"
  )
})
