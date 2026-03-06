# Exercise 1: datasaurus_dozen dataset structure
# Compute solution values from the package data so we don't hardcode numbers

test_that("Ex 1: Rmd Exercise 1 contains code exploring datasaurus_dozen", {
  skip_if(length(.rmd_content) == 0)
  potential_answers <- c("datasaurus_dozen", "datasauRus")
  pattern <- paste0("(", paste(potential_answers, collapse = "|"), ")")
  answer_in_rmd <- stringr::str_detect(.rmd_content, pattern) |> any()
  expect_equal(answer_in_rmd, TRUE,
               info = "Make sure to reference datasaurus_dozen or the datasauRus package in your Rmd file")
})

test_that("Ex 1: Rmd Exercise 1 reports correct number of rows", {
  skip_if(length(.rmd_content) == 0)
  data("datasaurus_dozen", package = "datasauRus", envir = environment())
  solution_nrow <- as.character(nrow(get("datasaurus_dozen", envir = environment())))
  potential_answers <- c(solution_nrow, "nrow\\(datasaurus_dozen\\)")
  pattern <- paste0("(", paste(potential_answers, collapse = "|"), ")")
  answer_in_rmd <- stringr::str_detect(.rmd_content, pattern) |> any()
  expect_equal(answer_in_rmd, TRUE,
               info = "Make sure to include the number of rows in the .rmd file")
})

test_that("Ex 1: Rmd Exercise 1 reports correct number of variables", {
  skip_if(length(.rmd_content) == 0)
  data("datasaurus_dozen", package = "datasauRus", envir = environment())
  solution_ncol <- as.character(ncol(get("datasaurus_dozen", envir = environment())))
  potential_answers <- c(solution_ncol, "ncol\\(datasaurus_dozen\\)", "names\\(datasaurus_dozen\\)")
  pattern <- paste0("(", paste(potential_answers, collapse = "|"), ")")
  answer_in_rmd <- stringr::str_detect(.rmd_content, pattern) |> any()
  expect_equal(answer_in_rmd, TRUE,
               info = "Make sure to include the number of variables in the .rmd file")
})

test_that("Ex 1: datasaurus_dozen object exists in student environment", {
  expect_true(exists("datasaurus_dozen"),
              info = "Load datasaurus_dozen (e.g., via data(datasaurus_dozen) or library(datasauRus))")
})

test_that("Ex 1: datasaurus_dozen matches expected dimensions", {
  skip_if(!exists("datasaurus_dozen"))
  # Compute solution from the package
  data("datasaurus_dozen", package = "datasauRus", envir = environment())
  solution <- get("datasaurus_dozen", envir = environment())
  expect_equal(nrow(datasaurus_dozen), nrow(solution),
               info = sprintf("Make sure datasaurus_dozen has %d rows", nrow(solution)))
  expect_equal(ncol(datasaurus_dozen), ncol(solution),
               info = sprintf("Make sure datasaurus_dozen has %d columns", ncol(solution)))
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
               info = sprintf("Make sure datasaurus_dozen contains %d datasets", solution_n))
})
