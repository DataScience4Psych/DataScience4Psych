# Exercise 3-4: Distribution of risk scores and demographics

test_that("Ex 3: decile_score ranges from 1 to 10", {
  skip_if(!exists("compas") || !"decile_score" %in% names(compas))
  scores <- compas$decile_score[!is.na(compas$decile_score)]
  expect_true(min(scores) >= 1 && max(scores) <= 10,
              label = "COMPAS decile scores should range from 1 to 10")
})

test_that("Ex 3: histogram of risk scores can be created", {
  skip_if(!exists("compas") || !"decile_score" %in% names(compas))
  p <- ggplot2::ggplot(compas, ggplot2::aes(x = decile_score)) +
    ggplot2::geom_histogram(binwidth = 1)
  expect_s3_class(p, "ggplot")
})

test_that("Ex 4: multiple racial groups exist in the data", {
  skip_if(!exists("compas") || !"race" %in% names(compas))
  n_races <- dplyr::n_distinct(compas$race)
  expect_true(n_races >= 3,
              label = "There should be at least 3 racial groups in the data")
})

test_that("Ex 4: both sexes are represented", {
  skip_if(!exists("compas") || !"sex" %in% names(compas))
  n_sex <- dplyr::n_distinct(compas$sex)
  expect_equal(n_sex, 2)
})
