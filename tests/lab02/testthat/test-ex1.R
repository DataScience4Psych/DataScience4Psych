# Exercise 1: Histogram of plastic waste per capita faceted by continent

test_that("Ex 1: plastic_waste data can be loaded", {
  skip_if(!file.exists("data/plastic-waste.csv"), message = "data/plastic-waste.csv not found")
  plastic_waste <- read.csv("data/plastic-waste.csv")
  expect_true(nrow(plastic_waste) > 0)
})

test_that("Ex 1: plastic_waste has expected columns", {
  skip_if(!file.exists("data/plastic-waste.csv"))
  plastic_waste <- read.csv("data/plastic-waste.csv")
  expected_cols <- c("code", "entity", "continent", "year",
                     "gdp_per_cap", "plastic_waste_per_cap",
                     "mismanaged_plastic_waste_per_cap",
                     "mismanaged_plastic_waste", "coastal_pop", "total_pop")
  expect_true(all(expected_cols %in% names(plastic_waste)),
              label = "plastic_waste should contain all expected variable names")
})

test_that("Ex 1: Trinidad and Tobago is the outlier above 3.5 kg/day", {
  skip_if(!file.exists("data/plastic-waste.csv"))
  plastic_waste <- read.csv("data/plastic-waste.csv")
  outlier <- plastic_waste %>%
    dplyr::filter(plastic_waste_per_cap > 3.5)
  expect_equal(nrow(outlier), 1)
  expect_true(grepl("Trinidad", outlier$entity),
              label = "The outlier country should be Trinidad and Tobago")
})

test_that("Ex 1: faceted histogram can be created without error", {
  skip_if(!file.exists("data/plastic-waste.csv"))
  plastic_waste <- read.csv("data/plastic-waste.csv")
  p <- ggplot2::ggplot(plastic_waste, ggplot2::aes(x = plastic_waste_per_cap)) +
    ggplot2::geom_histogram(binwidth = 0.2) +
    ggplot2::facet_wrap(~continent)
  expect_s3_class(p, "ggplot")
})
