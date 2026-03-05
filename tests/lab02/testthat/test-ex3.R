# Exercise 3: Violin plots of plastic waste per capita by continent

test_that("Ex 3: plastic_waste object exists for violin plots", {
  expect_true(exists("plastic_waste"),
              label = "plastic_waste must exist before creating violin plots")
})

test_that("Ex 3: plastic_waste has continent for violin plot grouping", {
  skip_if(!exists("plastic_waste"))
  expect_true("continent" %in% names(plastic_waste),
              label = "continent is needed as the x-axis variable for violin plots")
})

test_that("Ex 3: plastic_waste has plastic_waste_per_cap for violin plot y-axis", {
  skip_if(!exists("plastic_waste"))
  expect_true("plastic_waste_per_cap" %in% names(plastic_waste),
              label = "plastic_waste_per_cap is needed as the y-axis variable for violin plots")
})

test_that("Ex 3: plastic_waste_per_cap has variation within continents", {
  skip_if(!exists("plastic_waste"))
  pw_clean <- plastic_waste[!is.na(plastic_waste$plastic_waste_per_cap) &
                              !is.na(plastic_waste$continent), ]
  sds <- tapply(pw_clean$plastic_waste_per_cap, pw_clean$continent, sd, na.rm = TRUE)
  expect_true(all(sds > 0),
              label = "Each continent should have variation in plastic_waste_per_cap for meaningful violin plots")
})
