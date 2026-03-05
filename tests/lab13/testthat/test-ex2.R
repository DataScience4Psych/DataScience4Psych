# Exercise 2: Growing our colonists with correlated attributes

test_that("Ex 2.1: technical_skills variable exists", {
  skip_if(!exists("df_colonists"))
  expect_true("technical_skills" %in% names(df_colonists),
              label = "df_colonists should have a technical_skills column")
})

test_that("Ex 2.1: technical_skills is correlated with age", {
  skip_if(!exists("df_colonists"))
  skip_if(!all(c("age", "technical_skills") %in% names(df_colonists)))
  r <- cor(df_colonists$age, df_colonists$technical_skills)
  expect_true(r > 0.5,
              label = sprintf("technical_skills should be positively correlated with age, got r=%.2f", r))
})

test_that("Ex 2.2: problem_solving variable exists", {
  skip_if(!exists("df_colonists"))
  expect_true("problem_solving" %in% names(df_colonists),
              label = "df_colonists should have a problem_solving column")
})

test_that("Ex 2.2: problem_solving differs by role", {
  skip_if(!exists("df_colonists"))
  skip_if(!all(c("role", "problem_solving") %in% names(df_colonists)))
  means <- df_colonists %>%
    dplyr::group_by(role) %>%
    dplyr::summarize(m = mean(problem_solving), .groups = "drop")
  # The means should not all be identical
  expect_true(diff(range(means$m)) > 1,
              label = "Problem solving means should differ across roles")
})
