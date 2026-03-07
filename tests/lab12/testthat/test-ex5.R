# Exercise 5-7: Smoking vs birth weight comparison

test_that("Ex 5: ncbirths has habit and weight variables for boxplot", {
  skip_if(!exists("ncbirths"))
  expect_true("habit" %in% names(ncbirths),
              info ="ncbirths should have a habit column for the boxplot")
  expect_true("weight" %in% names(ncbirths),
              info ="ncbirths should have a weight column for the boxplot")
})

test_that("Ex 5: Rmd Exercise 5 contains boxplot code", {
  skip_if(length(.rmd_content) == 0)
  potential_answers <- c("geom_boxplot|boxplot|geom_violin", "ggplot", "habit", "weight")
  pattern <- paste0("(", paste(potential_answers, collapse = "|"), ")")
  answer_in_rmd <- stringr::str_detect(.rmd_content, pattern) |> any()
  expect_equal(answer_in_rmd, TRUE,
               info = "Include ggplot boxplot code comparing weight by habit in your Rmd")
})

test_that("Ex 6: ncbirths_clean object exists", {
  expect_true(exists("ncbirths_clean") || exists("ncbirths_habitweight"),
              info ="A cleaned dataset removing NA habit/weight should exist (ncbirths_clean or ncbirths_habitweight)")
})

test_that("Ex 6: ncbirths_clean has no NAs in habit or weight", {
  d <- NULL
  if (exists("ncbirths_clean")) d <- ncbirths_clean
  else if (exists("ncbirths_habitweight")) d <- ncbirths_habitweight
  skip_if(is.null(d), message = "No cleaned dataset found")
  skip_if(!all(c("habit", "weight") %in% names(d)))
  expect_true(sum(is.na(d$habit)) == 0,
              info ="ncbirths_clean should have no NAs in habit")
  expect_true(sum(is.na(d$weight)) == 0,
              info ="ncbirths_clean should have no NAs in weight")
})

test_that("Ex 6: ncbirths_clean has fewer or equal rows than ncbirths", {
  d <- NULL
  if (exists("ncbirths_clean")) d <- ncbirths_clean
  else if (exists("ncbirths_habitweight")) d <- ncbirths_habitweight
  skip_if(is.null(d) || !exists("ncbirths"))
  expect_true(nrow(d) <= nrow(ncbirths),
              info ="Cleaned dataset should have fewer or equal rows compared to ncbirths")
})

test_that("Ex 7: observed difference object exists", {
  has_diff <- exists("obs_diff") || exists("observed_diff") || exists("diff_mean") ||
              exists("obs") || exists("weight_diff")
  expect_true(has_diff,
              info ="An observed difference object should exist (e.g., obs_diff, observed_diff, diff_mean)")
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
              info =sprintf("Observed difference (nonsmoker - smoker) should be positive, got %.4f", diff_val))
})

test_that("Ex 7: student's observed difference matches solution", {
  diff_val <- NULL
  for (nm in c("obs_diff", "observed_diff", "diff_mean", "obs", "weight_diff")) {
    if (exists(nm)) { diff_val <- get(nm); break }
  }
  skip_if(is.null(diff_val), message = "No observed difference object found")
  if (is.data.frame(diff_val) && "stat" %in% names(diff_val)) {
    diff_val <- diff_val$stat[1]
  }
  # Compute the solution from student's cleaned data
  solution_d <- NULL
  if (exists("ncbirths_clean")) solution_d <- ncbirths_clean
  else if (exists("ncbirths_habitweight")) solution_d <- ncbirths_habitweight
  skip_if(is.null(solution_d), message = "No cleaned dataset found to compare against")
  skip_if(!all(c("habit", "weight") %in% names(solution_d)))
  solution_means <- solution_d %>%
    dplyr::group_by(habit) %>%
    dplyr::summarize(mean_weight = mean(weight), .groups = "drop")
  solution_diff <- solution_means$mean_weight[solution_means$habit == "nonsmoker"] -
                   solution_means$mean_weight[solution_means$habit == "smoker"]
  expect_true(abs(diff_val - solution_diff) < 0.1,
              info =sprintf("Student's difference (%.4f) should be close to solution (%.4f)",
                              diff_val, solution_diff))
})
