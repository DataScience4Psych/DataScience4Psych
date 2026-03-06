# Exercise 5: Recreate coastal population proportion plot

test_that("Ex 5: Rmd creates coastal_pop_prop variable", {
  skip_if(length(.rmd_content) == 0)
  potential_answers <- c(
    "coastal_pop_prop",
    "coastal_pop\\s*/\\s*total_pop"
  )
  pattern <- paste0("(", paste(potential_answers, collapse = "|"), ")")
  answer_in_rmd <- stringr::str_detect(.rmd_content, pattern) |> any()
  expect_equal(answer_in_rmd, TRUE,
    info = "Ex 5.1: Create a coastal_pop_prop variable (coastal_pop / total_pop)"
  )
})

test_that("Ex 5: Rmd filters out extreme outlier (plastic_waste_per_cap < 3)", {
  skip_if(length(.rmd_content) == 0)
  potential_answers <- c(
    "plastic_waste_per_cap\\s*<\\s*3",
    "filter.*plastic_waste_per_cap.*3"
  )
  pattern <- paste0("(", paste(potential_answers, collapse = "|"), ")")
  answer_in_rmd <- stringr::str_detect(.rmd_content, pattern) |> any()
  expect_equal(answer_in_rmd, TRUE,
    info = "Ex 5.1: Filter out extreme outlier (plastic_waste_per_cap < 3)"
  )
})

test_that("Ex 5: Rmd uses geom_smooth for trend line", {
  skip_if(length(.rmd_content) == 0)
  answer_in_rmd <- stringr::str_detect(.rmd_content, "geom_smooth") |> any()
  expect_equal(answer_in_rmd, TRUE,
    info = "Ex 5.1: Use geom_smooth() to add a trend line to the scatterplot"
  )
})

test_that("Ex 5: Rmd includes written interpretation of the plot", {
  skip_if(length(.rmd_content) == 0)
  ex5_section <- .find_ex_section(.rmd_content, "5")
  if (is.null(ex5_section)) skip("Exercise 5 section not found")
  non_code_lines <- ex5_section[!grepl("^```|^#|^\\s*$", ex5_section)]
  expect_true(length(non_code_lines) > 2,
    label = "Ex 5.1: Include written interpretation of the coastal population proportion plot"
  )
})
