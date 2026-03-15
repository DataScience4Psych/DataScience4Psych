# Exercise 8: Missingness is a modeling decision (Super Stretch)

test_that("Ex 8: cv_df exists and has fewer rows than full titanic3 (listwise deletion)", {
  skip_if(!exists("cv_df"), message = "cv_df not found")
  skip_if(!exists("titanic3"), message = "titanic3 not found")
  n_all <- sum(!is.na(titanic3$survived))
  expect_true(nrow(cv_df) < n_all,
              info = sprintf(
                "cv_df (%d rows) should have fewer rows than titanic3 non-missing survived (%d rows) due to listwise deletion",
                nrow(cv_df), n_all
              ))
})

test_that("Ex 8: Rmd discusses proportion of passengers retained after listwise deletion", {
  skip_if(length(.rmd_content) == 0)
  potential_answers <- c("prop_kept", "n_all", "n_kept", "proportion.*retain|retain.*proportion",
                         "missing", "listwise", "complete.*case|case.*complete",
                         "nrow\\(cv_df\\)", "nrow\\(titanic3\\)")
  pattern <- paste0("(", paste(potential_answers, collapse = "|"), ")")
  answer_in_rmd <- stringr::str_detect(.rmd_content, pattern) |> any()
  expect_equal(answer_in_rmd, TRUE,
               info = "Report the proportion of passengers retained after listwise deletion in your Rmd (Exercise 8)")
})

test_that("Ex 8: Rmd investigates who is missing (missingness analysis)", {
  skip_if(length(.rmd_content) == 0)
  potential_answers <- c("age_missing", "is\\.na\\(age\\)", "missing.*age|age.*missing",
                         "group_by", "summarize", "survival_rate",
                         "pct_first|pct_third|first_class|third_class")
  pattern <- paste0("(", paste(potential_answers, collapse = "|"), ")")
  answer_in_rmd <- stringr::str_detect(.rmd_content, pattern) |> any()
  expect_equal(answer_in_rmd, TRUE,
               info = "Include missingness investigation code in your Rmd (Exercise 8.2)")
})
