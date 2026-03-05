# Exercise 1: Get to know the Nobel data

test_that("Ex 1: nobel data can be loaded", {
  skip_if(!file.exists("data/nobel.csv"), message = "data/nobel.csv not found")
  nobel <- readr::read_csv("data/nobel.csv", show_col_types = FALSE)
  expect_true(nrow(nobel) > 0)
})

test_that("Ex 1: nobel has expected key variables", {
  skip_if(!file.exists("data/nobel.csv"))
  nobel <- readr::read_csv("data/nobel.csv", show_col_types = FALSE)
  expected_cols <- c("id", "firstname", "surname", "year", "category",
                     "country", "gender", "born_country")
  expect_true(all(expected_cols %in% names(nobel)),
              label = "nobel should contain key variables")
})

test_that("Ex 1: nobel has multiple categories of prizes", {
  skip_if(!file.exists("data/nobel.csv"))
  nobel <- readr::read_csv("data/nobel.csv", show_col_types = FALSE)
  n_cats <- dplyr::n_distinct(nobel$category)
  expect_true(n_cats >= 6,
              label = "There should be at least 6 prize categories")
})
