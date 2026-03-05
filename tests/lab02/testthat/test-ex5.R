# Exercise 5: Recreate coastal population proportion plot

test_that("Ex 5: coastal_pop_prop can be computed", {
  skip_if(!file.exists("data/plastic-waste.csv"))
  plastic_waste <- read.csv("data/plastic-waste.csv")
  result <- plastic_waste %>%
    dplyr::mutate(coastal_pop_prop = coastal_pop / total_pop) %>%
    dplyr::filter(plastic_waste_per_cap < 3)
  expect_true("coastal_pop_prop" %in% names(result))
  expect_true(nrow(result) > 0)
})

test_that("Ex 5: final recreation plot can be built without error", {
  skip_if(!file.exists("data/plastic-waste.csv"))
  plastic_waste <- read.csv("data/plastic-waste.csv")
  p <- plastic_waste %>%
    dplyr::mutate(coastal_pop_prop = coastal_pop / total_pop) %>%
    dplyr::filter(plastic_waste_per_cap < 3) %>%
    ggplot2::ggplot(ggplot2::aes(
      x = coastal_pop_prop,
      y = plastic_waste_per_cap,
      color = continent
    )) +
    ggplot2::geom_point() +
    ggplot2::geom_smooth(color = "black")
  expect_s3_class(p, "ggplot")
})
