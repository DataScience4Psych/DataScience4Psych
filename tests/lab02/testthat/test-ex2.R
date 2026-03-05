# Exercise 2: Density plots with alpha, color, and fill aesthetics

test_that("Ex 2: density plot with color and fill by continent can be created", {
  skip_if(!file.exists("data/plastic-waste.csv"))
  plastic_waste <- read.csv("data/plastic-waste.csv")
  p <- ggplot2::ggplot(
    data = plastic_waste,
    mapping = ggplot2::aes(
      x = plastic_waste_per_cap,
      color = continent,
      fill = continent
    )
  ) +
    ggplot2::geom_density(alpha = 0.3)
  expect_s3_class(p, "ggplot")
})

test_that("Ex 2: there are multiple continents in the data", {
  skip_if(!file.exists("data/plastic-waste.csv"))
  plastic_waste <- read.csv("data/plastic-waste.csv")
  n_continents <- dplyr::n_distinct(plastic_waste$continent, na.rm = TRUE)
  expect_true(n_continents >= 5,
              label = "There should be at least 5 continents in the data")
})
