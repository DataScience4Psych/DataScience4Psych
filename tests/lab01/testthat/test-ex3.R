# Exercise 3: Plot y vs x for star dataset and calculate correlation
# Students should reuse the dino code pattern, replacing dataset name with "star"

test_that("Ex 3: star_data object exists", {
  expect_true(exists("star_data"),
              label = "star_data should be created by filtering datasaurus_dozen for dataset == 'star'")
})

test_that("Ex 3: star_data contains only star observations", {
  skip_if(!exists("star_data"))
  expect_true(
    all(star_data$dataset == "star"),
    label = "star_data should only contain rows where dataset == 'star'"
  )
})

test_that("Ex 3: star_data has 142 rows", {
  skip_if(!exists("star_data"))
  expect_equal(nrow(star_data), 142)
})

test_that("Ex 3: star_data has columns dataset, x, y", {
  skip_if(!exists("star_data"))
  expect_true(all(c("x", "y") %in% names(star_data)))
})

test_that("Ex 3: correlation for star is near zero (negative)", {
  skip_if(!exists("star_data"))
  r_star <- cor(star_data$x, star_data$y)
  expect_true(r_star > -0.1 && r_star < 0,
              label = sprintf("star correlation should be between -0.1 and 0, got %.4f", r_star)
  )
})

test_that("Ex 3: Rmd Exercise 3 contains star dataset code", {
  skip_if(length(.rmd_content) == 0)
  section <- .find_ex_section(.rmd_content, "3", "4")
  skip_if(is.null(section), "Could not locate Exercise 3 section in Rmd")
  has_star <- any(grepl("star", section, ignore.case = TRUE))
  expect_true(has_star,
              label = "Exercise 3 section should reference the 'star' dataset")
})
