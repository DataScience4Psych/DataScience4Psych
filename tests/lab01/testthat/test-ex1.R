# Exercise 1: datasaurus_dozen dataset structure
# The help file says: 1846 rows, 3 columns (dataset, x, y)

test_that("Ex 1: Rmd Exercise 1 contains code exploring datasaurus_dozen", {
  skip_if(length(.rmd_content) == 0)
  section <- .find_ex_section(.rmd_content, "1", "2")
  skip_if(is.null(section), "Could not locate Exercise 1 section in Rmd")
  has_data <- any(grepl("datasaurus_dozen|datasauRus", section))
  expect_true(has_data,
              label = "Exercise 1 should reference datasaurus_dozen or the datasauRus package")
})

test_that("Ex 1: datasaurus_dozen object exists in student environment", {
  expect_true(exists("datasaurus_dozen"),
              label = "datasaurus_dozen should be loaded (e.g., via data(datasaurus_dozen) or library(datasauRus))")
})

test_that("Ex 1: datasaurus_dozen has 1846 rows", {
  skip_if(!exists("datasaurus_dozen"))
  expect_equal(nrow(datasaurus_dozen), 1846)
})

test_that("Ex 1: datasaurus_dozen has 3 columns", {
  skip_if(!exists("datasaurus_dozen"))
  expect_equal(ncol(datasaurus_dozen), 3)
})

test_that("Ex 1: datasaurus_dozen has variables dataset, x, and y", {
  skip_if(!exists("datasaurus_dozen"))
  expect_setequal(names(datasaurus_dozen), c("dataset", "x", "y"))
})

test_that("Ex 1: datasaurus_dozen contains 13 datasets", {
  skip_if(!exists("datasaurus_dozen"))
  expect_equal(dplyr::n_distinct(datasaurus_dozen$dataset), 13)
})
