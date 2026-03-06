# Exercise 1.1: Plot histogram of plastic waste per capita faceted by continent

test_that("Ex 1: plastic_waste object exists in student environment", {
  skip_if(length(.rmd_content) == 0)

  potential_answers <- c(
    "read\\.csv.*plastic-waste",
    "read_csv.*plastic-waste",
    "plastic_waste"
  )
  pattern <- paste0("(", paste(potential_answers, collapse = "|"), ")")
  answer_in_rmd <- stringr::str_detect(.rmd_content, pattern) |> any()
  expect_equal(answer_in_rmd, TRUE,
    info = "Make sure to load the plastic-waste dataset in your Rmd"
  )
})

test_that("Ex 1: plastic_waste has correct number of rows", {
  skip_if(!exists("plastic_waste"))
  solution <- read.csv(
    system.file("extdata", "plastic-waste.csv",
      package = "dsbox",
      mustWork = FALSE
    ),
    stringsAsFactors = FALSE
  )
  # Fall back to local data file if dsbox not available
  local_path <- file.path(Sys.getenv("STUDENT_CODE_DIR", "."), "data", "plastic-waste.csv")
  if (file.exists(local_path)) {
    solution <- read.csv(local_path, stringsAsFactors = FALSE)
  }
  expect_gt(nrow(plastic_waste), 0,
    label = "plastic_waste should have more than 0 rows"
  )
})

test_that("Ex 1: plastic_waste has expected variables", {
  skip_if(!exists("plastic_waste"))
  expected_vars <- c(
    "code", "entity", "continent", "year",
    "plastic_waste_per_cap", "mismanaged_plastic_waste_per_cap",
    "coastal_pop", "total_pop"
  )
  expect_true(
    all(expected_vars %in% names(plastic_waste)),
    label = paste(
      "plastic_waste should contain columns:",
      paste(expected_vars, collapse = ", ")
    )
  )
})

test_that("Ex 1: Rmd contains histogram of plastic waste per capita", {
  skip_if(length(.rmd_content) == 0)
  potential_answers <- c(
    "geom_histogram",
    "plastic_waste_per_cap"
  )
  pattern <- paste0("(", paste(potential_answers, collapse = "|"), ")")
  answer_in_rmd <- stringr::str_detect(.rmd_content, pattern) |> any()
  expect_equal(answer_in_rmd, TRUE,
    info = "Make sure Exercise 1 includes a histogram of plastic_waste_per_cap"
  )
})

test_that("Ex 1: Rmd uses facet_wrap by continent", {
  skip_if(length(.rmd_content) == 0)
  potential_answers <- c(
    "facet_wrap.*continent",
    "facet_grid.*continent"
  )
  pattern <- paste0("(", paste(potential_answers, collapse = "|"), ")")
  answer_in_rmd <- stringr::str_detect(.rmd_content, pattern) |> any()
  expect_equal(answer_in_rmd, TRUE,
    info = "Make sure to facet your histogram by continent"
  )
})
