# Exercise 3: Violin plots of plastic waste per capita by continent

test_that("Ex 3: plastic_waste object exists for violin plots", {
  expect_true(exists("plastic_waste"),
              label = "plastic_waste must exist before creating violin plots")
})

test_that("Ex 3: Rmd Exercise 3 contains violin plot code", {
  skip_if(length(.rmd_content) == 0)
  section <- .find_ex_section(.rmd_content, "3", "4")
  skip_if(is.null(section), "Could not locate Exercise 3 section in Rmd")
  has_violin <- any(grepl("geom_violin|violin", section))
  has_ggplot <- any(grepl("ggplot", section))
  expect_true(has_violin && has_ggplot,
              label = "Exercise 3 should contain ggplot code with geom_violin")
})
