# Exercises 4-10: Whickham smoking data (stretch goals / Simpson's Paradox)

test_that("Ex 4: Whickham object exists", {
  expect_true(exists("Whickham"),
              info ="Whickham should be loaded from the mosaicData package"
  )
})

test_that("Ex 4: Whickham has 1314 observations", {
  skip_if(!exists("Whickham"))
  expect_equal(nrow(Whickham), 1314,
               info ="Whickham should have 1314 observations")
})

test_that("Ex 4: Whickham has 3 variables (outcome, smoker, age)", {
  skip_if(!exists("Whickham"))
  expect_equal(ncol(Whickham), 3,
               info ="Whickham should have 3 variables")
  expect_true(all(c("outcome", "smoker", "age") %in% names(Whickham)),
              info ="Whickham should contain outcome, smoker, and age columns")
})

test_that("Ex 5: outcome is a factor with levels Alive and Dead", {
  skip_if(!exists("Whickham") || !"outcome" %in% names(Whickham))
  expect_true(is.factor(Whickham$outcome),
              info ="outcome should be a factor variable")
  expect_true(all(c("Alive", "Dead") %in% levels(Whickham$outcome)),
              info ="outcome should have levels Alive and Dead")
})

test_that("Ex 5: smoker is a factor with levels No and Yes", {
  skip_if(!exists("Whickham") || !"smoker" %in% names(Whickham))
  expect_true(is.factor(Whickham$smoker),
              info ="smoker should be a factor variable")
  expect_true(all(c("No", "Yes") %in% levels(Whickham$smoker)),
              info ="smoker should have levels No and Yes")
})

test_that("Ex 6: age variable is numeric", {
  skip_if(!exists("Whickham") || !"age" %in% names(Whickham))
  expect_true(is.numeric(Whickham$age),
              info ="age should be a numeric variable")
})

test_that("Ex 9: age_cat variable exists in Whickham data", {
  has_age_cat <- exists("Whickham") && "age_cat" %in% names(Whickham)
  expect_true(has_age_cat,
              info ="Whickham should have an age_cat column created with case_when or cut"
  )
})

test_that("Ex 9: age_cat has exactly 3 levels", {
  skip_if(!exists("Whickham") || !"age_cat" %in% names(Whickham))
  n_cats <- dplyr::n_distinct(Whickham$age_cat, na.rm = TRUE)
  expect_equal(n_cats, 3,
               info ="age_cat should have 3 categories (e.g. 18-44, 45-64, 65+)")
})

test_that("Ex 9: age_cat categories correctly partition ages", {
  skip_if(!exists("Whickham") || !"age_cat" %in% names(Whickham))
  cats <- sort(unique(as.character(Whickham$age_cat)))
  expect_true(length(cats) == 3,
              info ="age_cat should have exactly 3 unique values")
  # Verify the youngest category contains only ages <= 44
  young_ages <- Whickham$age[Whickham$age_cat == cats[1]]
  expect_true(all(young_ages <= 44, na.rm = TRUE),
              info ="The youngest age_cat group should contain ages up to 44")
})

test_that("Ex 9: no NA values in age_cat", {
  skip_if(!exists("Whickham") || !"age_cat" %in% names(Whickham))
  expect_true(sum(is.na(Whickham$age_cat)) == 0,
              info ="age_cat should have no missing values -- every observation should be categorized")
})
