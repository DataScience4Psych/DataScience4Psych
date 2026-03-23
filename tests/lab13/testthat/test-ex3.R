# Exercise 3: Exploring correlations with mvrnorm

test_that("Ex 3.2: resilience variable exists in df_colonists", {
  skip_if(!exists("df_colonists"))
  expect_true("resilience" %in% names(df_colonists),
    info = "df_colonists should have a resilience column"
  )
})

test_that("Ex 3.2: agreeableness variable exists in df_colonists", {
  skip_if(!exists("df_colonists"))
  expect_true("agreeableness" %in% names(df_colonists),
    info = "df_colonists should have an agreeableness column"
  )
})

test_that("Ex 3.2: resilience and agreeableness are numeric", {
  skip_if(!exists("df_colonists"))
  skip_if(!all(c("resilience", "agreeableness") %in% names(df_colonists)))
  expect_true(is.numeric(df_colonists$resilience),
    info = "resilience should be numeric"
  )
  expect_true(is.numeric(df_colonists$agreeableness),
    info = "agreeableness should be numeric"
  )
})

test_that("Ex 3.2: resilience and agreeableness are positively correlated", {
  skip_if(!exists("df_colonists"))
  skip_if(!all(c("resilience", "agreeableness") %in% names(df_colonists)))
  r <- cor(df_colonists$resilience, df_colonists$agreeableness)
  expect_true(r > 0,
    info = sprintf("Resilience and agreeableness should be positively correlated, got r=%.2f", r)
  )
})

test_that("Ex 3.2: resilience and agreeableness have 100 values each", {
  skip_if(!exists("df_colonists"))
  skip_if(!all(c("resilience", "agreeableness") %in% names(df_colonists)))
  expect_equal(sum(!is.na(df_colonists$resilience)), 100,
    info = "resilience should have 100 non-NA values"
  )
  expect_equal(sum(!is.na(df_colonists$agreeableness)), 100,
    info = "agreeableness should have 100 non-NA values"
  )
})

test_that("Ex 3.3: Big Five traits are simulated in df_colonists", {
  skip_if(!exists("df_colonists"))
  bigfive_cols <- c("EX", "ES", "AG", "CO", "OP")
  has_bigfive <- all(bigfive_cols %in% names(df_colonists))
  # Some students may use lowercase or full names
  if (!has_bigfive) {
    bigfive_lower <- c("ex", "es", "ag", "co", "op")
    has_bigfive <- all(bigfive_lower %in% tolower(names(df_colonists)))
  }
  if (!has_bigfive) {
    bigfive_full <- c(
      "extraversion", "emotional_stability", "agreeableness",
      "conscientiousness", "openness"
    )
    has_bigfive <- sum(tolower(names(df_colonists)) %in% bigfive_full) >= 5
  }
  expect_true(has_bigfive,
    info = "Big Five personality traits (EX, ES, AG, CO, OP) should be simulated in df_colonists"
  )
})

test_that("Ex 3.3: Big Five traits are numeric", {
  skip_if(!exists("df_colonists"))
  bigfive_cols <- c("EX", "ES", "AG", "CO", "OP")
  skip_if(!all(bigfive_cols %in% names(df_colonists)),
    message = "Big Five columns (EX, ES, AG, CO, OP) not found"
  )
  for (col in bigfive_cols) {
    expect_true(is.numeric(df_colonists[[col]]),
      info = sprintf("%s should be numeric", col)
    )
  }
})

test_that("Ex 3.3: Big Five traits have some correlation structure", {
  skip_if(!exists("df_colonists"))
  bigfive_cols <- c("EX", "ES", "AG", "CO", "OP")
  skip_if(!all(bigfive_cols %in% names(df_colonists)),
    message = "Big Five columns not found"
  )
  cor_mat <- cor(df_colonists[, bigfive_cols])
  # Off-diagonal elements should not all be zero (mvrnorm with non-identity sigma)
  off_diag <- cor_mat[upper.tri(cor_mat)]
  expect_true(any(abs(off_diag) > 0.05),
    info = "Big Five traits should show some correlation structure (from mvrnorm)"
  )
})
