# Exercise 3: Exploring correlations with mvrnorm

test_that("Ex 3.2: resilience and agreeableness are simulated", {
  skip_if(!exists("df_colonists"))
  has_traits <- all(c("resilience", "agreeableness") %in% names(df_colonists))
  # Some students may store in a separate data frame
  expect_true(has_traits || exists("traits_data") || exists("simulated_data"),
              label = "Resilience and agreeableness should be simulated")
})

test_that("Ex 3.2: resilience and agreeableness are positively correlated", {
  skip_if(!exists("df_colonists"))
  skip_if(!all(c("resilience", "agreeableness") %in% names(df_colonists)))
  r <- cor(df_colonists$resilience, df_colonists$agreeableness)
  expect_true(r > 0,
              label = sprintf("Resilience and agreeableness should be positively correlated, got r=%.2f", r))
})

test_that("Ex 3.3: Big Five traits are simulated", {
  # Students may store Big Five in df_colonists or in simulated_data
  has_bigfive <- FALSE
  if (exists("df_colonists")) {
    bigfive_cols <- c("EX", "ES", "AG", "CO", "OP")
    has_bigfive <- all(bigfive_cols %in% names(df_colonists))
  }
  if (!has_bigfive && exists("simulated_data")) {
    if (is.data.frame(simulated_data)) {
      has_bigfive <- ncol(simulated_data) >= 5
    } else if (is.matrix(simulated_data)) {
      has_bigfive <- ncol(simulated_data) >= 5
    }
  }
  expect_true(has_bigfive,
              label = "Big Five personality traits should be simulated")
})
