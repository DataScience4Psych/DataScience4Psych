# Exercise 3: Plot y vs x for star dataset and calculate correlation
# Students should reuse the dino code pattern, replacing dataset name with "star"

test_that("Ex 3: star_data object exists", {
  expect_true(exists("star_data"),
    info = "Create star_data by filtering datasaurus_dozen for dataset == 'star'"
  )
})

test_that("Ex 3: star_data contains only star observations", {
  skip_if(!exists("star_data"))
  expect_true(
    all(star_data$dataset == "star"),
    info = "Make sure star_data only contains rows where dataset == 'star'"
  )
})

test_that("Ex 3: star_data has correct number of rows", {
  skip_if(!exists("star_data"))
  data("datasaurus_dozen", package = "datasauRus", envir = environment())
  solution_n <- nrow(dplyr::filter(get("datasaurus_dozen", envir = environment()), dataset == "star"))
  expect_equal(nrow(star_data), solution_n,
    info = sprintf("Make sure star_data has %d rows", solution_n)
  )
})

test_that("Ex 3: star_data has columns dataset, x, y", {
  skip_if(!exists("star_data"))
  expect_true(all(c("x", "y") %in% names(star_data)))
})

test_that("Ex 3: correlation for star is near zero (negative)", {
  skip_if(!exists("star_data"))
  r_star <- cor(star_data$x, star_data$y)
  expect_true(r_star > -0.1 && r_star < 0,
    info = sprintf("Check your star correlation calculation — it should be between -0.1 and 0, but got %.4f", r_star)
  )
})

test_that("Ex 3: star and dino correlations are similar (within 0.05)", {
  skip_if(!exists("star_data") || !exists("dino_data"))
  r_dino <- cor(dino_data$x, dino_data$y)
  r_star <- cor(star_data$x, star_data$y)
  expect_true(abs(r_dino - r_star) < 0.05,
    info = "Verify that your dino and star correlations are very similar despite different shapes"
  )
})

test_that("Ex 3: star_data matches expected solution", {
  skip_if(!exists("star_data"))
  data("datasaurus_dozen")
  solution_star_data <- dplyr::filter(datasaurus_dozen, dataset == "star")
  expect_equal(nrow(star_data), nrow(solution_star_data),
    info = "Make sure star_data has the same number of rows as the correct solution"
  )
  expect_equal(sort(star_data$x), sort(solution_star_data$x),
    info = "Make sure star_data x values match the correct solution"
  )
})

test_that("Ex 3: Rmd Exercise 3 contains star dataset code", {
  skip_if(length(.rmd_content) == 0)
  potential_answers <- c("star")
  pattern <- paste0("(", paste(potential_answers, collapse = "|"), ")")
  answer_in_rmd <- stringr::str_detect(.rmd_content, pattern) |> any()
  expect_equal(answer_in_rmd, TRUE,
    info = "Make sure to reference the 'star' dataset in your Rmd file"
  )
})

test_that("Ex 3: Rmd Exercise 3 reports the star correlation value", {
  skip_if(length(.rmd_content) == 0)
  skip_if(!exists("star_data"))
  solution_r <- cor(star_data$x, star_data$y)
  potential_answers <- c(
    sprintf("%.4f", solution_r), sprintf("%.3f", solution_r),
    sprintf("%.2f", solution_r),
    "cor\\(star_data\\$x", "cor\\(star_data\\["
  )
  potential_answers <- gsub("-", "\\\\-", potential_answers)
  pattern <- paste0("(", paste(potential_answers, collapse = "|"), ")")
  answer_in_rmd <- stringr::str_detect(.rmd_content, pattern) |> any()
  expect_equal(answer_in_rmd, TRUE,
    info = "Make sure to include the star correlation value in the .rmd file"
  )
})
