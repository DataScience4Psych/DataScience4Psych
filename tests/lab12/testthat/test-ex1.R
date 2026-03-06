# Exercise 1: Explore ncbirths data

test_that("Ex 1: ncbirths object exists", {
  expect_true(exists("ncbirths"),
              label = "ncbirths should be loaded from the openintro package")
})

test_that("Ex 1: ncbirths has 1000 observations", {
  skip_if(!exists("ncbirths"))
  expect_equal(nrow(ncbirths), 1000,
               label = "ncbirths should have 1000 observations")
})

test_that("Ex 1: ncbirths has 13 variables", {
  skip_if(!exists("ncbirths"))
  expect_true(ncol(ncbirths) >= 13,
              label = "ncbirths should have at least 13 variables")
})

test_that("Ex 1: ncbirths has expected key variables", {
  skip_if(!exists("ncbirths"))
  expected <- c("weight", "habit", "mage", "whitemom", "mature", "lowbirthweight")
  expect_true(all(expected %in% names(ncbirths)),
              label = "ncbirths should have weight, habit, mage, whitemom, mature, lowbirthweight columns")
})

test_that("Ex 1: ncbirths weight variable is numeric", {
  skip_if(!exists("ncbirths"))
  skip_if(!"weight" %in% names(ncbirths))
  expect_true(is.numeric(ncbirths$weight),
              label = "weight should be a numeric variable")
})

test_that("Ex 1: Rmd Exercise 1 reports ncbirths dimensions or uses exploration code", {
  skip_if(length(.rmd_content) == 0)
  skip_if(!exists("ncbirths"))
  section <- .find_ex_section(.rmd_content, "1", "2")
  skip_if(is.null(section), "Could not locate Exercise 1 section in Rmd")
  solution_nrow <- nrow(ncbirths)
  has_value <- any(grepl(as.character(solution_nrow), section))
  has_code <- any(grepl("nrow\\(|dim\\(|str\\(|glimpse\\(|skim\\(", section))
  expect_true(has_value || has_code,
              label = sprintf("Exercise 1 should report %d observations or use exploration code", solution_nrow))
})
