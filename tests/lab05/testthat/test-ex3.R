# Exercise 6 & 7: Calculate distances and minimum distances in Alaska

test_that("Ex 6: dn_lq_ak has a distance variable", {
  skip_if(!exists("dn_lq_ak"))
  expect_true(
    "distance" %in% names(dn_lq_ak),
    label = "dn_lq_ak should have a distance variable calculated using the haversine formula"
  )
})

test_that("Ex 6: distance variable contains positive values", {
  skip_if(!exists("dn_lq_ak"))
  skip_if(!("distance" %in% names(dn_lq_ak)))
  expect_true(
    all(dn_lq_ak$distance > 0, na.rm = TRUE),
    label = "All distances should be positive (in km)"
  )
})

test_that("Ex 6: Rmd uses haversine function to calculate distance", {
  skip_if(length(.rmd_content) == 0)
  answer_in_rmd <- stringr::str_detect(.rmd_content, "haversine") |> any()
  expect_equal(answer_in_rmd, TRUE,
    info = "Ex 6: Use the haversine() function to calculate distances between locations"
  )
})

test_that("Ex 7: dn_lq_ak_mindist data frame exists with closest distances", {
  expect_true(
    exists("dn_lq_ak_mindist"),
    label = "dn_lq_ak_mindist should summarize the minimum distance per Denny's location"
  )
})

test_that("Ex 7: dn_lq_ak_mindist has one row per Denny's location in Alaska", {
  skip_if(!exists("dn_lq_ak_mindist"))
  expect_equal(nrow(dn_lq_ak_mindist), 3,
    info = "dn_lq_ak_mindist should have 3 rows (one per Denny's in Alaska)"
  )
})

test_that("Ex 7: Rmd uses group_by and summarize to find minimum distance", {
  skip_if(length(.rmd_content) == 0)
  has_group_by <- stringr::str_detect(.rmd_content, "group_by") |> any()
  has_summarize <- stringr::str_detect(.rmd_content, "summarize|summarise") |> any()
  has_min <- stringr::str_detect(.rmd_content, "min\\(") |> any()
  expect_true(has_group_by,
    label = "Ex 7: Use group_by() to group by Denny's location"
  )
  expect_true(has_summarize,
    label = "Ex 7: Use summarize() to compute the minimum distance"
  )
  expect_true(has_min,
    label = "Ex 7: Use min() to find the nearest La Quinta location"
  )
})
