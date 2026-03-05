# Exercise 5: Faceted plot of all datasets; group_by summary of all correlations

test_that("Ex 5: group_by + summarize produces one row per dataset", {
  data("datasaurus_dozen")
  all_r <- datasaurus_dozen %>%
    dplyr::group_by(dataset) %>%
    dplyr::summarize(r = cor(x, y), .groups = "drop")
  expect_equal(nrow(all_r), 13)
})

test_that("Ex 5: all 13 dataset correlations are near zero", {
  data("datasaurus_dozen")
  all_r <- datasaurus_dozen %>%
    dplyr::group_by(dataset) %>%
    dplyr::summarize(r = cor(x, y), .groups = "drop")
  expect_true(all(abs(all_r$r) < 0.15),
              label = "All correlations should be near zero (|r| < 0.15)"
  )
})

test_that("Ex 5: spread of correlations across all datasets is small", {
  data("datasaurus_dozen")
  all_r <- datasaurus_dozen %>%
    dplyr::group_by(dataset) %>%
    dplyr::summarize(r = cor(x, y), .groups = "drop")
  expect_lt(diff(range(all_r$r)), 0.1,
            label = "Max - min correlation across datasets should be < 0.1"
  )
})

test_that("Ex 5: faceted plot can be constructed without error", {
  data("datasaurus_dozen")
  p <- ggplot2::ggplot(datasaurus_dozen, ggplot2::aes(x = x, y = y, color = dataset)) +
    ggplot2::geom_point() +
    ggplot2::facet_wrap(~dataset, ncol = 3) +
    ggplot2::theme(legend.position = "none")
  expect_s3_class(p, "ggplot")
})
