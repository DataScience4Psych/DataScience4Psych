# Part 1: Getting to know the outcome

test_that("Ex 1: evals data is available from openintro", {
  skip_if(!requireNamespace("openintro", quietly = TRUE),
          message = "openintro package not available")
  data("evals", package = "openintro")
  expect_true(nrow(evals) > 0)
})

test_that("Ex 1: evals has expected key variables", {
  skip_if(!requireNamespace("openintro", quietly = TRUE))
  data("evals", package = "openintro")
  expected_cols <- c("score", "bty_avg", "gender", "rank", "age")
  expect_true(all(expected_cols %in% names(evals)),
              label = "evals should have score, bty_avg, gender, rank, age")
})

test_that("Ex 1: score distribution is left-skewed (most scores near top)", {
  skip_if(!requireNamespace("openintro", quietly = TRUE))
  data("evals", package = "openintro")
  expect_true(median(evals$score) > mean(evals$score),
              label = "Score distribution should be left-skewed (median > mean)")
})

test_that("Ex 2: scatterplot of score vs bty_avg can be created", {
  skip_if(!requireNamespace("openintro", quietly = TRUE))
  data("evals", package = "openintro")
  p <- ggplot2::ggplot(evals, ggplot2::aes(x = bty_avg, y = score)) +
    ggplot2::geom_point()
  expect_s3_class(p, "ggplot")
})

test_that("Ex 3: jittered scatterplot can be created", {
  skip_if(!requireNamespace("openintro", quietly = TRUE))
  data("evals", package = "openintro")
  p <- ggplot2::ggplot(evals, ggplot2::aes(x = bty_avg, y = score)) +
    ggplot2::geom_jitter()
  expect_s3_class(p, "ggplot")
})
