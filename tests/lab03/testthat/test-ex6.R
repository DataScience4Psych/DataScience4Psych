# Exercise 6: Frequency table of immigrant Nobel laureates' birth countries

test_that("Ex 6: nobel_living_science has required variables for immigrant analysis", {
  skip_if(!exists("nobel_living_science"))
  expect_true(all(c("country_us", "born_country_us", "born_country") %in% names(nobel_living_science)),
              info = "Make sure nobel_living_science has country_us, born_country_us, and born_country variables for Exercise 6")
})

test_that("Ex 6: Rmd Exercise 6 contains frequency table code", {
  skip_if(length(.rmd_content) == 0)
  potential_answers <- c("table", "count", "tally", "n\\(\\)")
  pattern <- paste0("(", paste(potential_answers, collapse = "|"), ")")
  has_table <- stringr::str_detect(.rmd_content, pattern) |> any()
  potential_answers_filter <- c("filter", "born_country")
  pattern_filter <- paste0("(", paste(potential_answers_filter, collapse = "|"), ")")
  has_filter <- stringr::str_detect(.rmd_content, pattern_filter) |> any()
  expect_true(has_table && has_filter,
              info = "Include code to create a frequency table of immigrant birth countries in your Rmd file")
})

test_that("Ex 6: Rmd Exercise 6 references immigrants or born_country", {
  skip_if(length(.rmd_content) == 0)
  potential_answers <- c("born_country", "immig", "born.*other", "Other")
  pattern <- paste0("(", paste(potential_answers, collapse = "|"), ")")
  answer_in_rmd <- stringr::str_detect(.rmd_content, pattern) |> any()
  expect_equal(answer_in_rmd, TRUE,
               info = "Make sure to reference born_country or immigrant filtering in your Rmd file")
})

test_that("Ex 6: immigrant laureates come from multiple birth countries (solution check)", {
  skip_if(!exists("nobel_living_science"))
  skip_if(!all(c("country_us", "born_country_us", "born_country") %in% names(nobel_living_science)))
  solution_immigrants <- nobel_living_science[
    nobel_living_science$country_us == "USA" &
      nobel_living_science$born_country_us == "Other", ]
  expect_true(nrow(solution_immigrants) > 0,
              info = "Make sure there are immigrant Nobel laureates (US-based, born outside US) in your data")
  solution_n_countries <- length(unique(solution_immigrants$born_country))
  expect_true(solution_n_countries > 1,
              info = "Check your filters — immigrant laureates should come from multiple birth countries")
})

test_that("Ex 6: frequency table has expected properties (solution check)", {
  skip_if(!exists("nobel_living_science"))
  skip_if(!all(c("country_us", "born_country_us", "born_country") %in% names(nobel_living_science)))
  solution_immigrants <- nobel_living_science[
    nobel_living_science$country_us == "USA" &
      nobel_living_science$born_country_us == "Other", ]
  solution_freq <- as.data.frame(table(solution_immigrants$born_country))
  solution_freq <- solution_freq[order(-solution_freq$Freq), ]
  expect_true(nrow(solution_freq) > 0,
              info = "Make sure your frequency table of immigrant birth countries has rows")
  expect_true(max(solution_freq$Freq) > 1,
              info = "Check your data — at least one birth country should have more than one immigrant laureate")
})

test_that("Ex 6: Rmd Exercise 6 mentions the most common immigrant birth country", {
  skip_if(length(.rmd_content) == 0)
  skip_if(!exists("nobel_living_science"))
  skip_if(!all(c("country_us", "born_country_us", "born_country") %in% names(nobel_living_science)))
  solution_immigrants <- nobel_living_science[
    nobel_living_science$country_us == "USA" &
      nobel_living_science$born_country_us == "Other", ]
  solution_freq <- as.data.frame(table(solution_immigrants$born_country))
  solution_freq <- solution_freq[order(-solution_freq$Freq), ]
  top_country <- as.character(solution_freq$Var1[1])
  potential_answers <- c(top_country, "born_country.*count|count.*born_country|table.*born_country")
  pattern <- paste0("(", paste(potential_answers, collapse = "|"), ")")
  answer_in_rmd <- stringr::str_detect(.rmd_content, pattern) |> any()
  expect_equal(answer_in_rmd, TRUE,
               info = sprintf("Make sure to mention %s as the most common birth country in the .rmd file", top_country))
})
