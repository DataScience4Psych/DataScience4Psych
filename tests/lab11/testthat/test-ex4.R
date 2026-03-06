# Exercise 4: Cutoff as a policy decision

test_that("Ex 4: Rmd tests multiple cutoffs (0.3, 0.5, 0.7)", {
  skip_if(length(.rmd_content) == 0)
  potential_answers <- c(
    "0\\.3",
    "0\\.5",
    "0\\.7",
    "cutoff",
    "threshold"
  )
  # Must have at least two of these
  matches <- sapply(potential_answers, function(p) {
    any(stringr::str_detect(.rmd_content, p))
  })
  expect_true(sum(matches) >= 2,
    label = "Ex 4: Test at least two different cutoff values (e.g., 0.3, 0.5, 0.7)"
  )
})

test_that("Ex 4: Rmd discusses why accuracy alone is a poor criterion for cutoff selection", {
  skip_if(length(.rmd_content) == 0)
  potential_answers <- c(
    "false.positive",
    "false.negative",
    "cost",
    "trade.off",
    "asymmetr"
  )
  pattern <- paste0("(", paste(potential_answers, collapse = "|"), ")")
  answer_in_rmd <- stringr::str_detect(.rmd_content, pattern) |> any()
  expect_equal(answer_in_rmd, TRUE,
    info = "Ex 4: Discuss why accuracy alone is a poor criterion for cutoff selection (consider false positives vs false negatives)"
  )
})

test_that("Ex 4: Rmd identifies which cutoff maximizes accuracy", {
  skip_if(length(.rmd_content) == 0)
  ex4_section <- .find_ex_section(.rmd_content, "4")
  if (is.null(ex4_section)) skip("Exercise 4 section not found")
  non_code_lines <- ex4_section[!grepl("^```|^#|^\\s*$", ex4_section)]
  expect_true(length(non_code_lines) > 2,
    label = "Ex 4: Report which cutoff maximized accuracy and explain the implications"
  )
})
