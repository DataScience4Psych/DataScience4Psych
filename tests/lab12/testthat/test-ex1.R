# Exercise 1: Explore ncbirths dataset

test_that("Ex 1: ncbirths data exists", {
  skip_if(length(.rmd_content) == 0)
  potential_answers <- c(
    "data\\(ncbirths\\)",
    "ncbirths",
    "library\\(openintro\\)"
  )
  pattern <- paste0("(", paste(potential_answers, collapse = "|"), ")")
  answer_in_rmd <- stringr::str_detect(.rmd_content, pattern) |> any()
  expect_equal(answer_in_rmd, TRUE,
    info = "Make sure to load the ncbirths dataset from the openintro package"
  )
})

test_that("Ex 1: ncbirths has expected variables", {
  skip_if(!requireNamespace("openintro", quietly = TRUE))
  data("ncbirths", package = "openintro", envir = environment())
  ncb <- get("ncbirths", envir = environment())
  expected_vars <- c("fage", "mage", "weeks", "weight", "habit", "whitemom")
  expect_true(
    all(expected_vars %in% names(ncb)),
    label = paste("ncbirths should contain columns:", paste(expected_vars, collapse = ", "))
  )
})

test_that("Ex 1: Rmd reports ncbirths dimensions using inline code", {
  skip_if(length(.rmd_content) == 0)
  potential_answers <- c(
    "nrow\\(ncbirths\\)",
    "ncol\\(ncbirths\\)",
    "dim\\(ncbirths\\)"
  )
  pattern <- paste0("(", paste(potential_answers, collapse = "|"), ")")
  answer_in_rmd <- stringr::str_detect(.rmd_content, pattern) |> any()
  expect_equal(answer_in_rmd, TRUE,
    info = "Ex 1: Report ncbirths dimensions using inline code"
  )
})

test_that("Ex 1: Rmd includes distribution plots of numeric variables", {
  skip_if(length(.rmd_content) == 0)
  potential_answers <- c(
    "geom_histogram",
    "geom_density",
    "geom_boxplot"
  )
  pattern <- paste0("(", paste(potential_answers, collapse = "|"), ")")
  answer_in_rmd <- stringr::str_detect(.rmd_content, pattern) |> any()
  expect_equal(answer_in_rmd, TRUE,
    info = "Ex 1: Include distribution plots (histogram/density) of the numeric variables"
  )
})
