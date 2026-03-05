# Exercise 3: Plot y vs x for star dataset and calculate correlation
# Students should reuse the dino code pattern, replacing dataset name with "star"

test_that("Ex 3: star dataset exists in datasaurus_dozen", {
  data("datasaurus_dozen")
  expect_true("star" %in% datasaurus_dozen$dataset)
})

test_that("Ex 3: star dataset has 142 rows", {
  data("datasaurus_dozen")
  star_data <- dplyr::filter(datasaurus_dozen, dataset == "star")
  expect_equal(nrow(star_data), 142)
})

test_that("Ex 3: correlation for star is near zero (negative)", {
  data("datasaurus_dozen")
  star_data <- dplyr::filter(datasaurus_dozen, dataset == "star")
  r_star <- cor(star_data$x, star_data$y)
  expect_true(r_star > -0.1 && r_star < 0,
              label = sprintf("star correlation should be between -0.1 and 0, got %.4f", r_star)
  )
})

test_that("Ex 3: star and dino correlations are similar (within 0.05)", {
  data("datasaurus_dozen")
  r_dino <- cor(
    dplyr::filter(datasaurus_dozen, dataset == "dino")$x,
    dplyr::filter(datasaurus_dozen, dataset == "dino")$y
  )
  r_star <- cor(
    dplyr::filter(datasaurus_dozen, dataset == "star")$x,
    dplyr::filter(datasaurus_dozen, dataset == "star")$y
  )
  expect_true(abs(r_dino - r_star) < 0.05,
              label = "dino and star correlations should be very similar despite different shapes"
  )
})
