# Exercise 1: Explore ncbirths data

test_that("Ex 1: ncbirths object exists", {
  expect_true(exists("ncbirths"),
    info = "ncbirths should be loaded from the openintro package"
  )
})

test_that("Ex 1: ncbirths has 1000 observations", {
  skip_if(!exists("ncbirths"))
  expect_equal(nrow(ncbirths), 1000,
    info = "ncbirths should have 1000 observations"
  )
})

test_that("Ex 1: ncbirths has 13 variables", {
  skip_if(!exists("ncbirths"))
  expect_true(ncol(ncbirths) >= 13,
    info = "ncbirths should have at least 13 variables"
  )
})

test_that("Ex 1: ncbirths has expected key variables", {
  skip_if(!exists("ncbirths"))
  expected <- c("weight", "habit", "mage", "whitemom", "mature", "lowbirthweight")
  expect_true(all(expected %in% names(ncbirths)),
    info = "ncbirths should have weight, habit, mage, whitemom, mature, lowbirthweight columns"
  )
})

test_that("Ex 1: ncbirths weight variable is numeric", {
  skip_if(!exists("ncbirths"))
  skip_if(!"weight" %in% names(ncbirths))
  expect_true(is.numeric(ncbirths$weight),
    info = "weight should be a numeric variable"
  )
})

test_that("Ex 1: Rmd Exercise 1 reports ncbirths dimensions or uses exploration code", {
  skip_if(length(.rmd_content) == 0)
  skip_if(!exists("ncbirths"))
  potential_answers <- c("1000", "ncbirths", "nrow\\(|dim\\(|str\\(|glimpse\\(|skim\\(", "openintro")
  pattern <- paste0("(", paste(potential_answers, collapse = "|"), ")")
  answer_in_rmd <- stringr::str_detect(.rmd_content, pattern) |> any()
  expect_equal(answer_in_rmd, TRUE,
    info = "Report ncbirths dimensions or use exploration code in your Rmd"
  )
})
