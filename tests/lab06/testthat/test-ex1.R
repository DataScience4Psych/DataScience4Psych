# Exercise 1: Instructional staff line plot

test_that("Ex 1: Rmd loads instructional-staff data", {
  skip_if(length(.rmd_content) == 0)
  potential_answers <- c(
    "instructional-staff",
    "staff\\s*<-",
    "staff\\s*="
  )
  pattern <- paste0("(", paste(potential_answers, collapse = "|"), ")")
  answer_in_rmd <- stringr::str_detect(.rmd_content, pattern) |> any()
  expect_equal(answer_in_rmd, TRUE,
    info = "Ex 1: Load the instructional-staff.csv dataset in your Rmd"
  )
})

test_that("Ex 1: staff data frame has expected structure", {
  skip_if(!exists("staff"))
  expect_gt(nrow(staff), 0,
    label = "staff data frame should have more than 0 rows"
  )
})

test_that("Ex 1: Rmd uses geom_line for the line plot", {
  skip_if(length(.rmd_content) == 0)
  answer_in_rmd <- stringr::str_detect(.rmd_content, "geom_line") |> any()
  expect_equal(answer_in_rmd, TRUE,
    info = "Ex 1: Use geom_line() to create the instructional staff line plot"
  )
})

test_that("Ex 1: Rmd includes axis labels and title", {
  skip_if(length(.rmd_content) == 0)
  potential_answers <- c(
    "labs\\(",
    "xlab\\(",
    "ylab\\(",
    "ggtitle\\("
  )
  pattern <- paste0("(", paste(potential_answers, collapse = "|"), ")")
  answer_in_rmd <- stringr::str_detect(.rmd_content, pattern) |> any()
  expect_equal(answer_in_rmd, TRUE,
    info = "Ex 1: Fix the title and axis labels using labs() or similar"
  )
})
