# Exercise 2: Density plots with alpha transparency

test_that("Ex 2: Rmd contains density plot with alpha level", {
  skip_if(length(.rmd_content) == 0)
  potential_answers <- c(
    "geom_density.*alpha",
    "alpha.*geom_density",
    "geom_density\\([^)]*alpha\\s*=\\s*[0-9]"
  )
  pattern <- paste0("(", paste(potential_answers, collapse = "|"), ")")
  answer_in_rmd <- stringr::str_detect(.rmd_content, pattern) |> any()
  expect_equal(answer_in_rmd, TRUE,
    info = "Ex 2.1: Make sure to use geom_density() with an alpha level"
  )
})

test_that("Ex 2: Rmd uses lower alpha than 0.7", {
  skip_if(length(.rmd_content) == 0)
  # Look for any alpha value less than 0.7 being used with geom_density
  potential_answers <- c(
    "alpha\\s*=\\s*0\\.[0-6]",
    "alpha\\s*=\\s*0\\.0[0-9]"
  )
  pattern <- paste0("(", paste(potential_answers, collapse = "|"), ")")
  answer_in_rmd <- stringr::str_detect(.rmd_content, pattern) |> any()
  expect_equal(answer_in_rmd, TRUE,
    info = "Ex 2.1: Use an alpha level lower than 0.7 for better visibility"
  )
})

test_that("Ex 2: Rmd maps color and fill to continent", {
  skip_if(length(.rmd_content) == 0)
  potential_answers <- c(
    "color\\s*=\\s*continent",
    "colour\\s*=\\s*continent",
    "fill\\s*=\\s*continent"
  )
  pattern <- paste0("(", paste(potential_answers, collapse = "|"), ")")
  answer_in_rmd <- stringr::str_detect(.rmd_content, pattern) |> any()
  expect_equal(answer_in_rmd, TRUE,
    info = "Ex 2.1: Map color/fill to continent in your density plot"
  )
})

test_that("Ex 2.2: Rmd explains alpha as geom characteristic, not aesthetic mapping", {
  skip_if(length(.rmd_content) == 0)
  ex2_section <- .find_ex_section(.rmd_content, "2", "3")
  if (is.null(ex2_section)) skip("Exercise 2 section not found")
  # Check that the section has some written explanation (more than just code)
  non_code_lines <- ex2_section[!grepl("^```|^#", ex2_section)]
  has_explanation <- length(non_code_lines) > 3
  expect_true(has_explanation,
    label = "Ex 2.2: Include a written explanation of why alpha is set in the geom, not aes()"
  )
})
