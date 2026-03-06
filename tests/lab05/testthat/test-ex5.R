# Exercise 12: Where does Mitch Hedberg's joke hold true?

test_that("Ex 12: Rmd discusses which state best supports the Hedberg joke", {
  skip_if(length(.rmd_content) == 0)
  potential_answers <- c(
    "Hedberg",
    "joke",
    "Texas|TX|Alaska|AK|North Carolina|NC"
  )
  pattern <- paste0("(", paste(potential_answers, collapse = "|"), ")")
  answer_in_rmd <- stringr::str_detect(.rmd_content, pattern) |> any()
  expect_equal(answer_in_rmd, TRUE,
    info = "Ex 12: Discuss which state best supports Mitch Hedberg's joke based on your analysis"
  )
})

test_that("Ex 11: Rmd analyzes a fourth state", {
  skip_if(length(.rmd_content) == 0)
  # The student should have filtered for at least 4 different state codes
  # AK, NC, TX are required; a fourth should be present
  state_pattern <- '"[A-Z]{2}"'
  state_matches <- stringr::str_extract_all(.rmd_content, state_pattern) |>
    unlist() |>
    unique()
  state_matches <- gsub('"', "", state_matches)
  # Remove non-state values
  valid_states <- state.abb
  found_states <- state_matches[state_matches %in% valid_states]
  expect_true(
    length(found_states) >= 4,
    label = "Ex 11: Analyze at least 4 states (AK, NC, TX, plus one of your choosing)"
  )
})
