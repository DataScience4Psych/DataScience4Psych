# Exercises 6-8: Add country variable to dn and lq

test_that("Ex 6: dn has a country variable", {
  skip_if(!exists("dn"))
  expect_true("country" %in% names(dn),
    info = "Use mutate to add a 'country' variable to the dn data frame"
  )
})

test_that("Ex 6: all Denny's locations have country 'United States'", {
  skip_if(!exists("dn"))
  skip_if(!"country" %in% names(dn))
  expect_true(all(dn$country == "United States"),
    info = "Set the country variable to 'United States' for all Denny's locations"
  )
})

test_that("Ex 8: lq has a country variable", {
  skip_if(!exists("lq"))
  expect_true("country" %in% names(lq),
    info = "Use case_when to add a 'country' variable to the lq data frame"
  )
})

test_that("Ex 8: lq country values are valid", {
  skip_if(!exists("lq"))
  skip_if(!"country" %in% names(lq))
  valid_countries <- c("United States", "Canada", "Colombia", "Mexico")
  lq_with_country <- lq[!is.na(lq$country), ]
  expect_true(all(lq_with_country$country %in% valid_countries),
    info = "Make sure lq country values are one of: United States, Canada, Colombia, Mexico"
  )
})

test_that("Ex 8: lq is filtered to US-only after adding country", {
  skip_if(!exists("lq"))
  skip_if(!"country" %in% names(lq))
  # After the lab instructions, students filter lq for US only
  # If they followed instructions, all remaining rows should be United States
  us_abbrevs <- c(state.abb, "DC")
  all_us_states <- all(lq$state %in% us_abbrevs)
  expect_true(all_us_states,
    info = "Filter lq to keep only US locations after adding the country variable"
  )
})
