# Exercise 5-7: Risk scores and recidivism accuracy

test_that("Ex 5: two_year_recid is binary (0 or 1)", {
  skip_if(!exists("compas") || !"two_year_recid" %in% names(compas))
  vals <- unique(compas$two_year_recid[!is.na(compas$two_year_recid)])
  expect_true(all(vals %in% c(0, 1)),
              label = "two_year_recid should be binary (0 or 1)")
})

test_that("Ex 6: can classify predictions as TP, TN, FP, FN", {
  skip_if(!exists("compas"))
  skip_if(!all(c("decile_score", "two_year_recid") %in% names(compas)))
  classified <- compas %>%
    dplyr::filter(!is.na(decile_score), !is.na(two_year_recid)) %>%
    dplyr::mutate(
      classification = dplyr::case_when(
        decile_score >= 7 & two_year_recid == 1 ~ "TP",
        decile_score <= 4 & two_year_recid == 0 ~ "TN",
        decile_score >= 7 & two_year_recid == 0 ~ "FP",
        decile_score <= 4 & two_year_recid == 1 ~ "FN",
        TRUE ~ "Medium"
      )
    )
  expect_true("classification" %in% names(classified))
  expect_true(all(c("TP", "TN", "FP", "FN") %in% classified$classification),
              label = "All four classification categories should be present")
})
