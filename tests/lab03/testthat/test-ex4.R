# Exercise 4: born_country_us variable

test_that("Ex 4: Rmd creates born_country_us variable", {
  skip_if(length(.rmd_content) == 0)
  potential_answers <- c(
    "born_country_us",
    "born_country.*USA",
    "if_else.*born_country"
  )
  pattern <- paste0("(", paste(potential_answers, collapse = "|"), ")")
  answer_in_rmd <- stringr::str_detect(.rmd_content, pattern) |> any()
  expect_equal(answer_in_rmd, TRUE,
    info = "Ex 4: Create a born_country_us variable indicating if laureate was born in USA"
  )
})

test_that("Ex 4: nobel_living has born_country_us variable", {
  skip_if(!exists("nobel_living"))
  expect_true(
    "born_country_us" %in% names(nobel_living),
    label = "nobel_living should have a born_country_us column after Ex 4"
  )
})

test_that("Ex 4: born_country_us contains only USA and Other", {
  skip_if(!exists("nobel_living"))
  skip_if(!("born_country_us" %in% names(nobel_living)))
  valid_vals <- c("USA", "Other")
  expect_true(
    all(nobel_living$born_country_us %in% valid_vals),
    label = "born_country_us should only contain 'USA' or 'Other'"
  )
})

test_that("Ex 4: Rmd reports how many winners were born in the US", {
  skip_if(length(.rmd_content) == 0)
  potential_answers <- c(
    "born_country_us.*USA",
    "sum.*born_country_us",
    "count.*born_country"
  )
  pattern <- paste0("(", paste(potential_answers, collapse = "|"), ")")
  answer_in_rmd <- stringr::str_detect(.rmd_content, pattern) |> any()
  expect_equal(answer_in_rmd, TRUE,
    info = "Ex 4: Report how many laureates were born in the US"
  )
})
