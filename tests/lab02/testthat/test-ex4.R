# Exercise 4: Scatterplots of plastic waste relationships colored by continent

test_that("Ex 4: plastic_waste object exists for scatterplots", {
  expect_true(exists("plastic_waste"),
              label = "plastic_waste must exist before creating scatterplots")
})

test_that("Ex 4: plastic_waste has mismanaged_plastic_waste_per_cap for scatterplot", {
  skip_if(!exists("plastic_waste"))
  expect_true("mismanaged_plastic_waste_per_cap" %in% names(plastic_waste),
              label = "mismanaged_plastic_waste_per_cap is needed for the scatterplot")
})

test_that("Ex 4: plastic_waste has total_pop for population scatterplot", {
  skip_if(!exists("plastic_waste"))
  expect_true("total_pop" %in% names(plastic_waste),
              label = "total_pop is needed for the population vs plastic waste scatterplot")
})

test_that("Ex 4: plastic_waste has coastal_pop for coastal population scatterplot", {
  skip_if(!exists("plastic_waste"))
  expect_true("coastal_pop" %in% names(plastic_waste),
              label = "coastal_pop is needed for the coastal population vs plastic waste scatterplot")
})

test_that("Ex 4: key numeric variables have sufficient non-missing values", {
  skip_if(!exists("plastic_waste"))
  expect_true(sum(!is.na(plastic_waste$mismanaged_plastic_waste_per_cap)) > 100,
              label = "mismanaged_plastic_waste_per_cap should have many non-missing values")
  expect_true(sum(!is.na(plastic_waste$total_pop)) > 100,
              label = "total_pop should have many non-missing values")
  expect_true(sum(!is.na(plastic_waste$coastal_pop)) > 100,
              label = "coastal_pop should have many non-missing values")
})
