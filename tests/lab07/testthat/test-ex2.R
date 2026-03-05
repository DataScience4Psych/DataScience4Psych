# Exercise 2: Accurate visualization of mask mandate data

test_that("Ex 2: an accurate line plot can be created", {
  skip_if(!exists("df") || !"mask_mandate" %in% names(df))
  p <- ggplot2::ggplot(df,
    ggplot2::aes(x = date, y = rolling_avg,
                 color = mask_mandate, group = mask_mandate)) +
    ggplot2::geom_line()
  expect_s3_class(p, "ggplot")
})

test_that("Ex 2: mask counties have lower rolling average by end of period", {
  skip_if(!exists("df") || !"mask_mandate" %in% names(df))
  skip_if(!"date" %in% names(df))
  last_date <- max(df$date, na.rm = TRUE)
  last_vals <- df %>%
    dplyr::filter(date == last_date)
  skip_if(nrow(last_vals) < 2)
  # Mask counties should generally show lower values
  mask_val <- last_vals$rolling_avg[grepl("[Mm]ask", last_vals$mask_mandate) &
                                     !grepl("[Nn]o", last_vals$mask_mandate)]
  nomask_val <- last_vals$rolling_avg[grepl("[Nn]o", last_vals$mask_mandate)]
  skip_if(length(mask_val) == 0 || length(nomask_val) == 0)
  expect_true(mask_val[1] < nomask_val[1],
              label = "Mask counties should show lower case rates by end of period")
})
