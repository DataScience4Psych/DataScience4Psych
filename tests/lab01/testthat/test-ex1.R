# Exercise 1: datasaurus_dozen dataset structure
# The help file says: 1846 rows, 3 columns (dataset, x, y)

test_that("Ex 1: datasaurus_dozen has 1846 rows", {

  # check if 1846 is in the rmd file ".rmd_content"

  an_in_rmd <- any(str_detect(.rmd_content, "1846")||str_detect(.rmd_content, "nrow(datasaurus_dozen)"))

  expect_true(an_in_rmd, info = "Make sure to include the number of rows in the .rmd file")

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
