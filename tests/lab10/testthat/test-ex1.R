# Part 1, Exercise 1: Distribution of score

test_that("Ex 1: evals data frame exists", {
  skip_if(length(.rmd_content) == 0)
  potential_answers <- c(
    "library\\(openintro\\)",
    "data\\(evals\\)",
    "evals"
  )
  pattern <- paste0("(", paste(potential_answers, collapse = "|"), ")")
  answer_in_rmd <- stringr::str_detect(.rmd_content, pattern) |> any()
  expect_equal(answer_in_rmd, TRUE,
    info = "Make sure to load the evals dataset from the openintro package"
  )
})

test_that("Ex 1: evals has score and bty_avg columns", {
  skip_if(!requireNamespace("openintro", quietly = TRUE))
  data("evals", package = "openintro", envir = environment())
  evals_sol <- get("evals", envir = environment())
  expected_vars <- c("score", "bty_avg", "gender", "rank", "ethnicity", "age")
  expect_true(
    all(expected_vars %in% names(evals_sol)),
    label = paste("evals should contain columns:", paste(expected_vars, collapse = ", "))
  )
})

test_that("Ex 1: Rmd visualizes distribution of score", {
  skip_if(length(.rmd_content) == 0)
  potential_answers <- c(
    "geom_histogram.*score",
    "score.*geom_histogram",
    "geom_density.*score",
    "score.*geom_density",
    "geom_boxplot.*score"
  )
  pattern <- paste0("(", paste(potential_answers, collapse = "|"), ")")
  answer_in_rmd <- stringr::str_detect(.rmd_content, pattern) |> any()
  expect_equal(answer_in_rmd, TRUE,
    info = "Ex 1: Visualize the distribution of score using a histogram or density plot"
  )
})

test_that("Ex 1: Rmd includes numerical summaries of score", {
  skip_if(length(.rmd_content) == 0)
  potential_answers <- c(
    "mean\\(.*score",
    "median\\(.*score",
    "summary\\(.*evals",
    "skim\\(.*evals"
  )
  pattern <- paste0("(", paste(potential_answers, collapse = "|"), ")")
  answer_in_rmd <- stringr::str_detect(.rmd_content, pattern) |> any()
  expect_equal(answer_in_rmd, TRUE,
    info = "Ex 1: Include numerical summaries (mean, median, etc.) of score"
  )
})
