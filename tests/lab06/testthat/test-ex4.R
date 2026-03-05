# Exercises 4-10: Whickham smoking data (stretch goals)

test_that("Ex 4-6: Whickham data can be loaded from mosaicData", {
  skip_if(!requireNamespace("mosaicData", quietly = TRUE),
          message = "mosaicData package not available")
  data("Whickham", package = "mosaicData")
  expect_true(nrow(Whickham) > 0)
})

test_that("Ex 4-6: Whickham has expected variables", {
  skip_if(!requireNamespace("mosaicData", quietly = TRUE))
  data("Whickham", package = "mosaicData")
  expect_true(all(c("outcome", "smoker", "age") %in% names(Whickham)),
              label = "Whickham should contain outcome, smoker, and age")
})

test_that("Ex 6: Whickham has 1314 observations", {
  skip_if(!requireNamespace("mosaicData", quietly = TRUE))
  data("Whickham", package = "mosaicData")
  expect_equal(nrow(Whickham), 1314)
})

test_that("Ex 9: age_cat variable can be created", {
  skip_if(!requireNamespace("mosaicData", quietly = TRUE))
  data("Whickham", package = "mosaicData")
  result <- Whickham %>%
    dplyr::mutate(age_cat = dplyr::case_when(
      age <= 44 ~ "18-44",
      age > 44 & age <= 64 ~ "45-64",
      age > 64 ~ "65+"
    ))
  expect_true("age_cat" %in% names(result))
  expect_equal(dplyr::n_distinct(result$age_cat), 3)
})
