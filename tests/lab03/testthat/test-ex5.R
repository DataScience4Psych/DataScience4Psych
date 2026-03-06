# Exercise 5: Enhanced faceted bar plot with born_country_us

test_that("Ex 5: Rmd adds born_country_us to the Ex 3 visualization", {
  skip_if(length(.rmd_content) == 0)
  potential_answers <- c(
    "born_country_us",
    "fill.*born_country",
    "color.*born_country"
  )
  pattern <- paste0("(", paste(potential_answers, collapse = "|"), ")")
  answer_in_rmd <- stringr::str_detect(.rmd_content, pattern) |> any()
  expect_equal(answer_in_rmd, TRUE,
    info = "Ex 5: Add born_country_us as a second variable to your Ex 3 visualization"
  )
})

test_that("Ex 5: Rmd still uses facet_wrap and geom_bar", {
  skip_if(length(.rmd_content) == 0)
  has_facet <- stringr::str_detect(.rmd_content, "facet_wrap|facet_grid") |> any()
  has_bar <- stringr::str_detect(.rmd_content, "geom_bar") |> any()
  expect_true(has_facet,
    label = "Ex 5: Keep facet_wrap in the visualization"
  )
  expect_true(has_bar,
    label = "Ex 5: Keep geom_bar in the visualization"
  )
})

test_that("Ex 5: Rmd includes written interpretation supporting/rejecting Buzzfeed claim", {
  skip_if(length(.rmd_content) == 0)
  ex5_section <- .find_ex_section(.rmd_content, "5", "6")
  if (is.null(ex5_section)) skip("Exercise 5 section not found")
  non_code_lines <- ex5_section[!grepl("^```|^#|^\\s*$", ex5_section)]
  expect_true(length(non_code_lines) > 2,
    label = "Ex 5: Include written interpretation about whether data supports the Buzzfeed claim"
  )
})
