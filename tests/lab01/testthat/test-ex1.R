# Exercise 1: datasaurus_dozen dataset structure
# The help file says: 1846 rows, 3 columns (dataset, x, y)

test_that("Ex 1: datasaurus_dozen has 1846 rows", {
  data("datasaurus_dozen")
  expect_equal(nrow(datasaurus_dozen), 1846)
})

test_that("Ex 1: datasaurus_dozen has 3 columns", {
  data("datasaurus_dozen")
  expect_equal(ncol(datasaurus_dozen), 3)
})

test_that("Ex 1: datasaurus_dozen has variables dataset, x, and y", {
  data("datasaurus_dozen")
  expect_setequal(names(datasaurus_dozen), c("dataset", "x", "y"))
})

test_that("Ex 1: datasaurus_dozen contains 13 datasets", {
  data("datasaurus_dozen")
  expect_equal(dplyr::n_distinct(datasaurus_dozen$dataset), 13)
})
