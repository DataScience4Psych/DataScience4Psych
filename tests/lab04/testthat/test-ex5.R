# Exercise 5: Filter Denny's for non-US locations

test_that("Ex 5: dn object exists for filtering", {
  expect_true(exists("dn") || exists("dennys"),
              label = "dn (or dennys) must exist to check for non-US locations")
})

test_that("Ex 5: Rmd Exercise 5 contains filtering code", {
  skip_if(length(.rmd_content) == 0)
  section <- .find_ex_section(.rmd_content, "5", "6")
  skip_if(is.null(section), "Could not locate Exercise 5 section in Rmd")
  has_filter <- any(grepl("filter|state|nrow", section))
  expect_true(has_filter,
              label = "Exercise 5 should contain code filtering Denny's for non-US locations")
})

test_that("Ex 5: Denny's has no locations outside the US", {
  skip_if(!exists("dn") && !exists("dennys"))
  d <- if (exists("dn")) dn else dennys
  us_abbrevs <- c(state.abb, "DC")
  outside_us <- d[!(d$state %in% us_abbrevs), ]
  expect_equal(nrow(outside_us), 0,
               label = "All Denny's locations should be in US states (filtering by state abbreviation)")
})

test_that("Ex 5: Rmd Exercise 5 reports correct number of non-US Denny's locations", {
  skip_if(length(.rmd_content) == 0)
  skip_if(!exists("dn") && !exists("dennys"))
  d <- if (exists("dn")) dn else dennys
  us_abbrevs <- c(state.abb, "DC")
  solution_n_outside <- as.character(nrow(d[!(d$state %in% us_abbrevs), ]))
  potential_answers <- c(solution_n_outside, "nrow\\(", "filter\\(", "none", "zero", "no loc")
  pattern <- paste0("(", paste(potential_answers, collapse = "|"), ")")
  answer_in_rmd <- stringr::str_detect(.rmd_content, regex(pattern, ignore_case = TRUE)) |> any()
  expect_equal(answer_in_rmd, TRUE,
               info = sprintf("Make sure to report the number of non-US Denny's locations (%s) in the .rmd file", solution_n_outside))
})
