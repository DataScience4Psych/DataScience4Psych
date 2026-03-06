# Exercise 3-4: Distribution of risk scores and demographics

test_that("Ex 3: compas object exists with decile_score", {
  skip_if(!exists("compas"),
          message = "compas must be loaded before testing risk scores")
  expect_true("decile_score" %in% names(compas),
              label = "compas should have a decile_score column")
})

test_that("Ex 3: Rmd Exercise 3 contains risk score visualization code", {
  skip_if(length(.rmd_content) == 0)
  section <- .find_ex_section(.rmd_content, "3", "4")
  skip_if(is.null(section), "Could not locate Exercise 3 section in Rmd")
  has_plot <- any(grepl("ggplot|geom_histogram|geom_bar|geom_density|decile_score", section))
  expect_true(has_plot,
              label = "Exercise 3 should contain code visualizing the distribution of risk scores")
})

test_that("Ex 4: Rmd Exercise 4 contains demographic analysis code", {
  skip_if(length(.rmd_content) == 0)
  section <- .find_ex_section(.rmd_content, "4", "5")
  skip_if(is.null(section), "Could not locate Exercise 4 section in Rmd")
  has_demo <- any(grepl("race|sex|gender|demographic", section))
  expect_true(has_demo,
              label = "Exercise 4 should contain code examining demographic variables (race, sex)")
})
