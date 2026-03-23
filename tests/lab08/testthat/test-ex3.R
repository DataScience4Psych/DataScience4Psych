# Exercise 3: Assembling the first 10 art pieces into a tibble

test_that("Ex 3: first_ten object exists", {
  skip_if(!exists("first_ten"),
    message = "first_ten not found; create a tibble of the first 10 art pieces with title, artist, and link columns"
  )
  expect_true(is.data.frame(first_ten),
    info = "Make sure 'first_ten' is a data frame or tibble"
  )
})

test_that("Ex 3: first_ten has title, artist, and link columns", {
  skip_if(!exists("first_ten"))
  expect_true(all(c("title", "artist", "link") %in% tolower(names(first_ten))),
    info = "Make sure 'first_ten' has title, artist, and link columns"
  )
})

test_that("Ex 3: first_ten has exactly 10 rows", {
  skip_if(!exists("first_ten"))
  expect_equal(nrow(first_ten), 10,
    info = "first_ten should contain exactly 10 art pieces (one per result on the first page)"
  )
})

test_that("Ex 3: first_ten link column contains full URLs (not relative paths)", {
  skip_if(!exists("first_ten"))
  link_col <- names(first_ten)[tolower(names(first_ten)) == "link"]
  skip_if(length(link_col) == 0, message = "No 'link' column found in first_ten")
  links <- first_ten[[link_col[1]]]
  links <- links[!is.na(links)]
  skip_if(length(links) == 0, message = "All link values are NA")
  expect_true(all(grepl("^https?://", links)),
    info = "Links should be full URLs (starting with 'https://') — use str_replace() to prepend the base URL"
  )
})

test_that("Ex 3: Rmd or scripts contain tibble or data.frame construction code for art pieces", {
  skip_if(length(.rmd_content) == 0 & length(.r_script_content) == 0)
  potential_answers <- c("tibble\\(", "data\\.frame\\(", "first_ten", "bind_rows")
  pattern <- paste0("(", paste(potential_answers, collapse = "|"), ")")
  answer_in_rmd <- stringr::str_detect(.rmd_content, pattern) |> any()
  answer_in_rscript <- stringr::str_detect(.r_script_content, pattern) |> any()
  answer_in_r <- answer_in_rmd | answer_in_rscript
  expect_equal(answer_in_r, TRUE,
    info = "Include code to build a tibble of art pieces (with title, artist, link) for Exercise 3 (in your Rmd or scripts/)"
  )
})
