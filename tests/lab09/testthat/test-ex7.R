# Exercise 7: Visualizing risk score distribution by race

test_that("Ex 7: compas has both race and decile_score for comparison", {
  skip_if(!exists("compas"))
  expect_true(all(c("race", "decile_score") %in% names(compas)),
    info = "compas should have race and decile_score columns to compare risk scores across groups"
  )
})

test_that("Ex 7: African-American defendants have higher mean decile_score than Caucasian defendants", {
  skip_if(!exists("compas"))
  skip_if(!all(c("race", "decile_score") %in% names(compas)))
  aa_mean <- mean(compas$decile_score[compas$race == "African-American"], na.rm = TRUE)
  cau_mean <- mean(compas$decile_score[compas$race == "Caucasian"], na.rm = TRUE)
  skip_if(is.nan(aa_mean) || is.nan(cau_mean),
    message = "Could not compute mean decile_score for both racial groups"
  )
  expect_true(aa_mean > cau_mean,
    info = paste(
      "African-American defendants have a higher mean risk score than Caucasian defendants.",
      sprintf("(African-American mean: %.2f, Caucasian mean: %.2f)", aa_mean, cau_mean)
    )
  )
})

test_that("Ex 7: Rmd Exercise 7 contains code comparing risk scores across racial groups", {
  skip_if(length(.rmd_content) == 0)
  potential_answers <- c(
    "ggplot", "geom_histogram|geom_density|geom_boxplot|geom_violin",
    "race", "decile_score", "fill\\s*=|color\\s*="
  )
  pattern <- paste0("(", paste(potential_answers, collapse = "|"), ")")
  answer_in_rmd <- stringr::str_detect(.rmd_content, pattern) |> any()
  expect_equal(answer_in_rmd, TRUE,
    info = "Include code visualizing the distribution of risk scores by race in your Rmd"
  )
})

test_that("Ex 7: Rmd mentions difference between Black and white defendants", {
  skip_if(length(.rmd_content) == 0)
  potential_answers <- c("African|Black|African-American", "Caucasian|white|White")
  has_aa <- stringr::str_detect(.rmd_content, potential_answers[1]) |> any()
  has_cau <- stringr::str_detect(.rmd_content, potential_answers[2]) |> any()
  expect_true(has_aa || has_cau,
    info = "Discuss or reference the racial groups (African-American / Caucasian) when comparing risk scores in your Rmd"
  )
})
