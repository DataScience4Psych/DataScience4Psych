# Exercise 10: Denny's and La Quinta locations per thousand square miles

test_that("Ex 10: Rmd joins Denny's count with states data", {
  skip_if(length(.rmd_content) == 0)
  potential_answers <- c(
    "inner_join.*states",
    "left_join.*states",
    "join.*states"
  )
  pattern <- paste0("(", paste(potential_answers, collapse = "|"), ")")
  answer_in_rmd <- stringr::str_detect(.rmd_content, pattern) |> any()
  expect_equal(answer_in_rmd, TRUE,
    info = "Ex 10: Join the Denny's count data with the states data frame"
  )
})

test_that("Ex 10: Rmd calculates locations per thousand square miles", {
  skip_if(length(.rmd_content) == 0)
  potential_answers <- c(
    "per.*thousand",
    "n.*area",
    "n\\s*/\\s*area",
    "locations_per"
  )
  pattern <- paste0("(", paste(potential_answers, collapse = "|"), ")")
  answer_in_rmd <- stringr::str_detect(.rmd_content, pattern) |> any()
  expect_equal(answer_in_rmd, TRUE,
    info = "Ex 10: Calculate locations per thousand square miles by dividing count by area"
  )
})

test_that("Ex 10: dn_lq combined data frame exists with establishment variable", {
  skip_if(!exists("dn_lq"))
  expect_true(
    "establishment" %in% names(dn_lq),
    label = "dn_lq should have an establishment variable indicating Denny's vs La Quinta"
  )
  expect_true(
    all(c("Denny's", "La Quinta") %in% dn_lq$establishment),
    label = "dn_lq$establishment should contain both 'Denny's' and 'La Quinta'"
  )
})
