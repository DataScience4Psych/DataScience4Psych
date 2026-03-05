# Exercise 5-7: Smoking vs birth weight comparison

test_that("Ex 5: boxplot of weight by habit can be created", {
  skip_if(!requireNamespace("openintro", quietly = TRUE))
  data("ncbirths", package = "openintro")
  p <- ggplot2::ggplot(ncbirths, ggplot2::aes(x = habit, y = weight)) +
    ggplot2::geom_boxplot()
  expect_s3_class(p, "ggplot")
})

test_that("Ex 6: ncbirths_clean object exists", {
  expect_true(exists("ncbirths_clean") || exists("ncbirths_habitweight"),
              label = "A cleaned dataset removing NA habit/weight should exist")
})

test_that("Ex 7: non-smokers have higher average birth weight", {
  skip_if(!requireNamespace("openintro", quietly = TRUE))
  data("ncbirths", package = "openintro")
  clean <- ncbirths %>%
    dplyr::filter(!is.na(habit), !is.na(weight))
  means <- clean %>%
    dplyr::group_by(habit) %>%
    dplyr::summarize(mean_weight = mean(weight), .groups = "drop")
  nonsmoker_mean <- means$mean_weight[means$habit == "nonsmoker"]
  smoker_mean <- means$mean_weight[means$habit == "smoker"]
  expect_true(nonsmoker_mean > smoker_mean,
              label = "Non-smokers should have higher average birth weight than smokers")
})
