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
  has_closest <- any(grepl("closest|min_dist|minimum", names(dn_lq_ak), ignore.case = TRUE))
  if (!has_closest) {
    skip_if(length(.rmd_content) == 0)
    section <- .find_ex_section(.rmd_content, "7", "8")
    skip_if(is.null(section), "Could not locate Exercise 7 section in Rmd")
    has_code <- any(grepl("min\\(distance\\)|slice_min|summarize.*min", section))
    expect_true(has_code,
                label = "Exercise 7 should compute minimum distances (e.g., summarize(closest = min(distance)))")
  }
})

test_that("Ex 7: minimum distances have expected properties (solution check)", {
  skip_if(!exists("dn_lq_ak"))
  skip_if(!"distance" %in% names(dn_lq_ak))
  skip_if(!"address.x" %in% names(dn_lq_ak))
  solution_min_dists <- tapply(dn_lq_ak$distance, dn_lq_ak$address.x, min)
  expect_equal(length(solution_min_dists), 3,
               label = "Should have one minimum distance per Denny's location (3 total)")
  expect_true(all(solution_min_dists >= 0),
              label = "All minimum distances should be non-negative")
  solution_max_dists <- tapply(dn_lq_ak$distance, dn_lq_ak$address.x, max)
  expect_true(all(solution_min_dists <= solution_max_dists),
              label = "Minimum distance should be <= maximum distance for each Denny's")
})

test_that("Ex 7: Rmd Exercise 7 reports minimum distance values or uses min() code", {
  skip_if(length(.rmd_content) == 0)
  skip_if(!exists("dn_lq_ak"))
  skip_if(!"distance" %in% names(dn_lq_ak))
  skip_if(!"address.x" %in% names(dn_lq_ak))
  section <- .find_ex_section(.rmd_content, "7", "8")
  skip_if(is.null(section), "Could not locate Exercise 7 section in Rmd")
  solution_min_dists <- tapply(dn_lq_ak$distance, dn_lq_ak$address.x, min)
  # Check if any rounded min distance value appears in Rmd
  dist_patterns <- unlist(lapply(solution_min_dists, function(d) {
    c(sprintf("%.1f", d), sprintf("%.2f", d), sprintf("%.0f", d))
  }))
  has_value <- any(sapply(dist_patterns, function(p) any(grepl(p, section, fixed = TRUE))))
  has_code <- any(grepl("min\\(distance|slice_min|summarize|summarise", section))
  expect_true(has_value || has_code,
              label = "Exercise 7 should report minimum distance values or use min()/summarize() code")
})
