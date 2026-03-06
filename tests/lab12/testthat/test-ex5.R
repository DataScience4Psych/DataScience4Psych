# Exercise 5-7: Smoking vs birth weight comparison

test_that("Ex 5: ncbirths has habit and weight variables for boxplot", {
  skip_if(!exists("ncbirths"))
  expect_true("habit" %in% names(ncbirths),
              label = "ncbirths should have a habit column for the boxplot")
  expect_true("weight" %in% names(ncbirths),
              label = "ncbirths should have a weight column for the boxplot")
})

test_that("Ex 5: Rmd Exercise 5 contains boxplot code", {
  skip_if(length(.rmd_content) == 0)
  section <- .find_ex_section(.rmd_content, "5", "6")
  skip_if(is.null(section), "Could not locate Exercise 5 section in Rmd")
  has_boxplot <- any(grepl("geom_boxplot|boxplot|geom_violin", section))
  has_ggplot <- any(grepl("ggplot", section))
  expect_true(has_boxplot && has_ggplot,
              label = "Exercise 5 should contain ggplot boxplot code comparing weight by habit")
})

test_that("Ex 6: ncbirths_clean object exists", {
  expect_true(exists("ncbirths_clean") || exists("ncbirths_habitweight"),
              label = "A cleaned dataset removing NA habit/weight should exist (ncbirths_clean or ncbirths_habitweight)")
})

test_that("Ex 6: ncbirths_clean has no NAs in habit or weight", {
  d <- NULL
  if (exists("ncbirths_clean")) d <- ncbirths_clean
  else if (exists("ncbirths_habitweight")) d <- ncbirths_habitweight
  skip_if(is.null(d), message = "No cleaned dataset found")
  skip_if(!all(c("habit", "weight") %in% names(d)))
  expect_true(sum(is.na(d$habit)) == 0,
              label = "ncbirths_clean should have no NAs in habit")
  expect_true(sum(is.na(d$weight)) == 0,
              label = "ncbirths_clean should have no NAs in weight")
})

test_that("Ex 6: ncbirths_clean has fewer or equal rows than ncbirths", {
  d <- NULL
  if (exists("ncbirths_clean")) d <- ncbirths_clean
  else if (exists("ncbirths_habitweight")) d <- ncbirths_habitweight
  skip_if(is.null(d) || !exists("ncbirths"))
  expect_true(nrow(d) <= nrow(ncbirths),
              label = "Cleaned dataset should have fewer or equal rows compared to ncbirths")
})

test_that("Ex 7: observed difference object exists", {
  has_diff <- exists("obs_diff") || exists("observed_diff") || exists("diff_mean") ||
              exists("obs") || exists("weight_diff")
  expect_true(has_diff,
              label = "An observed difference object should exist (e.g., obs_diff, observed_diff, diff_mean)")
})

test_that("Ex 7: observed difference in mean weight (nonsmoker - smoker) is positive", {
  diff_val <- NULL
  for (nm in c("obs_diff", "observed_diff", "diff_mean", "obs", "weight_diff")) {
    if (exists(nm)) { diff_val <- get(nm); break }
  }
  skip_if(is.null(diff_val), message = "No observed difference object found")
  # Handle infer output (tibble with stat column)
  if (is.data.frame(diff_val) && "stat" %in% names(diff_val)) {
    diff_val <- diff_val$stat[1]
  }
  expect_true(diff_val > 0,
              label = sprintf("Observed difference (nonsmoker - smoker) should be positive, got %.4f", diff_val))
})
