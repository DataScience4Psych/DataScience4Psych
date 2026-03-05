# Exercise 1-2: Instructional staff employment trends

test_that("Ex 1: staff data can be loaded", {
  skip_if(!file.exists("data/instructional-staff.csv"),
          message = "data/instructional-staff.csv not found")
  staff <- readr::read_csv("data/instructional-staff.csv", show_col_types = FALSE)
  expect_true(nrow(staff) > 0)
})

test_that("Ex 1: staff has faculty_type column", {
  skip_if(!file.exists("data/instructional-staff.csv"))
  staff <- readr::read_csv("data/instructional-staff.csv", show_col_types = FALSE)
  expect_true("faculty_type" %in% names(staff),
              label = "staff should have a faculty_type column")
})

test_that("Ex 1: staff has 5 faculty types", {
  skip_if(!file.exists("data/instructional-staff.csv"))
  staff <- readr::read_csv("data/instructional-staff.csv", show_col_types = FALSE)
  expect_equal(nrow(staff), 5,
               label = "staff should have 5 rows (one per faculty type)")
})

test_that("Ex 1: staff_long is created via pivot_longer", {
  expect_true(exists("staff_long"),
              label = "staff_long should be created using pivot_longer")
})

test_that("Ex 1: staff_long has correct structure", {
  skip_if(!exists("staff_long"))
  expect_true(all(c("faculty_type", "year") %in% names(staff_long)),
              label = "staff_long should have faculty_type and year columns")
  # 5 faculty types x 11 years = 55 rows
  expect_equal(nrow(staff_long), 55,
               label = "staff_long should have 55 rows (5 types x 11 years)")
})

test_that("Ex 1: line plot with grouped faculty types can be created", {
  skip_if(!exists("staff_long"))
  p <- ggplot2::ggplot(staff_long,
    ggplot2::aes(x = year, y = value,
                 group = faculty_type, color = faculty_type)) +
    ggplot2::geom_line()
  expect_s3_class(p, "ggplot")
})
