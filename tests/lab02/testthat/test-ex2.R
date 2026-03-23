# Exercise 2: Density plots of plastic waste per capita by continent

test_that("Ex 2: plastic_waste object exists for density plots", {
  expect_true(exists("plastic_waste"),
    info = "Create the plastic_waste object before making density plots"
  )
})

test_that("Ex 2: Rmd Exercise 2 contains density plot code", {
  skip_if(length(.rmd_content) == 0)
  potential_answers <- c("geom_density", "density")
  pattern <- paste0("(", paste(potential_answers, collapse = "|"), ")")
  has_density <- stringr::str_detect(.rmd_content, pattern) |> any()
  potential_answers_ggplot <- c("ggplot")
  pattern_ggplot <- paste0("(", paste(potential_answers_ggplot, collapse = "|"), ")")
  has_ggplot <- stringr::str_detect(.rmd_content, pattern_ggplot) |> any()
  expect_true(has_density && has_ggplot,
    info = "Add ggplot code with geom_density to create density plots in your Rmd"
  )
})

test_that("Ex 2: Rmd Exercise 2 uses continent for coloring", {
  skip_if(length(.rmd_content) == 0)
  potential_answers <- c("continent")
  pattern <- paste0("(", paste(potential_answers, collapse = "|"), ")")
  has_continent <- stringr::str_detect(.rmd_content, pattern) |> any()
  expect_true(has_continent,
    info = "Use continent for color or fill mapping in your density plots"
  )
})
