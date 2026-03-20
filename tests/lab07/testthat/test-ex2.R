# Exercise 2: Filter to Kansas and pivot to long format (lab Exercise 4)
# Note: test files for lab07 use internal numbering — test-ex2 covers lab Exercise 4 (Kansas filter + pivot).

test_that("Ex 2: kansas_cases object exists", {
  expect_true(exists("kansas_cases"),
    info = "Create a data frame called 'kansas_cases' by filtering and pivoting the cases data"
  )
})

test_that("Ex 2: kansas_cases is a data frame", {
  skip_if(!exists("kansas_cases"))
  expect_true(is.data.frame(kansas_cases),
    info = "Make sure 'kansas_cases' is a data frame"
  )
})

test_that("Ex 2: kansas_cases has expected columns after pivot", {
  skip_if(!exists("kansas_cases"))
  expect_true(all(c("countyFIPS", "date", "cumulative_cases") %in% names(kansas_cases)),
    info = "After pivot_longer, 'kansas_cases' should have countyFIPS, date, and cumulative_cases columns"
  )
})

test_that("Ex 2: kansas_cases date column is Date type", {
  skip_if(!exists("kansas_cases") || !"date" %in% names(kansas_cases))
  expect_true(inherits(kansas_cases$date, "Date"),
    info = "Make sure the 'date' column is a proper Date type (use lubridate::ymd())"
  )
})

test_that("Ex 2: kansas_cases contains only Kansas data", {
  skip_if(!exists("kansas_cases"))
  if ("State" %in% names(kansas_cases)) {
    expect_true(all(kansas_cases$State == "KS"),
      info = "Make sure you filtered to only Kansas (State == 'KS')"
    )
  }
})

test_that("Ex 2: kansas_cases has multiple counties", {
  skip_if(!exists("kansas_cases") || !"countyFIPS" %in% names(kansas_cases))
  n_counties <- dplyr::n_distinct(kansas_cases$countyFIPS)
  expect_true(n_counties > 50,
    info = "Kansas has 105 counties — make sure you have data for many of them"
  )
})

test_that("Ex 2: kansas_cases excludes the statewide total row (countyFIPS == 0)", {
  skip_if(!exists("kansas_cases") || !"countyFIPS" %in% names(kansas_cases))
  expect_true(!any(kansas_cases$countyFIPS == 0),
    info = "Make sure you filtered out the statewide total row (countyFIPS != 0)"
  )
})

test_that("Ex 2: kansas_cases cumulative_cases column is numeric", {
  skip_if(!exists("kansas_cases") || !"cumulative_cases" %in% names(kansas_cases))
  expect_true(is.numeric(kansas_cases$cumulative_cases),
    info = "cumulative_cases should be a numeric column"
  )
})

test_that("Ex 2: kansas_cases cumulative_cases are non-negative", {
  skip_if(!exists("kansas_cases") || !"cumulative_cases" %in% names(kansas_cases))
  expect_true(all(kansas_cases$cumulative_cases >= 0, na.rm = TRUE),
    info = "cumulative_cases should be non-negative — check your pivot_longer value column name"
  )
})

test_that("Ex 2: kansas_cases is in long format (many rows)", {
  skip_if(!exists("kansas_cases"))
  # 105 counties × many dates → many thousands of rows
  expect_true(nrow(kansas_cases) > 1000,
    info = "kansas_cases should be in long format with one row per county per date — expected many rows"
  )
})

# Exercise 2 also: filtered population data for Kansas

test_that("Ex 2: kansas_pop object exists", {
  has_pop <- exists("kansas_pop") || exists("ks_pop") || exists("pop_kansas")
  expect_true(has_pop,
    info = "Create a filtered population data frame for Kansas counties (e.g., named 'kansas_pop') by filtering pop_raw to State == 'KS' and countyFIPS != 0"
  )
})

test_that("Ex 2: kansas_pop is a data frame", {
  pop_obj <- if (exists("kansas_pop")) kansas_pop else if (exists("ks_pop")) ks_pop else if (exists("pop_kansas")) pop_kansas else NULL
  skip_if(is.null(pop_obj))
  expect_true(is.data.frame(pop_obj),
    info = "Make sure the filtered Kansas population object is a data frame"
  )
})

test_that("Ex 2: kansas_pop has countyFIPS, County Name, and population columns", {
  pop_obj <- if (exists("kansas_pop")) kansas_pop else if (exists("ks_pop")) ks_pop else if (exists("pop_kansas")) pop_kansas else NULL
  skip_if(is.null(pop_obj))
  expect_true(all(c("countyFIPS", "population") %in% names(pop_obj)),
    info = "The Kansas population data frame should have countyFIPS and population columns"
  )
})

test_that("Ex 2: kansas_pop contains only Kansas counties", {
  pop_obj <- if (exists("kansas_pop")) kansas_pop else if (exists("ks_pop")) ks_pop else if (exists("pop_kansas")) pop_kansas else NULL
  skip_if(is.null(pop_obj))
  if ("State" %in% names(pop_obj)) {
    expect_true(all(pop_obj$State == "KS"),
      info = "The Kansas population data frame should only contain Kansas (KS) counties"
    )
  }
})

test_that("Ex 2: kansas_pop has approximately 105 Kansas counties", {
  pop_obj <- if (exists("kansas_pop")) kansas_pop else if (exists("ks_pop")) ks_pop else if (exists("pop_kansas")) pop_kansas else NULL
  skip_if(is.null(pop_obj))
  skip_if(!"countyFIPS" %in% names(pop_obj))
  n_counties <- dplyr::n_distinct(pop_obj$countyFIPS)
  expect_true(n_counties >= 100 && n_counties <= 110,
    info = sprintf("Kansas has 105 counties — found %d unique FIPS codes", n_counties)
  )
})
