# Exercise 8: Add country variable to La Quinta dataset using case_when

test_that("Ex 8: lq has country variable", {
  skip_if(!exists("lq"))
  expect_true(
    "country" %in% names(lq),
    label = "lq should have a country variable added in Ex 8"
  )
})

test_that("Ex 8: Rmd uses case_when to populate country in lq", {
  skip_if(length(.rmd_content) == 0)
  potential_answers <- c(
    "case_when",
    "case_match"
  )
  pattern <- paste0("(", paste(potential_answers, collapse = "|"), ")")
  answer_in_rmd <- stringr::str_detect(.rmd_content, pattern) |> any()
  expect_equal(answer_in_rmd, TRUE,
    info = "Ex 8: Use case_when() to add a country variable to the La Quinta dataset"
  )
})

test_that("Ex 8: lq country variable includes non-US locations", {
  skip_if(!exists("lq"))
  skip_if(!("country" %in% names(lq)))
  # There are La Quinta locations in Mexico, Canada, and other countries
  non_us <- sum(lq$country != "United States", na.rm = TRUE)
  expect_gt(non_us, 0,
    label = "lq should have some non-US locations (La Quinta has locations in Mexico, Canada, etc.)"
  )
})

test_that("Ex 9: Rmd discusses which states have most/fewest Denny's", {
  skip_if(length(.rmd_content) == 0)
  potential_answers <- c(
    "count.*state",
    "arrange.*desc.*n",
    "most.*Denny",
    "fewest.*Denny"
  )
  pattern <- paste0("(", paste(potential_answers, collapse = "|"), ")")
  answer_in_rmd <- stringr::str_detect(.rmd_content, pattern) |> any()
  expect_equal(answer_in_rmd, TRUE,
    info = "Ex 9: Count Denny's by state and identify states with most/fewest locations"
  )
})
