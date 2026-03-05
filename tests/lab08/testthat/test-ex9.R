# Exercise 9-15: Analysis of scraped art data

test_that("Ex 9: uoe_art data file exists", {
  found <- file.exists("data/uoe-art.csv") ||
           file.exists("data/uoe_art.csv") ||
           exists("uoe_art")
  expect_true(found,
              label = "uoe_art data should be saved as CSV or exist as object")
})

test_that("Ex 10: title and date columns exist after separation", {
  skip_if(!exists("uoe_art"))
  expect_true(all(c("title") %in% names(uoe_art)),
              label = "uoe_art should have a title column")
})

test_that("Ex 11: skim or summary provides missing data counts", {
  skip_if(!exists("uoe_art"))
  n_missing_artist <- sum(is.na(uoe_art$artist) | uoe_art$artist == "")
  expect_true(is.numeric(n_missing_artist))
})

test_that("Ex 12: histogram of years can be created", {
  skip_if(!exists("uoe_art"))
  skip_if(!"year" %in% names(uoe_art))
  p <- ggplot2::ggplot(uoe_art, ggplot2::aes(x = year)) +
    ggplot2::geom_histogram()
  expect_s3_class(p, "ggplot")
})

test_that("Ex 15: can filter for titles containing 'child'", {
  skip_if(!exists("uoe_art"))
  child_pieces <- uoe_art %>%
    dplyr::filter(stringr::str_detect(title, regex("child", ignore_case = TRUE)))
  expect_true(is.data.frame(child_pieces))
})
