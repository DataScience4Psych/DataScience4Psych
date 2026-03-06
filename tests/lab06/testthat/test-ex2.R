# Exercise 2: Improve the instructional staff plot to highlight part-time faculty trend

test_that("Ex 2: Rmd highlights part-time faculty in improved plot", {
  skip_if(length(.rmd_content) == 0)
  potential_answers <- c(
    "Part-Time",
    "part.time",
    "part_time"
  )
  pattern <- paste0("(", paste(potential_answers, collapse = "|"), ")")
  answer_in_rmd <- stringr::str_detect(.rmd_content, pattern) |> any()
  expect_equal(answer_in_rmd, TRUE,
    info = "Ex 2: Your improved plot should highlight the part-time faculty trend"
  )
})

test_that("Ex 2: Rmd includes written documentation of changes made", {
  skip_if(length(.rmd_content) == 0)
  ex2_section <- .find_ex_section(.rmd_content, "2", "3")
  if (is.null(ex2_section)) skip("Exercise 2 section not found")
  non_code_lines <- ex2_section[!grepl("^```|^#|^\\s*$", ex2_section)]
  expect_true(length(non_code_lines) > 3,
    label = "Ex 2: Document the changes you made to improve the visualization"
  )
})

test_that("Ex 2: Rmd includes improved plot with ggplot2", {
  skip_if(length(.rmd_content) == 0)
  answer_in_rmd <- stringr::str_detect(.rmd_content, "ggplot") |> any()
  expect_equal(answer_in_rmd, TRUE,
    info = "Ex 2: Create the improved visualization using ggplot2"
  )
})
