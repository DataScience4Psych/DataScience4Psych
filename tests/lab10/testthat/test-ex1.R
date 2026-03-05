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
