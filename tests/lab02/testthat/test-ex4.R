# Exercise 4: Scatterplots of plastic waste relationships

test_that("Ex 4: scatterplot of plastic_waste_per_cap vs mismanaged can be created", {
  skip_if(!file.exists("data/plastic-waste.csv"))
  plastic_waste <- read.csv("data/plastic-waste.csv")
  p <- ggplot2::ggplot(
    data = plastic_waste,
    ggplot2::aes(x = mismanaged_plastic_waste_per_cap,
                 y = plastic_waste_per_cap)
  ) +
    ggplot2::geom_point()
  expect_s3_class(p, "ggplot")
})

test_that("Ex 4: scatterplot colored by continent can be created", {
  skip_if(!file.exists("data/plastic-waste.csv"))
  plastic_waste <- read.csv("data/plastic-waste.csv")
  p <- ggplot2::ggplot(
    data = plastic_waste,
    ggplot2::aes(x = mismanaged_plastic_waste_per_cap,
                 y = plastic_waste_per_cap,
                 color = continent)
  ) +
    ggplot2::geom_point()
  expect_s3_class(p, "ggplot")
})

test_that("Ex 4: plastic_waste_per_cap vs total_pop scatterplot can be created", {
  skip_if(!file.exists("data/plastic-waste.csv"))
  plastic_waste <- read.csv("data/plastic-waste.csv")
  p <- ggplot2::ggplot(
    data = plastic_waste,
    ggplot2::aes(x = total_pop, y = plastic_waste_per_cap)
  ) +
    ggplot2::geom_point()
  expect_s3_class(p, "ggplot")
})
