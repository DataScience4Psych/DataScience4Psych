# Exercises 5-7: Risk score accuracy and COMPAS performance

test_that("Ex 5: Rmd visualizes relationship between decile_score and recidivism", {
  skip_if(length(.rmd_content) == 0)
  has_decile <- stringr::str_detect(.rmd_content, "decile_score") |> any()
  has_recid <- stringr::str_detect(.rmd_content, "two_year_recid") |> any()
  expect_true(has_decile && has_recid,
    label = "Ex 5: Visualize the relationship between decile_score and two_year_recid"
  )
})

test_that("Ex 6: Rmd creates compas_classification variable (TP/TN/FP/FN)", {
  skip_if(length(.rmd_content) == 0)
  potential_answers <- c(
    "compas_classification",
    "TP|TN|FP|FN",
    "case_when.*decile_score.*recid"
  )
  pattern <- paste0("(", paste(potential_answers, collapse = "|"), ")")
  answer_in_rmd <- stringr::str_detect(.rmd_content, pattern) |> any()
  expect_equal(answer_in_rmd, TRUE,
    info = "Ex 6: Create a classification variable (TP/TN/FP/FN) based on decile_score and two_year_recid"
  )
})

test_that("Ex 7: Rmd reports overall accuracy of COMPAS", {
  skip_if(length(.rmd_content) == 0)
  potential_answers <- c(
    "accuracy",
    "correct",
    "percent.*correct",
    "mean.*correct"
  )
  pattern <- paste0("(", paste(potential_answers, collapse = "|"), ")")
  answer_in_rmd <- stringr::str_detect(.rmd_content, pattern) |> any()
  expect_equal(answer_in_rmd, TRUE,
    info = "Ex 7: Calculate and report the overall accuracy of the COMPAS algorithm"
  )
})

test_that("Ex 7: COMPAS accuracy is between 0 and 1 (or 0% and 100%)", {
  skip_if(!exists("compas"))
  skip_if(!("two_year_recid" %in% names(compas)))
  # Simple accuracy check: high risk (>=7) correctly flagged as recidivist
  high_risk_correct <- compas |>
    dplyr::mutate(
      correct = (decile_score >= 7 & two_year_recid == 1) |
        (decile_score <= 4 & two_year_recid == 0)
    ) |>
    dplyr::filter(!is.na(correct))
  acc <- mean(high_risk_correct$correct)
  expect_true(acc > 0 && acc < 1,
    label = sprintf("COMPAS accuracy should be between 0 and 1, got %.3f", acc)
  )
})
