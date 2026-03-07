# Exercise 7: Minimum distances per Denny's location

test_that("Ex 7: dn_lq_ak has distance and address columns needed for grouping", {
  skip_if(!exists("dn_lq_ak"))
  expect_true("distance" %in% names(dn_lq_ak),
              info ="dn_lq_ak needs a 'distance' column to compute minimum distances")
  expect_true("address.x" %in% names(dn_lq_ak),
              info ="dn_lq_ak needs 'address.x' to group by Denny's location")
})

test_that("Ex 7: Rmd Exercise 7 contains min distance code", {
  skip_if(length(.rmd_content) == 0)
  potential_answers <- c("\\bmin\\b", "summarize|summarise", "slice_min", "group_by", "address")
  pattern <- paste0("(", paste(potential_answers, collapse = "|"), ")")
  answer_in_rmd <- stringr::str_detect(.rmd_content, pattern) |> any()
  expect_equal(answer_in_rmd, TRUE,
               info = "Include code to compute minimum distances per Denny's location in your Rmd")
})

test_that("Ex 7: dn_lq_ak has closest or min_dist column from student computation", {
  skip_if(!exists("dn_lq_ak"))
  skip_if(!"distance" %in% names(dn_lq_ak))
  has_closest <- any(grepl("closest|min_dist|minimum", names(dn_lq_ak), ignore.case = TRUE))
  if (!has_closest) {
    skip_if(length(.rmd_content) == 0)
    potential_answers <- c("min\\(distance\\)", "slice_min", "summarize.*min", "summarise.*min")
    pattern <- paste0("(", paste(potential_answers, collapse = "|"), ")")
    answer_in_rmd <- stringr::str_detect(.rmd_content, pattern) |> any()
    expect_equal(answer_in_rmd, TRUE,
                 info = "Compute minimum distances in your Rmd (e.g., summarize(closest = min(distance)))")
  }
})

test_that("Ex 7: minimum distances have expected properties (solution check)", {
  skip_if(!exists("dn_lq_ak"))
  skip_if(!"distance" %in% names(dn_lq_ak))
  skip_if(!"address.x" %in% names(dn_lq_ak))
  solution_min_dists <- tapply(dn_lq_ak$distance, dn_lq_ak$address.x, min)
  expect_equal(length(solution_min_dists), 3,
               info ="Should have one minimum distance per Denny's location (3 total)")
  expect_true(all(solution_min_dists >= 0),
              info ="All minimum distances should be non-negative")
  solution_max_dists <- tapply(dn_lq_ak$distance, dn_lq_ak$address.x, max)
  expect_true(all(solution_min_dists <= solution_max_dists),
              info ="Minimum distance should be <= maximum distance for each Denny's")
})

test_that("Ex 7: Rmd Exercise 7 reports minimum distance values or uses min() code", {
  skip_if(length(.rmd_content) == 0)
  skip_if(!exists("dn_lq_ak"))
  skip_if(!"distance" %in% names(dn_lq_ak))
  skip_if(!"address.x" %in% names(dn_lq_ak))
  potential_answers <- c("min\\(distance", "slice_min", "summarize|summarise", "closest", "min_dist")
  pattern <- paste0("(", paste(potential_answers, collapse = "|"), ")")
  answer_in_rmd <- stringr::str_detect(.rmd_content, pattern) |> any()
  expect_equal(answer_in_rmd, TRUE,
               info = "Report minimum distance values or use min()/summarize() code in your Rmd")
})
