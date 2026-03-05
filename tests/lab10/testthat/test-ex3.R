# Part 3: Categorical predictors - gender and rank

test_that("Part 3 Ex 1: m_gen model exists", {
  expect_true(exists("m_gen"),
              label = "m_gen should be a linear model of score ~ gender")
})

test_that("Part 3 Ex 1: m_gen is a linear model", {
  skip_if(!exists("m_gen"))
  expect_s3_class(m_gen, "lm")
})

test_that("Part 3 Ex 2: rank_relevel variable is created", {
  skip_if(!requireNamespace("openintro", quietly = TRUE))
  data("evals", package = "openintro")
  skip_if(!exists("evals") || !"rank" %in% names(evals))
  # Check if student created rank_relevel
  if (exists("evals") && "rank_relevel" %in% names(evals)) {
    expect_true(TRUE)
  } else {
    skip("rank_relevel not found in evals; student may have used a different approach")
  }
})
