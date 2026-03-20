# Exercise 4: Scatterplots of plastic waste relationships colored by continent

test_that("Ex 4: plastic_waste object exists for scatterplots", {
  expect_true(exists("plastic_waste"),
    info = "Create the plastic_waste object before making scatterplots"
  )
})

test_that("Ex 4: Rmd Exercise 4 contains scatterplot code", {
  skip_if(length(.rmd_content) == 0)
  potential_answers <- c("geom_point")
  pattern <- paste0("(", paste(potential_answers, collapse = "|"), ")")
  has_point <- stringr::str_detect(.rmd_content, pattern) |> any()
  potential_answers_ggplot <- c("ggplot")
  pattern_ggplot <- paste0("(", paste(potential_answers_ggplot, collapse = "|"), ")")
  has_ggplot <- stringr::str_detect(.rmd_content, pattern_ggplot) |> any()
  expect_true(has_point && has_ggplot,
    info = "Add ggplot code with geom_point to create scatterplots in your Rmd"
  )
})

test_that("Ex 4: Rmd Exercise 4 references key variables", {
  skip_if(length(.rmd_content) == 0)
  potential_answers <- c("mismanaged_plastic_waste", "total_pop", "coastal_pop")
  pattern <- paste0("(", paste(potential_answers, collapse = "|"), ")")
  has_vars <- stringr::str_detect(.rmd_content, pattern) |> any()
  expect_true(has_vars,
    info = "Reference mismanaged_plastic_waste_per_cap, total_pop, or coastal_pop in your scatterplot code"
  )
})
