# Exercises 10-13: Year extraction, skim summary, histogram, and year correction

test_that("Ex 10: uoe_art has a date column after title separation", {
  skip_if(!exists("uoe_art"))
  expect_true("date" %in% names(uoe_art),
    info = "Create a 'date' column by separating the title at '(' using separate() for Exercise 10"
  )
})

test_that("Ex 10: uoe_art has a year column", {
  skip_if(!exists("uoe_art"))
  expect_true("year" %in% names(uoe_art),
    info = "Extract a 'year' from the date column (e.g., using str_extract()) and save it as a new column"
  )
})

test_that("Ex 10: year column is numeric", {
  skip_if(!exists("uoe_art") || !"year" %in% names(uoe_art))
  expect_true(is.numeric(uoe_art$year),
    info = "Convert the 'year' column to numeric (e.g., using as.numeric())"
  )
})

test_that("Ex 10: title column has been cleaned (no parenthetical date info)", {
  skip_if(!exists("uoe_art") || !"title" %in% names(uoe_art))
  titles <- uoe_art$title[!is.na(uoe_art$title)]
  skip_if(length(titles) == 0, message = "No non-NA titles to check")
  # After separate(), most titles should not contain '('
  pct_with_paren <- mean(grepl("\\(", titles))
  expect_true(pct_with_paren < 0.1,
    info = "After using separate(), the 'title' column should not contain parenthetical date info"
  )
})

test_that("Ex 10: some NA values exist in year column (expected for non-year dates)", {
  skip_if(!exists("uoe_art") || !"year" %in% names(uoe_art))
  expect_true(any(is.na(uoe_art$year)),
    info = "Some art pieces won't have a recognisable year — NA values in 'year' are expected and OK"
  )
})

test_that("Ex 10: Rmd contains separate() or str_extract() for year extraction", {
  skip_if(length(.rmd_content) == 0)
  potential_answers <- c(
    "separate\\(", "str_extract\\(", "str_remove\\(",
    "as\\.numeric\\(", "parse_number\\("
  )
  pattern <- paste0("(", paste(potential_answers, collapse = "|"), ")")
  answer_in_rmd <- stringr::str_detect(.rmd_content, pattern) |> any()
  expect_equal(answer_in_rmd, TRUE,
    info = "Use separate() or str_extract() to split the title and extract the year for Exercise 10"
  )
})

test_that("Ex 11: Rmd contains skim() to summarise uoe_art", {
  skip_if(length(.rmd_content) == 0)
  potential_answers <- c(
    "skim\\(", "skimr",
    "summary\\(.*uoe_art", "glimpse\\(.*uoe_art"
  )
  pattern <- paste0("(", paste(potential_answers, collapse = "|"), ")")
  answer_in_rmd <- stringr::str_detect(.rmd_content, pattern) |> any()
  expect_equal(answer_in_rmd, TRUE,
    info = "Use skim() from the skimr package to print a summary of uoe_art for Exercise 11"
  )
})

test_that("Ex 12: Rmd contains histogram code for years", {
  skip_if(length(.rmd_content) == 0)
  potential_answers <- c(
    "geom_histogram", "hist\\(",
    "ggplot.*year|year.*ggplot"
  )
  pattern <- paste0("(", paste(potential_answers, collapse = "|"), ")")
  answer_in_rmd <- stringr::str_detect(.rmd_content, pattern) |> any()
  expect_equal(answer_in_rmd, TRUE,
    info = "Create a histogram of years with ggplot2 (e.g., geom_histogram()) for Exercise 12"
  )
})

test_that("Ex 13: all non-NA year values fall within a plausible historical range", {
  skip_if(!exists("uoe_art") || !"year" %in% names(uoe_art))
  valid_years <- uoe_art$year[!is.na(uoe_art$year)]
  skip_if(length(valid_years) == 0, message = "No non-NA year values to check")
  expect_true(all(valid_years >= 1400 & valid_years <= 2025),
    info = "After correcting outliers in Exercise 13, all years should be between 1400 and 2025"
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
