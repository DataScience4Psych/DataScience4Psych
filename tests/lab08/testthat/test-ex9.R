# Exercises 9-15: Analysis of scraped art data

test_that("Ex 9: scraped art data frame exists", {
  .art <- .find_art_df()
  expect_true(!is.null(.art),
    info = "Create a scraped art data frame (e.g. named 'uoe_art') from your scraping code"
  )
})

test_that("Ex 9: scraped art data frame is a data frame", {
  .art <- .find_art_df()
  skip_if(is.null(.art))
  expect_true(is.data.frame(.art),
    info = "Make sure the scraped art object is a data frame"
  )
})

test_that("Ex 9: scraped art data frame has title column", {
  .art <- .find_art_df()
  skip_if(is.null(.art))
  expect_true("title" %in% names(.art),
    info = "Make sure the art data frame has a column named 'title'"
  )
})

test_that("Ex 9: scraped art data frame has artist column", {
  .art <- .find_art_df()
  skip_if(is.null(.art))
  expect_true("artist" %in% names(.art),
    info = "Make sure the art data frame has a column named 'artist'"
  )
})

test_that("Ex 9: scraped art data frame has link column", {
  .art <- .find_art_df()
  skip_if(is.null(.art))
  expect_true("link" %in% names(.art),
    info = "Make sure the art data frame has a column named 'link'"
  )
})

test_that("Ex 9: scraped art data frame has multiple rows of art pieces", {
  .art <- .find_art_df()
  skip_if(is.null(.art))
  expect_true(nrow(.art) > 100,
    info = "Make sure the art data frame contains many art pieces (scrape from multiple pages)"
  )
})

test_that("Ex 10: scraped art data frame has a year column after separating title from date", {
  .art <- .find_art_df()
  skip_if(is.null(.art))
  expect_true("year" %in% names(.art),
    info = "Create a 'year' column by separating the title from the date"
  )
})

test_that("Ex 10: year column is numeric", {
  .art <- .find_art_df()
  skip_if(is.null(.art) || !"year" %in% names(.art))
  expect_true(is.numeric(.art$year),
    info = "Convert the 'year' column to numeric after cleaning"
  )
})

test_that("Ex 10: year values are plausible (within a reasonable range)", {
  .art <- .find_art_df()
  skip_if(is.null(.art) || !"year" %in% names(.art))
  valid_years <- .art$year[!is.na(.art$year)]
  skip_if(length(valid_years) == 0, message = "No non-NA year values found")
  current_year <- as.integer(format(Sys.Date(), "%Y"))
  expect_true(all(valid_years >= 1400 & valid_years <= current_year),
    info = paste0("Check that your 'year' values are plausible dates for artworks (between 1400 and ", current_year, ")")
  )
})

test_that("Ex 14: can identify the most common artist in the art data frame", {
  .art <- .find_art_df()
  skip_if(is.null(.art) || !"artist" %in% names(.art))
  artist_counts <- .art %>%
    dplyr::filter(!is.na(artist), artist != "") %>%
    dplyr::count(artist, sort = TRUE)
  expect_true(nrow(artist_counts) > 0,
    info = "Make sure there are identifiable artists in the data"
  )
  expect_true(artist_counts$n[1] > 1,
    info = "Find the most common artist — they should have more than one piece"
  )
})

test_that("Ex 15: art data frame contains pieces with 'child' in the title", {
  .art <- .find_art_df()
  skip_if(is.null(.art) || !"title" %in% names(.art))
  child_pieces <- .art %>%
    dplyr::filter(stringr::str_detect(tolower(title), "child"))
  expect_true(nrow(child_pieces) > 0,
    info = "Filter for art pieces with 'child' in the title"
  )
})
