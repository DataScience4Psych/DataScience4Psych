# Part 2: Simple linear regression - beauty as a predictor

test_that("Ex 2: m_bty object exists", {
  expect_true(exists("m_bty"),
              info = "Create m_bty using lm(score ~ bty_avg, data = evals)")
})

test_that("Ex 2: m_bty is a linear model", {
  skip_if(!exists("m_bty"))
  expect_s3_class(m_bty, "lm")
})

test_that("Ex 2: m_bty has 2 coefficients (intercept + bty_avg)", {
  skip_if(!exists("m_bty"))
  expect_equal(length(coef(m_bty)), 2,
               info = "Ensure m_bty has 2 coefficients: intercept and bty_avg")
})

test_that("Ex 2: m_bty uses bty_avg as predictor", {
  skip_if(!exists("m_bty"))
  predictor_names <- names(coef(m_bty))
  expect_true("bty_avg" %in% predictor_names,
              info = "Include bty_avg as the predictor in your m_bty model")
})

test_that("Ex 2: m_bty has positive slope for bty_avg", {
  skip_if(!exists("m_bty"))
  slope <- coef(m_bty)["bty_avg"]
  expect_true(slope > 0,
              info = "The bty_avg coefficient should be positive (higher beauty -> higher score)")
})

test_that("Ex 2: R-squared for m_bty is small (around 0.03)", {
  skip_if(!exists("m_bty"))
  r_sq <- summary(m_bty)$r.squared
  expect_true(r_sq > 0.01 && r_sq < 0.10,
              info = sprintf("R-squared for beauty alone should be modest (0.01-0.10), got %.4f", r_sq))
})

test_that("Ex 2: m_bty was fit on all 463 evals observations", {
  skip_if(!exists("m_bty"))
  expect_equal(nobs(m_bty), 463,
               info = "Fit m_bty on all 463 observations in the evals dataset")
})

test_that("Ex 2: Rmd Exercise 2 reports model slope or uses summary/coef code", {
  skip_if(length(.rmd_content) == 0)
  skip_if(!exists("m_bty"))
  solution_slope <- coef(m_bty)["bty_avg"]
  slope_patterns <- c(sprintf("%.4f", solution_slope), sprintf("%.3f", solution_slope),
                      sprintf("%.2f", solution_slope))
  potential_answers <- c(slope_patterns, "summary\\(", "coef\\(", "tidy\\(")
  pattern <- paste0("(", paste(potential_answers, collapse = "|"), ")")
  answer_in_rmd <- stringr::str_detect(.rmd_content, pattern) |> any()
  expect_equal(answer_in_rmd, TRUE,
               info = sprintf("Report the bty_avg slope (%.4f) or use summary()/coef()/tidy() in your Rmd", solution_slope))
})

# Part 2, Question 2: Replot with regression line in orange, se = FALSE
test_that("Ex 2.2: Rmd adds a regression line to the scatterplot", {
  skip_if(length(.rmd_content) == 0)
  potential_answers <- c("geom_smooth", "geom_abline", "stat_smooth")
  pattern <- paste0("(", paste(potential_answers, collapse = "|"), ")")
  answer_in_rmd <- stringr::str_detect(.rmd_content, pattern) |> any()
  expect_equal(answer_in_rmd, TRUE,
               info = "Add a regression line using geom_smooth() (or geom_abline()) to your scatterplot")
})

test_that("Ex 2.2: Rmd turns off confidence interval shading (se = FALSE)", {
  skip_if(length(.rmd_content) == 0)
  potential_answers <- c("se\\s*=\\s*FALSE", "se\\s*=\\s*F\\b")
  pattern <- paste0("(", paste(potential_answers, collapse = "|"), ")")
  answer_in_rmd <- stringr::str_detect(.rmd_content, pattern) |> any()
  expect_equal(answer_in_rmd, TRUE,
               info = "Turn off the default shading around the regression line with se = FALSE")
})

test_that("Ex 2.2: Rmd uses orange color for the regression line", {
  skip_if(length(.rmd_content) == 0)
  potential_answers <- c("orange", "\"#[0-9A-Fa-f]{6}\"", "'#[0-9A-Fa-f]{6}'")
  pattern <- paste0("(", paste(potential_answers, collapse = "|"), ")")
  answer_in_rmd <- stringr::str_detect(.rmd_content, pattern) |> any()
  expect_equal(answer_in_rmd, TRUE,
               info = "Use orange (or an orange hex code) as the color for the regression line")
})

# Part 2, Question 3: Interpret intercept, slope, R-squared, and uncertainty shading
test_that("Ex 2.3: Rmd discusses the R-squared value of m_bty", {
  skip_if(length(.rmd_content) == 0)
  skip_if(!exists("m_bty"))
  r_sq <- summary(m_bty)$r.squared
  r_sq_patterns <- c(sprintf("%.4f", r_sq), sprintf("%.3f", r_sq), sprintf("%.2f", r_sq),
                     sprintf("%.1f", r_sq * 100))
  potential_answers <- c(r_sq_patterns, "r.squared", "R.squared", "r\\^2", "R\\^2",
                         "r2", "R2", "rsq", "r_sq")
  pattern <- paste0("(", paste(potential_answers, collapse = "|"), ")")
  answer_in_rmd <- stringr::str_detect(.rmd_content, pattern) |> any()
  expect_equal(answer_in_rmd, TRUE,
               info = sprintf("Report the R-squared value (%.4f) or reference R-squared in your Rmd", r_sq))
})

test_that("Ex 2.3: Rmd discusses the intercept of m_bty", {
  skip_if(length(.rmd_content) == 0)
  potential_answers <- c("intercept", "Intercept", "b_0", "b0", "\\(Intercept\\)")
  pattern <- paste0("(", paste(potential_answers, collapse = "|"), ")")
  answer_in_rmd <- stringr::str_detect(.rmd_content, pattern) |> any()
  expect_equal(answer_in_rmd, TRUE,
               info = "Discuss what the intercept means in the context of this model in your Rmd")
})
