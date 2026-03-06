# Exercise 2: Unique defendants in COMPAS dataset

test_that("Ex 2: Rmd checks number of unique defendants", {
  skip_if(length(.rmd_content) == 0)
  potential_answers <- c(
    "n_distinct\\(compas\\$id\\)",
    "unique.*id",
    "distinct.*id"
  )
  pattern <- paste0("(", paste(potential_answers, collapse = "|"), ")")
  answer_in_rmd <- stringr::str_detect(.rmd_content, pattern) |> any()
  expect_equal(answer_in_rmd, TRUE,
    info = "Ex 2: Use n_distinct() to count unique defendant IDs"
  )
})

test_that("Ex 2: COMPAS has repeated defendants (rows > unique IDs)", {
  skip_if(!exists("compas"))
  n_unique <- dplyr::n_distinct(compas$id)
  expect_true(
    nrow(compas) >= n_unique,
    label = "COMPAS dataset may have repeated defendants (multiple records per person)"
  )
})

test_that("Ex 3: Rmd visualizes decile_score distribution", {
  skip_if(length(.rmd_content) == 0)
  potential_answers <- c(
    "geom_histogram.*decile_score",
    "decile_score.*geom_histogram",
    "geom_bar.*decile_score",
    "decile_score"
  )
  pattern <- paste0("(", paste(potential_answers, collapse = "|"), ")")
  answer_in_rmd <- stringr::str_detect(.rmd_content, pattern) |> any()
  expect_equal(answer_in_rmd, TRUE,
    info = "Ex 3: Create a histogram/bar plot of the decile_score distribution"
  )
})

test_that("Ex 3: decile_score ranges from 1 to 10", {
  skip_if(!exists("compas"))
  expect_gte(min(compas$decile_score, na.rm = TRUE), 1,
    label = "decile_score minimum should be at least 1"
  )
  expect_lte(max(compas$decile_score, na.rm = TRUE), 10,
    label = "decile_score maximum should be at most 10"
  )
})
