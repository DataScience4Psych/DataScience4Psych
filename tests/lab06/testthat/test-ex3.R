# Exercise 3: Improve the fisheries visualization

test_that("Ex 3: fisheries data frame exists", {
  expect_true(exists("fisheries"),
    label = "fisheries data frame should be loaded from data/fisheries.csv"
  )
})

test_that("Ex 3: Rmd loads fisheries data", {
  skip_if(length(.rmd_content) == 0)
  potential_answers <- c(
    "fisheries",
    "read_csv.*fisheries",
    "read\\.csv.*fisheries"
  )
  pattern <- paste0("(", paste(potential_answers, collapse = "|"), ")")
  answer_in_rmd <- stringr::str_detect(.rmd_content, pattern) |> any()
  expect_equal(answer_in_rmd, TRUE,
    info = "Ex 3: Load the fisheries dataset in your Rmd"
  )
})

test_that("Ex 3: Rmd includes brainstorming of improvements for fisheries plot", {
  skip_if(length(.rmd_content) == 0)
  ex3_section <- .find_ex_section(.rmd_content, "3", "4")
  if (is.null(ex3_section)) skip("Exercise 3 section not found")
  non_code_lines <- ex3_section[!grepl("^```|^#|^\\s*$", ex3_section)]
  expect_true(length(non_code_lines) > 3,
    label = "Ex 3.1: Brainstorm improvements to the fisheries visualization"
  )
})

test_that("Ex 3: Rmd includes improved fisheries plot", {
  skip_if(length(.rmd_content) == 0)
  has_fisheries <- stringr::str_detect(.rmd_content, "fisheries") |> any()
  has_ggplot <- stringr::str_detect(.rmd_content, "ggplot") |> any()
  expect_true(has_fisheries && has_ggplot,
    label = "Ex 3.2: Create an improved visualization for the fisheries data"
  )
})
