# Exercise 2: Filter dino dataset, plot y vs x, calculate correlation

test_that("Ex 2: dino_data object exists", {
  expect_true(exists("dino_data"),
              label = "dino_data should be created by filtering datasaurus_dozen for dataset == 'dino'"
  )
})

test_that("Ex 2: dino_data contains only dino observations", {
  skip_if(!exists("dino_data"))
  expect_true(
    all(dino_data$dataset == "dino"),
    label = "dino_data should only contain rows where dataset == 'dino'"
  )
})

test_that("Ex 2: dino_data has correct number of rows", {
  skip_if(!exists("dino_data"))
  data("datasaurus_dozen", package = "datasauRus", envir = environment())
  solution_n <- nrow(dplyr::filter(get("datasaurus_dozen", envir = environment()), dataset == "dino"))
  expect_equal(nrow(dino_data), solution_n,
               label = sprintf("dino_data should have %d rows", solution_n))
})

test_that("Ex 2: dino_data has columns dataset, x, y", {
  skip_if(!exists("dino_data"))
  expect_true(all(c("x", "y") %in% names(dino_data)))
})

test_that("Ex 2: correlation between x and y for dino is near zero (negative)", {
  skip_if(!exists("dino_data"))
  r <- cor(dino_data$x, dino_data$y)
  expect_true(r > -0.1 && r < 0,
              label = sprintf("dino correlation should be between -0.1 and 0, got %.4f", r)
  )
})

test_that("Ex 2: Rmd Exercise 2 reports the dino correlation value", {
  skip_if(length(.rmd_content) == 0)
  skip_if(!exists("dino_data"))
  solution_r <- cor(dino_data$x, dino_data$y)
  potential_answers <- c(sprintf("%.4f", solution_r), sprintf("%.3f", solution_r),
                         sprintf("%.2f", solution_r),
                         "cor\\(dino_data\\$x", "cor\\(dino_data\\[")
  potential_answers <- gsub("-", "\\\\-", potential_answers)
  pattern <- paste0("(", paste(potential_answers, collapse = "|"), ")")
  answer_in_rmd <- stringr::str_detect(.rmd_content, pattern) |> any()
  expect_equal(answer_in_rmd, TRUE,
               info = "Make sure to include the dino correlation value in the .rmd file")
})
