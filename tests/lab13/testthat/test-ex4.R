# Exercise 4: Simulate 100 colonies and analyze variation

test_that("Ex 4: Rmd simulates multiple colonies (100 repetitions)", {
  skip_if(length(.rmd_content) == 0)
  potential_answers <- c(
    "replicate\\(",
    "for.*1:100",
    "for.*num_simulations",
    "100.*simulations",
    "num_simulations"
  )
  pattern <- paste0("(", paste(potential_answers, collapse = "|"), ")")
  answer_in_rmd <- stringr::str_detect(.rmd_content, pattern) |> any()
  expect_equal(answer_in_rmd, TRUE,
    info = "Ex 4: Simulate 100 colonies using replicate() or a for loop"
  )
})

test_that("Ex 4: all_simulations data frame exists", {
  expect_true(
    exists("all_simulations") || exists("colony_results"),
    label = "all_simulations (or colony_results) should store results from all 100 colony simulations"
  )
})

test_that("Ex 4: Rmd plots distribution of summary statistics across colonies", {
  skip_if(length(.rmd_content) == 0)
  potential_answers <- c(
    "geom_histogram",
    "geom_density"
  )
  pattern <- paste0("(", paste(potential_answers, collapse = "|"), ")")
  answer_in_rmd <- stringr::str_detect(.rmd_content, pattern) |> any()
  expect_equal(answer_in_rmd, TRUE,
    info = "Ex 4.2: Plot the distribution of summary statistics (e.g., mean extraversion) across colonies"
  )
})

test_that("Ex 4: Rmd discusses sample size needed for stable correlation estimate", {
  skip_if(length(.rmd_content) == 0)
  potential_answers <- c(
    "sample size",
    "stable",
    "consistent",
    "correlation"
  )
  pattern <- paste0("(", paste(potential_answers, collapse = "|"), ")")
  answer_in_rmd <- stringr::str_detect(.rmd_content, pattern) |> any()
  expect_equal(answer_in_rmd, TRUE,
    info = "Ex 4: Discuss how large a sample size is needed for a stable correlation estimate"
  )
})
