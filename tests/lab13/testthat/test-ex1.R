# Exercise 1: Simulating colonist attributes

test_that("Ex 1.1: df_colonists data frame exists", {
  expect_true(exists("df_colonists"),
              label = "df_colonists should be created with colonist data")
})

test_that("Ex 1.1: df_colonists has 100 rows", {
  skip_if(!exists("df_colonists"))
  expect_equal(nrow(df_colonists), 100,
               label = "df_colonists should have 100 rows (one per colonist)")
})

test_that("Ex 1.1: df_colonists has id and age columns", {
  skip_if(!exists("df_colonists"))
  expect_true("id" %in% names(df_colonists),
              label = "df_colonists should have an id column")
  expect_true("age" %in% names(df_colonists),
              label = "df_colonists should have an age column")
})

test_that("Ex 1.1: age is approximately normally distributed around 30", {
  skip_if(!exists("df_colonists") || !"age" %in% names(df_colonists))
  m <- mean(df_colonists$age)
  expect_true(m > 25 && m < 35,
              label = sprintf("Mean age should be near 30, got %.1f", m))
})

test_that("Ex 1.3: role variable exists with expected categories", {
  skip_if(!exists("df_colonists"))
  expect_true("role" %in% names(df_colonists),
              label = "df_colonists should have a role column")
  skip_if(!"role" %in% names(df_colonists))
  roles <- unique(df_colonists$role)
  expected_roles <- c("engineer", "scientist", "medic")
  expect_true(all(expected_roles %in% roles),
              label = "role should contain engineer, scientist, and medic")
})

test_that("Ex 1.4: marsgar variable exists", {
  skip_if(!exists("df_colonists"))
  expect_true("marsgar" %in% names(df_colonists),
              label = "df_colonists should have a marsgar (health) column")
})

test_that("Ex 1.4: marsgar values are within plausible range", {
  skip_if(!exists("df_colonists") || !"marsgar" %in% names(df_colonists))
  expect_true(all(df_colonists$marsgar >= 0 & df_colonists$marsgar <= 100),
              label = "MARSGAR scores should be between 0 and 100")
})
