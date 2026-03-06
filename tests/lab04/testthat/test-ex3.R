# Exercise 5: Finding Denny's locations outside the US

test_that("Ex 5: Rmd filters for Denny's states not in states$abbreviation", {
  skip_if(length(.rmd_content) == 0)
  potential_answers <- c(
    "!.*state.*%in%.*states",
    "state.*%in%.*states.*abbreviation",
    "filter.*state.*abbreviation"
  )
  pattern <- paste0("(", paste(potential_answers, collapse = "|"), ")")
  answer_in_rmd <- stringr::str_detect(.rmd_content, pattern) |> any()
  expect_equal(answer_in_rmd, TRUE,
    info = "Ex 5: Filter Denny's for states not in states$abbreviation"
  )
})

test_that("Ex 5: All Denny's locations are in the US (no locations outside US)", {
  skip_if(!exists("dn"))
  # Using state abbreviations to check
  us_states <- c(state.abb, "DC")
  # The filter should show 0 results — Denny's are all in the US
  outside_us <- dn[!(dn$state %in% us_states), ]
  expect_equal(nrow(outside_us), 0,
    info = "Denny's locations should all be in the US (0 locations outside US)"
  )
})

test_that("Ex 6: dn has country variable set to 'United States'", {
  skip_if(!exists("dn"))
  skip_if(!("country" %in% names(dn)))
  expect_true(
    all(dn$country == "United States"),
    label = "dn$country should be 'United States' for all rows"
  )
})

test_that("Ex 6: Rmd uses mutate to add country variable to dn", {
  skip_if(length(.rmd_content) == 0)
  potential_answers <- c(
    "mutate.*country.*United States",
    "country.*=.*United States"
  )
  pattern <- paste0("(", paste(potential_answers, collapse = "|"), ")")
  answer_in_rmd <- stringr::str_detect(.rmd_content, pattern) |> any()
  expect_equal(answer_in_rmd, TRUE,
    info = "Ex 6: Use mutate() to add a country variable to dn set to 'United States'"
  )
})
