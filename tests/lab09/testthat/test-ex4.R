# Exercise 4: Demographic distribution of defendants

test_that("Ex 4: compas has race column for demographic analysis", {
  skip_if(!exists("compas"))
  expect_true("race" %in% names(compas),
              info = "compas should have a race column for demographic analysis")
})

test_that("Ex 4: compas has sex column for demographic analysis", {
  skip_if(!exists("compas"))
  expect_true("sex" %in% names(compas),
              info = "compas should have a sex column for demographic analysis")
})

test_that("Ex 4: race column has multiple groups including African-American and Caucasian", {
  skip_if(!exists("compas"))
  skip_if(!"race" %in% names(compas))
  race_groups <- unique(compas$race)
  expect_true("African-American" %in% race_groups,
              info = "compas race column should include 'African-American'")
  expect_true("Caucasian" %in% race_groups,
              info = "compas race column should include 'Caucasian'")
})

test_that("Ex 4: both Male and Female are present in sex column", {
  skip_if(!exists("compas"))
  skip_if(!"sex" %in% names(compas))
  sex_vals <- unique(compas$sex)
  expect_true("Male" %in% sex_vals && "Female" %in% sex_vals,
              info = "compas sex column should contain both 'Male' and 'Female'")
})

test_that("Ex 4: Rmd Exercise 4 contains demographic visualization code", {
  skip_if(length(.rmd_content) == 0)
  potential_answers <- c("ggplot", "geom_bar|geom_col|geom_histogram", "race", "sex|gender")
  pattern <- paste0("(", paste(potential_answers, collapse = "|"), ")")
  answer_in_rmd <- stringr::str_detect(.rmd_content, pattern) |> any()
  expect_equal(answer_in_rmd, TRUE,
               info = "Include code creating demographic visualizations (race, sex) in your Rmd")
})

test_that("Ex 4: Rmd Exercise 4 includes both race and sex visualizations", {
  skip_if(length(.rmd_content) == 0)
  has_race <- stringr::str_detect(.rmd_content, "race") |> any()
  has_sex <- stringr::str_detect(.rmd_content, "sex|gender") |> any()
  expect_true(has_race,
              info = "Include a visualization showing distribution by race in your Rmd")
  expect_true(has_sex,
              info = "Include a visualization showing distribution by sex/gender in your Rmd")
})
