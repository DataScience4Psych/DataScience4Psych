# Exercise 2: Accurate visualization of mask mandate data

test_that("Ex 2: df object exists for plotting", {
  expect_true(exists("df"),
              label = "df must be created in Exercise 1 before creating the improved plot"
  )
})

test_that("Ex 2: df has required columns for an accurate plot", {
  skip_if(!exists("df"))
  expect_true(all(c("date", "mask_mandate", "rolling_avg") %in% names(df)),
              label = "df needs date, mask_mandate, and rolling_avg columns for the plot")
})

test_that("Ex 2: both mask mandate groups have data across multiple dates", {
  skip_if(!exists("df"))
  skip_if(!all(c("date", "mask_mandate") %in% names(df)))
  group_counts <- df %>%
    dplyr::group_by(mask_mandate) %>%
    dplyr::summarize(n_dates = dplyr::n_distinct(date), .groups = "drop")
  expect_true(all(group_counts$n_dates > 5),
              label = "Each mask mandate group should have data across many dates")
})

test_that("Ex 2: mask counties show lower rolling average by end of period", {
  skip_if(!exists("df"))
  skip_if(!all(c("date", "mask_mandate", "rolling_avg") %in% names(df)))
  last_date <- max(df$date, na.rm = TRUE)
  last_vals <- df %>%
    dplyr::filter(date == last_date)
  skip_if(nrow(last_vals) < 2,
          message = "Could not find both groups on the last date")
  mask_val <- last_vals$rolling_avg[grepl("[Mm]ask", last_vals$mask_mandate) &
                                     !grepl("[Nn]o", last_vals$mask_mandate)]
  nomask_val <- last_vals$rolling_avg[grepl("[Nn]o", last_vals$mask_mandate)]
  skip_if(length(mask_val) == 0 || length(nomask_val) == 0,
          message = "Could not identify mask vs no-mask groups")
  expect_true(mask_val[1] < nomask_val[1],
              label = "Mask mandate counties should show lower case rates by end of period")
})
