# Exercise 6: Candidate models (Super Stretch)

test_that("Ex 6: f_base formula object exists", {
  expect_true(exists("f_base"),
    info = "Create f_base as the baseline formula: survived ~ sex + pclass"
  )
})

test_that("Ex 6: f_base is a formula object", {
  skip_if(!exists("f_base"), message = "f_base not found")
  expect_true(inherits(f_base, "formula"),
    info = "f_base should be a formula object created with ~"
  )
})

test_that("Ex 6: f_base contains sex and pclass", {
  skip_if(!exists("f_base"), message = "f_base not found")
  f_str <- deparse(f_base)
  expect_true(grepl("sex", f_str, ignore.case = TRUE),
    info = "f_base should include sex as a predictor"
  )
  expect_true(grepl("pclass", f_str, ignore.case = TRUE),
    info = "f_base should include pclass as a predictor"
  )
})

test_that("Ex 6: f_expanded formula object exists", {
  expect_true(exists("f_expanded"),
    info = "Create f_expanded as an expanded formula with additional predictors beyond sex + pclass"
  )
})

test_that("Ex 6: f_expanded is a formula object", {
  skip_if(!exists("f_expanded"), message = "f_expanded not found")
  expect_true(inherits(f_expanded, "formula"),
    info = "f_expanded should be a formula object created with ~"
  )
})

test_that("Ex 6: f_expanded contains more predictors than f_base", {
  skip_if(!exists("f_base"), message = "f_base not found")
  skip_if(!exists("f_expanded"), message = "f_expanded not found")
  base_terms <- attr(terms(f_base), "term.labels")
  expanded_terms <- attr(terms(f_expanded), "term.labels")
  expect_true(length(expanded_terms) > length(base_terms),
    info = "f_expanded should include more predictors than f_base (add at least two predictors)"
  )
})

test_that("Ex 6: Rmd justifies chosen predictors", {
  skip_if(length(.rmd_content) == 0)
  potential_answers <- c(
    "f_expanded", "f_base", "predictor", "age|fare|embarked|title",
    "candidate", "survival"
  )
  pattern <- paste0("(", paste(potential_answers, collapse = "|"), ")")
  answer_in_rmd <- stringr::str_detect(.rmd_content, pattern) |> any()
  expect_equal(answer_in_rmd, TRUE,
    info = "Include justification for your chosen predictors in your Rmd (Exercise 6)"
  )
})
