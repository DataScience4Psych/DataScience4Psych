# Exercise 1: datasaurus_dozen dataset structure
# The help file says: 1846 rows, 3 columns (dataset, x, y)

test_that("Ex 1: datasaurus_dozen has 1846 rows", {

  # check if 1846 is in the rmd file ".rmd_content"

  potential_answers <- c("1846", "nrow\\(datasaurus_dozen\\)")
  pattern <- paste0("(", paste(potential_answers, collapse = "|"), ")")


  answer_in_rmd <- stringr::str_detect(.rmd_content, pattern) |> any()

  expect_equal(answer_in_rmd, TRUE,info = "Make sure to include the number of rows in the .rmd file")

})

test_that("Ex 1: datasaurus_dozen has 3 columns", {

  potential_answers <- c("3\\s?columns", "(ncol|length)\\(datasaurus_dozen\\)")
  pattern <- paste0("(", paste(potential_answers, collapse = "|"), ")")


  answer_in_rmd <- stringr::str_detect(.rmd_content, pattern) |> any()

  expect_equal(answer_in_rmd, TRUE,info = "Make sure to include the number of columns in the .rmd file")
})

test_that("Ex 1: datasaurus_dozen has variables dataset, x, and y", {
  data("datasaurus_dozen")
  expect_setequal(names(datasaurus_dozen), c("dataset", "x", "y"))
})

test_that("Ex 1: datasaurus_dozen contains 13 datasets", {
  data("datasaurus_dozen")
  expect_equal(dplyr::n_distinct(datasaurus_dozen$dataset), 13)
})
