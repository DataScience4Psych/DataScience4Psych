# 1.  Based on the help file, how many rows and how many columns does the `datasaurus_dozen` file have? What are the variables included in the data frame? Add your responses to your lab report.

test_that("Example 1: Rmd Exercise 1 reports correct number of rows", {
  skip_if(length(.rmd_content) == 0)

  student_data <- get("datasaurus_dozen", envir = environment())
  solution_data <- get("datasaurus_dozen", envir = asNamespace("datasauRus"))


  student_answer <- nrow(student_data)
  solution_answer <- nrow(solution_data)



  potential_answers <- c("data\(datasaurus_dozen\)", "library\(datasauRus\)", "nrow\\(datasaurus_dozen\\)", as.character(solution_answer))


  pattern <- paste0("(", paste(potential_answers, collapse = "|"), ")")


  answer_in_rmd <- stringr::str_detect(.rmd_content, pattern) |> any()

  expect_equal(answer_in_rmd, TRUE,info = "Make sure to include the number of rows in the .rmd file")

})

