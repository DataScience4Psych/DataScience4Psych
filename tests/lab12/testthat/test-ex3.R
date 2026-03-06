# Exercise 4: Hypothesis test using simulation-based inference

test_that("Ex 4: Rmd uses simulation-based inference (bootstrap or permutation)", {
  skip_if(length(.rmd_content) == 0)
  potential_answers <- c(
    "library\\(infer\\)",
    "infer::",
    "specify\\(",
    "generate\\(",
    "hypothesize\\(",
    "bootstrap",
    "simulate"
  )
  pattern <- paste0("(", paste(potential_answers, collapse = "|"), ")")
  answer_in_rmd <- stringr::str_detect(.rmd_content, pattern) |> any()
  expect_equal(answer_in_rmd, TRUE,
    info = "Ex 4: Use the infer package or simulation-based methods for the hypothesis test"
  )
})

test_that("Ex 4: Rmd generates null distribution for hypothesis test", {
  skip_if(length(.rmd_content) == 0)
  potential_answers <- c(
    "null_dist",
    "null_distribution",
    "generate.*null",
    "hypothesize.*null"
  )
  pattern <- paste0("(", paste(potential_answers, collapse = "|"), ")")
  answer_in_rmd <- stringr::str_detect(.rmd_content, pattern) |> any()
  expect_equal(answer_in_rmd, TRUE,
    info = "Ex 4: Generate a null distribution to test the hypothesis about mean birth weight"
  )
})

test_that("Ex 3: Rmd discusses conditions for simulation-based inference", {
  skip_if(length(.rmd_content) == 0)
  potential_answers <- c(
    "independent",
    "random",
    "sample size",
    "condition",
    "assumption"
  )
  pattern <- paste0("(", paste(potential_answers, collapse = "|"), ")")
  answer_in_rmd <- stringr::str_detect(.rmd_content, pattern) |> any()
  expect_equal(answer_in_rmd, TRUE,
    info = "Ex 3: Discuss conditions necessary for simulation-based inference"
  )
})
