# Exercise 3: Simulate Big Five personality traits using mvrnorm

test_that("Ex 3: Rmd uses mvrnorm from MASS package", {
  skip_if(length(.rmd_content) == 0)
  potential_answers <- c(
    "mvrnorm",
    "MASS::mvrnorm",
    "library\\(MASS\\)"
  )
  pattern <- paste0("(", paste(potential_answers, collapse = "|"), ")")
  answer_in_rmd <- stringr::str_detect(.rmd_content, pattern) |> any()
  expect_equal(answer_in_rmd, TRUE,
    info = "Ex 3: Use mvrnorm() from the MASS package to simulate correlated traits"
  )
})

test_that("Ex 3: traits_data or df_colonists has resilience and agreeableness columns", {
  skip_if(!exists("df_colonists"))
  has_resilience <- "resilience" %in% names(df_colonists)
  has_traits_data <- exists("traits_data")
  expect_true(
    has_resilience || has_traits_data,
    label = "df_colonists should have resilience (and agreeableness) columns from mvrnorm simulation"
  )
})

test_that("Ex 3: Rmd defines a covariance or correlation matrix", {
  skip_if(length(.rmd_content) == 0)
  potential_answers <- c(
    "matrix\\(",
    "cov_matrix",
    "Sigma",
    "cor_matrix"
  )
  pattern <- paste0("(", paste(potential_answers, collapse = "|"), ")")
  answer_in_rmd <- stringr::str_detect(.rmd_content, pattern) |> any()
  expect_equal(answer_in_rmd, TRUE,
    info = "Ex 3: Define a covariance or correlation matrix (Sigma) for mvrnorm"
  )
})

test_that("Ex 3: resilience and agreeableness are positively correlated", {
  skip_if(!exists("df_colonists"))
  skip_if(!all(c("resilience", "agreeableness") %in% names(df_colonists)))
  r <- cor(df_colonists$resilience, df_colonists$agreeableness, use = "complete.obs")
  expect_gt(r, 0,
    label = sprintf(
      "resilience and agreeableness should be positively correlated (r > 0), got r = %.3f",
      r
    )
  )
})

test_that("Ex 3: traits_data or Big Five simulation has 100 rows", {
  skip_if(!exists("traits_data"))
  expect_equal(nrow(traits_data), 100,
    info = "traits_data should have 100 rows (one per colonist)"
  )
})
