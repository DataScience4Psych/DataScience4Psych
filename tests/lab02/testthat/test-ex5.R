# Exercise 5: Recreate coastal population proportion plot

test_that("Ex 5: plastic_waste object exists for recreation plot", {
  expect_true(exists("plastic_waste"),
              label = "plastic_waste must exist to compute coastal_pop_prop")
})

test_that("Ex 5: coastal_pop and total_pop exist for computing coastal_pop_prop", {
  skip_if(!exists("plastic_waste"))
  expect_true(all(c("coastal_pop", "total_pop") %in% names(plastic_waste)),
              label = "coastal_pop and total_pop are needed to compute coastal_pop_prop")
})

test_that("Ex 5: coastal_pop_prop can be computed and filtered correctly", {
  skip_if(!exists("plastic_waste"))
  skip_if(!all(c("coastal_pop", "total_pop") %in% names(plastic_waste)))
  pw <- plastic_waste
  pw$coastal_pop_prop <- pw$coastal_pop / pw$total_pop
  result <- pw[!is.na(pw$plastic_waste_per_cap) & pw$plastic_waste_per_cap < 3, ]
  expect_true(nrow(result) > 0,
              label = "Filtering for plastic_waste_per_cap < 3 should retain rows")
  expect_true("coastal_pop_prop" %in% names(result),
              label = "coastal_pop_prop should be computable from coastal_pop / total_pop")
})

test_that("Ex 5: coastal_pop_prop values are between 0 and 1 (mostly)", {
  skip_if(!exists("plastic_waste"))
  skip_if(!all(c("coastal_pop", "total_pop") %in% names(plastic_waste)))
  pw <- plastic_waste
  pw$coastal_pop_prop <- pw$coastal_pop / pw$total_pop
  pw_clean <- pw[!is.na(pw$coastal_pop_prop), ]
  med <- median(pw_clean$coastal_pop_prop, na.rm = TRUE)
  expect_true(med >= 0 && med <= 1,
              label = "Median coastal_pop_prop should be between 0 and 1")
})
