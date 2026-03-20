# Exercise 2: Unique defendants in the COMPAS dataset

test_that("Ex 2: compas has an id column for identifying defendants", {
  skip_if(!exists("compas"))
  expect_true("id" %in% names(compas),
    info = "compas should have an id column identifying individual defendants"
  )
})

test_that("Ex 2: number of unique defendants is less than or equal to number of rows", {
  skip_if(!exists("compas"))
  skip_if(!"id" %in% names(compas))
  n_unique <- dplyr::n_distinct(compas$id)
  expect_true(n_unique <= nrow(compas),
    info = "The number of unique defendants should be <= number of rows (some defendants may appear more than once)"
  )
})

test_that("Ex 2: dataset has a substantial number of unique defendants (> 5000)", {
  skip_if(!exists("compas"))
  skip_if(!"id" %in% names(compas))
  n_unique <- dplyr::n_distinct(compas$id)
  expect_true(n_unique > 5000,
    info = "There should be thousands of unique defendants in the COMPAS dataset"
  )
})

test_that("Ex 2: Rmd Exercise 2 contains unique defendant analysis code", {
  skip_if(length(.rmd_content) == 0)
  potential_answers <- c("n_distinct", "unique\\(", "duplicated\\(", "length\\(unique", "distinct\\(")
  pattern <- paste0("(", paste(potential_answers, collapse = "|"), ")")
  answer_in_rmd <- stringr::str_detect(.rmd_content, pattern) |> any()
  expect_equal(answer_in_rmd, TRUE,
    info = "Include code to count unique defendants (e.g., n_distinct(compas$id)) in your Rmd"
  )
})
