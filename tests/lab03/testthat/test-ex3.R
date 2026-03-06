# Exercise 3: Faceted bar plot — category vs country_us

test_that("Ex 3: Rmd contains country_us variable creation", {
  skip_if(length(.rmd_content) == 0)
  potential_answers <- c(
    "country_us",
    "if_else.*country.*USA",
    "fct_other.*country.*USA"
  )
  pattern <- paste0("(", paste(potential_answers, collapse = "|"), ")")
  answer_in_rmd <- stringr::str_detect(.rmd_content, pattern) |> any()
  expect_equal(answer_in_rmd, TRUE,
    info = "Ex 3: Create a country_us variable indicating if laureate was in USA when winning"
  )
})

test_that("Ex 3: nobel_living_science data frame exists", {
  expect_true(exists("nobel_living_science"),
    label = "nobel_living_science should be created by filtering for science categories"
  )
})

test_that("Ex 3: nobel_living_science contains only science categories", {
  skip_if(!exists("nobel_living_science"))
  expected_cats <- c("Physics", "Medicine", "Chemistry", "Economics")
  expect_true(
    all(nobel_living_science$category %in% expected_cats),
    label = "nobel_living_science should only contain Physics, Medicine, Chemistry, Economics"
  )
})

test_that("Ex 3: Rmd contains faceted bar plot with coord_flip", {
  skip_if(length(.rmd_content) == 0)
  potential_answers <- c(
    "facet_wrap",
    "facet_grid"
  )
  pattern_facet <- paste0("(", paste(potential_answers, collapse = "|"), ")")
  has_facet <- stringr::str_detect(.rmd_content, pattern_facet) |> any()
  has_coord_flip <- stringr::str_detect(.rmd_content, "coord_flip") |> any()
  expect_true(has_facet,
    label = "Ex 3: Use facet_wrap() or facet_grid() in your bar plot"
  )
  expect_true(has_coord_flip,
    label = "Ex 3: Use coord_flip() to flip the bar plot coordinates"
  )
})
