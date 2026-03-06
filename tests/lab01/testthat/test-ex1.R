# Exercise 1: datasaurus_dozen dataset structure
# Compute solution values from the package data so we don't hardcode numbers

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

test_that("Ex 1: datasaurus_dozen matches expected dimensions", {
  skip_if(!exists("datasaurus_dozen"))
  # Compute solution from the package
  data("datasaurus_dozen", package = "datasauRus", envir = environment())
  solution <- get("datasaurus_dozen", envir = environment())
  expect_equal(nrow(datasaurus_dozen), nrow(solution),
               label = sprintf("datasaurus_dozen should have %d rows", nrow(solution)))
  expect_equal(ncol(datasaurus_dozen), ncol(solution),
               label = sprintf("datasaurus_dozen should have %d columns", ncol(solution)))
})

test_that("Ex 1: datasaurus_dozen has variables dataset, x, and y", {
  skip_if(!exists("datasaurus_dozen"))
  data("datasaurus_dozen", package = "datasauRus", envir = environment())
  solution <- get("datasaurus_dozen", envir = environment())
  expect_setequal(names(datasaurus_dozen), names(solution))
})

test_that("Ex 1: datasaurus_dozen contains expected number of datasets", {
  skip_if(!exists("datasaurus_dozen"))
  data("datasaurus_dozen", package = "datasauRus", envir = environment())
  solution <- get("datasaurus_dozen", envir = environment())
  solution_n <- dplyr::n_distinct(solution$dataset)
  expect_equal(dplyr::n_distinct(datasaurus_dozen$dataset), solution_n,
               label = sprintf("datasaurus_dozen should contain %d datasets", solution_n))
})
