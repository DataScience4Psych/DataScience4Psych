# Exercises 12-16: Sources of bias and designing fairer algorithms

test_that("Ex 12: Rmd visualizes priors_count vs decile_score colored by race", {
  skip_if(length(.rmd_content) == 0)
  has_priors <- stringr::str_detect(.rmd_content, "priors_count") |> any()
  has_race <- stringr::str_detect(.rmd_content, "race") |> any()
  has_plot <- stringr::str_detect(.rmd_content, "ggplot|geom_") |> any()
  expect_true(has_priors && has_race && has_plot,
    label = "Ex 12: Visualize priors_count vs decile_score with race coloring"
  )
})

test_that("Ex 14: Rmd discusses design of fairer algorithm", {
  skip_if(length(.rmd_content) == 0)
  ex14_section <- .find_ex_section(.rmd_content, "14", "15")
  if (is.null(ex14_section)) skip("Exercise 14 section not found")
  non_code_lines <- ex14_section[!grepl("^```|^#|^\\s*$", ex14_section)]
  expect_true(length(non_code_lines) > 2,
    label = "Ex 14: Discuss changes you would make to design a fairer risk assessment algorithm"
  )
})

test_that("Ex 15: Rmd discusses trade-offs in fairness definitions", {
  skip_if(length(.rmd_content) == 0)
  potential_answers <- c(
    "trade.off",
    "fairness",
    "incompatible",
    "definition"
  )
  pattern <- paste0("(", paste(potential_answers, collapse = "|"), ")")
  ex15_section <- .find_ex_section(.rmd_content, "15", "16")
  if (is.null(ex15_section)) skip("Exercise 15 section not found")
  answer_in_section <- stringr::str_detect(ex15_section, pattern) |> any()
  expect_true(answer_in_section,
    label = "Ex 15: Discuss trade-offs between different definitions of algorithmic fairness"
  )
})
