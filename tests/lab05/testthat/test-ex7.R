# Exercise 7-8: Minimum distances

test_that("Ex 7: minimum distances are calculated for each Denny's", {
  skip_if(!exists("dn_lq_ak") || !"distance" %in% names(dn_lq_ak))
  min_dists <- dn_lq_ak %>%
    dplyr::group_by(address.x) %>%
    dplyr::summarize(closest = min(distance), .groups = "drop")
  expect_equal(nrow(min_dists), 3,
               label = "Should have one minimum distance per Denny's location")
  expect_true(all(min_dists$closest >= 0),
              label = "All minimum distances should be non-negative")
})
