# Exercise 5: Add mask mandate labels and join population data (Ex 6 in lab)
# Note: test files for lab07 use internal numbering (test-ex5 = lab Exercise 6).
# This follows the established convention where test-ex1=lab Ex 3, test-ex2=lab Ex 4, test-ex3=lab Ex 7.

# Helper: detect mask vs no-mask group labels from the mask_mandate column values
.is_mask_group <- function(x) stringr::str_detect(x, "^[Mm]ask$") | stringr::str_detect(x, "^[Mm]ask [Cc]ounties?$")
.is_nomask_group <- function(x) stringr::str_detect(x, "[Nn]o[- ][Mm]ask") | x == "No Mask" | x == "no mask"

test_that("Ex 5: Rmd uses str_remove() to strip ' County' suffix", {
  skip_if(length(.rmd_content) == 0)
  expect_true(
    any(stringr::str_detect(.rmd_content, "str_remove\\s*\\(")),
    info = "Use str_remove() to strip the ' County' suffix from county names before assigning mask_mandate"
  )
})

test_that("Ex 5: Rmd uses left_join() to bring in population data", {
  skip_if(length(.rmd_content) == 0)
  expect_true(
    any(stringr::str_detect(.rmd_content, "left_join\\s*\\(")),
    info = "Use left_join() to attach the population data to the daily cases data frame"
  )
})

test_that("Ex 5: Rmd references mask mandate counties from the MMWR report", {
  skip_if(length(.rmd_content) == 0)
  # At least a few of the 24 mask mandate counties should appear
  mask_counties <- c("Sedgwick", "Johnson", "Douglas", "Shawnee", "Wyandotte", "Reno")
  pattern <- paste0("(", paste(mask_counties, collapse = "|"), ")")
  expect_true(
    any(stringr::str_detect(.rmd_content, pattern)),
    info = "Reference the mask mandate county names from the MMWR report in your Rmd (e.g., Sedgwick, Johnson, Douglas)"
  )
})

test_that("Ex 5: an object with a mask_mandate column exists", {
  result <- .find_obj_with_col("mask_mandate")
  expect_true(!is.null(result),
    info = "Create a data frame with a 'mask_mandate' column using ifelse() after str_remove()"
  )
})

test_that("Ex 5: mask_mandate has exactly two distinct values", {
  result <- .find_obj_with_col("mask_mandate")
  skip_if(is.null(result))
  n_vals <- dplyr::n_distinct(result$obj$mask_mandate)
  expect_equal(n_vals, 2L,
    info = "mask_mandate should have exactly two values — 'Mask' and 'No Mask' (or similar)"
  )
})

test_that("Ex 5: mask_mandate values indicate mask and no-mask groups", {
  result <- .find_obj_with_col("mask_mandate")
  skip_if(is.null(result))
  vals <- unique(as.character(result$obj$mask_mandate))
  has_mask <- any(.is_mask_group(vals))
  has_no_mask <- any(.is_nomask_group(vals))
  expect_true(has_mask,
    info = paste("Expected a 'Mask' group in mask_mandate — found values:", paste(vals, collapse = ", "))
  )
  expect_true(has_no_mask,
    info = paste("Expected a 'No Mask' group in mask_mandate — found values:", paste(vals, collapse = ", "))
  )
})

test_that("Ex 5: an object with both mask_mandate and population columns exists", {
  result <- .find_obj_with_col("mask_mandate")
  skip_if(is.null(result))
  expect_true("population" %in% names(result$obj),
    info = "After left_join(), the data frame with mask_mandate should also have a 'population' column"
  )
})

test_that("Ex 5: population column is numeric", {
  result <- .find_obj_with_col("mask_mandate")
  skip_if(is.null(result))
  skip_if(!"population" %in% names(result$obj))
  expect_true(is.numeric(result$obj$population),
    info = "population should be a numeric column after joining with pop data"
  )
})

test_that("Ex 5: population values are positive", {
  result <- .find_obj_with_col("mask_mandate")
  skip_if(is.null(result))
  skip_if(!"population" %in% names(result$obj))
  pop_vals <- result$obj$population[!is.na(result$obj$population)]
  expect_true(all(pop_vals > 0),
    info = "All population values should be positive — check your join keys (countyFIPS)"
  )
})

test_that("Ex 5: mask group covers 24 counties and no-mask covers remaining Kansas counties", {
  result <- .find_obj_with_col("mask_mandate")
  skip_if(is.null(result))
  skip_if(!all(c("countyFIPS", "mask_mandate") %in% names(result$obj)))
  group_counts <- result$obj %>%
    dplyr::distinct(countyFIPS, mask_mandate) %>%
    dplyr::group_by(mask_mandate) %>%
    dplyr::summarize(n = dplyr::n(), .groups = "drop")
  mask_rows <- group_counts$n[.is_mask_group(group_counts$mask_mandate)]
  no_mask_rows <- group_counts$n[.is_nomask_group(group_counts$mask_mandate)]
  skip_if(length(mask_rows) == 0 || length(no_mask_rows) == 0)
  expect_equal(mask_rows[1], 24L,
    info = "The mask mandate group should include exactly 24 Kansas counties per the MMWR report"
  )
  expect_true(no_mask_rows[1] > 24,
    info = "The no-mask group should cover the remaining Kansas counties (more than 24)"
  )
})
