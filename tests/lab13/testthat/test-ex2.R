# Exercise 2: Simulate colonist attributes based on relationships

test_that("Ex 2.1: df_colonists has technical_skills column", {
  skip_if(!exists("df_colonists"))
  expect_true(
    "technical_skills" %in% names(df_colonists),
    label = "df_colonists should have a technical_skills column"
  )
})

test_that("Ex 2.1: technical_skills correlates with age (r > 0.9)", {
  skip_if(!exists("df_colonists"))
  skip_if(!all(c("age", "technical_skills") %in% names(df_colonists)))
  r <- cor(df_colonists$age, df_colonists$technical_skills, use = "complete.obs")
  expect_gt(r, 0.9,
    label = sprintf(
      "technical_skills should strongly correlate with age (r > 0.9), got r = %.3f",
      r
    )
  )
})

test_that("Ex 2.2: df_colonists has problem_solving column", {
  skip_if(!exists("df_colonists"))
  expect_true(
    "problem_solving" %in% names(df_colonists),
    label = "df_colonists should have a problem_solving column"
  )
})

test_that("Ex 2.2: problem_solving differs by role", {
  skip_if(!exists("df_colonists"))
  skip_if(!all(c("role", "problem_solving") %in% names(df_colonists)))
  # Make sure problem_solving is not just a constant (1 = placeholder)
  role_means <- tapply(df_colonists$problem_solving, df_colonists$role, mean, na.rm = TRUE)
  expect_gt(diff(range(role_means)), 5,
    label = "problem_solving should differ by role (means should vary by more than 5 points)"
  )
})

test_that("Ex 2: Rmd uses rnorm to simulate attributes", {
  skip_if(length(.rmd_content) == 0)
  answer_in_rmd <- stringr::str_detect(.rmd_content, "rnorm") |> any()
  expect_equal(answer_in_rmd, TRUE,
    info = "Ex 2: Use rnorm() to simulate colonist attributes"
  )
})
