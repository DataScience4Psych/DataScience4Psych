# Exercise 1: Load plastic_waste data and explore; histogram faceted by continent

test_that("Ex 1: plastic_waste object exists", {
  expect_true(exists("plastic_waste"),
              label = "plastic_waste should be created by reading data/plastic-waste.csv")
})

test_that("Ex 1: plastic_waste is a data frame", {
  skip_if(!exists("plastic_waste"))
  expect_true(is.data.frame(plastic_waste),
              label = "plastic_waste should be a data frame")
})

test_that("Ex 1: plastic_waste has 240 rows", {
  skip_if(!exists("plastic_waste"))
  expect_equal(nrow(plastic_waste), 240,
               label = "plastic_waste should have 240 observations")
})

test_that("Ex 1: plastic_waste has 10 columns", {
  skip_if(!exists("plastic_waste"))
  expect_equal(ncol(plastic_waste), 10,
               label = "plastic_waste should have 10 columns")
})

test_that("Ex 1: plastic_waste has expected column names", {
  skip_if(!exists("plastic_waste"))
  expected_cols <- c("code", "entity", "continent", "year",
                     "gdp_per_cap", "plastic_waste_per_cap",
                     "mismanaged_plastic_waste_per_cap",
                     "mismanaged_plastic_waste", "coastal_pop", "total_pop")
  expect_true(all(expected_cols %in% names(plastic_waste)),
              label = "plastic_waste should contain all expected variable names")
})

test_that("Ex 1: Trinidad and Tobago is the outlier above 3.5 kg/day", {
  skip_if(!exists("plastic_waste"))
  outlier <- plastic_waste[!is.na(plastic_waste$plastic_waste_per_cap) &
                             plastic_waste$plastic_waste_per_cap > 3.5, ]
  expect_equal(nrow(outlier), 1,
               label = "There should be exactly one country with plastic_waste_per_cap > 3.5")
  expect_true(grepl("Trinidad", outlier$entity),
              label = "The outlier country should be Trinidad and Tobago")
})

test_that("Ex 1: continent variable has at least 5 distinct values", {
  skip_if(!exists("plastic_waste"))
  n_continents <- length(unique(plastic_waste$continent[!is.na(plastic_waste$continent)]))
  expect_true(n_continents >= 5,
              label = "There should be at least 5 continents in the data")
})

test_that("Ex 1: Rmd Exercise 1 identifies the outlier country", {
  skip_if(length(.rmd_content) == 0)
  skip_if(!exists("plastic_waste"))
  solution_outlier <- plastic_waste$entity[!is.na(plastic_waste$plastic_waste_per_cap) &
                                             plastic_waste$plastic_waste_per_cap > 3.5]
  potential_answers <- c(as.character(solution_outlier), "filter\\(.*plastic_waste_per_cap")
  pattern <- paste0("(", paste(potential_answers, collapse = "|"), ")")
  answer_in_rmd <- stringr::str_detect(.rmd_content, pattern) |> any()
  expect_equal(answer_in_rmd, TRUE,
               info = sprintf("Make sure to identify %s as the outlier in the .rmd file", solution_outlier))
})
