# Exercise 4: Scatterplots of plastic waste relationships colored by continent

test_that("Ex 4: plastic_waste object exists for scatterplots", {
  expect_true(exists("plastic_waste"),
              label = "plastic_waste must exist before creating scatterplots")
})

test_that("Ex 4: Rmd Exercise 4 contains scatterplot code", {
  skip_if(length(.rmd_content) == 0)
  section <- .find_ex_section(.rmd_content, "4", "5")
  skip_if(is.null(section), "Could not locate Exercise 4 section in Rmd")
  has_point <- any(grepl("geom_point", section))
  has_ggplot <- any(grepl("ggplot", section))
  expect_true(has_point && has_ggplot,
              label = "Exercise 4 should contain ggplot code with geom_point for scatterplots")
})

test_that("Ex 4: Rmd Exercise 4 references key variables", {
  skip_if(length(.rmd_content) == 0)
  section <- .find_ex_section(.rmd_content, "4", "5")
  skip_if(is.null(section), "Could not locate Exercise 4 section in Rmd")
  has_mismanaged <- any(grepl("mismanaged_plastic_waste", section))
  has_pop <- any(grepl("total_pop|coastal_pop", section))
  expect_true(has_mismanaged || has_pop,
              label = "Exercise 4 should reference mismanaged_plastic_waste_per_cap, total_pop, or coastal_pop")
})
