# Exercise 5: Faceted plot of all datasets; group_by summary of all correlations

test_that("Ex 5: Rmd Exercise 5 contains group_by or summarize code", {
  skip_if(length(.rmd_content) == 0)
  section <- .find_ex_section(.rmd_content, "5", NULL)
  skip_if(is.null(section), "Could not locate Exercise 5 section in Rmd")
  has_groupby <- any(grepl("group_by", section))
  has_summarize <- any(grepl("summar", section))
  expect_true(has_groupby || has_summarize,
              label = "Exercise 5 should contain group_by and/or summarize code")
})

test_that("Ex 5: Rmd Exercise 5 contains facet_wrap code", {
  skip_if(length(.rmd_content) == 0)
  section <- .find_ex_section(.rmd_content, "5", NULL)
  skip_if(is.null(section), "Could not locate Exercise 5 section in Rmd")
  has_facet <- any(grepl("facet_wrap", section))
  expect_true(has_facet,
              label = "Exercise 5 should contain facet_wrap code for the faceted plot")
})

test_that("Ex 5: Rmd Exercise 5 contains correlation code", {
  skip_if(length(.rmd_content) == 0)
  section <- .find_ex_section(.rmd_content, "5", NULL)
  skip_if(is.null(section), "Could not locate Exercise 5 section in Rmd")
  has_cor <- any(grepl("\\bcor\\b", section))
  expect_true(has_cor,
              label = "Exercise 5 should compute correlations using cor()")
})

test_that("Ex 5: all 13 dataset correlations should be near zero (solution check)", {
  data("datasaurus_dozen")
  solution_all_r <- datasaurus_dozen %>%
    dplyr::group_by(dataset) %>%
    dplyr::summarize(r = cor(x, y), .groups = "drop")
  expect_equal(nrow(solution_all_r), 13)
  expect_true(all(abs(solution_all_r$r) < 0.15),
              label = "All correlations should be near zero (|r| < 0.15)")
  expect_lt(diff(range(solution_all_r$r)), 0.1,
            label = "Max - min correlation across datasets should be < 0.1")
})
