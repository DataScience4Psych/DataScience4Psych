# Exercise 4: Scatterplots — relationships with plastic waste per capita

test_that("Ex 4: Rmd contains scatterplot of plastic_waste vs mismanaged", {
  skip_if(length(.rmd_content) == 0)
  potential_answers <- c(
    "mismanaged_plastic_waste_per_cap",
    "mismanaged_plastic_waste"
  )
  pattern <- paste0("(", paste(potential_answers, collapse = "|"), ")")
  answer_in_rmd <- stringr::str_detect(.rmd_content, pattern) |> any()
  expect_equal(answer_in_rmd, TRUE,
    info = "Ex 4.1: Visualize the relationship between plastic waste per capita and mismanaged plastic waste per capita"
  )
})

test_that("Ex 4: Rmd uses geom_point for scatterplot", {
  skip_if(length(.rmd_content) == 0)
  answer_in_rmd <- stringr::str_detect(.rmd_content, "geom_point") |> any()
  expect_equal(answer_in_rmd, TRUE,
    info = "Ex 4.1: Use geom_point() to create a scatterplot"
  )
})

test_that("Ex 4: Rmd colors scatterplot points by continent", {
  skip_if(length(.rmd_content) == 0)
  potential_answers <- c(
    "color\\s*=\\s*continent",
    "colour\\s*=\\s*continent"
  )
  pattern <- paste0("(", paste(potential_answers, collapse = "|"), ")")
  answer_in_rmd <- stringr::str_detect(.rmd_content, pattern) |> any()
  expect_equal(answer_in_rmd, TRUE,
    info = "Ex 4.2: Color scatterplot points by continent"
  )
})

test_that("Ex 4: Rmd visualizes plastic waste vs total or coastal population", {
  skip_if(length(.rmd_content) == 0)
  potential_answers <- c(
    "total_pop",
    "coastal_pop"
  )
  pattern <- paste0("(", paste(potential_answers, collapse = "|"), ")")
  answer_in_rmd <- stringr::str_detect(.rmd_content, pattern) |> any()
  expect_equal(answer_in_rmd, TRUE,
    info = "Ex 4.3: Visualize plastic waste per capita vs total_pop and coastal_pop"
  )
})

test_that("Ex 4: plastic_waste has no negative values for per-capita metric", {
  skip_if(!exists("plastic_waste"))
  valid_vals <- plastic_waste$plastic_waste_per_cap[!is.na(plastic_waste$plastic_waste_per_cap)]
  expect_true(all(valid_vals >= 0),
    label = "plastic_waste_per_cap should be non-negative"
  )
})
