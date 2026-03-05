# Exercise 3: Violin plots of plastic waste per capita by continent

test_that("Ex 3: violin plot can be created without error", {
  skip_if(!file.exists("data/plastic-waste.csv"))
  plastic_waste <- read.csv("data/plastic-waste.csv")
  p <- ggplot2::ggplot(
    data = plastic_waste,
    mapping = ggplot2::aes(x = continent, y = plastic_waste_per_cap)
  ) +
    ggplot2::geom_violin()
  expect_s3_class(p, "ggplot")
})
