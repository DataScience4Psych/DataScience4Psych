# Exercise 4: Plot y vs x for circle dataset and calculate correlation

test_that("Ex 4: circle_data object exists", {
  expect_true(exists("circle_data"),
              label = "circle_data should be created by filtering datasaurus_dozen for dataset == 'circle'")
})

test_that("Ex 4: circle_data contains only circle observations", {
  skip_if(!exists("circle_data"))
  expect_true(
    all(circle_data$dataset == "circle"),
    label = "circle_data should only contain rows where dataset == 'circle'"
  )
})

test_that("Ex 4: circle_data has 142 rows", {
  skip_if(!exists("circle_data"))
  expect_equal(nrow(circle_data), 142)
})

test_that("Ex 4: circle_data has columns dataset, x, y", {
  skip_if(!exists("circle_data"))
  expect_true(all(c("x", "y") %in% names(circle_data)))
})

test_that("Ex 4: correlation for circle is near zero (negative)", {
  skip_if(!exists("circle_data"))
  r_circle <- cor(circle_data$x, circle_data$y)
  expect_true(r_circle > -0.1 && r_circle < 0,
              label = sprintf("circle correlation should be between -0.1 and 0, got %.4f", r_circle)
  )
})

test_that("Ex 4: Rmd Exercise 4 contains circle dataset code", {
  skip_if(length(.rmd_content) == 0)
  section <- .find_ex_section(.rmd_content, "4", "5")
  skip_if(is.null(section), "Could not locate Exercise 4 section in Rmd")
  has_circle <- any(grepl("circle", section, ignore.case = TRUE))
  expect_true(has_circle,
              label = "Exercise 4 section should reference the 'circle' dataset")
})
