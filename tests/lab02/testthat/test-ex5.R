# Exercise 5: Recreate coastal population proportion plot

test_that("Ex 5: plastic_waste object exists for recreation plot", {
  expect_true(exists("plastic_waste"),
              label = "plastic_waste must exist to compute coastal_pop_prop")
})

test_that("Ex 5: Rmd Exercise 5 computes coastal_pop_prop", {
  skip_if(length(.rmd_content) == 0)
  section <- .find_ex_section(.rmd_content, "5", NULL)
  skip_if(is.null(section), "Could not locate Exercise 5 section in Rmd")
  has_prop <- any(grepl("coastal_pop_prop|coastal_pop\\s*/\\s*total_pop", section))
  expect_true(has_prop,
              label = "Exercise 5 should compute coastal_pop_prop (coastal_pop / total_pop)")
})

test_that("Ex 5: Rmd Exercise 5 contains plot code", {
  skip_if(length(.rmd_content) == 0)
  section <- .find_ex_section(.rmd_content, "5", NULL)
  skip_if(is.null(section), "Could not locate Exercise 5 section in Rmd")
  has_ggplot <- any(grepl("ggplot", section))
  expect_true(has_ggplot,
              label = "Exercise 5 should contain ggplot code to recreate the plot")
})

test_that("Ex 5: Rmd Exercise 5 filters for plastic_waste_per_cap < 3", {
  skip_if(length(.rmd_content) == 0)
  section <- .find_ex_section(.rmd_content, "5", NULL)
  skip_if(is.null(section), "Could not locate Exercise 5 section in Rmd")
  has_filter <- any(grepl("filter|< ?3", section))
  expect_true(has_filter,
              label = "Exercise 5 should filter out the outlier (plastic_waste_per_cap < 3)")
})
