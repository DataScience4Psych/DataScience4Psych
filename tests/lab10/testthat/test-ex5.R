# Part 5: The search for the best model
# Candidate predictors: rank, ethnicity, gender, language, age, cls_perc_eval,
# cls_did_eval, cls_students, cls_level, cls_profs, cls_credits, bty_avg

# Part 5, Question 1: Worst predictor reasoning
test_that("Ex 5.1: Rmd discusses which variable would be the worst predictor", {
  skip_if(length(.rmd_content) == 0)
  potential_answers <- c("worst", "least", "no.*association", "not.*assoc",
                         "unrelated", "expect.*not", "wouldn.t expect",
                         "cls_profs", "cls_did_eval", "cls_level", "cls_credits",
                         "no.*relationship", "weak.*predictor")
  pattern <- paste0("(", paste(potential_answers, collapse = "|"), ")")
  answer_in_rmd <- stringr::str_detect(.rmd_content, pattern) |> any()
  expect_equal(answer_in_rmd, TRUE,
               info = "Discuss which variable you expect to be the worst predictor of score and why")
})

# Part 5, Question 2: Check worst predictor with model output
test_that("Ex 5.2: Rmd fits a single-predictor model for the worst predictor check", {
  skip_if(length(.rmd_content) == 0)
  # Any lm with one of the candidate predictors
  potential_answers <- c(
    "lm\\(score\\s*~\\s*rank\\b",
    "lm\\(score\\s*~\\s*ethnicity\\b",
    "lm\\(score\\s*~\\s*language\\b",
    "lm\\(score\\s*~\\s*age\\b",
    "lm\\(score\\s*~\\s*cls_perc_eval\\b",
    "lm\\(score\\s*~\\s*cls_did_eval\\b",
    "lm\\(score\\s*~\\s*cls_students\\b",
    "lm\\(score\\s*~\\s*cls_level\\b",
    "lm\\(score\\s*~\\s*cls_profs\\b",
    "lm\\(score\\s*~\\s*cls_credits\\b"
  )
  pattern <- paste0("(", paste(potential_answers, collapse = "|"), ")")
  answer_in_rmd <- stringr::str_detect(.rmd_content, pattern) |> any()
  expect_equal(answer_in_rmd, TRUE,
               info = "Fit a single-predictor linear model to check your worst-predictor suspicion")
})

# Part 5, Question 3: cls_did_eval should be excluded (collinear with cls_perc_eval + cls_students)
test_that("Ex 5.3: Rmd mentions cls_did_eval as the variable to exclude", {
  skip_if(length(.rmd_content) == 0)
  potential_answers <- c("cls_did_eval")
  pattern <- paste0("(", paste(potential_answers, collapse = "|"), ")")
  answer_in_rmd <- stringr::str_detect(.rmd_content, pattern) |> any()
  expect_equal(answer_in_rmd, TRUE,
               info = "Mention cls_did_eval in your Rmd (a separate test checks that it is excluded from your model)")
})

test_that("Ex 5.3: Rmd explains why cls_did_eval should be excluded (collinearity / derived variable)", {
  skip_if(length(.rmd_content) == 0)
  potential_answers <- c("collinear", "derived", "cls_perc_eval.*cls_students",
                         "cls_students.*cls_perc_eval", "computed", "product",
                         "redundant", "combination", "related")
  pattern <- paste0("(", paste(potential_answers, collapse = "|"), ")")
  answer_in_rmd <- stringr::str_detect(.rmd_content, pattern) |> any()
  expect_equal(answer_in_rmd, TRUE,
               info = "Explain why cls_did_eval should be excluded (it is derived from cls_perc_eval and cls_students)")
})

# Part 5, Question 4: Full model
test_that("Ex 5.4: full model object exists", {
  has_full <- exists("m_full") || exists("full_model") || exists("model_full")
  expect_true(has_full,
              info = "Fit a full model with all candidate predictors except cls_did_eval (e.g., m_full)")
})

test_that("Ex 5.4: full model is a linear model", {
  m <- NULL
  for (nm in c("m_full", "full_model", "model_full")) {
    if (exists(nm) && inherits(get(nm), "lm")) { m <- get(nm); break }
  }
  skip_if(is.null(m), message = "No full model object found")
  expect_s3_class(m, "lm")
})

test_that("Ex 5.4: full model has many predictors (at least 8 term labels)", {
  m <- NULL
  for (nm in c("m_full", "full_model", "model_full")) {
    if (exists(nm) && inherits(get(nm), "lm")) { m <- get(nm); break }
  }
  skip_if(is.null(m), message = "No full model object found")
  n_terms <- length(attr(terms(m), "term.labels"))
  expect_true(n_terms >= 8,
              info = sprintf("Full model should have at least 8 predictors, got %d", n_terms))
})

test_that("Ex 5.4: full model does not include cls_did_eval", {
  m <- NULL
  for (nm in c("m_full", "full_model", "model_full")) {
    if (exists(nm) && inherits(get(nm), "lm")) { m <- get(nm); break }
  }
  skip_if(is.null(m), message = "No full model object found")
  model_terms <- attr(terms(m), "term.labels")
  expect_false("cls_did_eval" %in% model_terms,
               info = "Exclude cls_did_eval from the full model (it is derived from cls_perc_eval and cls_students)")
})

test_that("Ex 5.4: full model includes bty_avg", {
  m <- NULL
  for (nm in c("m_full", "full_model", "model_full")) {
    if (exists(nm) && inherits(get(nm), "lm")) { m <- get(nm); break }
  }
  skip_if(is.null(m), message = "No full model object found")
  model_terms <- attr(terms(m), "term.labels")
  expect_true("bty_avg" %in% model_terms,
              info = "Include bty_avg as a predictor in the full model")
})

test_that("Ex 5.4: full model is fit on evals data (463 observations)", {
  m <- NULL
  for (nm in c("m_full", "full_model", "model_full")) {
    if (exists(nm) && inherits(get(nm), "lm")) { m <- get(nm); break }
  }
  skip_if(is.null(m), message = "No full model object found")
  expect_equal(nobs(m), 463,
               info = "Fit the full model on all 463 evals observations")
})

# Part 5, Question 5: Best model via backward selection
test_that("Ex 5.5: best model object exists (from backward selection)", {
  has_best <- exists("m_best") || exists("best_model") || exists("model_best") ||
              exists("m_final") || exists("final_model")
  expect_true(has_best,
              info = "Use backward selection to find the best model and save it (e.g., m_best, m_final)")
})

test_that("Ex 5.5: best model is a linear model", {
  m <- NULL
  for (nm in c("m_best", "best_model", "model_best", "m_final", "final_model")) {
    if (exists(nm) && inherits(get(nm), "lm")) { m <- get(nm); break }
  }
  skip_if(is.null(m), message = "No best model object found")
  expect_s3_class(m, "lm")
})

test_that("Ex 5.5: best model has fewer or equal predictors than full model", {
  m_full <- NULL
  for (nm in c("m_full", "full_model", "model_full")) {
    if (exists(nm) && inherits(get(nm), "lm")) { m_full <- get(nm); break }
  }
  m_best <- NULL
  for (nm in c("m_best", "best_model", "model_best", "m_final", "final_model")) {
    if (exists(nm) && inherits(get(nm), "lm")) { m_best <- get(nm); break }
  }
  skip_if(is.null(m_full) || is.null(m_best),
          message = "Need both full model and best model to compare")
  n_full <- length(attr(terms(m_full), "term.labels"))
  n_best <- length(attr(terms(m_best), "term.labels"))
  expect_true(n_best <= n_full,
              info = sprintf("Best model (%d predictors) should have at most as many predictors as full model (%d)",
                             n_best, n_full))
})

test_that("Ex 5.5: Rmd shows the backward selection final model output", {
  skip_if(length(.rmd_content) == 0)
  potential_answers <- c("backward", "step.*selection|selection.*step",
                         "m_best", "best_model", "m_final", "final_model",
                         "adj.*r.squared|adjusted.*r")
  pattern <- paste0("(", paste(potential_answers, collapse = "|"), ")")
  answer_in_rmd <- stringr::str_detect(.rmd_content, pattern) |> any()
  expect_equal(answer_in_rmd, TRUE,
               info = "Show the backward selection process or final model output in your Rmd")
})

# Part 5, Question 6: Interpret slopes of final model
test_that("Ex 5.6: Rmd interprets at least one numerical predictor slope from the final model", {
  skip_if(length(.rmd_content) == 0)
  potential_answers <- c("slope", "coefficient", "for each.*unit|unit.*increase",
                         "one.*unit|unit.*change", "holding.*constant|controlling",
                         "ceteris paribus", "all else equal", "bty_avg", "age",
                         "cls_perc_eval", "cls_students")
  pattern <- paste0("(", paste(potential_answers, collapse = "|"), ")")
  answer_in_rmd <- stringr::str_detect(.rmd_content, pattern) |> any()
  expect_equal(answer_in_rmd, TRUE,
               info = "Interpret the slope of a numerical predictor from your final model")
})

test_that("Ex 5.6: Rmd interprets at least one categorical predictor coefficient from the final model", {
  skip_if(length(.rmd_content) == 0)
  potential_answers <- c("gender", "rank", "ethnicity", "language",
                         "cls_level", "cls_credits", "cls_profs",
                         "compared to|relative to|reference level|baseline")
  pattern <- paste0("(", paste(potential_answers, collapse = "|"), ")")
  answer_in_rmd <- stringr::str_detect(.rmd_content, pattern) |> any()
  expect_equal(answer_in_rmd, TRUE,
               info = "Interpret the coefficient of a categorical predictor from your final model")
})

# Part 5, Question 7: Characteristics of a high-scoring professor
test_that("Ex 5.7: Rmd describes characteristics of a high-scoring professor", {
  skip_if(length(.rmd_content) == 0)
  potential_answers <- c("high.*scor", "best.*scor", "highest.*scor",
                         "characteristic", "professor.*with", "would.*receiv",
                         "associated.*with.*high", "predict.*high", "maximize",
                         "male|female|gender", "beauty|bty_avg", "age",
                         "non.?native|native", "language", "tenure")
  pattern <- paste0("(", paste(potential_answers, collapse = "|"), ")")
  answer_in_rmd <- stringr::str_detect(.rmd_content, pattern) |> any()
  expect_equal(answer_in_rmd, TRUE,
               info = "Describe the characteristics of a professor likely to receive a high evaluation score")
})

# Part 5, Question 8: Generalizability
test_that("Ex 5.8: Rmd discusses whether findings generalize to all universities", {
  skip_if(length(.rmd_content) == 0)
  potential_answers <- c("generaliz", "university|universities",
                         "UT Austin|Texas|Austin",
                         "all.*universit|other.*school|other.*universit",
                         "limit", "scope", "representat",
                         "single.*universit|one.*universit",
                         "external.*valid|internal.*valid")
  pattern <- paste0("(", paste(potential_answers, collapse = "|"), ")")
  answer_in_rmd <- stringr::str_detect(.rmd_content, pattern) |> any()
  expect_equal(answer_in_rmd, TRUE,
               info = "Discuss whether your conclusions generalize to professors at other universities")
})
