# Exercise 2: Create honest visualization of Kansas COVID data

test_that("Ex 2: Rmd creates an improved, honest visualization", {
  skip_if(length(.rmd_content) == 0)
  # Student should use ggplot and show both mask groups with honest axes
  has_ggplot <- stringr::str_detect(.rmd_content, "ggplot") |> any()
  has_mask <- stringr::str_detect(.rmd_content, "mask_mandate|mask") |> any()
  expect_true(has_ggplot,
    label = "Ex 2: Use ggplot2 for your honest visualization"
  )
  expect_true(has_mask,
    label = "Ex 2: Your visualization should use the mask_mandate variable"
  )
})

test_that("Ex 3: Rmd explains what message is clearer in honest visualization", {
  skip_if(length(.rmd_content) == 0)
  ex3_section <- .find_ex_section(.rmd_content, "3", "4")
  if (is.null(ex3_section)) skip("Exercise 3 section not found")
  non_code_lines <- ex3_section[!grepl("^```|^#|^\\s*$", ex3_section)]
  expect_true(length(non_code_lines) > 2,
    label = "Ex 3: Write an explanation of what is clearer in your honest visualization"
  )
})

test_that("Ex 4: Rmd discusses what the data tells us about mask wearing and COVID", {
  skip_if(length(.rmd_content) == 0)
  potential_answers <- c(
    "mask",
    "COVID",
    "pandemic",
    "association"
  )
  pattern <- paste0("(", paste(potential_answers, collapse = "|"), ")")
  ex4_section <- .find_ex_section(.rmd_content, "4", "5")
  if (is.null(ex4_section)) skip("Exercise 4 section not found")
  answer_in_section <- stringr::str_detect(ex4_section, pattern) |> any()
  expect_true(answer_in_section,
    label = "Ex 4: Discuss what the data tells us about mask wearing and COVID"
  )
})
