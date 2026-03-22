# Exercise 11: Summarising the data with skim()

test_that("Ex 11: Rmd contains skim() to summarise uoe_art", {
  skip_if(length(.rmd_content) == 0)
  potential_answers <- c(
    "skim\\(", "skimr",
    "summary\\(.*uoe_art", "glimpse\\(.*uoe_art"
  )
  pattern <- paste0("(", paste(potential_answers, collapse = "|"), ")")
  answer_in_rmd <- stringr::str_detect(.rmd_content, pattern) |> any()
  expect_equal(answer_in_rmd, TRUE,
    info = "Use skim() from the skimr package to print a summary of uoe_art for Exercise 11"
  )
})

test_that("Ex 11: uoe_art has some missing artist values (expected)", {
  .art <- .find_art_df()
  skip_if(is.null(.art) || !"artist" %in% names(.art))
  expect_true(any(is.na(.art$artist) | .art$artist == ""),
    info = "Some art pieces won't have artist information — the skim() output should show this"
  )
})

test_that("Ex 11: uoe_art has some missing year values (expected)", {
  .art <- .find_art_df()
  skip_if(is.null(.art) || !"year" %in% names(.art))
  expect_true(any(is.na(.art$year)),
    info = "Some art pieces won't have year information — the skim() output should show this"
  )
})
