# Exercise 10: Bootstrap confidence interval for mean difference

test_that("Ex 10: Rmd calculates confidence interval for difference in birth weights", {
  skip_if(length(.rmd_content) == 0)
  potential_answers <- c(
    "get_confidence_interval",
    "get_ci",
    "conf_int",
    "confidence.interval",
    "bootstrap"
  )
  pattern <- paste0("(", paste(potential_answers, collapse = "|"), ")")
  answer_in_rmd <- stringr::str_detect(.rmd_content, pattern) |> any()
  expect_equal(answer_in_rmd, TRUE,
    info = "Ex 10: Calculate a bootstrap confidence interval for the difference in mean birth weights"
  )
})

test_that("Ex 8: Rmd states null and alternative hypotheses for smoking test", {
  skip_if(length(.rmd_content) == 0)
  potential_answers <- c(
    "null hypothesis",
    "alternative hypothesis",
    "H_0",
    "H_A",
    "H0:",
    "H1:"
  )
  pattern <- paste0("(", paste(potential_answers, collapse = "|"), ")")
  answer_in_rmd <- stringr::str_detect(.rmd_content, pattern) |> any()
  expect_equal(answer_in_rmd, TRUE,
    info = "Ex 8: State the null and alternative hypotheses for testing if smoking affects birth weight"
  )
})
