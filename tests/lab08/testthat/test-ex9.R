# Exercises 9-15: Analysis of scraped art data

test_that("Ex 9: uoe_art object exists", {
  expect_true(exists("uoe_art"),
              label = "uoe_art should be loaded from the saved CSV or created in the student's code"
  )
})

test_that("Ex 9: uoe_art is a data frame", {
  skip_if(!exists("uoe_art"))
  expect_true(is.data.frame(uoe_art),
              label = "uoe_art should be a data frame")
})

test_that("Ex 9: uoe_art has title column", {
  skip_if(!exists("uoe_art"))
  expect_true("title" %in% names(uoe_art),
              label = "uoe_art should have a title column")
})

test_that("Ex 9: uoe_art has artist column", {
  skip_if(!exists("uoe_art"))
  expect_true("artist" %in% names(uoe_art),
              label = "uoe_art should have an artist column")
})

test_that("Ex 9: uoe_art has link column", {
  skip_if(!exists("uoe_art"))
  expect_true("link" %in% names(uoe_art),
              label = "uoe_art should have a link column")
})

test_that("Ex 9: uoe_art has multiple rows of art pieces", {
  skip_if(!exists("uoe_art"))
  expect_true(nrow(uoe_art) > 100,
              label = "uoe_art should contain many art pieces (scraped from multiple pages)")
})

test_that("Ex 10: uoe_art has a year column after separating title from date", {
  skip_if(!exists("uoe_art"))
  expect_true("year" %in% names(uoe_art),
              label = "uoe_art should have a year column created by separating title from date")
})

test_that("Ex 10: year column is numeric", {
  skip_if(!exists("uoe_art") || !"year" %in% names(uoe_art))
  expect_true(is.numeric(uoe_art$year),
              label = "year column should be numeric after cleaning")
})

test_that("Ex 10: year values are plausible (within a reasonable range)", {
  skip_if(!exists("uoe_art") || !"year" %in% names(uoe_art))
  valid_years <- uoe_art$year[!is.na(uoe_art$year)]
  skip_if(length(valid_years) == 0, message = "No non-NA year values found")
  expect_true(all(valid_years >= 1400 & valid_years <= 2025),
              label = "year values should be plausible dates for artworks")
})

test_that("Ex 14: can identify the most common artist in uoe_art", {
  skip_if(!exists("uoe_art") || !"artist" %in% names(uoe_art))
  artist_counts <- uoe_art %>%
    dplyr::filter(!is.na(artist), artist != "") %>%
    dplyr::count(artist, sort = TRUE)
  expect_true(nrow(artist_counts) > 0,
              label = "There should be identifiable artists in the data")
  expect_true(artist_counts$n[1] > 1,
              label = "The most common artist should have more than one piece")
})

test_that("Ex 15: uoe_art contains pieces with 'child' in the title", {
  skip_if(!exists("uoe_art") || !"title" %in% names(uoe_art))
  child_pieces <- uoe_art %>%
    dplyr::filter(stringr::str_detect(tolower(title), "child"))
  expect_true(nrow(child_pieces) > 0,
              label = "There should be art pieces with 'child' in the title")
})
