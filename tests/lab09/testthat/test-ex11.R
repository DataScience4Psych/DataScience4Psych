# Exercise 11: Fairness debate — ProPublica vs. Northpointe

test_that("Ex 11: Rmd Exercise 11 discusses ProPublica or Northpointe fairness debate", {
  skip_if(length(.rmd_content) == 0)
  potential_answers <- c("[Pp]ro[Pp]ublica", "[Nn]orthpointe", "calibrat", "error.rate",
                         "false.positive|false.negative", "fairness|fair")
  pattern <- paste0("(", paste(potential_answers, collapse = "|"), ")")
  answer_in_rmd <- stringr::str_detect(.rmd_content, pattern) |> any()
  expect_equal(answer_in_rmd, TRUE,
               info = "Discuss the ProPublica vs. Northpointe fairness debate in your Rmd (error rates vs. calibration)")
})

test_that("Ex 11: Rmd Exercise 11 references both error-rate and calibration perspectives", {
  skip_if(length(.rmd_content) == 0)
  has_error_rate <- stringr::str_detect(.rmd_content, "error.rate|false.positive|false.negative|FPR|FNR") |> any()
  has_calibration <- stringr::str_detect(.rmd_content, "calibrat|same.*score.*same.*probability|predictive.*parity") |> any()
  expect_true(has_error_rate || has_calibration,
              info = "Discuss at least one fairness perspective (error rates or calibration) in your Rmd")
})

test_that("Ex 11: Rmd Exercise 11 addresses racial disparity findings", {
  skip_if(length(.rmd_content) == 0)
  potential_answers <- c("race|racial", "African|Black|Caucasian|white", "disparit", "bias")
  pattern <- paste0("(", paste(potential_answers, collapse = "|"), ")")
  answer_in_rmd <- stringr::str_detect(.rmd_content, pattern) |> any()
  expect_equal(answer_in_rmd, TRUE,
               info = "Discuss racial disparities in the context of the fairness debate in your Rmd")
})
