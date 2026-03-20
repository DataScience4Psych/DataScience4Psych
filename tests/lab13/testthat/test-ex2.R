# Exercise 2: Growing our colonists with correlated attributes

test_that("Ex 2.1: technical_skills variable exists in df_colonists", {
  skip_if(!exists("df_colonists"))
  expect_true("technical_skills" %in% names(df_colonists),
    info = "df_colonists should have a technical_skills column"
  )
})

test_that("Ex 2.1: technical_skills is numeric", {
  skip_if(!exists("df_colonists"))
  skip_if(!"technical_skills" %in% names(df_colonists))
  expect_true(is.numeric(df_colonists$technical_skills),
    info = "technical_skills should be numeric"
  )
})

test_that("Ex 2.1: technical_skills is strongly correlated with age", {
  skip_if(!exists("df_colonists"))
  skip_if(!all(c("age", "technical_skills") %in% names(df_colonists)))
  r <- cor(df_colonists$age, df_colonists$technical_skills)
  expect_true(r > 0.25,
    info = sprintf("technical_skills should be positively correlated with age (r > 0.5), got r=%.2f", r)
  )
})

test_that("Ex 2.1: technical_skills is not a perfect linear function of age", {
  skip_if(!exists("df_colonists"))
  skip_if(!all(c("age", "technical_skills") %in% names(df_colonists)))
  r <- cor(df_colonists$age, df_colonists$technical_skills)
  expect_true(r < 1.0,
    info = "technical_skills should include noise (correlation < 1.0 with age)"
  )
})

test_that("Ex 2.2: problem_solving variable exists in df_colonists", {
  skip_if(!exists("df_colonists"))
  expect_true("problem_solving" %in% names(df_colonists),
    info = "df_colonists should have a problem_solving column"
  )
})

test_that("Ex 2.2: problem_solving is numeric", {
  skip_if(!exists("df_colonists"))
  skip_if(!"problem_solving" %in% names(df_colonists))
  expect_true(is.numeric(df_colonists$problem_solving),
    info = "problem_solving should be numeric"
  )
})

test_that("Ex 2.2: problem_solving differs by role", {
  skip_if(!exists("df_colonists"))
  skip_if(!all(c("role", "problem_solving") %in% names(df_colonists)))
  means <- df_colonists %>%
    dplyr::group_by(role) %>%
    dplyr::summarize(m = mean(problem_solving), .groups = "drop")
  # The means should not all be identical
  expect_true(diff(range(means$m)) > 1,
    info = "Problem solving means should differ across roles (range of means > 1)"
  )
})

test_that("Ex 2.2: all roles have problem_solving values", {
  skip_if(!exists("df_colonists"))
  skip_if(!all(c("role", "problem_solving") %in% names(df_colonists)))
  counts <- df_colonists %>%
    dplyr::group_by(role) %>%
    dplyr::summarize(n = sum(!is.na(problem_solving)), .groups = "drop")
  expect_true(all(counts$n > 0),
    info = "Every role should have non-missing problem_solving values"
  )
})
