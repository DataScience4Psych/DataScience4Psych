# Exercise 9: Repeat analysis for North Carolina

test_that("Ex 9: Rmd filters Denny's for North Carolina", {
  skip_if(length(.rmd_content) == 0)
  potential_answers <- c(
    "state.*==.*NC",
    'state.*==.*"NC"',
    "filter.*NC"
  )
  pattern <- paste0("(", paste(potential_answers, collapse = "|"), ")")
  answer_in_rmd <- stringr::str_detect(.rmd_content, pattern) |> any()
  expect_equal(answer_in_rmd, TRUE,
    info = "Ex 9: Filter both datasets for North Carolina (NC)"
  )
})

test_that("Ex 9: dn_nc or dn_lq_nc data frame exists", {
  has_dn_nc <- exists("dn_nc")
  has_dn_lq_nc <- exists("dn_lq_nc")
  expect_true(
    has_dn_nc || has_dn_lq_nc,
    label = "Create dn_nc (filtered Denny's for NC) or dn_lq_nc (joined NC data)"
  )
})

test_that("Ex 9: Rmd visualizes NC distance distribution", {
  skip_if(length(.rmd_content) == 0)
  potential_answers <- c(
    "geom_histogram",
    "geom_density",
    "geom_boxplot"
  )
  pattern <- paste0("(", paste(potential_answers, collapse = "|"), ")")
  answer_in_rmd <- stringr::str_detect(.rmd_content, pattern) |> any()
  expect_equal(answer_in_rmd, TRUE,
    info = "Ex 9: Visualize the distribution of minimum distances in NC"
  )
})

test_that("Ex 10: Rmd repeats analysis for Texas", {
  skip_if(length(.rmd_content) == 0)
  potential_answers <- c(
    'state.*==.*"TX"',
    "state.*==.*TX",
    "filter.*TX"
  )
  pattern <- paste0("(", paste(potential_answers, collapse = "|"), ")")
  answer_in_rmd <- stringr::str_detect(.rmd_content, pattern) |> any()
  expect_equal(answer_in_rmd, TRUE,
    info = "Ex 10: Repeat the distance analysis for Texas (TX)"
  )
})
