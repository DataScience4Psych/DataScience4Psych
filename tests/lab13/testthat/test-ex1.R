# Exercise 1: Simulating colonist attributes

test_that("Ex 1.1: df_colonists data frame exists", {
  expect_true(exists("df_colonists"),
    info = "df_colonists should be created with colonist data"
  )
})

test_that("Ex 1.1: df_colonists is a data frame", {
  skip_if(!exists("df_colonists"))
  expect_true(is.data.frame(df_colonists),
    info = "df_colonists should be a data frame"
  )
})

test_that("Ex 1.1: df_colonists has 100 rows", {
  skip_if(!exists("df_colonists"))
  expect_equal(nrow(df_colonists), 100,
    info = "df_colonists should have 100 rows (one per colonist)"
  )
})

test_that("Ex 1.1: df_colonists has id column", {
  skip_if(!exists("df_colonists"))
  expect_true("id" %in% names(df_colonists),
    info = "df_colonists should have an id column"
  )
})

test_that("Ex 1.1: id column contains values 1 through 100", {
  skip_if(!exists("df_colonists"))
  id_var_name <- c("id", "ID", "iD")

  skip_if(!any(id_var_name %in% names(df_colonists)))
  expect_equal(sort(df_colonists$id), 1:100,
    info = "id should contain values 1 through 100"
  )
})

test_that("Ex 1.1: df_colonists has age column", {
  skip_if(!exists("df_colonists"))

  age_var_name <- c("age", "AGE")
  expect_true(any(age_var_name %in% names(df_colonists)),
    info = "df_colonists should have an age column"
  )
})

test_that("Ex 1.1: age is numeric", {
  skip_if(!exists("df_colonists"))
  skip_if(!"age" %in% names(df_colonists))
  expect_true(is.numeric(df_colonists$age),
    info = "age should be a numeric variable"
  )
})

test_that("Ex 1.1: age is approximately normally distributed around 30", {
  skip_if(!exists("df_colonists"))
  skip_if(!"age" %in% names(df_colonists))
  m <- mean(df_colonists$age)
  expect_true(m > 25 && m < 35,
    info = sprintf("Mean age should be near 30, got %.1f", m)
  )
})

test_that("Ex 1.1: age has standard deviation near 5", {
  skip_if(!exists("df_colonists"))
  skip_if(!"age" %in% names(df_colonists))
  s <- sd(df_colonists$age)
  expect_true(s > 2 && s < 10,
    info = sprintf("SD of age should be near 5, got %.1f", s)
  )
})

test_that("Ex 1.3: role variable exists in df_colonists", {
  skip_if(!exists("df_colonists"))
  expect_true("role" %in% names(df_colonists),
    info = "df_colonists should have a role column"
  )
})

test_that("Ex 1.3: role contains engineer, scientist, and medic", {
  skip_if(!exists("df_colonists"))
  skip_if(!"role" %in% names(df_colonists))
  roles <- unique(df_colonists$role)
  expected_roles <- c("engineer", "scientist", "medic")
  expect_true(all(expected_roles %in% roles),
    info = "role should contain engineer, scientist, and medic"
  )
})

test_that("Ex 1.3: all rows have a valid role assigned", {
  skip_if(!exists("df_colonists"))
  skip_if(!"role" %in% names(df_colonists))
  expect_true(sum(is.na(df_colonists$role)) == 0,
    info = "No colonist should have a missing role"
  )
})

test_that("Ex 1.4: marsgar variable exists in df_colonists", {
  skip_if(!exists("df_colonists"))
  expect_true("marsgar" %in% names(df_colonists),
    info = "df_colonists should have a marsgar (health) column"
  )
})

test_that("Ex 1.4: marsgar values are between 0 and 100", {
  skip_if(!exists("df_colonists"))
  skip_if(!"marsgar" %in% names(df_colonists))
  expect_true(all(df_colonists$marsgar >= 0 & df_colonists$marsgar <= 100),
    info = "MARSGAR scores should be between 0 and 100"
  )
})

test_that("Ex 1.4: marsgar is numeric", {
  skip_if(!exists("df_colonists"))
  skip_if(!"marsgar" %in% names(df_colonists))
  expect_true(is.numeric(df_colonists$marsgar),
    info = "marsgar should be numeric (from runif)"
  )
})
