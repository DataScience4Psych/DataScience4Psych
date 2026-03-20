# Exercise 4: Plot y vs x for circle dataset and calculate correlation

test_that("Ex 4: circle_data object exists", {
  expect_true(exists("circle_data"),
    info = "Create circle_data by filtering datasaurus_dozen for dataset == 'circle'"
  )
})

test_that("Ex 4: circle_data contains only circle observations", {
  skip_if(!exists("circle_data"))
  expect_true(
    all(circle_data$dataset == "circle"),
    info = "Make sure circle_data only contains rows where dataset == 'circle'"
  )
})

test_that("Ex 4: circle_data has correct number of rows", {
  skip_if(!exists("circle_data"))
  data("datasaurus_dozen", package = "datasauRus", envir = environment())
  solution_n <- nrow(dplyr::filter(get("datasaurus_dozen", envir = environment()), dataset == "circle"))
  expect_equal(nrow(circle_data), solution_n,
    info = sprintf("Make sure circle_data has %d rows", solution_n)
  )
})

test_that("Ex 4: circle_data has columns dataset, x, y", {
  skip_if(!exists("circle_data"))
  expect_true(all(c("x", "y") %in% names(circle_data)))
})

test_that("Ex 4: correlation for circle is near zero (negative)", {
  skip_if(!exists("circle_data"))
  r_circle <- cor(circle_data$x, circle_data$y)
  expect_true(r_circle > -0.1 && r_circle < 0,
    info = sprintf("Check your circle correlation calculation — it should be between -0.1 and 0, but got %.4f", r_circle)
  )
})

test_that("Ex 4: circle and dino correlations are similar (within 0.05)", {
  skip_if(!exists("circle_data") || !exists("dino_data"))
  r_dino <- cor(dino_data$x, dino_data$y)
  r_circle <- cor(circle_data$x, circle_data$y)
  expect_true(abs(r_dino - r_circle) < 0.05,
    info = "Verify that your dino and circle correlations are very similar despite different shapes"
  )
})

test_that("Ex 4: circle_data matches expected solution", {
  skip_if(!exists("circle_data"))
  data("datasaurus_dozen")
  solution_circle_data <- dplyr::filter(datasaurus_dozen, dataset == "circle")
  expect_equal(nrow(circle_data), nrow(solution_circle_data),
    info = "Make sure circle_data has the same number of rows as the correct solution"
  )
  expect_equal(sort(circle_data$x), sort(solution_circle_data$x),
    info = "Make sure circle_data x values match the correct solution"
  )
})

test_that("Ex 4: Rmd Exercise 4 contains circle dataset code", {
  skip_if(length(.rmd_content) == 0)
  potential_answers <- c("circle")
  pattern <- paste0("(", paste(potential_answers, collapse = "|"), ")")
  answer_in_rmd <- stringr::str_detect(.rmd_content, pattern) |> any()
  expect_equal(answer_in_rmd, TRUE,
    info = "Make sure to reference the 'circle' dataset in your Rmd file"
  )
})

test_that("Ex 4: Rmd Exercise 4 reports the circle correlation value", {
  skip_if(length(.rmd_content) == 0)
  skip_if(!exists("circle_data"))
  solution_r <- cor(circle_data$x, circle_data$y)
  potential_answers <- c(
    sprintf("%.4f", solution_r), sprintf("%.3f", solution_r),
    sprintf("%.2f", solution_r),
    "cor\\(circle_data\\$x", "cor\\(circle_data\\["
  )
  potential_answers <- gsub("-", "\\\\-", potential_answers)
  pattern <- paste0("(", paste(potential_answers, collapse = "|"), ")")
  answer_in_rmd <- stringr::str_detect(.rmd_content, pattern) |> any()
  expect_equal(answer_in_rmd, TRUE,
    info = "Make sure to include the circle correlation value in the .rmd file"
  )
})
