# Exercise 5: Faceted plot of all datasets; group_by summary of all correlations

# tests using objects from student lab
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



# tests that rmd answer is present
test_that("Ex 5: Rmd Exercise 5 contains facet_wrap code", {
  skip_if(length(.rmd_content) == 0)
  potential_answers <- c("facet_wrap")
  pattern <- paste0("(", paste(potential_answers, collapse = "|"), ")")
  answer_in_rmd <- stringr::str_detect(.rmd_content, pattern) |> any()
  expect_equal(answer_in_rmd, TRUE,
               info = "Make sure to include facet_wrap code for the faceted plot in your Rmd file for Exercise 5")
})

test_that("Ex 5: Rmd Exercise 5 contains group_by or summarize code", {
  skip_if(length(.rmd_content) == 0)
  potential_answers <- c("group_by", "summar")
  pattern <- paste0("(", paste(potential_answers, collapse = "|"), ")")
  answer_in_rmd <- stringr::str_detect(.rmd_content, pattern) |> any()
  expect_equal(answer_in_rmd, TRUE,
               info = "Make sure to include group_by and/or summarize code in your Rmd file for Exercise 5")
})

test_that("Ex 5: Rmd Exercise 5 contains correlation code", {
  skip_if(length(.rmd_content) == 0)
  potential_answers <- c("\\bcor\\b")
  pattern <- paste0("(", paste(potential_answers, collapse = "|"), ")")
  answer_in_rmd <- stringr::str_detect(.rmd_content, pattern) |> any()
  expect_equal(answer_in_rmd, TRUE,
               info = "Make sure to compute correlations using cor() in your Rmd file for Exercise 5")
})