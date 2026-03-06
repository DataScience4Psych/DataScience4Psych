# Part 1: Getting to know the data

test_that("Ex 1: evals object exists", {
  expect_true(exists("evals"),
              info = "Load the evals dataset from the openintro package")
})

test_that("Ex 1: evals has 463 observations", {
  skip_if(!exists("evals"))
  expect_equal(nrow(evals), 463,
               info = "Make sure evals has 463 observations — load the full dataset")
})

test_that("Ex 1: evals has expected key variables", {
  skip_if(!exists("evals"))
  expected_cols <- c("score", "bty_avg", "gender", "rank", "age")
  expect_true(all(expected_cols %in% names(evals)),
              info = "Ensure evals has score, bty_avg, gender, rank, and age columns")
})

test_that("Ex 1: score variable is numeric and within valid range", {
  skip_if(!exists("evals"))
  skip_if(!"score" %in% names(evals))
  expect_true(is.numeric(evals$score),
              info = "Ensure score is a numeric variable")
  expect_true(all(evals$score >= 1 & evals$score <= 5),
              info = "Ensure score values are between 1 and 5")
})

test_that("Ex 1: score distribution is left-skewed (most scores near top)", {
  skip_if(!exists("evals"))
  skip_if(!"score" %in% names(evals))
  expect_true(median(evals$score) > mean(evals$score),
              info = "Check that the score distribution is left-skewed (median > mean)")
})

test_that("Ex 1: Rmd Exercise 1 reports evals dimensions or uses exploration code", {
  skip_if(length(.rmd_content) == 0)
  skip_if(!exists("evals"))
  solution_nrow <- nrow(evals)
  potential_answers <- c(as.character(solution_nrow), "nrow\\(", "dim\\(", "str\\(", "glimpse\\(", "skim\\(")
  pattern <- paste0("(", paste(potential_answers, collapse = "|"), ")")
  answer_in_rmd <- stringr::str_detect(.rmd_content, pattern) |> any()
  expect_equal(answer_in_rmd, TRUE,
               info = sprintf("Report the number of observations (%d) or use exploration code like nrow(), dim(), str(), or glimpse() in your Rmd", solution_nrow))
})
