# Exercise 2: Density plots of plastic waste per capita by continent

test_that("Ex 2: plastic_waste object exists for density plots", {
  expect_true(exists("plastic_waste"),
              label = "plastic_waste must exist before creating density plots")
})

test_that("Ex 2: plastic_waste_per_cap variable is numeric", {
  skip_if(!exists("plastic_waste"))
  expect_true(is.numeric(plastic_waste$plastic_waste_per_cap),
              label = "plastic_waste_per_cap should be numeric for plotting")
})

test_that("Ex 2: continent variable exists for color/fill mapping", {
  skip_if(!exists("plastic_waste"))
  expect_true("continent" %in% names(plastic_waste),
              label = "continent variable is needed for color and fill aesthetics in density plots")
})

test_that("Ex 2: plastic_waste_per_cap has non-missing values for plotting", {
  skip_if(!exists("plastic_waste"))
  expect_true(sum(!is.na(plastic_waste$plastic_waste_per_cap)) > 100,
              label = "plastic_waste_per_cap should have many non-missing values for meaningful density plots")
})
