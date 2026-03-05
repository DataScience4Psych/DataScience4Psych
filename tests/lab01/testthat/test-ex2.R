# Exercise 2: Filter dino dataset, plot y vs x, calculate correlation

test_that("Ex 2: dino_data object exists", {
  expect_true(exists("dino_data"),
              label = "dino_data should be created by filtering datasaurus_dozen for dataset == 'dino'"
  )
})

test_that("Ex 2: dino_data contains only dino observations", {
  skip_if(!exists("dino_data"))
  expect_true(
    all(dino_data$dataset == "dino"),
    label = "dino_data should only contain rows where dataset == 'dino'"
  )
})

test_that("Ex 2: dino_data has 142 rows", {
  skip_if(!exists("dino_data"))
  expect_equal(nrow(dino_data), 142)
})

test_that("Ex 2: dino_data has columns dataset, x, y", {
  skip_if(!exists("dino_data"))
  expect_true(all(c("x", "y") %in% names(dino_data)))
})

test_that("Ex 2: correlation between x and y for dino is near zero (negative)", {
  skip_if(!exists("dino_data"))
  r <- cor(dino_data$x, dino_data$y)
  expect_true(r > -0.1 && r < 0,
              label = sprintf("dino correlation should be between -0.1 and 0, got %.4f", r)
  )
})
