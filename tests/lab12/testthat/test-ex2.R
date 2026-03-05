# Exercise 2: Filter for white mothers and calculate mean weight

test_that("Ex 2: ncbirths_white object exists", {
  expect_true(exists("ncbirths_white"),
              label = "ncbirths_white should be created by filtering for white mothers")
})

test_that("Ex 2: ncbirths_white contains only white mothers", {
  skip_if(!exists("ncbirths_white"))
  skip_if(!"whitemom" %in% names(ncbirths_white))
  expect_true(all(ncbirths_white$whitemom == "white", na.rm = TRUE),
              label = "ncbirths_white should only contain rows where whitemom == 'white'")
})

test_that("Ex 2: mean weight of white babies is approximately 7.25 lbs", {
  skip_if(!exists("ncbirths_white"))
  skip_if(!"weight" %in% names(ncbirths_white))
  m <- mean(ncbirths_white$weight, na.rm = TRUE)
  expect_true(m > 6.5 && m < 8.0,
              label = sprintf("Mean weight should be between 6.5 and 8.0, got %.2f", m))
})
