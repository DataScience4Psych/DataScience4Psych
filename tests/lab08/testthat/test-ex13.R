# Exercise 13: Finding and correcting the out-of-range year

test_that("Ex 13: all non-NA year values fall within a plausible historical range", {
  .art <- if (exists("uoe_art")) uoe_art else .find_art_df()
  skip_if(is.null(.art) || !"year" %in% names(.art))
  valid_years <- .art$year[!is.na(.art$year)]
  skip_if(length(valid_years) == 0, message = "No non-NA year values to check")
  current_year <- as.integer(format(Sys.Date(), "%Y"))
  expect_true(all(valid_years >= 1400 & valid_years <= current_year),
    info = paste0(
      "After correcting outliers in Exercise 13, all years should be between 1400 and ",
      current_year
    )
  )
})

test_that("Ex 13: Rmd contains year-correction code using mutate() and if_else() or case_when()", {
  skip_if(length(.rmd_content) == 0)
  potential_answers <- c(
    "mutate\\(",
    "if_else\\(|ifelse\\(|case_when\\("
  )
  pattern <- paste0("(", paste(potential_answers, collapse = "|"), ")")
  answer_in_rmd <- stringr::str_detect(.rmd_content, pattern) |> any()
  expect_equal(answer_in_rmd, TRUE,
    info = "Use mutate() with if_else() or case_when() to correct the out-of-range year for Exercise 13"
  )
})
