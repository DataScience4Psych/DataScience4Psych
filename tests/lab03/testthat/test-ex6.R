# Exercise 6: Frequency table of immigrant Nobel laureates' birth countries

test_that("Ex 6: nobel_living_science has required variables for immigrant analysis", {
  skip_if(!exists("nobel_living_science"))
  expect_true(all(c("country_us", "born_country_us", "born_country") %in% names(nobel_living_science)),
              label = "nobel_living_science needs country_us, born_country_us, and born_country for Exercise 6")
})

test_that("Ex 6: immigrant Nobel laureates can be identified", {
  skip_if(!exists("nobel_living_science"))
  skip_if(!all(c("country_us", "born_country_us") %in% names(nobel_living_science)))
  immigrants <- nobel_living_science[
    nobel_living_science$country_us == "USA" &
      nobel_living_science$born_country_us == "Other", ]
  expect_true(nrow(immigrants) > 0,
              label = "There should be immigrant Nobel laureates (US-based, born outside US)")
})

test_that("Ex 6: immigrant laureates come from multiple birth countries", {
  skip_if(!exists("nobel_living_science"))
  skip_if(!all(c("country_us", "born_country_us", "born_country") %in% names(nobel_living_science)))
  immigrants <- nobel_living_science[
    nobel_living_science$country_us == "USA" &
      nobel_living_science$born_country_us == "Other", ]
  n_countries <- length(unique(immigrants$born_country))
  expect_true(n_countries > 1,
              label = "Immigrant laureates should come from multiple birth countries")
})

test_that("Ex 6: frequency table of birth countries can be constructed", {
  skip_if(!exists("nobel_living_science"))
  skip_if(!all(c("country_us", "born_country_us", "born_country") %in% names(nobel_living_science)))
  immigrants <- nobel_living_science[
    nobel_living_science$country_us == "USA" &
      nobel_living_science$born_country_us == "Other", ]
  freq_table <- as.data.frame(table(immigrants$born_country))
  freq_table <- freq_table[order(-freq_table$Freq), ]
  expect_true(nrow(freq_table) > 0,
              label = "Frequency table of immigrant birth countries should have rows")
  expect_true(max(freq_table$Freq) > 1,
              label = "At least one birth country should have more than one immigrant laureate")
})
