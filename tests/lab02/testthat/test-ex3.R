# Exercise 3: Violin plots — plastic waste per capita by continent

test_that("Ex 3: Rmd contains violin plot", {
  skip_if(length(.rmd_content) == 0)
  potential_answers <- c(
    "geom_violin"
  )
  pattern <- paste0("(", paste(potential_answers, collapse = "|"), ")")
  answer_in_rmd <- stringr::str_detect(.rmd_content, pattern) |> any()
  expect_equal(answer_in_rmd, TRUE,
    info = "Ex 3.1: Convert box plots to violin plots using geom_violin()"
  )
})

test_that("Ex 3: Violin plot maps continent to x-axis", {
  skip_if(length(.rmd_content) == 0)
  potential_answers <- c(
    "x\\s*=\\s*continent",
    "aes.*continent"
  )
  pattern <- paste0("(", paste(potential_answers, collapse = "|"), ")")
  answer_in_rmd <- stringr::str_detect(.rmd_content, pattern) |> any()
  expect_equal(answer_in_rmd, TRUE,
    info = "Ex 3.1: Map continent to the x-axis in your violin plot"
  )
})

test_that("Ex 3: Violin plot maps plastic_waste_per_cap to y-axis", {
  skip_if(length(.rmd_content) == 0)
  potential_answers <- c(
    "y\\s*=\\s*plastic_waste_per_cap",
    "aes.*plastic_waste_per_cap"
  )
  pattern <- paste0("(", paste(potential_answers, collapse = "|"), ")")
  answer_in_rmd <- stringr::str_detect(.rmd_content, pattern) |> any()
  expect_equal(answer_in_rmd, TRUE,
    info = "Ex 3.1: Map plastic_waste_per_cap to the y-axis"
  )
})

test_that("Ex 3: Rmd includes written comparison of violin vs box plot", {
  skip_if(length(.rmd_content) == 0)
  ex3_section <- .find_ex_section(.rmd_content, "3", "4")
  if (is.null(ex3_section)) skip("Exercise 3 section not found")
  non_code_lines <- ex3_section[!grepl("^```|^#|^\\s*$", ex3_section)]
  expect_true(length(non_code_lines) > 2,
    label = "Ex 3.1: Include written interpretation comparing violin and box plots"
  )
})
