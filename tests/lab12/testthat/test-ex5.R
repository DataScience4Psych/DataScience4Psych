# Exercise 5-7: Smoking vs birth weight comparison

test_that("Ex 5: ncbirths has habit and weight variables for boxplot", {
  skip_if(!exists("ncbirths"))
  expect_true("habit" %in% names(ncbirths),
              label = "ncbirths should have a habit column for the boxplot")
  expect_true("weight" %in% names(ncbirths),
              label = "ncbirths should have a weight column for the boxplot")
})

test_that("Ex 5: habit variable has smoker and nonsmoker levels", {
  skip_if(!exists("ncbirths"))
  skip_if(!"habit" %in% names(ncbirths))
  habit_vals <- unique(ncbirths$habit[!is.na(ncbirths$habit)])
  expect_true("nonsmoker" %in% habit_vals,
              label = "habit should include 'nonsmoker' level")
  expect_true("smoker" %in% habit_vals,
              label = "habit should include 'smoker' level")
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

test_that("Ex 7: observed difference in mean weight (nonsmoker - smoker) is positive", {
  # Check for student-created object first
  has_diff <- exists("obs_diff") || exists("observed_diff") || exists("diff_mean") ||
              exists("obs") || exists("weight_diff")
  if (has_diff) {
    diff_val <- NULL
    for (nm in c("obs_diff", "observed_diff", "diff_mean", "obs", "weight_diff")) {
      if (exists(nm)) { diff_val <- get(nm); break }
    }
    # Handle infer output (tibble with stat column)
    if (is.data.frame(diff_val) && "stat" %in% names(diff_val)) {
      diff_val <- diff_val$stat[1]
    }
    expect_true(diff_val > 0,
                label = sprintf("Observed difference (nonsmoker - smoker) should be positive, got %.4f", diff_val))
  } else {
    # Fall back to computing from ncbirths_clean
    d <- NULL
    if (exists("ncbirths_clean")) d <- ncbirths_clean
    else if (exists("ncbirths_habitweight")) d <- ncbirths_habitweight
    skip_if(is.null(d), message = "No observed difference object or cleaned data found")
    skip_if(!all(c("habit", "weight") %in% names(d)))
    means <- d %>%
      dplyr::group_by(habit) %>%
      dplyr::summarize(mean_weight = mean(weight), .groups = "drop")
    nonsmoker_mean <- means$mean_weight[means$habit == "nonsmoker"]
    smoker_mean <- means$mean_weight[means$habit == "smoker"]
    expect_true(nonsmoker_mean > smoker_mean,
                label = "Non-smokers should have higher average birth weight than smokers")
  }
})
