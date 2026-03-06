# 1.  Based on the help file, how many rows and how many columns does the `datasaurus_dozen` file have? What are the variables included in the data frame? Add your responses to your lab report.

test_that("Ex 1: datasaurus_dozen object exists in student environment", {
  skip_if(length(.rmd_content) == 0)

  potential_answers <- c("data\(datasaurus_dozen\)", "library\(datasauRus\)")
  pattern <- paste0("(", paste(potential_answers, collapse = "|"), ")")


  answer_in_rmd <- stringr::str_detect(.rmd_content, pattern) |> any()

  expect_equal(answer_in_rmd, TRUE,info = "Make sure to include the number of rows in the .rmd file")

})



test_that("Ex 1: Rmd Exercise 1 reports correct number of rows", {
  skip_if(length(.rmd_content) == 0)
  data("datasaurus_dozen", package = "datasauRus", envir = environment())
  solution_nrow <- as.character(nrow(get("datasaurus_dozen", envir = environment())))
  potential_answers <- c(solution_nrow, "nrow\\(datasaurus_dozen\\)", "names\\(datasaurus_dozen\\)")
  pattern <- paste0("(", paste(potential_answers, collapse = "|"), ")")

  answer_in_rmd <- stringr::str_detect(.rmd_content, pattern) |> any()

  expect_equal(answer_in_rmd, TRUE,
               info = "Make sure to include the number of rows in the .rmd file")
})


test_that("Ex 1: Rmd Exercise 1 reports correct number of variables", {

  potential_answers <- c("3\\s?(columns|variables)", "(ncol|length)\\(datasaurus_dozen\\)")
  pattern <- paste0("(", paste(potential_answers, collapse = "|"), ")")


  answer_in_rmd <- stringr::str_detect(.rmd_content, pattern) |> any()

  expect_equal(answer_in_rmd, TRUE, info = "Make sure to include the number of columns in the .rmd file")
})


test_that("Ex 1: datasaurus_dozen matches expected dimensions", {
  skip_if(!exists("datasaurus_dozen"))
  # Compute solution from the package
  data("datasaurus_dozen", package = "datasauRus", envir = environment())
  solution <- get("datasaurus_dozen", envir = environment())

  potential_answers <- c(solution_ncol, "ncol\\(datasaurus_dozen\\)", "names\\(datasaurus_dozen\\)")
  pattern <- paste0("(", paste(potential_answers, collapse = "|"), ")")


  expect_equal(nrow(datasaurus_dozen), nrow(solution),
               info = sprintf("Make sure datasaurus_dozen has %d rows", nrow(solution)))
  expect_equal(ncol(datasaurus_dozen), ncol(solution),
               info = sprintf("Make sure datasaurus_dozen has %d columns", ncol(solution)))
})

test_that("Ex 1: datasaurus_dozen has variables dataset, x, and y", {
  data("datasaurus_dozen")
  expect_setequal(names(datasaurus_dozen), c("dataset", "x", "y"))
})

test_that("Ex 1: datasaurus_dozen contains 13 datasets", {
  data("datasaurus_dozen")
  expect_equal(dplyr::n_distinct(datasaurus_dozen$dataset), 13)
})
