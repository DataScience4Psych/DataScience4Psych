# Exercise 3-4: Distribution of risk scores and demographics

test_that("Ex 3: compas object exists with decile_score", {
  skip_if(!exists("compas"),
          message = "compas must be loaded before testing risk scores")
  expect_true("decile_score" %in% names(compas),
              info ="compas should have a decile_score column")
})

test_that("Ex 3: Rmd Exercise 3 contains risk score visualization code", {
  skip_if(length(.rmd_content) == 0)
  potential_answers <- c("ggplot", "geom_histogram|geom_bar|geom_density", "decile_score")
  pattern <- paste0("(", paste(potential_answers, collapse = "|"), ")")
  answer_in_rmd <- stringr::str_detect(.rmd_content, pattern) |> any()
  expect_equal(answer_in_rmd, TRUE,
               info = "Include code visualizing the distribution of risk scores in your Rmd")
})

test_that("Ex 4: Rmd Exercise 4 contains demographic analysis code", {
  skip_if(length(.rmd_content) == 0)
  potential_answers <- c("race", "sex|gender", "demographic", "group_by", "table\\(")
  pattern <- paste0("(", paste(potential_answers, collapse = "|"), ")")
  answer_in_rmd <- stringr::str_detect(.rmd_content, pattern) |> any()
  expect_equal(answer_in_rmd, TRUE,
               info = "Include code examining demographic variables (race, sex) in your Rmd")
})
