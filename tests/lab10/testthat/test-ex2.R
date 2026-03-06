# Part 2, Exercise 1: Linear model m_bty (score ~ bty_avg)

test_that("Ex 2.1: m_bty model exists", {
  expect_true(exists("m_bty"),
    label = "m_bty should be a linear model predicting score from bty_avg"
  )
})

test_that("Ex 2.1: m_bty is a linear model", {
  skip_if(!exists("m_bty"))
  expect_s3_class(m_bty, "lm")
})

test_that("Ex 2.1: m_bty predicts score from bty_avg", {
  skip_if(!exists("m_bty"))
  expect_true(
    "bty_avg" %in% names(coef(m_bty)),
    label = "m_bty should include bty_avg as a predictor"
  )
})

test_that("Ex 2.1: m_bty bty_avg slope is positive (beauty predicts higher scores)", {
  skip_if(!exists("m_bty"))
  bty_coef <- coef(m_bty)["bty_avg"]
  expect_gt(bty_coef, 0,
    label = sprintf(
      "The slope for bty_avg in m_bty should be positive, got %.4f",
      bty_coef
    )
  )
})

test_that("Ex 2.2: Rmd adds regression line to scatterplot", {
  skip_if(length(.rmd_content) == 0)
  potential_answers <- c(
    "geom_smooth.*lm",
    "geom_abline",
    "geom_smooth"
  )
  pattern <- paste0("(", paste(potential_answers, collapse = "|"), ")")
  answer_in_rmd <- stringr::str_detect(.rmd_content, pattern) |> any()
  expect_equal(answer_in_rmd, TRUE,
    info = "Ex 2.2: Add a regression line (geom_smooth) to your scatterplot"
  )
})
