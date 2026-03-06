# Exercise 6: Immigrant Nobel laureates — birth countries frequency table

test_that("Ex 6: Rmd filters for US-based winners born outside US", {
  skip_if(length(.rmd_content) == 0)
  potential_answers <- c(
    "country.*USA.*born_country_us.*Other",
    "country.*USA",
    "filter.*country.*USA"
  )
  pattern <- paste0("(", paste(potential_answers, collapse = "|"), ")")
  answer_in_rmd <- stringr::str_detect(.rmd_content, pattern) |> any()
  expect_equal(answer_in_rmd, TRUE,
    info = "Ex 6: Filter for laureates who won in the US but were born outside the US"
  )
})

test_that("Ex 6: Rmd uses count() function for frequency table", {
  skip_if(length(.rmd_content) == 0)
  potential_answers <- c(
    "count\\(born_country\\)",
    "count.*born_country"
  )
  pattern <- paste0("(", paste(potential_answers, collapse = "|"), ")")
  answer_in_rmd <- stringr::str_detect(.rmd_content, pattern) |> any()
  expect_equal(answer_in_rmd, TRUE,
    info = "Ex 6: Use count() to create a frequency table of birth countries"
  )
})

test_that("Ex 6: Rmd arranges frequency table in descending order", {
  skip_if(length(.rmd_content) == 0)
  potential_answers <- c(
    "arrange.*desc",
    "arrange.*-n",
    "sort.*decreas"
  )
  pattern <- paste0("(", paste(potential_answers, collapse = "|"), ")")
  answer_in_rmd <- stringr::str_detect(.rmd_content, pattern) |> any()
  expect_equal(answer_in_rmd, TRUE,
    info = "Ex 6: Arrange the frequency table in descending order"
  )
})

test_that("Ex 6: Germany is among top birth countries for immigrant Nobelists", {
  skip_if(!exists("nobel_living"))
  skip_if(!all(c("country", "born_country_us") %in% names(nobel_living)))
  immigrant_counts <- nobel_living |>
    dplyr::filter(country == "USA", born_country_us == "Other") |>
    dplyr::count(born_country) |>
    dplyr::arrange(dplyr::desc(n))
  top_countries <- head(immigrant_counts$born_country, 5)
  expect_true(
    "Germany" %in% top_countries,
    label = "Germany should be among the top 5 birth countries for immigrant Nobel laureates"
  )
})
