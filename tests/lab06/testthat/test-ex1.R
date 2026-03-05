# Exercise 1-2: Instructional staff employment trends

test_that("Ex 1: staff object exists", {
  expect_true(exists("staff"),
              label = "staff should be created by reading data/instructional-staff.csv"
  )
})

test_that("Ex 1: staff has correct dimensions (5 rows x 12 cols)", {
  skip_if(!exists("staff"))
  expect_equal(nrow(staff), 5,
               label = "staff should have 5 rows (one per faculty type)")
  expect_equal(ncol(staff), 12,
               label = "staff should have 12 columns (faculty_type + 11 year columns)")
})

test_that("Ex 1: staff has faculty_type column", {
  skip_if(!exists("staff"))
  expect_true("faculty_type" %in% names(staff),
              label = "staff should have a faculty_type column")
})

test_that("Ex 1: staff contains all five faculty types", {
  skip_if(!exists("staff") || !"faculty_type" %in% names(staff))
  expect_equal(dplyr::n_distinct(staff$faculty_type), 5,
               label = "staff should have 5 distinct faculty types")
})

test_that("Ex 1: staff_long object exists", {
  expect_true(exists("staff_long"),
              label = "staff_long should be created using pivot_longer on staff"
  )
})

test_that("Ex 1: staff_long has 55 rows", {
  skip_if(!exists("staff_long"))
  expect_equal(nrow(staff_long), 55,
               label = "staff_long should have 55 rows (5 faculty types x 11 years)")
})

test_that("Ex 1: staff_long has expected columns (faculty_type, year, value)", {
  skip_if(!exists("staff_long"))
  expect_true("faculty_type" %in% names(staff_long),
              label = "staff_long should have a faculty_type column")
  expect_true("year" %in% names(staff_long),
              label = "staff_long should have a year column")
  expect_true("value" %in% names(staff_long),
              label = "staff_long should have a value column")
})

test_that("Ex 1: staff_long year column contains valid years (1975-2011)", {
  skip_if(!exists("staff_long") || !"year" %in% names(staff_long))
  years <- as.numeric(staff_long$year)
  expect_true(all(years >= 1975 & years <= 2011, na.rm = TRUE),
              label = "staff_long year values should be between 1975 and 2011")
})

test_that("Ex 1: staff_long value column is numeric", {
  skip_if(!exists("staff_long") || !"value" %in% names(staff_long))
  expect_true(is.numeric(staff_long$value),
              label = "staff_long value column should be numeric (percentages)")
})

test_that("Ex 2: staff_long has 5 distinct faculty types", {
  skip_if(!exists("staff_long") || !"faculty_type" %in% names(staff_long))
  expect_equal(dplyr::n_distinct(staff_long$faculty_type), 5,
               label = "staff_long should have 5 distinct faculty types")
})
