# Exercises 9-12: State-level analysis, bind_rows, and visualization

test_that("Ex 9: Rmd Exercise 9 contains state counting code", {
  skip_if(length(.rmd_content) == 0)
  potential_answers <- c("count", "table", "tally", "n\\(\\)", "group_by")
  pattern <- paste0("(", paste(potential_answers, collapse = "|"), ")")
  has_count <- stringr::str_detect(.rmd_content, pattern) |> any()
  has_state <- stringr::str_detect(.rmd_content, "state") |> any()
  expect_true(has_count && has_state,
    info = "Add code to count locations by state in your Rmd file (e.g., using count() or table())"
  )
})

test_that("Ex 9: Denny's data has California locations (solution check)", {
  skip_if(!exists("dn") && !exists("dennys"))
  d <- if (exists("dn")) dn else dennys
  solution_state_counts <- as.data.frame(table(d$state))
  expect_true(nrow(solution_state_counts) > 0,
    info = "Make sure Denny's state counts have rows -- check your data"
  )
  expect_true("CA" %in% d$state,
    info = "Make sure California appears in Denny's locations -- check your data loading"
  )
})

test_that("Ex 9: La Quinta data has Texas locations (solution check)", {
  skip_if(!exists("lq") && !exists("laquinta"))
  d <- if (exists("lq")) lq else laquinta
  solution_state_counts <- as.data.frame(table(d$state))
  expect_true(nrow(solution_state_counts) > 0,
    info = "Make sure La Quinta state counts have rows -- check your data"
  )
  expect_true("TX" %in% d$state,
    info = "Make sure Texas appears in La Quinta locations -- check your data loading"
  )
})

test_that("Ex 9: Rmd Exercise 9 reports the state with the most Denny's locations", {
  skip_if(length(.rmd_content) == 0)
  skip_if(!exists("dn") && !exists("dennys"))
  d <- if (exists("dn")) dn else dennys
  solution_counts <- sort(table(d$state), decreasing = TRUE)
  solution_top_state <- names(solution_counts)[1]
  potential_answers <- c(solution_top_state, "count\\(.*state", "table\\(.*state", "tally")
  pattern <- paste0("(", paste(potential_answers, collapse = "|"), ")")
  answer_in_rmd <- stringr::str_detect(.rmd_content, pattern) |> any()
  expect_equal(answer_in_rmd, TRUE,
    info = sprintf("Make sure to report that %s has the most Denny's locations in the .rmd file", solution_top_state)
  )
})

test_that("Ex 9: Rmd Exercise 9 reports the state with the most La Quinta locations", {
  skip_if(length(.rmd_content) == 0)
  skip_if(!exists("lq") && !exists("laquinta"))
  d <- if (exists("lq")) lq else laquinta
  solution_counts <- sort(table(d$state), decreasing = TRUE)
  solution_top_state <- names(solution_counts)[1]
  potential_answers <- c(solution_top_state, "count\\(.*state", "table\\(.*state", "tally")
  pattern <- paste0("(", paste(potential_answers, collapse = "|"), ")")
  answer_in_rmd <- stringr::str_detect(.rmd_content, pattern) |> any()
  expect_equal(answer_in_rmd, TRUE,
    info = sprintf("Make sure to report that %s has the most La Quinta locations in the .rmd file", solution_top_state)
  )
})

test_that("Ex 10-11: dn_lq combined data frame exists", {
  expect_true(exists("dn_lq"),
    info = "Create dn_lq by using bind_rows on dn and lq with an establishment variable"
  )
})

test_that("Ex 10-11: dn_lq has establishment variable", {
  skip_if(!exists("dn_lq"))
  expect_true("establishment" %in% names(dn_lq),
    info = "Add an 'establishment' column to dn_lq that distinguishes Denny's from La Quinta"
  )
})

test_that("Ex 10-11: dn_lq has both Denny's and La Quinta", {
  skip_if(!exists("dn_lq"))
  skip_if(!"establishment" %in% names(dn_lq))
  establishments <- unique(dn_lq$establishment)
  expect_true(length(establishments) == 2,
    info = "Make sure dn_lq contains exactly two types of establishments (Denny's and La Quinta)"
  )
})

test_that("Ex 10-11: dn_lq has longitude and latitude for plotting", {
  skip_if(!exists("dn_lq"))
  expect_true(all(c("longitude", "latitude") %in% names(dn_lq)),
    info = "Make sure dn_lq has longitude and latitude columns for creating scatter plots"
  )
})

test_that("Ex 11-12: dn_lq contains NC observations for filtering", {
  skip_if(!exists("dn_lq"))
  nc_rows <- dn_lq[dn_lq$state == "NC", ]
  expect_true(nrow(nc_rows) > 0,
    info = "Make sure dn_lq contains North Carolina observations for the Exercise 11 plot"
  )
})

test_that("Ex 12: dn_lq contains TX observations for filtering", {
  skip_if(!exists("dn_lq"))
  tx_rows <- dn_lq[dn_lq$state == "TX", ]
  expect_true(nrow(tx_rows) > 0,
    info = "Make sure dn_lq contains Texas observations for the Exercise 12 plot"
  )
})
