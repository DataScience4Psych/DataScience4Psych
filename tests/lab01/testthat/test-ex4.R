# Exercise 4: Plot y vs x for circle dataset and calculate correlation

test_that("Ex 4: circle dataset exists in datasaurus_dozen", {
  data("datasaurus_dozen")
  expect_true("circle" %in% datasaurus_dozen$dataset)
})

test_that("Ex 4: circle dataset has 142 rows", {
  data("datasaurus_dozen")
  circle_data <- dplyr::filter(datasaurus_dozen, dataset == "circle")
  expect_equal(nrow(circle_data), 142)
})

test_that("Ex 4: correlation for circle is near zero (negative)", {
  data("datasaurus_dozen")
  circle_data <- dplyr::filter(datasaurus_dozen, dataset == "circle")
  r_circle <- cor(circle_data$x, circle_data$y)
  expect_true(r_circle > -0.1 && r_circle < 0,
              label = sprintf("circle correlation should be between -0.1 and 0, got %.4f", r_circle)
  )
})

test_that("Ex 4: circle and dino correlations are similar (within 0.05)", {
  data("datasaurus_dozen")
  r_dino <- cor(
    dplyr::filter(datasaurus_dozen, dataset == "dino")$x,
    dplyr::filter(datasaurus_dozen, dataset == "dino")$y
  )
  r_circle <- cor(
    dplyr::filter(datasaurus_dozen, dataset == "circle")$x,
    dplyr::filter(datasaurus_dozen, dataset == "circle")$y
  )
  expect_true(abs(r_dino - r_circle) < 0.05,
              label = "dino and circle correlations should be very similar despite different shapes"
  )
})
