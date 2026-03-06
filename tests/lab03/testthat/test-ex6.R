# Exercise 6: Frequency table of immigrant Nobel laureates' birth countries

test_that("Ex 6: nobel_living_science has required variables for immigrant analysis", {
  skip_if(!exists("nobel_living_science"))
  expect_true(all(c("country_us", "born_country_us", "born_country") %in% names(nobel_living_science)),
              label = "nobel_living_science needs country_us, born_country_us, and born_country for Exercise 6")
})

test_that("Ex 6: Rmd Exercise 6 contains frequency table code", {
  skip_if(length(.rmd_content) == 0)
  section <- .find_ex_section(.rmd_content, "6", NULL)
  skip_if(is.null(section), "Could not locate Exercise 6 section in Rmd")
  has_table <- any(grepl("table|count|tally|n\\(\\)", section))
  has_filter <- any(grepl("filter|born_country", section))
  expect_true(has_table && has_filter,
              label = "Exercise 6 should contain code to create a frequency table of immigrant birth countries")
})

test_that("Ex 6: Rmd Exercise 6 references immigrants or born_country", {
  skip_if(length(.rmd_content) == 0)
  section <- .find_ex_section(.rmd_content, "6", NULL)
  skip_if(is.null(section), "Could not locate Exercise 6 section in Rmd")
  has_born <- any(grepl("born_country", section))
  has_immigrant <- any(grepl("immig|born.*other|Other", section))
  expect_true(has_born || has_immigrant,
              label = "Exercise 6 should reference born_country or immigrant filtering")
})
