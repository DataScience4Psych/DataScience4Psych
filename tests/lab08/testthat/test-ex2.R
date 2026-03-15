# Exercises 2-4: Artist scraping, tibble construction, and second page

test_that("Ex 2: Rmd contains code to scrape artist names", {
  skip_if(length(.rmd_content) == 0)
  potential_answers <- c(
    "\\.iteminfo", "artist", "html_nodes\\(|html_node\\(|html_elements\\(",
    "html_text\\(|html_attr\\("
  )
  pattern <- paste0("(", paste(potential_answers, collapse = "|"), ")")
  answer_in_rmd <- stringr::str_detect(.rmd_content, pattern) |> any()
  expect_equal(answer_in_rmd, TRUE,
    info = "Include code to scrape artist names using rvest (e.g., html_nodes('.iteminfo'), html_text())"
  )
})

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

test_that("Ex 3: Rmd contains tibble or data.frame construction code for art pieces", {
  skip_if(length(.rmd_content) == 0)
  potential_answers <- c("tibble\\(", "data\\.frame\\(", "first_ten", "bind_rows")
  pattern <- paste0("(", paste(potential_answers, collapse = "|"), ")")
  answer_in_rmd <- stringr::str_detect(.rmd_content, pattern) |> any()
  expect_equal(answer_in_rmd, TRUE,
    info = "Include code to build a tibble of art pieces (with title, artist, link) for Exercise 3"
  )
})

test_that("Ex 4: second_url is defined", {
  expect_true(exists("second_url"),
    info = "Define 'second_url' as the URL for the second page (offset=10)"
  )
})

test_that("Ex 4: second_url contains offset=10", {
  skip_if(!exists("second_url"))
  expect_true(grepl("offset=10", second_url),
    info = "second_url should point to the second page — check that it contains 'offset=10'"
  )
})

test_that("Ex 4: second_ten object exists", {
  skip_if(!exists("second_ten"),
    message = "second_ten not found; scrape the second page and save the results as 'second_ten'"
  )
  expect_true(is.data.frame(second_ten),
    info = "Make sure 'second_ten' is a data frame or tibble"
  )
})

test_that("Ex 4: second_ten has title, artist, and link columns", {
  skip_if(!exists("second_ten"))
  expect_true(all(c("title", "artist", "link") %in% tolower(names(second_ten))),
    info = "Make sure 'second_ten' has title, artist, and link columns (same structure as first_ten)"
  )
})

test_that("Ex 4: second_ten has exactly 10 rows", {
  skip_if(!exists("second_ten"))
  expect_equal(nrow(second_ten), 10,
    info = "second_ten should contain 10 art pieces from the second page"
  )
})

test_that("Ex 4: second_ten and first_ten contain different art pieces", {
  skip_if(!exists("second_ten") || !exists("first_ten"))
  ft_names <- tolower(names(first_ten))
  st_names <- tolower(names(second_ten))
  skip_if(!"title" %in% ft_names || !"title" %in% st_names)
  ft_title_col <- names(first_ten)[ft_names == "title"][1]
  st_title_col <- names(second_ten)[st_names == "title"][1]
  ft_titles <- first_ten[[ft_title_col]]
  st_titles <- second_ten[[st_title_col]]
  expect_true(length(intersect(ft_titles, st_titles)) < 5,
    info = "first_ten and second_ten should contain different art pieces (from different pages)"
  )
})
