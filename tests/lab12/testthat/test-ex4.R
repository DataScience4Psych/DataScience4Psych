# Exercises 5-7: Comparing smoking vs non-smoking birth weights

test_that("Ex 5: Rmd creates side-by-side box plots of habit vs weight", {
  skip_if(length(.rmd_content) == 0)
  has_boxplot <- stringr::str_detect(.rmd_content, "geom_boxplot") |> any()
  has_habit <- stringr::str_detect(.rmd_content, "habit") |> any()
  has_weight <- stringr::str_detect(.rmd_content, "weight") |> any()
  expect_true(has_boxplot && has_habit && has_weight,
    label = "Ex 5: Create side-by-side box plots of habit vs weight"
  )
})

test_that("Ex 6: ncbirths_clean data frame exists without missing values in habit/weight", {
  expect_true(exists("ncbirths_clean"),
    label = "ncbirths_clean should be a version of ncbirths with no missing values in habit or weight"
  )
})

test_that("Ex 6: ncbirths_clean has no NA in habit or weight", {
  skip_if(!exists("ncbirths_clean"))
  expect_false(
    any(is.na(ncbirths_clean$habit)),
    label = "ncbirths_clean should have no missing values in the habit column"
  )
  expect_false(
    any(is.na(ncbirths_clean$weight)),
    label = "ncbirths_clean should have no missing values in the weight column"
  )
})

test_that("Ex 7: Rmd calculates observed difference in mean birth weight by smoking status", {
  skip_if(length(.rmd_content) == 0)
  potential_answers <- c(
    "obs_diff",
    "obs_stat",
    "observed.*diff",
    "diff.*mean.*weight",
    "group_by.*habit"
  )
  pattern <- paste0("(", paste(potential_answers, collapse = "|"), ")")
  answer_in_rmd <- stringr::str_detect(.rmd_content, pattern) |> any()
  expect_equal(answer_in_rmd, TRUE,
    info = "Ex 7: Calculate the observed difference in mean birth weight between smoking and non-smoking mothers"
  )
})

test_that("Ex 7: Smoking mothers have lower mean birth weight babies", {
  skip_if(!requireNamespace("openintro", quietly = TRUE))
  data("ncbirths", package = "openintro", envir = environment())
  ncb <- get("ncbirths", envir = environment()) |>
    dplyr::filter(!is.na(habit) & !is.na(weight))
  mean_weights <- ncb |>
    dplyr::group_by(habit) |>
    dplyr::summarize(mean_weight = mean(weight))
  nonsmoker_weight <- mean_weights$mean_weight[mean_weights$habit == "nonsmoker"]
  smoker_weight <- mean_weights$mean_weight[mean_weights$habit == "smoker"]
  expect_gt(nonsmoker_weight, smoker_weight,
    label = "Non-smoking mothers should have higher mean birth weight babies than smoking mothers"
  )
})
