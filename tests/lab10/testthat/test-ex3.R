# Part 3: Categorical predictors - gender and rank

test_that("Ex 3: m_gen object exists", {
  expect_true(exists("m_gen"),
    info = "Create m_gen using lm(score ~ gender, data = evals)"
  )
})

test_that("Ex 3: m_gen is a linear model", {
  skip_if(!exists("m_gen"))
  expect_s3_class(m_gen, "lm")
})

test_that("Ex 3: m_gen has 2 coefficients (intercept + gender)", {
  skip_if(!exists("m_gen"))
  expect_equal(length(coef(m_gen)), 2,
    info = "Ensure m_gen has 2 coefficients: intercept and one gender level"
  )
})

test_that("Ex 3: m_gen uses gender as predictor", {
  skip_if(!exists("m_gen"))
  model_terms <- attr(terms(m_gen), "term.labels")
  expect_true("gender" %in% model_terms,
    info = "Use gender as the predictor variable in your m_gen model"
  )
})

test_that("Ex 3: rank_relevel variable is created in evals", {
  skip_if(!exists("evals"))
  expect_true("rank_relevel" %in% names(evals),
    info = "Create a rank_relevel column in evals by releveling the rank variable"
  )
})

test_that("Ex 3: rank_relevel is a factor with tenure track as reference", {
  skip_if(!exists("evals"))
  skip_if(!"rank_relevel" %in% names(evals))
  expect_true(is.factor(evals$rank_relevel),
    info = "Ensure rank_relevel is a factor variable"
  )
  expect_equal(levels(evals$rank_relevel)[1], "tenure track",
    info = "Set 'tenure track' as the reference level of rank_relevel"
  )
})

test_that("Ex 3: rank_relevel has same values as rank (just releveled)", {
  skip_if(!exists("evals"))
  skip_if(!all(c("rank", "rank_relevel") %in% names(evals)))
  expect_equal(sort(unique(as.character(evals$rank))),
    sort(unique(as.character(evals$rank_relevel))),
    info = "Ensure rank_relevel contains the same unique values as rank"
  )
})

test_that("Ex 3: tenure_eligible variable is created in evals", {
  skip_if(!exists("evals"))
  expect_true("tenure_eligible" %in% names(evals),
    info = "Create a tenure_eligible column in evals"
  )
})

test_that("Ex 3: tenure_eligible has two levels", {
  skip_if(!exists("evals"))
  skip_if(!"tenure_eligible" %in% names(evals))
  n_unique <- length(unique(evals$tenure_eligible))
  expect_equal(n_unique, 2,
    info = "Ensure tenure_eligible has exactly 2 unique values (yes/no or eligible/not)"
  )
})

# Part 3, Question 2: Fit three rank models
test_that("Ex 3.2: m_rank object exists (score ~ rank)", {
  has_rank_model <- exists("m_rank") || exists("model_rank") || exists("rank_model")
  expect_true(has_rank_model,
    info = "Create a model predicting score from rank (e.g., m_rank)"
  )
})

test_that("Ex 3.2: m_rank is a linear model using rank as predictor", {
  m <- NULL
  for (nm in c("m_rank", "model_rank", "rank_model")) {
    if (exists(nm) && inherits(get(nm), "lm")) {
      m <- get(nm)
      break
    }
  }
  skip_if(is.null(m), message = "No rank model found")
  expect_s3_class(m, "lm")
  model_terms <- attr(terms(m), "term.labels")
  expect_true("rank" %in% model_terms,
    info = "Use rank as the predictor variable in your rank model"
  )
})

test_that("Ex 3.2: m_rank has 3 coefficients (intercept + 2 rank dummies)", {
  m <- NULL
  for (nm in c("m_rank", "model_rank", "rank_model")) {
    if (exists(nm) && inherits(get(nm), "lm")) {
      m <- get(nm)
      break
    }
  }
  skip_if(is.null(m), message = "No rank model found")
  expect_equal(length(coef(m)), 3,
    info = "m_rank should have 3 coefficients: intercept and 2 rank dummies"
  )
})

test_that("Ex 3.2: m_rank_relevel object exists (score ~ rank_relevel)", {
  has_relevel_model <- exists("m_rank_relevel") || exists("model_rank_relevel") ||
    exists("rank_relevel_model")
  expect_true(has_relevel_model,
    info = "Create a model predicting score from rank_relevel (e.g., m_rank_relevel)"
  )
})

test_that("Ex 3.2: m_rank_relevel is a linear model using rank_relevel as predictor", {
  m <- NULL
  for (nm in c("m_rank_relevel", "model_rank_relevel", "rank_relevel_model")) {
    if (exists(nm) && inherits(get(nm), "lm")) {
      m <- get(nm)
      break
    }
  }
  skip_if(is.null(m), message = "No rank_relevel model found")
  expect_s3_class(m, "lm")
  model_terms <- attr(terms(m), "term.labels")
  expect_true("rank_relevel" %in% model_terms,
    info = "Use rank_relevel as the predictor variable in your releveled rank model"
  )
})

test_that("Ex 3.2: m_rank_relevel has 3 coefficients (intercept + 2 rank_relevel dummies)", {
  m <- NULL
  for (nm in c("m_rank_relevel", "model_rank_relevel", "rank_relevel_model")) {
    if (exists(nm) && inherits(get(nm), "lm")) {
      m <- get(nm)
      break
    }
  }
  skip_if(is.null(m), message = "No rank_relevel model found")
  expect_equal(length(coef(m)), 3,
    info = "m_rank_relevel should have 3 coefficients: intercept and 2 rank dummies"
  )
})

test_that("Ex 3.2: tenure_eligible model exists (score ~ tenure_eligible)", {
  has_elig_model <- exists("m_tenure_elig") || exists("m_tenure_eligible") ||
    exists("m_elig") || exists("model_tenure_elig") ||
    exists("tenure_elig_model")
  expect_true(has_elig_model,
    info = "Create a model predicting score from tenure_eligible (e.g., m_tenure_elig)"
  )
})

test_that("Ex 3.2: tenure_eligible model is a linear model with 2 coefficients", {
  m <- NULL
  for (nm in c(
    "m_tenure_elig", "m_tenure_eligible", "m_elig",
    "model_tenure_elig", "tenure_elig_model"
  )) {
    if (exists(nm) && inherits(get(nm), "lm")) {
      m <- get(nm)
      break
    }
  }
  skip_if(is.null(m), message = "No tenure_eligible model found")
  expect_s3_class(m, "lm")
  expect_equal(length(coef(m)), 2,
    info = "Tenure-eligible model should have 2 coefficients: intercept and one dummy"
  )
})

# Part 3, Question 3: Interpret slopes and intercepts
test_that("Ex 3.3: Rmd interprets rank model slopes and intercepts", {
  skip_if(length(.rmd_content) == 0)
  potential_answers <- c(
    "intercept", "Intercept", "slope", "coefficient",
    "teaching", "tenure track", "tenured", "tenure_track"
  )
  pattern <- paste0("(", paste(potential_answers, collapse = "|"), ")")
  answer_in_rmd <- stringr::str_detect(.rmd_content, pattern) |> any()
  expect_equal(answer_in_rmd, TRUE,
    info = "Interpret the slopes and intercepts of your rank models in your Rmd"
  )
})

# Part 3, Question 4: Report R-squared for rank models
test_that("Ex 3.4: Rmd reports R-squared for rank model(s)", {
  skip_if(length(.rmd_content) == 0)
  potential_answers <- c(
    "r.squared", "R.squared", "r\\^2", "R\\^2", "r2", "R2",
    "rsq", "r_sq", "r_squared"
  )
  pattern <- paste0("(", paste(potential_answers, collapse = "|"), ")")
  answer_in_rmd <- stringr::str_detect(.rmd_content, pattern) |> any()
  expect_equal(answer_in_rmd, TRUE,
    info = "Report the R-squared value for your rank model(s) and comment on explanatory power"
  )
})

test_that("Ex 3.4: rank models have small R-squared (rank is a weak predictor)", {
  m <- NULL
  for (nm in c(
    "m_rank", "model_rank", "rank_model",
    "m_rank_relevel", "model_rank_relevel"
  )) {
    if (exists(nm) && inherits(get(nm), "lm")) {
      m <- get(nm)
      break
    }
  }
  skip_if(is.null(m), message = "No rank model found to check R-squared")
  r_sq <- summary(m)$r.squared
  expect_true(r_sq < 0.10,
    info = sprintf("Rank should explain little variance in score (R² < 0.10), got %.4f", r_sq)
  )
})
