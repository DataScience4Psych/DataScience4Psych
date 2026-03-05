# Exercise 11-12: Mature mothers and low birth weight

test_that("Ex 11: mature cutoff age is 35", {
  skip_if(!requireNamespace("openintro", quietly = TRUE))
  data("ncbirths", package = "openintro")
  mature_ages <- ncbirths %>%
    dplyr::filter(mature == "mature mom") %>%
    dplyr::pull(mage)
  younger_ages <- ncbirths %>%
    dplyr::filter(mature == "younger mom") %>%
    dplyr::pull(mage)
  expect_true(min(mature_ages) >= 35,
              label = "Minimum age for mature mothers should be 35")
  expect_true(max(younger_ages) < 35,
              label = "Maximum age for younger mothers should be < 35")
})

test_that("Ex 12: proportion of low birth weight can be calculated by group", {
  skip_if(!requireNamespace("openintro", quietly = TRUE))
  data("ncbirths", package = "openintro")
  props <- ncbirths %>%
    dplyr::filter(!is.na(mature), !is.na(lowbirthweight)) %>%
    dplyr::group_by(mature) %>%
    dplyr::summarize(
      pct_low = mean(lowbirthweight == "low"),
      .groups = "drop"
    )
  expect_equal(nrow(props), 2,
               label = "Should have proportions for both mature and younger mothers")
})
