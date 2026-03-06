# Exercise 8-11: Racial disparities in COMPAS scores

test_that("Ex 8: Rmd Exercise 8 contains racial disparity analysis code", {
  skip_if(length(.rmd_content) == 0)
  potential_answers <- c("race|African|Caucasian", "decile_score", "mean\\(", "group_by")
  pattern <- paste0("(", paste(potential_answers, collapse = "|"), ")")
  answer_in_rmd <- stringr::str_detect(.rmd_content, pattern) |> any()
  expect_equal(answer_in_rmd, TRUE,
               info = "Include code comparing risk scores across racial groups in your Rmd")
})

test_that("Ex 9: Rmd Exercise 9 contains high risk classification analysis", {
  skip_if(length(.rmd_content) == 0)
  potential_answers <- c("high.*risk", ">= ?7", "decile_score", "classification", "case_when|ifelse")
  pattern <- paste0("(", paste(potential_answers, collapse = "|"), ")")
  answer_in_rmd <- stringr::str_detect(.rmd_content, pattern) |> any()
  expect_equal(answer_in_rmd, TRUE,
               info = "Include code analyzing high risk classification rates in your Rmd")
})

test_that("Ex 10: non_recidivists object exists", {
  expect_true(exists("non_recidivists"),
              info ="non_recidivists should be created by filtering compas where two_year_recid == 0"
  )
})

test_that("Ex 10: non_recidivists contains only defendants who did not recidivate", {
  skip_if(!exists("non_recidivists"))
  skip_if(!"two_year_recid" %in% names(non_recidivists))
  expect_true(all(non_recidivists$two_year_recid == 0),
              info ="non_recidivists should only contain rows where two_year_recid == 0")
})

test_that("Ex 10: non_recidivists has fewer rows than compas", {
  skip_if(!exists("non_recidivists") || !exists("compas"))
  expect_true(nrow(non_recidivists) < nrow(compas),
              info ="non_recidivists should be a subset of compas (fewer rows)")
  expect_true(nrow(non_recidivists) > 0,
              info ="non_recidivists should not be empty")
})

test_that("Ex 10: non_recidivists has race and decile_score for disparity analysis", {
  skip_if(!exists("non_recidivists"))
  expect_true(all(c("race", "decile_score") %in% names(non_recidivists)),
              info ="non_recidivists should have race and decile_score columns for false positive rate analysis")
})

test_that("Ex 10: Rmd Exercise 10 contains false positive rate analysis", {
  skip_if(length(.rmd_content) == 0)
  potential_answers <- c("false.*positive|fp_rate", "non_recidiv", "two_year_recid", "race|African|Caucasian")
  pattern <- paste0("(", paste(potential_answers, collapse = "|"), ")")
  answer_in_rmd <- stringr::str_detect(.rmd_content, pattern) |> any()
  expect_equal(answer_in_rmd, TRUE,
               info = "Include code analyzing false positive rates by race in your Rmd")
})

test_that("Ex 10: false positive rate is higher for Black non-recidivists (solution check)", {
  skip_if(!exists("non_recidivists"))
  skip_if(!all(c("race", "decile_score") %in% names(non_recidivists)))
  solution_fp <- non_recidivists %>%
    dplyr::filter(race %in% c("African-American", "Caucasian")) %>%
    dplyr::group_by(race) %>%
    dplyr::summarize(fp_rate = mean(decile_score >= 7, na.rm = TRUE), .groups = "drop")
  skip_if(nrow(solution_fp) < 2,
          message = "Could not find both racial groups in non_recidivists")
  solution_black_fp <- solution_fp$fp_rate[solution_fp$race == "African-American"]
  solution_white_fp <- solution_fp$fp_rate[solution_fp$race == "Caucasian"]
  expect_true(solution_black_fp > solution_white_fp,
              info ="Black non-recidivists should have a higher false positive rate")
})

test_that("Ex 10: Rmd Exercise 10 reports false positive rate values or uses computation code", {
  skip_if(length(.rmd_content) == 0)
  skip_if(!exists("non_recidivists"))
  skip_if(!all(c("race", "decile_score") %in% names(non_recidivists)))
  potential_answers <- c("mean\\(.*decile_score", "fp_rate", "group_by.*race", "false.*positive", "African|Caucasian")
  pattern <- paste0("(", paste(potential_answers, collapse = "|"), ")")
  answer_in_rmd <- stringr::str_detect(.rmd_content, pattern) |> any()
  expect_equal(answer_in_rmd, TRUE,
               info = "Report false positive rate values or use computation code in your Rmd")
})
