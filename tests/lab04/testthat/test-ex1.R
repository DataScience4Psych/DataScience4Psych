# Exercise 1: Dimensions of the Denny's dataset

test_that("Ex 1: dennys / dn object exists in student environment", {
  skip_if(length(.rmd_content) == 0)
  potential_answers <- c(
    "library\\(dsbox\\)",
    "dennys",
    "dn\\s*<-",
    "dn\\s*="
  )
  pattern <- paste0("(", paste(potential_answers, collapse = "|"), ")")
  answer_in_rmd <- stringr::str_detect(.rmd_content, pattern) |> any()
  expect_equal(answer_in_rmd, TRUE,
    info = "Make sure to load the dennys dataset in your Rmd"
  )
})

test_that("Ex 1: dn has more than 1000 rows", {
  skip_if(!exists("dn"))
  expect_gt(nrow(dn), 1000,
    label = "dn (Denny's) should have more than 1000 rows"
  )
})

test_that("Ex 1: dn has address, city, state, zip, longitude, latitude", {
  skip_if(!exists("dn"))
  expected_vars <- c("address", "city", "state", "zip", "longitude", "latitude")
  expect_true(
    all(expected_vars %in% names(dn)),
    label = paste("dn should contain columns:", paste(expected_vars, collapse = ", "))
  )
})

test_that("Ex 1: Rmd reports Denny's dimensions using inline code", {
  skip_if(length(.rmd_content) == 0)
  potential_answers <- c(
    "nrow\\(dn\\)",
    "ncol\\(dn\\)",
    "dim\\(dn\\)",
    "nrow\\(dennys\\)",
    "ncol\\(dennys\\)"
  )
  pattern <- paste0("(", paste(potential_answers, collapse = "|"), ")")
  answer_in_rmd <- stringr::str_detect(.rmd_content, pattern) |> any()
  expect_equal(answer_in_rmd, TRUE,
    info = "Ex 1: Use inline code (nrow/ncol) to report Denny's dataset dimensions"
  )
})
