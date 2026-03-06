# Exercises 10-15: Analysis of the Edinburgh art collection

test_that("Ex 10: Rmd uses separate() to split title and date", {
  skip_if(length(.rmd_content) == 0)
  potential_answers <- c(
    "separate\\(",
    "separate_wider"
  )
  pattern <- paste0("(", paste(potential_answers, collapse = "|"), ")")
  answer_in_rmd <- stringr::str_detect(.rmd_content, pattern) |> any()
  expect_equal(answer_in_rmd, TRUE,
    info = "Ex 10: Use separate() to split the title column into title and date"
  )
})

test_that("Ex 10: uoe_art has year column after cleaning", {
  skip_if(!exists("uoe_art"))
  expect_true(
    "year" %in% names(uoe_art),
    label = "uoe_art should have a year column after data cleaning"
  )
})

test_that("Ex 12: Rmd creates histogram of years", {
  skip_if(length(.rmd_content) == 0)
  has_hist <- stringr::str_detect(.rmd_content, "geom_histogram") |> any()
  has_year <- stringr::str_detect(.rmd_content, "year") |> any()
  expect_true(has_hist && has_year,
    label = "Ex 12: Create a histogram of the year variable using geom_histogram()"
  )
})

test_that("Ex 14: Rmd identifies most commonly featured artist", {
  skip_if(length(.rmd_content) == 0)
  potential_answers <- c(
    "count.*artist",
    "table.*artist",
    "arrange.*desc.*n"
  )
  pattern <- paste0("(", paste(potential_answers, collapse = "|"), ")")
  answer_in_rmd <- stringr::str_detect(.rmd_content, pattern) |> any()
  expect_equal(answer_in_rmd, TRUE,
    info = "Ex 14: Count artist occurrences to identify the most featured artist"
  )
})

test_that("Ex 15: Rmd counts art pieces with 'child' in the title", {
  skip_if(length(.rmd_content) == 0)
  potential_answers <- c(
    "str_detect.*child",
    "grepl.*child",
    "filter.*child"
  )
  pattern <- paste0("(", paste(potential_answers, collapse = "|"), ")")
  answer_in_rmd <- stringr::str_detect(.rmd_content, pattern) |> any()
  expect_equal(answer_in_rmd, TRUE,
    info = "Ex 15: Use str_detect() or filter() to count pieces with 'child' in the title"
  )
})
