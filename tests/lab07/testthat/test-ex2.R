# Exercise 2: Explore data structure and compute group summaries

test_that("Ex 2: df object exists for exploration", {
  expect_true(exists("df"),
              info = "Create 'df' in Exercise 1 before exploring it"
  )
})

test_that("Ex 2: df has required columns for exploration", {
  skip_if(!exists("df"))
  expect_true(all(c("date", "mask_mandate", "rolling_avg") %in% names(df)),
              info = "Make sure 'df' has date, mask_mandate, and rolling_avg columns")
})

test_that("Ex 2: both mask mandate groups have data across multiple dates", {
  skip_if(!exists("df"))
  skip_if(!all(c("date", "mask_mandate") %in% names(df)))
  group_counts <- df %>%
    dplyr::group_by(mask_mandate) %>%
    dplyr::summarize(n_dates = dplyr::n_distinct(date), .groups = "drop")
  expect_true(all(group_counts$n_dates > 5),
              info = "Make sure each mask mandate group has data across many dates")
})

test_that("Ex 2: mask counties show lower rolling average by end of period", {
  skip_if(!exists("df"))
  skip_if(!all(c("date", "mask_mandate", "rolling_avg") %in% names(df)))
  last_date <- max(df$date, na.rm = TRUE)
  last_vals <- df %>%
    dplyr::filter(date == last_date)
  skip_if(nrow(last_vals) < 2,
          message = "Could not find both groups on the last date")
  mask_val <- last_vals$rolling_avg[stringr::str_detect(last_vals$mask_mandate, "[Mm]ask") &
                                     !stringr::str_detect(last_vals$mask_mandate, "[Nn]o")]
  nomask_val <- last_vals$rolling_avg[stringr::str_detect(last_vals$mask_mandate, "[Nn]o")]
  skip_if(length(mask_val) == 0 || length(nomask_val) == 0,
          message = "Could not identify mask vs no-mask groups")
  expect_true(mask_val[1] < nomask_val[1],
              info = "Mask mandate counties should show lower case rates by end of period — check your data reflects this")
})
