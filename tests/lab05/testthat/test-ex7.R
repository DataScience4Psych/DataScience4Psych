# Exercise 7: Minimum distances per Denny's location

test_that("Ex 7: dn_lq_ak has distance and address columns needed for grouping", {
  skip_if(!exists("dn_lq_ak"))
  expect_true("distance" %in% names(dn_lq_ak),
              label = "dn_lq_ak needs a 'distance' column to compute minimum distances")
  expect_true("address.x" %in% names(dn_lq_ak),
              label = "dn_lq_ak needs 'address.x' to group by Denny's location")
})

test_that("Ex 7: Rmd Exercise 7 contains min distance code", {
  skip_if(length(.rmd_content) == 0)
  section <- .find_ex_section(.rmd_content, "7", "8")
  skip_if(is.null(section), "Could not locate Exercise 7 section in Rmd")
  has_min <- any(grepl("\\bmin\\b|summarize|summarise|slice_min", section))
  has_group <- any(grepl("group_by|address", section))
  expect_true(has_min && has_group,
              label = "Exercise 7 should contain code to compute minimum distances per Denny's location")
})

test_that("Ex 7: dn_lq_ak has closest or min_dist column from student computation", {
  skip_if(!exists("dn_lq_ak"))
  skip_if(!"distance" %in% names(dn_lq_ak))
  # Check that student computed something — either a closest column or
  # grouped/sliced to show min distances
  has_closest <- any(grepl("closest|min_dist|minimum", names(dn_lq_ak), ignore.case = TRUE))
  if (!has_closest) {
    # Alternative: check Rmd has the computation
    skip_if(length(.rmd_content) == 0)
    section <- .find_ex_section(.rmd_content, "7", "8")
    skip_if(is.null(section), "Could not locate Exercise 7 section in Rmd")
    has_code <- any(grepl("min\\(distance\\)|slice_min|summarize.*min", section))
    expect_true(has_code,
                label = "Exercise 7 should compute minimum distances (e.g., summarize(closest = min(distance)))")
  }
})
