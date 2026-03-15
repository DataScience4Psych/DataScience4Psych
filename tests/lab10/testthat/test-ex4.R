# Part 4: Multiple linear regression

test_that("Ex 4: m_bty_gen object exists", {
  expect_true(exists("m_bty_gen"),
              info = "Create m_bty_gen using lm(score ~ bty_avg + gender, data = evals)")
})

test_that("Ex 4: m_bty_gen is a linear model", {
  skip_if(!exists("m_bty_gen"))
  expect_s3_class(m_bty_gen, "lm")
})

test_that("Ex 4: m_bty_gen has 3 coefficients (intercept + bty_avg + gender)", {
  skip_if(!exists("m_bty_gen"))
  expect_equal(length(coef(m_bty_gen)), 3,
               info = "Ensure m_bty_gen has 3 coefficients: intercept, bty_avg, and gender")
})

test_that("Ex 4: m_bty_gen uses both bty_avg and gender as predictors", {
  skip_if(!exists("m_bty_gen"))
  model_terms <- attr(terms(m_bty_gen), "term.labels")
  expect_true("bty_avg" %in% model_terms,
              info = "Include bty_avg as a predictor in m_bty_gen")
  expect_true("gender" %in% model_terms,
              info = "Include gender as a predictor in m_bty_gen")
})

test_that("Ex 4: adjusted R-squared for m_bty_gen >= m_bty", {
  skip_if(!exists("m_bty") || !exists("m_bty_gen"))
  r2_bty <- summary(m_bty)$adj.r.squared
  r2_bty_gen <- summary(m_bty_gen)$adj.r.squared
  expect_true(r2_bty_gen >= r2_bty,
              info = "Adding gender should not decrease adjusted R-squared compared to m_bty")
})

test_that("Ex 4: m_bty_rank object exists", {
  expect_true(exists("m_bty_rank"),
              info = "Create m_bty_rank using lm(score ~ bty_avg + rank, data = evals)")
})

test_that("Ex 4: m_bty_rank is a linear model", {
  skip_if(!exists("m_bty_rank"))
  expect_s3_class(m_bty_rank, "lm")
})

test_that("Ex 4: m_bty_rank has 4 coefficients (intercept + bty_avg + 2 rank levels)", {
  skip_if(!exists("m_bty_rank"))
  expect_equal(length(coef(m_bty_rank)), 4,
               info = "Ensure m_bty_rank has 4 coefficients: intercept, bty_avg, and 2 rank dummies")
})

test_that("Ex 4: m_bty_rank uses both bty_avg and rank as predictors", {
  skip_if(!exists("m_bty_rank"))
  model_terms <- attr(terms(m_bty_rank), "term.labels")
  expect_true("bty_avg" %in% model_terms,
              info = "Include bty_avg as a predictor in m_bty_rank")
  expect_true("rank" %in% model_terms,
              info = "Include rank as a predictor in m_bty_rank")
})

# Part 4, Question 1: Does the beauty slope change when gender is added?
test_that("Ex 4.1: beauty slope in m_bty_gen is still positive", {
  skip_if(!exists("m_bty_gen"))
  slope <- coef(m_bty_gen)["bty_avg"]
  expect_true(slope > 0,
              info = "The bty_avg slope should remain positive in m_bty_gen")
})

test_that("Ex 4.1: Rmd discusses change in beauty slope when gender is added", {
  skip_if(length(.rmd_content) == 0)
  potential_answers <- c("slope", "bty_avg", "beauty.*slope|slope.*beauty",
                         "change.*slope|slope.*change", "m_bty_gen", "gender.*added|added.*gender")
  pattern <- paste0("(", paste(potential_answers, collapse = "|"), ")")
  answer_in_rmd <- stringr::str_detect(.rmd_content, pattern) |> any()
  expect_equal(answer_in_rmd, TRUE,
               info = "Discuss how the beauty slope changes when gender is added to the model")
})

# Part 4, Question 2: Does gender still shift the predicted score for same beauty rating?
test_that("Ex 4.2: gender coefficient in m_bty_gen is positive (males score higher)", {
  skip_if(!exists("m_bty_gen"))
  # The gendermale coefficient should be positive
  gender_coef <- coef(m_bty_gen)[grepl("gender", names(coef(m_bty_gen)))]
  skip_if(length(gender_coef) == 0, message = "No gender coefficient found in m_bty_gen")
  expect_true(gender_coef > 0,
              info = "The gender (male) coefficient in m_bty_gen should be positive")
})

test_that("Ex 4.2: Rmd discusses gender effect for professors with same beauty rating", {
  skip_if(length(.rmd_content) == 0)
  potential_answers <- c("gender", "same.*beauty|beauty.*same", "holding.*constant|controlling.*for",
                         "female|male", "m_bty_gen")
  pattern <- paste0("(", paste(potential_answers, collapse = "|"), ")")
  answer_in_rmd <- stringr::str_detect(.rmd_content, pattern) |> any()
  expect_equal(answer_in_rmd, TRUE,
               info = "Discuss whether gender shifts predicted scores after controlling for beauty")
})

# Part 4, Question 3: Compare adjusted R-squared
test_that("Ex 4.3: Rmd compares adjusted R-squared of m_bty and m_bty_gen", {
  skip_if(length(.rmd_content) == 0)
  potential_answers <- c("adj.*r.squared|adjusted.*r.squared|adj.*R.squared|adjusted.*R",
                         "adj.*r2|adjusted.*r2", "adj_r2|adj_r_sq",
                         "adjr|AdjR")
  pattern <- paste0("(", paste(potential_answers, collapse = "|"), ")")
  answer_in_rmd <- stringr::str_detect(.rmd_content, pattern) |> any()
  expect_equal(answer_in_rmd, TRUE,
               info = "Compare adjusted R-squared values between m_bty and m_bty_gen in your Rmd")
})

# Part 4, Question 4: Interpret m_bty_rank coefficients
test_that("Ex 4.4: m_bty_rank bty_avg slope is still positive", {
  skip_if(!exists("m_bty_rank"))
  slope <- coef(m_bty_rank)["bty_avg"]
  expect_true(slope > 0,
              info = "The bty_avg slope should remain positive in m_bty_rank")
})

test_that("Ex 4.4: Rmd interprets m_bty_rank rank coefficient and beauty slope", {
  skip_if(length(.rmd_content) == 0)
  potential_answers <- c("m_bty_rank", "rank.*coeff|coeff.*rank",
                         "teaching|tenure track|tenured",
                         "bty_avg.*slope|slope.*bty_avg",
                         "beauty.*rank|rank.*beauty")
  pattern <- paste0("(", paste(potential_answers, collapse = "|"), ")")
  answer_in_rmd <- stringr::str_detect(.rmd_content, pattern) |> any()
  expect_equal(answer_in_rmd, TRUE,
               info = "Interpret a rank coefficient and the beauty slope from m_bty_rank in your Rmd")
})
