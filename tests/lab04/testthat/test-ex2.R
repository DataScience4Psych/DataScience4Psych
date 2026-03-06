# Exercise 2: Dimensions of the La Quinta dataset

test_that("Ex 2: laquinta / lq object exists in student environment", {
  skip_if(length(.rmd_content) == 0)
  potential_answers <- c(
    "laquinta",
    "lq\\s*<-",
    "lq\\s*="
  )
  pattern <- paste0("(", paste(potential_answers, collapse = "|"), ")")
  answer_in_rmd <- stringr::str_detect(.rmd_content, pattern) |> any()
  expect_equal(answer_in_rmd, TRUE,
    info = "Make sure to load the laquinta dataset in your Rmd"
  )
})

test_that("Ex 2: lq has more than 800 rows", {
  skip_if(!exists("lq"))
  expect_gt(nrow(lq), 800,
    label = "lq (La Quinta) should have more than 800 rows"
  )
})

test_that("Ex 2: lq has address, city, state, zip, longitude, latitude", {
  skip_if(!exists("lq"))
  expected_vars <- c("address", "city", "state", "zip", "longitude", "latitude")
  expect_true(
    all(expected_vars %in% names(lq)),
    label = paste("lq should contain columns:", paste(expected_vars, collapse = ", "))
  )
})

test_that("Ex 2: Rmd reports La Quinta dimensions using inline code", {
  skip_if(length(.rmd_content) == 0)
  potential_answers <- c(
    "nrow\\(lq\\)",
    "ncol\\(lq\\)",
    "dim\\(lq\\)",
    "nrow\\(laquinta\\)",
    "ncol\\(laquinta\\)"
  )
  pattern <- paste0("(", paste(potential_answers, collapse = "|"), ")")
  answer_in_rmd <- stringr::str_detect(.rmd_content, pattern) |> any()
  expect_equal(answer_in_rmd, TRUE,
    info = "Ex 2: Use inline code (nrow/ncol) to report La Quinta dataset dimensions"
  )
})
