# Exercise 10: Separating title from date and extracting year

test_that("Ex 10: uoe_art has a date or year column after title separation", {
  .art <- .find_art_df()
  skip_if(is.null(.art))
  has_date_or_year <- "date" %in% names(.art) || "year" %in% names(.art)
  expect_true(has_date_or_year,
    info = "Create a 'date' column by separating the title at '(' using separate() for Exercise 10, then extract 'year'"
  )
})

test_that("Ex 10: uoe_art has a year column", {
  .art <- .find_art_df()
  skip_if(is.null(.art))
  expect_true("year" %in% names(.art),
    info = "Extract a 'year' from the date column (e.g., using str_extract()) and save it as a new column"
  )
})

test_that("Ex 10: year column is numeric", {
  .art <- .find_art_df()
  skip_if(is.null(.art) || !"year" %in% names(.art))
  expect_true(is.numeric(.art$year),
    info = "Convert the 'year' column to numeric (e.g., using as.numeric())"
  )
})

test_that("Ex 10: title column has been cleaned (no parenthetical date info)", {
  .art <- .find_art_df()
  skip_if(is.null(.art) || !"title" %in% names(.art))
  titles <- .art$title[!is.na(.art$title)]
  skip_if(length(titles) == 0, message = "No non-NA titles to check")
  # After separate(), most titles should not contain '(' — date info should be in the date column
  pct_with_paren <- mean(grepl("\\(", titles))
  expect_true(pct_with_paren < 0.1,
    info = "After using separate(), the 'title' column should not contain parenthetical date info"
  )
})

test_that("Ex 10: some NA values exist in year column (expected for non-year dates)", {
  .art <- .find_art_df()
  skip_if(is.null(.art) || !"year" %in% names(.art))
  expect_true(any(is.na(.art$year)),
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
