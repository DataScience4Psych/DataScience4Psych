# Exercise 7: Intentionally misleading "opposite" visualization

test_that("Ex 7: Rmd creates an intentionally misleading visualization", {
  skip_if(length(.rmd_content) == 0)
  # Should have multiple ggplot calls (one honest, one misleading)
  ggplot_matches <- stringr::str_detect(.rmd_content, "ggplot\\(") |> which()
  expect_gt(sum(stringr::str_detect(.rmd_content, "ggplot")), 1,
    label = "Ex 7: Create a second (misleading) visualization in addition to the honest one"
  )
})

test_that("Ex 7: Rmd reflects on how visualization choices alter the message", {
  skip_if(length(.rmd_content) == 0)
  ex7_section <- .find_ex_section(.rmd_content, "7", "8")
  if (is.null(ex7_section)) skip("Exercise 7 section not found")
  non_code_lines <- ex7_section[!grepl("^```|^#|^\\s*$", ex7_section)]
  expect_true(length(non_code_lines) > 2,
    label = "Ex 7: Include a brief reflection on how visualization choices affect interpretation"
  )
})

test_that("Ex 8: Rmd includes analysis of a real-world misleading graph", {
  skip_if(length(.rmd_content) == 0)
  ex8_section <- .find_ex_section(.rmd_content, "8")
  if (is.null(ex8_section)) skip("Exercise 8 section not found")
  # Should have some text analysis of a misleading graph
  non_code_lines <- ex8_section[!grepl("^```|^#|^\\s*$", ex8_section)]
  expect_true(length(non_code_lines) > 3,
    label = "Ex 8: Include analysis of a real-world misleading graph"
  )
})
