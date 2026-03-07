# Exercise 3: Violin plots of plastic waste per capita by continent

test_that("Ex 3: plastic_waste object exists for violin plots", {
  expect_true(exists("plastic_waste"),
              info = "Create the plastic_waste object before making violin plots")
})

test_that("Ex 3: Rmd Exercise 3 contains violin plot code", {
  skip_if(length(.rmd_content) == 0)
  potential_answers <- c("geom_violin", "violin")
  pattern <- paste0("(", paste(potential_answers, collapse = "|"), ")")
  has_violin <- stringr::str_detect(.rmd_content, pattern) |> any()
  potential_answers_ggplot <- c("ggplot")
  pattern_ggplot <- paste0("(", paste(potential_answers_ggplot, collapse = "|"), ")")
  has_ggplot <- stringr::str_detect(.rmd_content, pattern_ggplot) |> any()
  expect_true(has_violin && has_ggplot,
              info = "Add ggplot code with geom_violin to create violin plots in your Rmd")
})
