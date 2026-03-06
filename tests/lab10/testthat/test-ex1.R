# Part 1: Getting to know the data

test_that("Ex 1: evals object exists", {
  expect_true(exists("evals"),
              label = "evals should be loaded from the openintro package")
})

test_that("Ex 1: evals has 463 observations", {
  skip_if(!exists("evals"))
  expect_equal(nrow(evals), 463,
               label = "evals should have 463 observations")
})

test_that("Ex 1: evals has expected key variables", {
  skip_if(!exists("evals"))
  expected_cols <- c("score", "bty_avg", "gender", "rank", "age")
  expect_true(all(expected_cols %in% names(evals)),
              label = "evals should have score, bty_avg, gender, rank, and age columns")
})

test_that("Ex 1: score variable is numeric and within valid range", {
  skip_if(!exists("evals"))
  skip_if(!"score" %in% names(evals))
  expect_true(is.numeric(evals$score),
              label = "score should be numeric")
  expect_true(all(evals$score >= 1 & evals$score <= 5),
              label = "score values should be between 1 and 5")
})

test_that("Ex 1: score distribution is left-skewed (most scores near top)", {
  skip_if(!exists("evals"))
  skip_if(!"score" %in% names(evals))
  expect_true(median(evals$score) > mean(evals$score),
              label = "Score distribution should be left-skewed (median > mean)")
})

test_that("Ex 1: Rmd Exercise 1 reports evals dimensions or uses exploration code", {
  skip_if(length(.rmd_content) == 0)
  skip_if(!exists("evals"))
  section <- .find_ex_section(.rmd_content, "1", "2")
  skip_if(is.null(section), "Could not locate Exercise 1 section in Rmd")
  solution_nrow <- nrow(evals)
  has_value <- any(grepl(as.character(solution_nrow), section))
  has_code <- any(grepl("nrow\\(|dim\\(|str\\(|glimpse\\(|skim\\(", section))
  expect_true(has_value || has_code,
              label = sprintf("Exercise 1 should report %d observations or use exploration code", solution_nrow))
})
