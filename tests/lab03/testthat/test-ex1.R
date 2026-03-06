# Exercise 1: Dimensions and structure of the Nobel laureates dataset

test_that("Ex 1: nobel object exists in student environment", {
  skip_if(length(.rmd_content) == 0)
  potential_answers <- c(
    "read_csv.*nobel",
    "nobel\\s*<-",
    "nobel\\s*="
  )
  pattern <- paste0("(", paste(potential_answers, collapse = "|"), ")")
  answer_in_rmd <- stringr::str_detect(.rmd_content, pattern) |> any()
  expect_equal(answer_in_rmd, TRUE,
    info = "Make sure to load the Nobel dataset in your Rmd"
  )
})

test_that("Ex 1: nobel has more than 900 rows", {
  skip_if(!exists("nobel"))
  expect_gt(nrow(nobel), 900,
    label = "The Nobel dataset should have more than 900 rows"
  )
})

test_that("Ex 1: nobel has expected variables", {
  skip_if(!exists("nobel"))
  expected_vars <- c(
    "id", "firstname", "surname", "year", "category",
    "country", "gender", "born_country", "died_date"
  )
  expect_true(
    all(expected_vars %in% names(nobel)),
    label = paste("nobel should contain columns:", paste(expected_vars, collapse = ", "))
  )
})

test_that("Ex 1: Rmd reports number of observations using inline code", {
  skip_if(length(.rmd_content) == 0)
  potential_answers <- c(
    "nrow\\(nobel\\)",
    "dim\\(nobel\\)",
    "`r nrow",
    as.character(nrow(
      tryCatch(
        read.csv(
          file.path(Sys.getenv("STUDENT_CODE_DIR", "."), "data", "nobel.csv")
        ),
        error = function(e) data.frame()
      )
    ))
  )
  pattern <- paste0("(", paste(potential_answers, collapse = "|"), ")")
  answer_in_rmd <- stringr::str_detect(.rmd_content, pattern) |> any()
  expect_equal(answer_in_rmd, TRUE,
    info = "Ex 1: Report the number of observations using inline R code"
  )
})
