# Exercise 2: Density plots of plastic waste per capita by continent

test_that("Ex 2: plastic_waste object exists for density plots", {
  expect_true(exists("plastic_waste"),
              label = "plastic_waste must exist before creating density plots")
})

test_that("Ex 2: Rmd Exercise 2 contains density plot code", {
  skip_if(length(.rmd_content) == 0)
  section <- .find_ex_section(.rmd_content, "2", "3")
  skip_if(is.null(section), "Could not locate Exercise 2 section in Rmd")
  has_density <- any(grepl("geom_density|density", section))
  has_ggplot <- any(grepl("ggplot", section))
  expect_true(has_density && has_ggplot,
              label = "Exercise 2 should contain ggplot code with geom_density")
})

test_that("Ex 2: Rmd Exercise 2 uses continent for coloring", {
  skip_if(length(.rmd_content) == 0)
  section <- .find_ex_section(.rmd_content, "2", "3")
  skip_if(is.null(section), "Could not locate Exercise 2 section in Rmd")
  has_continent <- any(grepl("continent", section))
  expect_true(has_continent,
              label = "Exercise 2 density plots should use continent for color/fill mapping")
})
