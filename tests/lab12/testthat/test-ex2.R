# Exercise 2: Filter ncbirths for White mothers

test_that("Ex 2: ncbirths_white data frame exists", {
  expect_true(exists("ncbirths_white"),
    label = "ncbirths_white should be a filtered version of ncbirths containing only White mothers"
  )
})

test_that("Ex 2: ncbirths_white contains only White mothers", {
  skip_if(!exists("ncbirths_white"))
  expect_true(
    all(ncbirths_white$whitemom == "white", na.rm = TRUE),
    label = "ncbirths_white should only contain rows where whitemom == 'white'"
  )
})

test_that("Ex 2: Rmd calculates mean weight for ncbirths_white", {
  skip_if(length(.rmd_content) == 0)
  potential_answers <- c(
    "mean.*weight.*ncbirths_white",
    "mean.*ncbirths_white.*weight",
    "ncbirths_white.*mean\\(weight"
  )
  pattern <- paste0("(", paste(potential_answers, collapse = "|"), ")")
  answer_in_rmd <- stringr::str_detect(.rmd_content, pattern) |> any()
  expect_equal(answer_in_rmd, TRUE,
    info = "Ex 2: Calculate the mean birth weight for White mothers' babies"
  )
})

test_that("Ex 2: mean weight for White babies is close to known value (near 7.25 lbs)", {
  skip_if(!exists("ncbirths_white"))
  mean_weight <- mean(ncbirths_white$weight, na.rm = TRUE)
  expect_true(
    mean_weight > 6.5 && mean_weight < 8.5,
    label = sprintf(
      "Mean birth weight for White babies should be between 6.5 and 8.5 lbs, got %.3f",
      mean_weight
    )
  )
})
