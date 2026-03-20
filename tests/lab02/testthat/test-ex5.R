# Exercise 5: Recreate coastal population proportion plot

test_that("Ex 5: plastic_waste object exists for recreation plot", {
  expect_true(exists("plastic_waste"),
    info = "Create the plastic_waste object to compute coastal_pop_prop"
  )
})

test_that("Ex 5: Rmd Exercise 5 computes coastal_pop_prop", {
  skip_if(length(.rmd_content) == 0)
  potential_answers <- c("coastal_pop_prop", "coastal_pop\\s*/\\s*total_pop")
  pattern <- paste0("(", paste(potential_answers, collapse = "|"), ")")
  answer_in_rmd <- stringr::str_detect(.rmd_content, pattern) |> any()
  expect_equal(answer_in_rmd, TRUE,
    info = "Compute coastal_pop_prop (coastal_pop / total_pop) in your Rmd"
  )
})

test_that("Ex 5: Rmd Exercise 5 contains plot code", {
  skip_if(length(.rmd_content) == 0)
  potential_answers <- c("ggplot")
  pattern <- paste0("(", paste(potential_answers, collapse = "|"), ")")
  answer_in_rmd <- stringr::str_detect(.rmd_content, pattern) |> any()
  expect_equal(answer_in_rmd, TRUE,
    info = "Add ggplot code to recreate the plot in your Rmd"
  )
})

test_that("Ex 5: Rmd Exercise 5 filters for plastic_waste_per_cap < 3", {
  skip_if(length(.rmd_content) == 0)
  potential_answers <- c("filter", "< ?3")
  pattern <- paste0("(", paste(potential_answers, collapse = "|"), ")")
  answer_in_rmd <- stringr::str_detect(.rmd_content, pattern) |> any()
  expect_equal(answer_in_rmd, TRUE,
    info = "Filter out the outlier by keeping plastic_waste_per_cap < 3 in your Rmd"
  )
})

test_that("Ex 5: coastal_pop_prop solution values are between 0 and 1", {
  skip_if(!exists("plastic_waste"))
  skip_if(!all(c("coastal_pop", "total_pop") %in% names(plastic_waste)))
  solution_pw <- plastic_waste
  solution_pw$coastal_pop_prop <- solution_pw$coastal_pop / solution_pw$total_pop
  solution_pw_clean <- solution_pw[!is.na(solution_pw$coastal_pop_prop), ]
  solution_med <- median(solution_pw_clean$coastal_pop_prop, na.rm = TRUE)
  expect_true(solution_med >= 0 && solution_med <= 1,
    info = "Ensure the median coastal_pop_prop is between 0 and 1"
  )
})

test_that("Ex 5: filtering for plastic_waste_per_cap < 3 retains most rows", {
  skip_if(!exists("plastic_waste"))
  skip_if(!all(c("coastal_pop", "total_pop", "plastic_waste_per_cap") %in% names(plastic_waste)))
  solution_pw <- plastic_waste
  solution_pw$coastal_pop_prop <- solution_pw$coastal_pop / solution_pw$total_pop
  solution_result <- solution_pw[!is.na(solution_pw$plastic_waste_per_cap) &
    solution_pw$plastic_waste_per_cap < 3, ]
  expect_true(nrow(solution_result) > 200,
    info = "Filtering for plastic_waste_per_cap < 3 should retain most rows"
  )
})
