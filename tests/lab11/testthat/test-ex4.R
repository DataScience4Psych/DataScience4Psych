# Exercise 4: When the cutoff is a policy decision

test_that("Ex 4: cutoff_results data frame exists", {
  expect_true(exists("cutoff_results"),
    info = "Create cutoff_results with columns cutoff and accuracy for cutoffs 0.3, 0.5, 0.7"
  )
})

test_that("Ex 4: cutoff_results has cutoff and accuracy columns", {
  skip_if(!exists("cutoff_results"), message = "cutoff_results not found")
  expect_true("cutoff" %in% names(cutoff_results),
    info = "cutoff_results should have a cutoff column"
  )
  expect_true("accuracy" %in% names(cutoff_results),
    info = "cutoff_results should have an accuracy column"
  )
})

test_that("Ex 4: cutoff_results contains at least three cutoffs (0.3, 0.5, 0.7)", {
  skip_if(!exists("cutoff_results"), message = "cutoff_results not found")
  skip_if(!"cutoff" %in% names(cutoff_results))
  expect_true(0.3 %in% cutoff_results$cutoff,
    info = "cutoff_results should include cutoff = 0.3"
  )
  expect_true(0.5 %in% cutoff_results$cutoff,
    info = "cutoff_results should include cutoff = 0.5"
  )
  expect_true(0.7 %in% cutoff_results$cutoff,
    info = "cutoff_results should include cutoff = 0.7"
  )
})

test_that("Ex 4: cutoff_results accuracy values are between 0 and 1", {
  skip_if(!exists("cutoff_results"), message = "cutoff_results not found")
  skip_if(!all(c("cutoff", "accuracy") %in% names(cutoff_results)))
  expect_true(all(cutoff_results$accuracy >= 0 & cutoff_results$accuracy <= 1, na.rm = TRUE),
    info = "All accuracy values in cutoff_results should be between 0 and 1"
  )
})

test_that("Ex 4: accuracy at cutoff 0.5 is reasonable (> 60%)", {
  skip_if(!exists("cutoff_results"), message = "cutoff_results not found")
  skip_if(!all(c("cutoff", "accuracy") %in% names(cutoff_results)))
  skip_if(!0.5 %in% cutoff_results$cutoff)
  acc_50 <- cutoff_results$accuracy[cutoff_results$cutoff == 0.5]
  if (length(acc_50) == 0) skip("No row with cutoff = 0.5")
  expect_true(acc_50 > 0.60,
    info = sprintf("Accuracy at cutoff 0.5 should be > 60%%, got %.1f%%", acc_50 * 100)
  )
})

test_that("Ex 4: cutoff_results_fine (finer grid) exists with many cutoffs", {
  skip_if(!exists("cutoff_results_fine"), message = "cutoff_results_fine not found — it is created in Exercise 4.2")
  expect_true("cutoff" %in% names(cutoff_results_fine),
    info = "cutoff_results_fine should have a cutoff column"
  )
  expect_true(nrow(cutoff_results_fine) >= 5,
    info = "cutoff_results_fine should have at least 5 cutoff values"
  )
})

test_that("Ex 4: Rmd contains cutoff analysis code", {
  skip_if(length(.rmd_content) == 0)
  potential_answers <- c("cutoff", "cutoffs", "ifelse.*>.*0\\.[0-9]", "0\\.3", "0\\.5", "0\\.7")
  pattern <- paste0("(", paste(potential_answers, collapse = "|"), ")")
  answer_in_rmd <- stringr::str_detect(.rmd_content, pattern) |> any()
  expect_equal(answer_in_rmd, TRUE,
    info = "Include cutoff analysis code in your Rmd (Exercise 4)"
  )
})
