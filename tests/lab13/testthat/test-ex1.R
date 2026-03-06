# Exercise 1: Simulate colonist basic attributes

test_that("Ex 1: Rmd uses set.seed for reproducibility", {
  skip_if(length(.rmd_content) == 0)
  answer_in_rmd <- stringr::str_detect(.rmd_content, "set\\.seed") |> any()
  expect_equal(answer_in_rmd, TRUE,
    info = "Ex 1: Use set.seed() for reproducibility in your simulation"
  )
})

test_that("Ex 1: df_colonists data frame exists", {
  expect_true(exists("df_colonists"),
    label = "df_colonists should be a data frame of simulated colonist attributes"
  )
})

test_that("Ex 1: df_colonists has 100 rows", {
  skip_if(!exists("df_colonists"))
  expect_equal(nrow(df_colonists), 100,
    info = "df_colonists should have 100 rows (one per colonist)"
  )
})

test_that("Ex 1: df_colonists has id and age columns", {
  skip_if(!exists("df_colonists"))
  expect_true(
    all(c("id", "age") %in% names(df_colonists)),
    label = "df_colonists should have 'id' and 'age' columns"
  )
})

test_that("Ex 1: age distribution is approximately normal with mean ~30", {
  skip_if(!exists("df_colonists"))
  skip_if(!("age" %in% names(df_colonists)))
  mean_age <- mean(df_colonists$age, na.rm = TRUE)
  expect_true(
    mean_age > 22 && mean_age < 38,
    label = sprintf("Mean age should be near 30 (within 8 years), got %.1f", mean_age)
  )
})

test_that("Ex 1: Rmd uses rnorm to simulate age", {
  skip_if(length(.rmd_content) == 0)
  answer_in_rmd <- stringr::str_detect(.rmd_content, "rnorm") |> any()
  expect_equal(answer_in_rmd, TRUE,
    info = "Ex 1: Use rnorm() to generate ages from a normal distribution"
  )
})
