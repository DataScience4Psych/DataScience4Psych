# Exercise 2: Scraping artist names

test_that("Ex 2: Rmd contains code to scrape artist names", {
  skip_if(length(.rmd_content) == 0 & length(.r_script_content) == 0)
  potential_answers <- c(
    "\\.iteminfo", "artist", "html_nodes\\(|html_node\\(|html_elements\\(",
    "html_text\\(|html_attr\\("
  )
  pattern <- paste0("(", paste(potential_answers, collapse = "|"), ")")
  answer_in_rmd <- stringr::str_detect(.rmd_content, pattern) |> any()
  answer_in_rscript <- stringr::str_detect(.r_script_content, pattern) |> any()
  answer_in_r <- answer_in_rmd | answer_in_rscript
  expect_equal(answer_in_r, TRUE,
    info = "Include code to scrape artist names using rvest (e.g., html_nodes('.iteminfo'), html_text())"
  )
})

