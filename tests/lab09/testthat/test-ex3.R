# Exercise 3-4: Distribution of risk scores and demographics

test_that("Ex 3: compas object exists with decile_score", {
  skip_if(!exists("compas"),
          message = "compas must be loaded before testing risk scores")
  expect_true("decile_score" %in% names(compas),
              label = "compas should have a decile_score column")
})

test_that("Ex 3: decile_score is numeric", {
  skip_if(!exists("compas") || !"decile_score" %in% names(compas))
  expect_true(is.numeric(compas$decile_score),
              label = "decile_score should be numeric")
})

test_that("Ex 3: decile_score ranges from 1 to 10", {
  skip_if(!exists("compas") || !"decile_score" %in% names(compas))
  scores <- compas$decile_score[!is.na(compas$decile_score)]
  expect_true(min(scores) >= 1,
              label = "Minimum decile_score should be at least 1")
  expect_true(max(scores) <= 10,
              label = "Maximum decile_score should be at most 10")
})

test_that("Ex 3: decile_score uses all 10 levels", {
  skip_if(!exists("compas") || !"decile_score" %in% names(compas))
  n_unique <- dplyr::n_distinct(compas$decile_score, na.rm = TRUE)
  expect_equal(n_unique, 10,
               label = "decile_score should have 10 distinct values (1 through 10)")
})

test_that("Ex 4: race column exists with multiple groups", {
  skip_if(!exists("compas") || !"race" %in% names(compas))
  n_races <- dplyr::n_distinct(compas$race)
  expect_true(n_races >= 3,
              label = "There should be at least 3 racial groups in the data")
})

test_that("Ex 4: sex column exists with both groups", {
  skip_if(!exists("compas") || !"sex" %in% names(compas))
  n_sex <- dplyr::n_distinct(compas$sex)
  expect_equal(n_sex, 2,
               label = "There should be exactly 2 sex groups")
})
