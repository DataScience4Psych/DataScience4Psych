# Exercise 2: Filter for white mothers and calculate mean weight

test_that("Ex 2: ncbirths_white object exists", {
  expect_true(exists("ncbirths_white"),
              label = "ncbirths_white should be created by filtering ncbirths for whitemom == 'white'")
})

test_that("Ex 2: ncbirths_white is a data frame", {
  skip_if(!exists("ncbirths_white"))
  expect_true(is.data.frame(ncbirths_white),
              label = "ncbirths_white should be a data frame")
})

test_that("Ex 2: ncbirths_white contains only white mothers", {
  skip_if(!exists("ncbirths_white"))
  skip_if(!"whitemom" %in% names(ncbirths_white))
  expect_true(all(ncbirths_white$whitemom == "white", na.rm = TRUE),
              label = "ncbirths_white should only contain rows where whitemom == 'white'")
})

test_that("Ex 2: ncbirths_white has fewer rows than ncbirths", {
  skip_if(!exists("ncbirths_white") || !exists("ncbirths"))
  expect_true(nrow(ncbirths_white) < nrow(ncbirths),
              label = "ncbirths_white should have fewer rows than the full ncbirths dataset")
})

test_that("Ex 2: ncbirths_white has weight variable", {
  skip_if(!exists("ncbirths_white"))
  expect_true("weight" %in% names(ncbirths_white),
              label = "ncbirths_white should retain the weight column")
})

test_that("Ex 2: mean weight of white mothers' babies is reasonable", {
  skip_if(!exists("ncbirths_white"))
  skip_if(!"weight" %in% names(ncbirths_white))
  m <- mean(ncbirths_white$weight, na.rm = TRUE)
  expect_true(m > 6.5 && m < 8.0,
              label = sprintf("Mean weight should be between 6.5 and 8.0 lbs, got %.2f", m))
})
