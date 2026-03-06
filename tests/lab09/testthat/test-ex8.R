# Exercise 8-11: Racial disparities in COMPAS scores

test_that("Ex 8: Rmd Exercise 8 contains racial disparity analysis code", {
  skip_if(length(.rmd_content) == 0)
  section <- .find_ex_section(.rmd_content, "8", "9")
  skip_if(is.null(section), "Could not locate Exercise 8 section in Rmd")
  has_race <- any(grepl("race|African|Caucasian", section))
  has_score <- any(grepl("decile_score|mean|group_by", section))
  expect_true(has_race && has_score,
              label = "Exercise 8 should contain code comparing risk scores across racial groups")
})

test_that("Ex 9: Rmd Exercise 9 contains high risk classification analysis", {
  skip_if(length(.rmd_content) == 0)
  section <- .find_ex_section(.rmd_content, "9", "10")
  skip_if(is.null(section), "Could not locate Exercise 9 section in Rmd")
  has_risk <- any(grepl("high.*risk|>= ?7|decile_score", section))
  expect_true(has_risk,
              label = "Exercise 9 should contain code analyzing high risk classification rates")
})

test_that("Ex 10: non_recidivists object exists", {
  expect_true(exists("non_recidivists"),
              label = "non_recidivists should be created by filtering compas where two_year_recid == 0"
  )
})

test_that("Ex 10: non_recidivists contains only defendants who did not recidivate", {
  skip_if(!exists("non_recidivists"))
  skip_if(!"two_year_recid" %in% names(non_recidivists))
  expect_true(all(non_recidivists$two_year_recid == 0),
              label = "non_recidivists should only contain rows where two_year_recid == 0")
})

test_that("Ex 10: non_recidivists has fewer rows than compas", {
  skip_if(!exists("non_recidivists") || !exists("compas"))
  expect_true(nrow(non_recidivists) < nrow(compas),
              label = "non_recidivists should be a subset of compas (fewer rows)")
  expect_true(nrow(non_recidivists) > 0,
              label = "non_recidivists should not be empty")
})

test_that("Ex 10: non_recidivists has race and decile_score for disparity analysis", {
  skip_if(!exists("non_recidivists"))
  expect_true(all(c("race", "decile_score") %in% names(non_recidivists)),
              label = "non_recidivists should have race and decile_score columns for false positive rate analysis")
})

test_that("Ex 10: Rmd Exercise 10 contains false positive rate analysis", {
  skip_if(length(.rmd_content) == 0)
  section <- .find_ex_section(.rmd_content, "10", "11")
  skip_if(is.null(section), "Could not locate Exercise 10 section in Rmd")
  has_fp <- any(grepl("false.*positive|fp_rate|non_recidiv|two_year_recid", section))
  has_race <- any(grepl("race|African|Caucasian", section))
  expect_true(has_fp && has_race,
              label = "Exercise 10 should contain code analyzing false positive rates by race")
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
              label = "Black non-recidivists should have a higher false positive rate")
})

test_that("Ex 10: Rmd Exercise 10 reports false positive rate values or uses computation code", {
  skip_if(length(.rmd_content) == 0)
  skip_if(!exists("non_recidivists"))
  skip_if(!all(c("race", "decile_score") %in% names(non_recidivists)))
  section <- .find_ex_section(.rmd_content, "10", "11")
  skip_if(is.null(section), "Could not locate Exercise 10 section in Rmd")
  solution_fp <- non_recidivists %>%
    dplyr::filter(race %in% c("African-American", "Caucasian")) %>%
    dplyr::group_by(race) %>%
    dplyr::summarize(fp_rate = mean(decile_score >= 7, na.rm = TRUE), .groups = "drop")
  skip_if(nrow(solution_fp) < 2, message = "Could not find both racial groups")
  solution_black_fp <- solution_fp$fp_rate[solution_fp$race == "African-American"]
  fp_patterns <- c(sprintf("%.4f", solution_black_fp), sprintf("%.3f", solution_black_fp),
                   sprintf("%.2f", solution_black_fp),
                   sprintf("%.1f", solution_black_fp * 100))
  has_value <- any(sapply(fp_patterns, function(p) any(grepl(p, section, fixed = TRUE))))
  has_code <- any(grepl("mean\\(.*decile_score|fp_rate|group_by.*race", section))
  expect_true(has_value || has_code,
              label = sprintf("Exercise 10 should report false positive rate (%.4f for Black) or use computation code", solution_black_fp))
})
