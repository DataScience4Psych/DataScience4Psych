# Exercises 6-8: Add country variable to dn and lq

test_that("Ex 6: dn has a country variable", {
  skip_if(!exists("dn"))
  expect_true("country" %in% names(dn),
              label = "dn should have a 'country' variable after mutate")
})

test_that("Ex 6: all Denny's locations have country 'United States'", {
  skip_if(!exists("dn"))
  skip_if(!"country" %in% names(dn))
  expect_true(all(dn$country == "United States"),
              label = "All Denny's should have country == 'United States'")
})

test_that("Ex 8: lq has a country variable", {
  skip_if(!exists("lq"))
  expect_true("country" %in% names(lq),
              label = "lq should have a 'country' variable after using case_when")
})

test_that("Ex 8: lq country values are valid", {
  skip_if(!exists("lq"))
  skip_if(!"country" %in% names(lq))
  valid_countries <- c("United States", "Canada", "Colombia", "Mexico")
  lq_with_country <- lq[!is.na(lq$country), ]
  expect_true(all(lq_with_country$country %in% valid_countries),
              label = "lq country values should be one of: United States, Canada, Colombia, Mexico")
})

test_that("Ex 8: lq is filtered to US-only after adding country", {

  skip_if(!exists("lq"))
  skip_if(!"country" %in% names(lq))
  # After the lab instructions, students filter lq for US only
  # If they followed instructions, all remaining rows should be United States
  us_abbrevs <- c(state.abb, "DC")
  all_us_states <- all(lq$state %in% us_abbrevs)
  expect_true(all_us_states,
              label = "After filtering, lq should only contain US locations (state should be a valid US abbreviation)")
})
