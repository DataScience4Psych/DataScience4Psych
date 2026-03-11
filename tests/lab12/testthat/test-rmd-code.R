# Per-exercise checks

test_that("Exercise 1 section contains R code", {
  skip_if(length(.rmd_content) == 0)
  potential_answers <- c("^```\\{r", "`r\\s+[^`]+`", "ncbirths", "openintro", "nrow\\(|dim\\(|glimpse\\(|str\\(")
  pattern <- paste0("(", paste(potential_answers, collapse = "|"), ")")
  answer_in_rmd <- stringr::str_detect(.rmd_content, pattern) |> any()
  expect_equal(answer_in_rmd, TRUE,
    info = "Include R code for Exercise 1 in your Rmd (e.g., exploring ncbirths data)"
  )
})

test_that("Exercise 2 section contains R code", {
  skip_if(length(.rmd_content) == 0)
  potential_answers <- c("ncbirths_white", "whitemom", "filter\\(", "mean\\(.*weight", "white")
  pattern <- paste0("(", paste(potential_answers, collapse = "|"), ")")
  answer_in_rmd <- stringr::str_detect(.rmd_content, pattern) |> any()
  expect_equal(answer_in_rmd, TRUE,
    info = "Include R code for Exercise 2 in your Rmd (e.g., filtering for white mothers)"
  )
})

test_that("Exercise 5 section contains R code", {
  skip_if(length(.rmd_content) == 0)
  potential_answers <- c("geom_boxplot|boxplot|geom_violin", "ggplot", "habit", "weight", "smoker|nonsmoker")
  pattern <- paste0("(", paste(potential_answers, collapse = "|"), ")")
  answer_in_rmd <- stringr::str_detect(.rmd_content, pattern) |> any()
  expect_equal(answer_in_rmd, TRUE,
    info = "Include R code for Exercise 5 in your Rmd (e.g., creating a boxplot of weight by habit)"
  )
})

test_that("Exercise 11 section contains R code", {
  skip_if(length(.rmd_content) == 0)
  potential_answers <- c("mature", "mage", "lowbirthweight", "geom_|ggplot", "inference\\(|t\\.test|bootstrap")
  pattern <- paste0("(", paste(potential_answers, collapse = "|"), ")")
  answer_in_rmd <- stringr::str_detect(.rmd_content, pattern) |> any()
  expect_equal(answer_in_rmd, TRUE,
    info = "Include R code for Exercise 11 in your Rmd (e.g., analyzing mature mothers)"
  )
})
